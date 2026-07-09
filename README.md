# anx_bridge

A lightweight compatibility bridge for **anx-scripts** resources.

`anx_bridge` detects which framework, inventory and target system your server is
running and exposes a single, unified API through the global `Bridge` object.
Write your resource once against the bridge and it will run on any supported
stack — no per-framework forks, no `if QBCore then ... elseif ESX then ...`.

## Supported resources

| Module      | Supported resources                          |
| ----------- | -------------------------------------------- |
| `framework` | `qb-core`, `qbx_core`, `es_extended`         |
| `inventory` | `qb-inventory`, `ox_inventory`               |
| `target`    | `qb-target`, `ox_target`                     |

If no supported resource is detected for a module, a **fallback** adapter is
loaded instead. Fallbacks are no-ops that log a warning, so a missing dependency
never crashes the resource — it just degrades gracefully.

## Dependencies

- [ox_lib](https://github.com/overextended/ox_lib)

## How it works

On start, `init.lua` iterates over each module (`framework`, `inventory`,
`target`) and picks the adapter to load:

1. It reads the convar `anx_bridge:<module>` (default `auto`).
2. In `auto` mode it loads the adapter for the first supported resource whose
   state is `started`.
3. You can force a specific resource by setting the convar (see below).
4. If nothing matches, the `fallback` adapter is used.

The chosen adapters are attached to the global `Bridge` table:

```
Bridge = {
    framework = { ... },   -- FrameworkModule
    inventory = { ... },   -- InventoryModule
    target    = { ... },   -- TargetModule
    shared    = { ... },   -- utils
}
```

`server` methods are stripped on the client and `client` methods are stripped on
the server, so you always access the correct side directly.

When run as a standalone resource, `anx_bridge` prints the resolved adapters for
each module on startup.

## Convars

Force a specific adapter instead of auto-detection (server.cfg):

```cfg
# valid values: auto (default) | qb-core | qbx_core | es_extended
setr anx_bridge:framework auto

# valid values: auto (default) | qb-inventory | ox_inventory
setr anx_bridge:inventory auto

# valid values: auto (default) | qb-target | ox_target
setr anx_bridge:target auto
```

## Usage

Add the bridge to your resource's `fxmanifest.lua` and require it as a shared
script (it must load after `ox_lib`):

```lua
shared_scripts {
    '@ox_lib/init.lua',
    '@anx_bridge/init.lua',
}
```

> **Important:** in your `server.cfg`, start `anx_bridge` **after** `ox_lib`
> and the resources it bridges (framework, inventory, target). Any resource
> that uses the bridge must start **after** `anx_bridge`.

Then use the global `Bridge` object anywhere in your resource. Refer to
`types.lua` for the full API surface of each module.

## Extending

Each module is a directory containing one Lua file per supported resource plus a
`fallback.lua`.

### Add a resource to an existing module

To support a new resource for a module that already exists (e.g. a new inventory):

1. Create `<module>/<resource>.lua` returning a table that implements the
   module's interface (see `types.lua` for the full contracts).
2. Add an entry to that module's `path` list in `init.lua`:
   ```lua
   { name = "<resource>", file = "<resource>" },
   ```
   `name` is the resource name checked against `GetResourceState`, `file` is the
   Lua file to load (they can differ — e.g. `qbx_core` reuses the `qb-core` file).
3. The resource's `name` is now a valid value for the module's convar
   (`anx_bridge:<module>`), so it can be forced instead of auto-detected. Add it
   to that module's list of valid values in the **Convars** section.

### Add a new module

To add a whole new module (e.g. `dispatch`, `phone`):

1. Create a `<module>/` directory with one Lua file per supported resource plus a
   `fallback.lua`, each returning a table with `client`/`server` tables.
2. Describe its interface in `types.lua` — a `<Module>Module` class — and add a
   matching field to `BridgeRoot`.
3. Register the module in the `modules` list in `init.lua` with its `name` and
   `path` entries.
4. Add `'<module>/**.lua'` to the `files` block in `fxmanifest.lua`.
5. The module automatically gets its own `anx_bridge:<module>` convar (defaults
   to `auto`). Document it and its valid values in the **Convars** section.
