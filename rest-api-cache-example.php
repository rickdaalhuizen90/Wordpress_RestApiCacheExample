<?php
/*
Plugin Name: REST API Cache Example
Description: A simple plugin to demonstrate REST API endpoints with and without cache.
Version: 1.0
Author: Rick Daalhuizen
*/

function generate_large_string() {
    $base_string = str_repeat('A', 1024); // 1KB
    // Repeat the base string 10240 times to get approximately 10MB
    return str_repeat($base_string, 10240); // 100MB
}

function example_nocache( ) {
    $response = array( 'message' => 'This is not a cached response.', 'data' => generate_large_string() );
    return new WP_REST_Response( $response, 200 );
}

function example_cached() {
    $cached_response = get_transient( 'example_cached_response' );
    if ( $cached_response == false ) {
        $response = array( 'message' => 'This is a cached response.', 'data' => generate_large_string() );

        set_transient( 'example_cached_response', $response, 3600 );
        $cached_response = $response;
    }
    
    return new WP_REST_Response( $cached_response, 200 );
}

add_action( 'rest_api_init', function () {
    register_rest_route( 'example/v1', '/nocache', array(
        'methods' => 'GET',
        'callback' => 'example_nocache',
    ));

    register_rest_route( 'example/v1', '/cached', array(
        'methods' => 'GET',
        'callback' => 'example_cached',
    ));
});
