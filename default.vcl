vcl 4.0;

backend default {
  .host = "${VARNISH_BACKEND_IP}";
  .port = "${VARNISH_BACKEND_PORT}";
}

sub vcl_recv {
  // Add a Surrogate-Capability header to announce ESI support.
  set req.http.Surrogate-Capability = "abc=ESI/1.0";
}

sub vcl_backend_response {
  // Check for ESI acknowledgement and remove Surrogate-Control header
  if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
    unset beresp.http.Surrogate-Control;
    set beresp.do_esi = true;
  }
}
