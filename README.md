WHMCS Custom Stripe Payment Gateway
============

This is a free and open source Stripe Payment Gateway for WHMCS that supports one time and recurring payments without ever having a credit card number hit your WHMCS server. It's pretty neat!

## Overview

This gateway allows the [WHMCS](http://www.whmcs.com) billing system to use [Stripe's](https://www.stripe.com) one time and reoccurring payment gateway capabilities. [Stripe](https://www.stripe.com) provides the unique ability to take a client's credit card information without ever having the client leave your site, but it also allows for credit card data to never get stored in or even pass through your own server, eliminating costly concerns over PCI compliance. This gateway for WHMCS is being released free for anyone, although it should still be considered in beta as there are likely still bugs to work out of it.


You can sign up for a Stripe account at https://stripe.com.

## Stripe API version

1. Stripe API 4.12.0 (Release date 05/06/2017)
2. Stripe Elements integration with js version v3

## Requirements

1. PHP 5.3.3 and later.
2. WHMCS (V7.X, V6.X)
3. cURL must be enabled (This is most likely already enabled on your server, but you can contact your hosting provider if you are unsure)
4. SSL certificate installed (in order to process live transactions)
5. Stripe merchant account

## Instructions For Use

1. Copy the file in the repository's root folder called `stripe.php` and place it into the `/modules/gateways/` folder of your WHMCS installation.
2. From within the `callback` folder of the repository, copy the other `stripe.php` file and place it into the `/modules/gateways/callback` folder of your WHMCS installation.
3. Copy the `ccpay.php` file from the repository into the root directory of your WHMCS installation.
4. Finally, copy the `clientareacreditcard-stripe.tpl` file into the root level of the theme folder you are currently using for WHMCS. For example, if you're using the `default` theme, then copy this file to `/templates/default/`.
5. Add a webhook in Stripe to `https://yourwhmcsinstall.com/modules/gateways/callback/stripe.php`.

In the end, your folder structure should look roughly like the diagram below, with a ccpay.php file in the root of your install, a stripe.php in `/modules/gateways/callback`, a stripe.php in `/modules/gateways/`, a `clientareacreditcard-stripe.tpl` in the root of your WHMCS active template folder, and the `lib` folder of the Stripe API in the newly-created `/modules/gateways/stripe/` folder.

```
whmcs
  |-- ccpay.php
  |-- modules
  	  |-- gateways
  	  	  |-- callbacks
  	  	  	  |-- stripe.php
  	  	  |-- stripe (contains the lib folder of the Stripe PHP API)
  	  	  	  |-- Stripe
  	  	  	  	|-- ... (files from Stripe API)
  	  	  	  |-- data
  	  	  	  	|-- ... (files from Stripe API)
  	  	  	  |-- Stripe.php (Stripe API core file)
  	  	  |-- stripe.php
  |-- templates
  	  |-- yourtemplatename (i.e. default)
  	      |-- clientareacreditcard-stripe.tpl
 ```

You may now activate this new payment gateway from within WHMCS through the Setup > Payments > Payment Gateways screen. This module should be listed as *Stripe*. You can then fill in the appropriate API key information as well as a *required* email address where the gateway can send you any serious errors that come up while billing clients or communicating with Stripe.

## Warnings and Notices

+ This payment gateway relies on the way it saves an Invoice title and description to Stripe in order to properly function and credit invoices once they are paid. Because of this, you shouldn't attempt to modify the way invoices and plans are displayed in Stripe's web interface.
+ This payment gateway assumes that you are using the default WHMCS template based on Twitter's Bootstrap framework. If you are not, or if your theme uses a heavily or otherwise extremely modified version of Bootstrap, double-check to ensure that the Javscript this module uses will still work properly.
+ This gateway currently only works in English with United States Dollars as the currency.

## Credits and Acknowledgements

This module wouldn't have been possible to make without the help of [WHMCS'](http://www.whmcs.com) developer team as well as the staff at [Stripe](https://www.stripe.com) for their great product, well-documented PHP API, and quick support as well. All pieces of code, including the payment gateway template, are the property of their original owners.

## Support Information

I'm always looking to improve this code, so if you see something that can be changed or if you have an idea for a new feature or any other feedback, send me an email to `sagasdeshmukh91@gmail.com`, or send me a message on Twitter (`@starsagar91`), and I'll get right back to you. If you decide to use this module in your WHMCS install, send me a message to say hello (and let me know what you think too) and it'll make my day. Thanks!