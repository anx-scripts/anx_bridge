---@alias Compatibility "good"|"average"|"poor"

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
---@field getPlayerData fun(): FrameworkPlayerData

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
---@field compatibility Compatibility

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
---@field items fun(): InventoryClientItem[]
---@field openStash fun(identifier: string)
---@field hasItem fun(name: string, count: number): boolean
---@field setBusy fun(state: boolean)

---@class InventoryServer
---@field item fun(name: string): InventoryServerItem
---@field items fun(): InventoryServerItem[]
---@field createStash fun(identifier: string, label: string, slots: number, weight: number)
---@field canCarryItem fun(src: number, item: string, count: number): boolean
---@field getItems fun(src: number, name: string): InventoryInstanceItem[]
---@field getItemCount fun(src: number, item: string, metadata?: table<string, any>, shouldMetadataMatch?: boolean): number
---@field getItemBySlot fun(src: number, slot: number): InventoryNamedItem|nil
---@field addItem fun(src: number, item: string, count: number, metadata?: table<string, any>): boolean
---@field removeItem fun(src: number, item: string, count: number, slot?: number, metadata?: table<string, any>, shouldMetadataMatch?: boolean): boolean
---@field setMetadata fun(src: number, slot: number, metadata: table<string, any>|nil): boolean
---@field createUseableItem fun(name: string, cb: fun(src: number, slot: number, metadata?: table<string, any>))

---@class InventoryModule
---@field client InventoryClient
---@field server InventoryServer
---@field name string
---@field compatibility Compatibility

---@class TargetBaseOptions
---@field label string
---@field name string

---@class TargetAddOptions: TargetBaseOptions
---@field icon? string
---@field onSelect fun(entity: number)
---@field canInteract? fun(entity: number)

---@class TargetRemoveOptions: TargetBaseOptions

---@class TargetClient
---@field addGlobalObject fun(options: TargetAddOptions[], distance?: number)
---@field removeGlobalObject fun(options: TargetRemoveOptions[])
---@field addGlobalPed fun(options: TargetAddOptions[], distance?: number)
---@field removeGlobalPed fun(options: TargetRemoveOptions[])
---@field addGlobalVehicle fun(options: TargetAddOptions[], distance?: number)
---@field removeGlobalVehicle fun(options: TargetRemoveOptions[])
---@field addModels fun(models: string[], options: TargetAddOptions[], distance?: number)
---@field removeModels fun(models: TargetRemoveOptions[])
---@field addLocalEntities fun(entities: number[], options: TargetAddOptions[], distance?: number)
---@field removeLocalEntities fun(entities: TargetRemoveOptions[])

---@class TargetModule
---@field client TargetClient
---@field name string
---@field compatibility Compatibility

---@class SharedModule
---@field dump fun(...)
---@field log fun(message: string, type: "error"|"success"|"warn"|"info")

---@class BridgeRoot
---@field framework FrameworkModule
---@field inventory InventoryModule
---@field target TargetModule
---@field shared SharedModule
