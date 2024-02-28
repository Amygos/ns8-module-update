*** Settings ***
Library    SSHLibrary

*** Test Cases ***
Check if module-update is installed correctly
    ${output}  ${rc} =    Execute Command    add-module ${IMAGE_URL} 1
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    &{output} =    Evaluate    ${output}
    Set Suite Variable    ${module_id}    ${output.module_id}

Check if module-update can be configured
    ${rc} =    Execute Command    api-cli run module/${module_id}/configure-module --data '{}'
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

Check if module-update works as expected
    ${rc} =    Execute Command    curl -f http://127.0.0.1/module-update/
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

Check if module-update is removed correctly
    ${rc} =    Execute Command    remove-module --no-preserve ${module_id}
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0
