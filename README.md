# Simple Weapon Holster System

An immersive FiveM script for QBCore framework that displays visible weapons holstered on player characters.

## Overview

This script enhances roleplay realism by displaying holstered weapons on players instead of having them magically disappear when not equipped. When players switch weapons, the previous weapon is visibly attached to the character model in a realistic position.

## Features

- Realistic weapon holstering on character body
- Permission-based system (admin only option, job restrictions)
- Weapon visibility synced across all players
- Configurable options for server administrators

## Dependencies

- QBCore Framework

## Installation

1. Download the resource
2. Extract it to your server's resources folder
3. Add `ensure omiya-weaponcarry` to your server.cfg
4. Restart your server or start the resource manually

## Configuration

Configuration can be managed through the `server.lua` file:

```lua
local Config = {
    AdminOnly = false,       -- Set to true to restrict usage to admins only
    EnabledJobs = {},        -- Empty means all jobs can use it, or specify like {'police', 'sheriff'}
    VersionCheck = true      -- Check for updates
}
```

### Options:

- **AdminOnly**: When set to `true`, only server administrators can use the holster system
- **EnabledJobs**: Specify which jobs can use the holster system (empty array allows all jobs)
- **VersionCheck**: Enable/disable update checking

## Commands

| Command | Description | Permission |
|---------|-------------|------------|
| `/holsterconfig` | Reload holster configuration | Admin |

## Permissions

The script includes a permission system that can restrict usage based on:
- Admin status
- Job assignments

## Developer Information

### Client Events

- `omiya-weaponcarry:client:syncHolster`: Syncs holster visibility between players
- `omiya-weaponcarry:client:reloadConfig`: Reloads holster configuration from server

### Server Events

- `omiya-weaponcarry:server:syncHolster`: Broadcasts holster visibility to other players
- `omiya-weaponcarry:server:checkPermission`: Callback to verify player permissions

## Version History

- **1.0.1** - Current release with permission system and synchronization
- **1.0.0** - Initial release

## Support

For issues, feature requests, or contributions, please use the GitHub issues system.

## Credits

Created by Omiya


## License

Copyright © 2025 Omiya. All rights reserved.

This project is not licensed for public use. Permission is required from the author for any distribution, modification, or commercial use.
