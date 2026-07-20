---@meta _

---@class FrameworkJob
---@field name string
---@field label string
---@field grade number
---@field gradeLabel string
---@field onDuty boolean

---@class FrameworkPlayerData
---@field identifier string
---@field name string
---@field job FrameworkJob
---@field metadata table<string, any>

---@alias FrameworkMoneyTypes "cash"|"bank"

---@class FrameworkClient
---@field getPlayerData fun(): FrameworkPlayerData|nil

---@class FrameworkServer
---@field getPlayerData fun(src: number): FrameworkPlayerData|nil
---@field getSourceByIdentifier fun(identifier: string): number|nil
---@field getPlayerMoney fun(src: number, type: FrameworkMoneyTypes): number|nil
---@field addPlayerMoney fun(src: number, type: FrameworkMoneyTypes, amount: number): boolean
---@field removePlayerMoney fun(src: number, type: FrameworkMoneyTypes, amount: number): boolean
---@field createUseableItem fun(name: string, cb: fun(src: number, slot: number, metadata?: table<string, any>))

---@class FrameworkModule
---@field client FrameworkClient
---@field server FrameworkServer
---@field name string
---@field object? table Underlying framework core object (QBCore/ESX shared object).

---@class InventoryItemBase
---@field name string
---@field label string
---@field description? string

---@class InventoryClientItem: InventoryItemBase
---@field image? string

---@class InventoryServerItem: InventoryItemBase

---@class InventoryInstanceItem
---@field slot number
---@field count number
---@field metadata? table<string, any>

---@class InventoryNamedItem
---@field name string
---@field count number
---@field metadata? table<string, any>

---@class InventoryClient
---@field item fun(name: string): InventoryClientItem
---@field items fun(): table<string, InventoryClientItem>
---@field hasItem fun(name: string, count: number): boolean
---@field setBusy fun(state: boolean)
---@field isBusy fun(): boolean

---@class InventoryServer
---@field item fun(name: string): InventoryServerItem
---@field createStash fun(identifier: string, label: string, slots: number, weight: number)
---@field canCarryItem fun(src: number, name: string, count: number): boolean
---@field getItems fun(src: number, name: string): InventoryInstanceItem[]
---@field getItemCount fun(src: number, name: string, metadata?: table<string, any>, shouldMatch?: boolean): number
---@field getItemBySlot fun(src: number, slot: number): InventoryNamedItem|nil
---@field addItem fun(src: number, name: string, count: number, metadata?: table<string, any>): boolean
---@field removeItem fun(src: number, name: string, count: number, slot?: number, metadata?: table<string, any>, shouldMatch?: boolean): boolean
---@field setMetadata fun(src: number, slot: number, metadata: table<string, any>|nil)
---@field createUseableItem fun(name: string, cb: fun(src: number, slot: number, metadata?: table<string, any>))

---@class InventoryModule
---@field client InventoryClient
---@field server InventoryServer
---@field name string

---@class TargetBaseOptions
---@field label string
---@field name string

---@class TargetAddOptions: TargetBaseOptions
---@field icon? string
---@field onSelect fun(entity: number)
---@field canInteract? fun(entity: number): boolean?

---@class TargetRemoveOptions: TargetBaseOptions

---@class TargetClient
---@field addGlobalObject fun(options: TargetAddOptions[], distance?: number)
---@field removeGlobalObject fun(options: TargetRemoveOptions[])
---@field addGlobalPed fun(options: TargetAddOptions[], distance?: number)
---@field removeGlobalPed fun(options: TargetRemoveOptions[])
---@field addGlobalVehicle fun(options: TargetAddOptions[], distance?: number)
---@field removeGlobalVehicle fun(options: TargetRemoveOptions[])
---@field addModel fun(models: string[], options: TargetAddOptions[], distance?: number)
---@field removeModel fun(models: string[], options: TargetRemoveOptions[])
---@field addLocalEntity fun(entities: number[], options: TargetAddOptions[], distance?: number)
---@field removeLocalEntity fun(entities: number[], options: TargetRemoveOptions[])

---@class TargetModule
---@field client TargetClient
---@field name string

---@class SharedModule
---@field dump fun(...)
---@field log fun(message: string, level?: "error"|"success"|"warn"|"info")

---@class BridgeRoot
---@field resource string
---@field version string
---@field isServer boolean
---@field isBridge boolean
---@field framework FrameworkModule
---@field inventory InventoryModule
---@field target TargetModule
---@field shared SharedModule

---@type BridgeRoot
---@diagnostic disable-next-line: missing-fields
Bridge = {}
