# Final Project

## TODO: Submit your wireframes in the form of a pull request

This example wireframe lives in `readme_assets/wireframe_example.jpg`

Swap it out with your actual wireframes...

![Wireframe Example](https://docs.google.com/document/d/165dzLR5-saUitkK95jK9lcBdRyt-8RJiMnsST0VZ-vA/edit?usp=sharing)

## TODO: Submit your ERD in the form of a pull request

This ERD was created online. View it [here](https://editor.ponyorm.com/user/dmmmd/miim).

![ERD Example](readme_assets/erd.png)

Swap it out with your actual ERD...

## Deployment

If your project uses the `react_on_rails` gem, you will need to:

* `heroku create your-app-name`
* `heroku buildpacks:set --index 1 heroku/nodejs`
* `heroku buildpacks:add heroku/ruby`
* `git push heroku master`
* `heroku run rails db:migrate`
* optional: `heroku run rails db:seed`

## Instructor Checklist

* Clone this repo, create a new one
* Set branch protection rules on `master` (There is a CODEOWNERS file in this repo, but it is up to you how you want to use it.)
* Create a Slack Channel, invite team members and TAs
* in Slack: `/github subscribe wyncode/repo_name issues,reviews,comments`
