send_confirmation_mail = function(name, email_adress, filePath){

    
    library(gmailr)
    gm_auth_configure(path = './mail_api/credentials.json')
    gm_auth(email = "emtips.2020@gmail.com", cache = '.secrets')

    # name = 'daniel'
    email_adress = 'daniel.knos@gmail.com'
    mail_body = sprintf(paste0('<b>Hej %s!</b> <br> Välkommen till EM-tipset, kul att du vill vara med.',
            ' Ditt tips är i tryggt förvar men här får du även din personliga kopia att rama in och sätta på väggen'),name)
    test_email <-
        gm_mime() %>%
        gm_to(email_adress) %>%
        gm_from("EMtips.2020@gmail.com") %>%
        gm_cc("EMtips.2020@gmail.com") %>%
        gm_bcc("daniel.knos@gmail.com") %>%
        gm_subject("EM-tips 2020 - submission") %>%
        gm_html_body(mail_body) %>% 
        gm_attach_file(file = filePath, type = "text/plain")

    gm_create_draft(test_email)
    gm_send_message(test_email)

}