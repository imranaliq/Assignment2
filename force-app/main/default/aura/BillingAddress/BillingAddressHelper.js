({
    createAddress : function(cmp,event,billingAddress) {
        console.log('billingAddress '+JSON.stringify(billingAddress));
        var action = component.get("c.validateAddressBySmartyStreetAPI");
        action.setParams({
        "billingAddress": billingAddress
    });
   
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            console.log(response.getReturnValue());
            var response = response.getReturnValue();
            
            console.log(response);
            alert(response);
           
        }
        else {
           
            console.log("Error: " + state);
        }
    });

    $A.enqueueAction(action);
    }
})
