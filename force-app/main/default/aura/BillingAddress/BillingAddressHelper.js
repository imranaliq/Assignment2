({
    validateAddress : function(cmp,event,billingAddress) {
        var action = component.get("c.validateAddressBySmartyStreetAPI");
        action.setParams({
        "billingAddress": billingAddress
    });
   
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            var items = [];
            console.log(response.getReturnValue());
            var response = response.getReturnValue();
            
            console.log(response);
            alert(response);
           
        }
        else {
            var resp = response;
            console.log("Error: " + state);
        }
    });
    // Send action off to be executed
    $A.enqueueAction(action);
    }
})
