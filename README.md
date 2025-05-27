# ubuntu-cleanup

Maintenance script to clean up disk space (unnecessary or old files, cache, ...) 

## Features

- 📅 Will remove files older than a specified number of days;
- 🗑️ Cleaning cache and temporary files.

This script will not cleanup packages. Check out [ubuntu-update](https://github.com/margrevm/ubuntu-update.git) for this purpose.

Other things you can do:

- go to Settings ⇾ Privacy ⇾ File History and Trash. Set 'Automatically Delete Trash Content' and then choose at what interval you want to clear the trash.

## Running the script

```sh
chmod +x cleanup.sh
./cleanup.sh
```

## Supported versions

- Ubuntu 25.04

## Credits

By Mike Margreve (mike.margreve@outlook.com) and licensed under MIT. The original source can be found here: https://github.com/margrevm/ubuntu-cleanup
