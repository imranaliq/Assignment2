({
    clickCreate: function (cmp, event, helper) {

        // Create the new expense
        alert('test');
        var validAddress = cmp.find('billingform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (validAddress) {
            console.log('billingAddress');
            var billingAddress = component.get("v.billingAddress");
            helper.createAddress(cmp, event, billingAddress);
            
            console.log(billingAddress);
        }

    }
})