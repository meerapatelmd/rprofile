.First <-
  function() {

    cli::cat_boxx("Startup",
                  float = "center",
                  align = "center")

    secretary::typewrite(secretary::italicize("Reading Renviron..."))
    readRenviron("~/.Renviron")

    secretary::typewrite(secretary::italicize("Setting options..."))
    options(usethis.full_name = "Meera Y. Patel, M.D.",
            usethis.description = list(
              `Authors@R` =
                'person("Meera", "Patel, MD",
                                email = "patelmeeray@gmail.com", role = c("aut", "cre"),
                                comment = c(ORCID = "0000-0002-3401-3948"))',
              License = "Apache License 2.0"
            )
    )

    options("WrapRmd.width")

    if (interactive()) {

      basePkgs <- c("secretary",
                    "cave",
                    "broca",
                    "centipede",
                    "glitter",
                    "rubix",
                    "pg13",
                    "chariot",
                    "skyscraper")

      secretary::typewrite(secretary::italicize("Installing Packages:"))
      for (i in 1:length(basePkgs)) {
        secretary::typewrite(basePkgs[i], tabs = 5, timepunched = FALSE)
      }
      cat("\n")


      errors <- vector()
      while (length(basePkgs) > 0) {

        basePkg <- basePkgs[1]

        results <-
          tryCatch(suppressMessages(devtools::install_github(paste0("meerapatelmd/", basePkg))),
                   error = function(e) "Error")

        if (identical(results, "Error")) {

          errors <-
            c(errors,
              basePkg)

        }

        basePkgs <- basePkgs[-1]

      }

      if (length(errors) > 0) {
        for (i in 1:length(errors)) {
          secretary::typewrite_warning(secretary::italicize(errors[i]), "failed to install.")
        }
      }
      cat("\n")

      if (glitter::isRepo()) {

        cli::cat_boxx("Git Details",
                      float = "center",
                      align = "center")
        glitter::branch()
        glitter::pull()
        cli::cat_boxx("Issues",
                      float = "center",
                      align = "center")
        openIssuesDf <- glitter::list_open_issues()
        print(openIssuesDf)
        cat("\n")
      }

    }

  }
