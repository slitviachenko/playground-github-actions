import * as core from '@actions/core';

let errorMessage = `This is
a multiline
string.`;

core.setOutput('error', ':x: ' + errorMessage);
