Hi, 

This is a work in progress, if you have any ideas about how it can progress, please let me know or send a PR! 

#### Install instructions: 

1. `git clone https://github.com/bgreg/invoicer.git`
1. `cd invoicer`
1. `./install.sh`
1. Fill in your personal info in personal_info.rb


#### Usage instructions:

- run `ruby make_invoice.rb` and follow the onscreen instructions

![screen shot 2015-08-21 at 1 14 27 pm](https://cloud.githubusercontent.com/assets/3711139/9418217/3258c862-4807-11e5-9db3-dff1c477de0c.png)



#### TODO: 

[ ] When an invoice has been paid build a script that lets you say `pay invoice_1` 
    which would move it would move it to paid folder and give it a time stamp.  

[ ] make the invoicer render handle any length string and still look like a box

[ ] Improve word breaks in the row class

