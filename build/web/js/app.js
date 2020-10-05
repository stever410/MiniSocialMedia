/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(() => {
    $("#registrationForm").validate({
        rules: {
            txtEmail: {
                required: true,
                email: true
            },
            txtName: {
                required: true,
                rangelength: [1, 100]
            },
            txtPassword: {
                required: true
            },
            txtRetype: {
                equalTo: "#txtPassword"
            }
        },
        messages: {
            txtEmail: "Please enter a valid email",
            txtName: {
                required: "Please enter your name",
                rangelength: "Your name length must be between 1 - 100"
            },
            txtPassword: "Please enter your password",
            txtRetype: "Password not match"
        }
    });
});

document.addEventListener('DOMContentLoaded', () => {
    (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
        $notification = $delete.parentNode;
        $delete.addEventListener('click', () => {
            $notification.parentNode.removeChild($notification);
        });
    });
});

$(document).ready(function () {

    // Check for click events on the navbar burger icon
    $(".navbar-burger").click(function () {

        // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
        $(".navbar-burger").toggleClass("is-active");
        $(".navbar-menu").toggleClass("is-active");

    });
});

$(document).ready(() => {
    $("#post-article-form").validate({
        rules: {
            txtTitle: {
                required: true,
                rangelength: [1, 200]
            },
            txtContent: {
                required: true,
                rangelength: [1, 500]
            },
            txtImage: {
                extension: "png|jpe?g"
            }
        },
        messages: {
            txtTitle: "Title must be from 1 - 200 characters",
            txtContent: "Content must be from 1 - 500 characters",
            txtImage: "Image must be .jpg, .jpeg or .png"
        }
    });
});


$(document).ready(() => {
    $("#comment-form").validate({
        rules: {
            txtComment: {
                required: true,
                rangelength: [1, 500]
            }
        },
        messages: {
            txtComment: "Comment must be from 1 - 500 characters"
        }
    });
});

$(document).ready(() => {
   $("#delete-article").click(() => {
        if(confirm("Do you want to delete this post?")) {
            $('#delete-article-form').submit();
        }
   });
});

$(document).ready(() => {
   $(".delete-comment").click(() => {
        if(confirm("Do you want to delete this comment?")) {
            $('.delete-comment-form').submit();
        }
   });
});
