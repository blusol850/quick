component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Create Spec", function() {
            aroundEach( function( spec ) {
                transaction action="begin" {
                    try { arguments.spec.body(); }
                    catch ( any e ) { rethrow; }
                    finally { transaction action="rollback"; }
                }
            } );

            it( "can create and return a model that is already saved in the database", function() {
                var user = getInstance( "User" ).create( {
                    "username" = "JaneDoe",
                    "first_name" = "Jane",
                    "last_name" = "Doe",
                    "password" = hash( "password" )
                } );
                expect( user.getLoaded() ).toBeTrue();
                expect( user.newEntity().where( "username", "JaneDoe" ).first() ).notToBeNull();
            } );
        } );
    }

}