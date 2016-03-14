Log Storage in GoogleDocs
==========
1. Open [Google Drive](https://drive.google.com/), click New > More > Google Forms.
![](http://i.imgur.com/f3tJNTS.png)
2. Enter a title to your form from the top left corner
3. The first field which is "Question Title" should be "App Version" and "Question Type" should be "Text" (Or "Short Answer" in new version)
![](http://i.imgur.com/799xH6D.png)
4. Click Done. Add 3 more questions like this, their texts should be "User Information", "Code Information", "Log Text". 
5. Make sure it looks like this at the end: 
![](http://i.imgur.com/uTFVSMu.png)
6. Click "View Live Form", https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/viewform a link like this opens up. Use the link as the first paramater in your code like this:
  
  ```swift
QorumOnlineLogs.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/formResponse", 
versionField: <#String#>, userInfoField: <#String#>, methodInfoField: <#String#>, textField: <#String#>)
  ```
With one difference: change "viewform" to "formResponse".

7. Go back to your live form, under App Version, select the text field, right click and select "Inspect Element" (I am using Chrome, might be different in your browser) 

    ![demo](http://i.imgur.com/KvMBISU.png)

8. Get the value of "id" from that text fields HTML.  
![](http://i.imgur.com/eZKlzjq.png)

Edit: In new version scroll down until you see something like:
```javascript
<input type="hidden" name="entry.473505335" jsname="L9xHkb">
```
Get the contents of "name".

9. Use that as the second parameter in your code:

  ```swift
QorumOnlineLogs.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/formResponse", 
versionField: "entry_631576183", userInfoField: <#String#>, methodInfoField: <#String#>, textField: <#String#>)
  ```
10. Repeat the same process for the other text fields:

  ```swift
QorumOnlineLogs.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/formResponse", 
versionField: "entry_631576183", userInfoField: "entry_922538006", methodInfoField: "entry_836974774", textField: "entry_526236259")
  ```
11. Type these after your setup:

  ```swift
  QorumLogs.enabled = false // This should be disabled for OnlineLogs to work
  QorumOnlineLogs.enabled = true
  QorumOnlineLogs.test()
  ```
12. Go back to the screen where you edited the form and click "View Responses"
13. Run your application, you should see this in the Xcode debugger:

![demo](http://i.imgur.com/DLzZmfl.png)

and this in your form responses:

![demo](http://i.imgur.com/LJmc13G.png)

Here is the public demo sheet: https://docs.google.com/spreadsheets/d/1rYRStyI46L2sjiFF9DTDMlCb2qR2FMtKrZk3USRdXkA/

Congratulations!
