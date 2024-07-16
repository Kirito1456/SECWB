from django.shortcuts import render
from django.http import HttpResponseServerError
import sys

def get_exception_response(request, exception, debug):
    if debug:
        from django.views.debug import ExceptionReporter
        reporter = ExceptionReporter(request, *sys.exc_info())
        return HttpResponseServerError(reporter.get_traceback_html(), content_type='text/html')
    else:
        return HttpResponseServerError("An unexpected error occurred. Please try again later.")
