# TheLuxEmpire RoleplayWorld

## 🌟 Introduction

TheLuxEmpire RoleplayWorld is an advanced, highly configurable resource for FiveM servers using the QBCore framework. This resource introduces a comprehensive system of activities, crafting, skills, market interactions, and dynamic events to create an immersive and engaging roleplay experience.

Developed by iBoss21, this resource aims to provide server owners with a robust foundation for creating unique and exciting gameplay elements that encourage long-term player engagement and server longevity.

## 🚀 Features

- **Advanced Activity System**: Includes lumberjacking, mining, hunting, fishing, and foraging.
- **Dynamic Crafting**: Craft items using gathered resources, with recipes tied to skill levels.
- **Skill Progression**: Gain experience and level up in various skills to unlock new abilities and recipes.
- **Realistic Market System**: Buy and sell items with dynamically changing prices.
- **Random Events**: Engage in server-wide events that provide bonuses and unique gameplay experiences.
- **NPC Interaction**: Interact with NPCs for quests, trading, and more.
- **Highly Configurable**: Extensive configuration options to tailor the experience to your server.

## 📋 Requirements

- QBCore Framework
- oxmysql

## 💾 Installation

1. Clone this repository into your server's `resources` folder: git clone https://github.com/iBoss21/theluxempire_roleplayworld.git
   
2. Copy the `theluxempire-core` and `theluxempire-lib` folders from the `dependencies` directory to your server's `resources` folder.

3. Add the following lines to your `server.cfg`:

ensure theluxempire-core
ensure theluxempire-lib
ensure theluxempire_roleplayworld

4. Import the provided SQL file (`theluxempire_roleplayworld.sql`) into your database.

5. Configure the resource by editing the `config.lua` file to suit your server's needs.

## ⚙️ Configuration

The `config.lua` file contains extensive options for customizing the resource. Here are some key areas you can configure:

- Activity locations and resource yields
- Crafting recipes and required skill levels
- Skill progression rates
- Market prices and fluctuation rates
- Event types, durations, and bonuses
- NPC locations and interactions

Refer to the comments in the `config.lua` file for detailed explanations of each configuration option.

## 🛠️ Usage

### Player Commands
- `/viewskills`: Display current skill levels and progress
- `/opencrafting`: Open the crafting menu

### Admin Commands
- `/startevent [eventName]`: Start a specific event
- `/endevent [eventName]`: End a currently active event
- `/addskillxp [playerId] [skillName] [xpAmount]`: Add skill XP to a player
- `/setskill [playerId] [skillName] [level]`: Set a player's skill level

## 🧩 Integration

TheLuxEmpire RoleplayWorld is designed to work seamlessly with other QBCore resources. However, you may need to make some adjustments to ensure compatibility with your specific server setup.

### Inventory Integration
By default, this resource uses QBCore's default inventory system. If you're using a different inventory resource (e.g., ox_inventory), you'll need to modify the relevant functions in `server/activities.lua` and `server/crafting.lua`.

### Job Integration
This resource can be integrated with job systems. Consider adding job-specific bonuses or exclusive activities for certain professions.

## 🚧 Development and Expansion

TheLuxEmpire RoleplayWorld is designed to be easily expandable. Here are some tips for developers looking to add new features:

1. **Adding New Activities**: 
- Add the new activity to the `Config.Activities` table in `config.lua`
- Create corresponding client-side logic in `client/activities.lua`
- Implement server-side reward logic in `server/activities.lua`

2. **Creating New Events**:
- Add the new event to the `Config.Events` table in `config.lua`
- Implement event-specific logic in `server/events.lua` and `client/events.lua`

3. **Expanding the Crafting System**:
- Add new recipes to the `Config.Crafting` table in `config.lua`
- If necessary, add new crafting logic in `server/crafting.lua`

## 🐛 Troubleshooting

If you encounter issues:

1. Ensure all dependencies are correctly installed and up to date.
2. Check the server console and client console for error messages.
3. Verify that all resource names in your `server.cfg` match the installed resource folder names.
4. Double-check the configuration in `config.lua` for any mistakes.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 📞 Support

For support, please open an issue in the GitHub repository or contact iBoss21 through the FiveM forums.

## 🙏 Acknowledgements

- QBCore Team for the amazing framework
- All contributors and testers who have helped shape this resource

---

Enjoy your enhanced roleplay experience with TheLuxEmpire RoleplayWorld!
