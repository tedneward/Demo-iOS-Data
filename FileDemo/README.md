# FileDemo

An example of how to do "raw" file I/O from within an iOS app.

This is a single-screen application, with two buttons, "Load" and "Save". Pushing "Load" will attempt to read a file from the application's "documents" directory, while "Save" will look to (over)write the file at the same location.

Pushing "Load" before "Save" will (deliberately) generate an exception, so as to make it clear what happens when we try to open a file that does not exist. To run the application without the possibility of crash, have the button fire `loadNoFail` rather than `load`.

