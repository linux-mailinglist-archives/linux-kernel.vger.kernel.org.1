Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA728901E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgJIRiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733195AbgJIRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:37:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DAC0613D2;
        Fri,  9 Oct 2020 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5KGK0KBNJicqKUUx6uAxbNxMchAcU7TkrBnzqht4jjU=; b=OBN0U505hPl2JYq1qKCFJtzg29
        aBueYoEBcoRGnFB7z1ViVBYfrWLduByjly8klpbPTDkQ2oQ8hXxPyletq2QpS3JNWbTTDjS3IYwlp
        3XAD5LhbA3kB2gbfPpP7pPzf35oUcbDa0t/JCM97LIJexRYZebP/8T3cQ+fCYaSjwP2iJ3js0M1X1
        d8A5Xl8xdYXQaCrWogVpKpIraqOSfopExmy00dzGv243BvSb2Po6ORSnQ81RJ4COsid7I0a4iShXR
        yKcViRZjhVfG4ZU6Ib2sQOsG95J4CedtFKIrMWoc32WcP/xAxaaDyVVcX4AegY0/LpkMG3QaB57ee
        r57EF/Bg==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQwKz-0001JC-Jg; Fri, 09 Oct 2020 17:37:50 +0000
Subject: Re: [RFC PATCH v1 22/26] docs: reporting-bugs: explain what users
 should do once the report got out
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <60aeaadf670271ee69a47f5eff3f6bf7b530ac5a.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57bebfe1-7f57-744c-a803-093f219cb451@infradead.org>
Date:   Fri, 9 Oct 2020 10:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <60aeaadf670271ee69a47f5eff3f6bf7b530ac5a.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:50 AM, Thorsten Leemhuis wrote:
> Users should know that sending the report is not the end of this
> process: if want to see the issue fixed, they will need to keep the ball
> rolling sometimes. Hence, explain why it's in their interest to send a
> reminder occasionally. Als point out that it's a really good idea to
> retest shortly after the rc1 of a new mainline release came out.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> 
> = RFC =
> 
> This commit removes a section from the old text that kinda tells maintainers
> what users can expect from them. Should this be made more explicit in the Kernel
> Maintainer Handbook? Maybe something along the lines of "Try to answer each
> issue report at least once, ideally within 1 to 5 business days"?
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 222 +++++++++++++++----
>  1 file changed, 180 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index b06935cad880..b8bc6c4e2340 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -1043,6 +1043,186 @@ High priority issues need special handling when sending the report:
>     information.
>  
>  
> +Duties after the report went out
> +--------------------------------
> +
> +    *Wait for reactions and keep the thing rolling until you can accept the
> +    outcome in one way or the other. Thus react publicly and in a timely manner
> +    to any inquiries. Test proposed fixes. Do proactive testing when a new rc1
> +    gets released. Sent friendly reminders if things stall. And try to help

                      Send

> +    yourself, if you don't get any help or if it is unsatisfying.*
> +
> +If your report was good and you are really lucky then one of the developers
> +might immediately spot what's causing the issue; then he might write a patch to
> +fix it, test it, and sends it straight for integration in mainline while

                        send

> +tagging it for later backport to stable and longterm kernels that need it. Then
> +all you need to do is reply with a 'Thank you very much' and switch to a
> +version with the fix once it gets released.
> +
> +But this ideal scenario rarely happens, that's why the job is only starting once

                                  happens. That's

> +you got the report out. What you'll have to do depends on the issue, but often
> +it will be the things listed below. But before digging into the details a few

                                                                   details, here are a few

> +important things you need to keep in mind for this part of the process.
> +
> +General advice for further interactions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +*Always reply in public*: When the issue was filed in a bug tracker always
> +reply there and do not contact any of the developer privately about it. For

                                             developers

> +mailed reports always use the 'Reply-all' function when replying to any mails
> +you receive. That includes mails with any additional data you might want to add
> +to your report: go to your mail applications 'Sent' folder and use 'reply-all'
> +on your mail with the report. This approach will make sure the public mailing
> +list(s) and everyone else that gets involved over time always stays in the
> +loop; it also keeps the mail thread intact, which among others is really
> +important for mailing list to group all related mails together.
> +
> +There are just two situations where a comment in a bug tracker or a 'Reply-all'
> +is unsuitable:
> +
> + * Someone tells you to send something privately.
> +
> + * You were told to sent something, but noticed it contains sensitive

                       send

> +   information that really needs to be kept private. In that case it's okay to
> +   sent it in private to the developer that asked for it. But point in the

      send                                                   But note in the

> +   ticket or a mail that you did that, so everyone else knows the request was
> +   honored.
> +
> +*Do research before asking for clarifications or help*: In this part of the
> +process someone might tell you to do something that requires a skill you might
> +not have mastered yet. For example, you might get ask to use some test tools

                                                 be asked

> +you never have heard of yet; or you might get asked to apply a patch to the

                                             be

> +Linux kernel sources to test if it helps. In some cases it will be fine sending
> +a reply asking for instructions how to do that. But before going that route try
> +to find the answer own your own by searching the internet; alternatively
> +consider asking a friend or in some chatroom/forum you normally hang out for
> +advice.
> +
> +*Be patient*: If you are really lucky you might get a reply to your report
> +within a few hours. But most of the time it will take longer, as maintainers
> +are scattered around the globe and thus might be in a different time zone – one
> +where they already enjoy their evening away from keyboard.
> +
> +In general, kernel developers will take one to five business days to respond to
> +reports. Sometimes it will take longer, as they might be busy with other work,
> +visiting developer conferences, or simply enjoying a long summer holiday.
> +
> +The 'issues of high priority' (see above for an explanation) are an exception
> +here: maintainer should address them as soon as possible, that's why you should

         maintainers                               possible; that's

> +wait a week at maximum (or just two days if it's something urgent) before
> +sending a friendly reminder. If the maintainer is not responding in a timely
> +manner or not handing it appropriately, mention that you are considering to
> +escalate the issue to a higher authority and do so if there is in the end

                                            and do so if there seems to be
no way around this.

although such a "threat" probably won't do much good.

> +there seems to be no way around this. In case of Wi-Fi driver code you for
> +example would escalate it to the wireless maintainers; if there are no higher
> +level maintainers or all else fails it might be one of those situations where
> +it's okay to get Linus Torvalds involved directly.
> +
> +*Proactive testing*: Every time the first pre-release (the 'rc1') of a new
> +mainline kernel version gets released, go and check if the issue is fixed there
> +or if anything of importance changed. Mention the outcome in the ticket or in a
> +reply to the report (make sure it has all those in the CC that up to that point
> +participated in the discussion). This will show your commitment and that you
> +are willing to help. It also tells developers if the issue persists and makes
> +sure they do not forget about it. A few other occasional retests (for example
> +with rc3, rc6 and the final) are also a good idea, but only report your results
> +if something relevant changed or if you are writing something anyway.
> +
> +With all these general things off the table let's get into the details how to

                                                                  details of how to

> +help to get issues resolved once they were reported.
> +
> +Inquires and testing request
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Here are your duties in case you got replies to your report:
> +
> + *Check who you deal with*: Most of the time it will be the maintainer or a
> + developer of the particular code area that will respond to your report. But as
> + issues are normally reported in public it could be anyone that's replying —
> + including people that want to help, but in the end might guide you totally off
> + track with their questions or requests. That rarely happens, but it's one of
> + many reasons why it's wise to quickly run an internet search to see who you're
> + interacting with. You also get aware if your report was heard by the right
> + people, as a reminder to the maintainer (see below) might be in order later if
> + discussion fades out and does not lead to a fix.
> +
> + *Inquires for data*: Often you will be asked to test something or provide

     Inquiries

> + additional details. Try to provide the information requested soon, as you have
> + the attention of someone that might help and risk losing it the longer you
> + wait; that outcome is even likely if you do not provide the information within
> + a few business days.
> +
> + *Requests for testing*: When you get asked to test a diagnostic patch or a

                                     are

> + possible fix try to test it in timely manner, too. Do it properly and make

             fix,

> + sure to not rush it: mixing things up can happen easily and lead to a lot
> + of confusion for everyone involved. A common mistake for example is thinking a
> + kernel patch that might fix the issue was applied, but in fact wasn't – even
> + experienced testers make such mistakes occasionally and only notice when the
> + kernel built from those sources behaves just as before.
> +
> +What to do when nothing of substance happens
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Some report will not get any reaction from the responsible Linux kernel

        reports

> +developers; or a discussion around the issue evolved, but it faded out and
> +nothing of substance came out of it.
> +
> +In these cases wait two (better: three) weeks before sending a friendly
> +reminder: maybe the maintainer was just away from keyboard for a while when
> +your report arrived or had something more important to take care of. When
> +writing the reminder, kindly ask if anything else from your side is needed to
> +get the ball running somehow. If the report got out by mail do that in the first
> +lines of a mail that is a reply to your initial mail (see above) which includes
> +a full quote of the original report below: that's on of those few situations
> +where such a 'TOFU' (Text Over, Fullquote Under) is the right approach, as then
> +all the recipients will have the details at hand immediately in the proper
> +order.
> +
> +After the reminder wait three more weeks for replies. If you still don't get a
> +proper reaction, you first should reconsider your approach. Did you maybe try
> +to reach out to the wrong people? Was the report maybe offensive or so
> +confusing that people decided to completely stay away from it? The best way to
> +rule out such factors: show the report to one or two people familiar with FLOSS
> +issue reporting and ask for their option. Also ask them for their advice how to

                                     opinion.

> +move forward. That might mean: prepare a better report and make those people
> +review it before you sent it out. Such an approach it totally fine, just

                        send                          is         fine; just

> +mentions that this is the second and improved report on the issue and include a

   mention

> +link to the first report.
> +
> +If the report was proper you can send a second reminder; in it ask for advice
> +why the report did not get any replies. A good moment for this second reminder
> +mail is shortly after the first pre-release (the 'rc1') of a new Linux kernel
> +version got published, as you should retest at that point anyway (see above).
> +
> +If the second reminder again results in no reaction within a week, try to
> +contact a higher-level maintainer asking for advice: even busy maintainers by
> +then should at least have sent some kind of acknowledgment.
> +
> +Remember to prepare yourself for a disappointment: maintainers ideally should
> +react somehow to every issue report, but they are only obliged to fix those
> +'issues of high priority' outlined earlier. So don't be too devastating if you
> +get a  reply along the lines of 'thanks for the report, I have more important
> +issues to deal with currently and won't have time to look into this for the
> +foreseeable future'.
> +
> +It's also possible that after some discussion in the bug tracker or one a list

                                                                       on a list

> +nothing happens anymore and reminders don't help to motivate anyone to work out
> +a fix. Such situations can be devastating, but is within the cards when if

                                                                           it

> +comes to Linux kernel development. This and sore other reasons for not getting

                                               several

> +help are explained in 'Why some issues won't get any reaction or remain unfixed
> +after being reported' near the end of this document.
> +
> +Don't get devastated if you don't get any help or if the issue in the end does
> +not get solved: as this the Linux kernel is FLOSS and thus you can still help
> +yourself. Find others that are affected and try to team up with them to get the
> +issue resolved. You for example can prepare a fresh report together that
> +mentions how many you are and why this is something that in your option should
> +get fixed. Maybe together you can also narrow down the root cause or the change
> +that introduced a regression, which often makes developing a fix easier. And
> +with a bit of luck there might be someone in the team that knows a bit about
> +programming and might be able to write a fix.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.


-- 
~Randy

