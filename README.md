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
    target    = { ... },   -- TargetModule (client only)
    shared    = { ... },   -- helpers (dump, log)
}
```

`server` methods are stripped on the client and `client` methods are stripped on
the server, so you always access the correct side directly.

When run as a standalone resource, `anx_bridge` prints the resolved adapters and
a compatibility rating for each module on startup.

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

Then use the global `Bridge` object anywhere in your resource. Refer to
`types.lua` for the full API surface of each module.

## Extending

Each module is a directory containing one Lua file per supported resource plus a
`fallback.lua`. To add support for a new resource:

1. Create `<module>/<resource>.lua` returning a table that implements the
   module's interface (see `types.lua` for the full contracts).
2. Register it in the `modules` list in `init.lua`.

## License

Part of the anx-scripts project.
