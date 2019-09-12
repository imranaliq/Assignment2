({
    clickCreate: function(cmp, event, helper) {
        
            // Create the new expense
            var billingAddress = component.get("v.billingAddress");
            helper.validateAddress(cmp,event,billingAddress);
            console.log(billingAddress);
          
    }
})