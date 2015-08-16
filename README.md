Hi, 

This is a work in progress, if you have any ideas about how it can progress, please let me know or send a PR! 

Install instructions: 

`git clone https://github.com/bgreg/invoicer.git`

`cd invoicer`

`./install.sh`

 

Usage instructions:

- Fill in your personal info in personal_info.rb
- Fill in your items inside the make_invoice file
- run `ruby make_invoice.rb`


TODO: 

[ ] When an invoice has been paid build a script that lets you say `pay invoice_1` 
    whoch would move it would move it to paid folder and give it a time stamp.  

[ ] make the invoicer render handle any length string and still look like a box

