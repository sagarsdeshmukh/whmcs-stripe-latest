{include file="$template/pageheader.tpl" title="Credit Card Payment Information"}

{if $success != true}
<script src="https://js.stripe.com/v3/"></script> 

<script type="text/javascript">

	 // Create a Stripe client
	 var stripe = Stripe('{$stripe_pubkey}');
	 
	// Create an instance of Elements
	var elements = stripe.elements();

	// Custom styling can be passed to options when creating an Element.
	// (Note that this demo uses a wider set of styles than the guide below.)
	var style = {
	  base: {
		color: '#32325d',
		lineHeight: '24px',
		fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
		fontSmoothing: 'antialiased',
		fontSize: '16px',
		'::placeholder': {
		  color: '#aab7c4'
		}
	  },
	  invalid: {
		color: '#fa755a',
		iconColor: '#fa755a'
	  }
	};

	// Create an instance of the card Element
	var card = elements.create('cardNumber', {style: style});
	// Add an instance of the card Element into the `card-number` <div>
	card.mount('#card-number');
	
	// Handle real-time validation errors from the card Element.
	/*card.addEventListener('change', function(event) {
	  var displayError = document.getElementById('card-number-errors');
	  if (event.error) {
		displayError.textContent = event.error.message;
		$("#card_error").addClass("is-invalid");
	  } else {
		displayError.textContent = '';
		$("#card_error").removeClass("is-invalid");
	  }
	
		// Display card brand image as per user input
		var cardbrand = event.brand; // Get Card Brand Name
	
		if (cardbrand == "unknown") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon");
		} else if (cardbrand == "visa") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon visa");
		} else if (cardbrand == "mastercard") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon master-card");
		} else if (cardbrand == "amex") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon american-express");
		} else if (cardbrand == "discover") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon discover");
		} else if (cardbrand == "diners") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon diners-club");
		} else if (cardbrand == "jcb") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon jcb");
		} else if (cardbrand == "maestro") {
			$("#payment_method_icon").removeClass();  
			$("#payment_method_icon").addClass("payment-method-icon maestro");
		}
	});*/

	// Create an instance of the card Element
	card = elements.create('cardExpiry', {style: style});
	// Add an instance of the card Element into the `card-expiry` <div>
	card.mount('#card-expiry');
	
	// Handle real-time validation errors from the card Element.
	/*card.addEventListener('change', function(event) {
	  var displayError = document.getElementById('card-expiry-errors');
	  if (event.error) {
		displayError.textContent = event.error.message;
		$("#exp_error").addClass("is-invalid");
	  } else {
		displayError.textContent = '';
		$("#exp_error").removeClass("is-invalid");
	  }
	});*/
	
	// Create an instance of the card Element
	card = elements.create('cardCvc', {style: style});
	// Add an instance of the card Element into the `card-cvv` <div>
	card.mount('#card-cvv');
	
	// Handle real-time validation errors from the card Element.
	/*card.addEventListener('change', function(event) {
	  var displayError = document.getElementById('card-cvv-errors');
	  if (event.error) {
		displayError.textContent = event.error.message;
		$("#cvc_error").addClass("is-invalid");
	  } else {
		displayError.textContent = '';
		$("#cvc_error").removeClass("is-invalid");
	  }
	});*/
	
	// Handle form submission
	var form = document.getElementById('payment-form');
	form.addEventListener('submit', function(event) {
	  event.preventDefault();
	
	   $('.submit-button').prop('disabled', true);
	
	  var extraDetails = {
		name: $('.cardholder-name').val(),
		address_line1: $('.cardholder-address-l1').val(),
		address_line2: $('.cardholder-address-l2').val(),
		address_city: $('.cardholder-city').val(),
		address_state: $('.cardholder-state').val(),
		address_zip: $('.cardholder-zip').val(),
		address_country: 'US'
	  };
	
	  stripe.createToken(card, extraDetails).then(function(result) {
		if (result.error) {
		  // Inform the user if there was an error
		  $('.alert-error').show();
		  $('.payment-errors').text('Error: ' + result.error.message + '.');
		  $('.submit-button').prop('disabled', false);
	
		} else {
		  // Send the token to your server
		  stripeTokenHandler(result.token);
		}
	  });
	});

	function stripeTokenHandler(token) {
	  // Insert the token ID into the form so it gets submitted to the server
	  var form = document.getElementById('payment-form');
	  var hiddenInput = document.createElement('input');
	  hiddenInput.setAttribute('type', 'hidden');
	  hiddenInput.setAttribute('name', 'stripeToken');
	  hiddenInput.setAttribute('value', token.id);
	  form.appendChild(hiddenInput);
	
	  // Submit the form
	  form.submit();
	}
	
{/literal}
</script>

{if $processingerror}
<div class="alert alert-error">
    <p class="bold payment-errors">{$processingerror}</p>
</div>
{/if}

<div class="alert alert-error" style="display: none;">
    <p class="bold payment-errors"></p>
</div>

	<p>{$explanation} Please make sure the credit card billing information below is correct before continuing and then click <strong>Pay Now</strong>.</p>

<form class="form-horizontal" action="ccpay.php" method="POST" id="payment-form">
<br/>

  <fieldset class="onecol">

	<div class="styled_title"><h3>Cardholder Information</h3></div>
	
	<div class="control-group">
	    <label class="control-label" for="cardholder-name">Cardholder Name</label>
		<div class="controls">
		     <input type="text" size="20" autocomplete="off" class="cardholder-name" value="{$name}" />
		</div>
	</div>
	
	<div class="control-group">
	    <label class="control-label" for="cardholder-address-l1">Address</label>
		<div class="controls">
		     <input type="text" size="20" autocomplete="off" class="cardholder-address-l1" value="{$address1}" /><br/><br/>
		     <input type="text" size="20" autocomplete="off" class="cardholder-address-l2" value="{$address2}" />
		</div>
	</div>
	
	<div class="control-group">
	    <label class="control-label" for="cardholder-city">City</label>
		<div class="controls">
		     <input type="text" size="20" autocomplete="off" class="cardholder-city" value="{$city}" />
		</div>
	</div>
	
	<div class="control-group">
	    <label class="control-label" for="cardholder-state">State</label>
		<div class="controls">
		     <input type="text" size="20" autocomplete="off" class="cardholder-state" value="{$state}" />
		</div>
	</div>
	
	<div class="control-group">
	    <label class="control-label" for="cardholder-zip">Zip/Postal Code</label>
		<div class="controls">
		     <input type="text" size="20" autocomplete="off" class="cardholder-zip" value="{$zipcode}" />
		</div>
	</div>

	<div class="styled_title"><h3>Card Information</h3></div>
	
    <div class="control-group">
	    <label class="control-label" for="card-number">{$LANG.creditcardcardnumber}</label>
		<div class="controls">
           <div id="card-number"> 
             <!-- a Stripe Element will be inserted here. --> 
           </div>
		</div>
	</div>
	
	<div class="control-group">
	    <label class="control-label" for="card-cvc">CVC / Security Code</label>
		<div class="controls">
            <div id="card-cvv" style="margin-left:30px; margin-top:5px"> 
              <!-- a Stripe Element will be inserted here. --> 
            </div>
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="ccexpirymonth">{$LANG.creditcardcardexpires} (MM/YYYY)</label>
		<div class="controls">
		    <div id="card-expiry"> 
              <!-- a Stripe Element will be inserted here. --> 
            </div>
		</div>
	</div>
	
	<input type="hidden" name="ccpay" value="true" />
	<input type="hidden" name="description" value="{$description}" />
	<input type="hidden" name="invoiceid" value="{$invoiceid}" />
	<input type="hidden" name="amount" value="{$amount}" />
	<input type="hidden" name="total_amount" value="{$total_amount}" />
	<input type="hidden" name="planid" value="{$planid}" />
	<input type="hidden" name="planname" value="{$planname}" />
	<input type="hidden" name="multiple" value="{$multiple}" />
	<input type="hidden" name="payfreq" value="{$payfreq}" />

  </fieldset>

  <div class="form-actions">
    <input class="btn btn-primary submit-button" type="submit" value="Pay Now" />
    <a href="viewinvoice.php?id={$invoiceid}" class="btn">Cancel Payment</a>
  </div>

</form>

{/if}
{if $success == true}

<center>
	<h1>Success</h1>
	<p>Your credit card payment was successful.</p>
	<p><a href="viewinvoice.php?id={$invoiceid}&paymentsuccess=true" title="Invoice #{$invoiceid}">Click here</a> to view your paid invoice.</p>
</center>
<br/>
<br/>
<br/>
<br/>
{/if}

<center>{$companyname} values the security of your personal information.<br>Credit card details are transmitted and stored according the highest level of security standards available.</center>

<hr>