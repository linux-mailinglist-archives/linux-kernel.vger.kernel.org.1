Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DF0289150
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgJISm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgJISm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:42:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85800C0613D2;
        Fri,  9 Oct 2020 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=khfxKWiNX3qFzSkEltKQhd15dNeJGI+p+CjG+G7danE=; b=rAnpItzH42ALE50VSa1bLfifbW
        hSzTz/fjCSNXt5pyvMPd7WrI5awQqIikjxx671K/yMFXkUd4GEC3QK79fo0L2bfcT8v6h7L08q99e
        wsPVPATusMYFMNLgXGcVeBFgCxZUK/f87L4KiawybQqqR9xDqojYqOmw2hOh8Nh42/jlqLtnisf6m
        otxW3rnsEE87/GtyM//7ohvnnZpg5rrnc8m9ZF70smznSVApVwN+7jILIEGa7zMbMjcOfHZaVA4tl
        JBs3XvjWWyR2Zb40DfyApq0oDk7kKJkjheCzOwJcr87YYtjs5ZYs5bIGmK357WGxCHZRz4L6xinS4
        6Qz5nCRQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQxLU-0005NV-2G; Fri, 09 Oct 2020 18:42:24 +0000
Subject: Re: [RFC PATCH v1 23/26] docs: reporting-bugs: details for issues
 specific to stable and longterm
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <2cc7172602eecefc12b4f870dd0be143524bd4bc.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aa333881-a899-ece7-da2b-fd4b66e3f6d6@infradead.org>
Date:   Fri, 9 Oct 2020 11:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2cc7172602eecefc12b4f870dd0be143524bd4bc.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:50 AM, Thorsten Leemhuis wrote:
> Describe what users have to do if they can't reproduce a problem with
> mainline they want to see fixed in stable and longterm kernels. This is
> separated from the main flow, as integrating it there would make it
> harder to follow.
> 
> Note users will only enter this section in two cases: (1) the issue was
> fixed in mainline (on purpose or accidentally) (2) it's a regression

                                   accidentally); (2)

> that never was present in mainline (for example due to a broken
> backport).
> 
> Help users to differentiate between the two, as they ideally are handled
> differently.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 191 +++++++++++++++++--
>  1 file changed, 179 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index b8bc6c4e2340..340fa44b352c 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -1223,24 +1223,191 @@ with a bit of luck there might be someone in the team that knows a bit about
>  programming and might be able to write a fix.
>  
>  
> +Details about reporting issues only occurring in older kernel version lines
> +---------------------------------------------------------------------------
> +
> +Find below details about the steps in the subsection for reporting issues that
> +only happen in stable and longterm kernels.
> +
> +
> +Some fixes are too complex
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +    *Prepare yourself for the possibility that going through the next few steps
> +    might not get the issue solved in older releases: the fix might be too big
> +    or risky to get backported there.*
> +
> +Even small and seemingly obvious code-changes sometimes introduce new and
> +totally unexpected problems. The maintainers of the stable and longterm kernels
> +are very aware of that and thus only apply changes to these kernels that are
> +:ref:`within rules outlined in Documentation/process/stable-kernel-rules.rst
> +<stable_kernel_rules>`.
> +
> +Complex or risky changes for example do not qualify and thus only get applied to
> +mainline; sometimes fixes are easy to get backported to the newest stable and
> +longterm kernels, but too risky to integrate into older ones. So be aware the
> +fix you are hoping for might be one of those and that you have no other choice
> +then to live with the issue or switch to a newer version, unless you want to
> +patch the fix into your own kernels yourselfs.

                                       yourself.

> +
> +
> +Make sure the particular version line is still supported
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +    *Check if the kernel developers still maintain the Linux kernel version line
> +    you care about: go to the front-page of kernel.org and make sure it mentions

                                 front page

> +    the latest release of the particular version line without an '[EOL]' tag.*
> +
> +Most kernel version lines only get supported for about three months, as
> +maintaining them longer is quite a lot of work. Hence, only one per year is
> +chosen and gets supported for at least two years (often six). That's why you
> +need to check if the kernel developer still support the version line you care

                               devlopers

> +for.
> +
> +Note: if kernel.org lists two 'stable' version lines, you likely want to focus
> +on the newer of the two, as support for the older is likely to be abandoned
> +soon and thus "end-of-life" (EOL). Version lines that reached that point still
> +get mentioned on the kernel.org-frontpage for a week or two, but then they are

                        kernel.org front page

> +unsuitable for testing and reporting.
> +
> +
> +Search stable mailing list
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +    *Check the archives of the Linux stable mailing list for existing reports.*
> +
> +Maybe the issue you face is already known and was fixed or is about to. Hence,
> +`search the archives of the Linux stable mailing list
> +<https://lore.kernel.org/stable/>`_ for reports about an issue like yours. If
> +you find any matches, consider joining the discussion, unless the fix is already
> +finished and scheduled to get applied soon.
> +
> +
> +Reproduce issue with the newest release
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +   *Install the latest release from the particular version line as a vanilla
> +   kernel. Ensure this kernel is not tainted and still shows the problem, as the
> +   issue might have already been fixed there.*
> +
> +Before investing any more time in this you want to check if the issue was
> +already fixed in the latest release of version line you're interested in. This
> +kernel needs to be vanilla and shouldn't be tainted before the issue happens, as
> +detailed outlined already above in the process of testing mainline.
> +
> +
> +Check code history and search for existing discussions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +    *Search the Linux kernel version control system for the change that fixed
> +    the issue in mainline, as its commit message might tell you if the fix is
> +    scheduled for backporting already. If you don't find anything that way,
> +    search the appropriate mailing lists for posts that discuss such an issue or
> +    peer-review possible fixes. That might lead you to the commit with the fix
> +    or tell you if it's unsuitable for backporting. If backporting was not
> +    considered at all, join the newest discussion, asking if its in the cards.*

                                                                it's

> +
> +In a lot of cases the issue you deal with, will have happened with mainline,

                                        with will

> +but got fixed there. The commit that fixed it would need to get backported as
> +well to get the issue solved. That why you want to search for it or any
> +discussions abound it.
> +
> + * First try to find the fix on the Git repository that holds the Linux kernel

I would say                     in
but maybe it doesn't matter.

> +   sources. You can do this with the web interfaces `on kernel.org
> +   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
> +   or its mirror `on GitHub <https://github.com/torvalds/linux>`_; if you have a
> +   local clone you alternatively can search on the command line with
> +   ``git log --grep=<pattern>``.
> +
> +   If you find the fix, look if the commit message near the end contains a
> +   'stable tag' that looks like this:
> +
> +          Cc: <stable@vger.kernel.org> # 5.4+
> +
> +   If that's case the developer marked the fix safe for backporting to version
> +   line 5.4 and later. Most of the time it's getting applied there within two
> +   weeks, but sometimes it takes a bit longer.
> +
> + * If the commit doesn't tell you anything or if you can't find the fix, look
> +   again for discussions about the issue. Search the net with your favorite
> +   internet    search engine as well as the archives for the `Linux kernel

              ^^^ too many spaces.

> +   developers mailing list <https://lore.kernel.org/lkml/>`_. Also read the
> +   section `Locate kernel area that causes the issue` above and follow the
> +   instructions to find  the subsystem in question: its bug tracker or mailing

                          ^^ drop one space.

> +   list archive might have the answer you are looking for.
> +
> +   * If you see a proposed fix, search for it in the version control system as
> +     outlined above, as the commit might tell you if a backport can be expected.
> +
> +   * Check the discussions for any indicators the fix might be too risky to get
> +     backported to the version line you care about. If that's the case you have
> +     to live with the issue or switch to the kernel version line where the fix
> +     got applied.
> +
> +   * If the fix doesn't contain a stable tag and backporting was not discussed,
> +     join the discussion: mention the version where you face the issue and that
> +     you would like to see it fixed, if suitable.
> +
> +
> +Check if it's a regression specific to stable or longterm kernels
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +    *Check if you're dealing with a regression that was never present in
> +    mainline by installing the first release of the version line you care about.
> +    If the issue doesn't show up with it, you basically need to report the issue
> +    with this version like you would report a problem with mainline (see above).
> +    This ideally includes a bisection followed by a search for existing reports
> +    on the net; with the help of the subject and the two relevant commit-ids. If
> +    that doesn't turn up anything, write the report; CC or forward the report to
> +    the stable maintainers, the stable mailing list, and those that authored the
> +    change. Include the shortened commit-id if you found the change that causes
> +    it.*
> +
> +Sometimes you won't find anything in the previous step: the issue you face might
> +have never occurred in mainline, as it its caused by some change that is

                                    as it is caused

> +incomplete or not correctly applied. To check this, install the first release
> +from version line you care about, e.g. if you care about 5.4.x, install 5.4.
> +
> +If the issue doesn't show itself there, it's a regression specific to the
> +particular version line. In that case you need to report it like an issue
> +happening in mainline, like the last few steps in the main section above

                                                  in the main section in the above

> +outline.
> +
> +One of them suggests doing a bisection, which you are strongly advised to do in
> +this case. After finding the culprit, search the net for existing reports again:
> +not only search for the exact subject and the commit-id (proper and shortened to
> +twelve characters) of the change, but also for the commit-id (proper and
> +shortened) mentioned as 'Upstream commit' in the commit message.
> +
> +Write the report, just keep a few specialties in mind: CC or forward the report

             report; just

> +to the stable maintainers, the stable mailing list, which the `MAINTAINERS file
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
> +mentions in the section "STABLE BRANCH". If you performed a successful
> +bisection, CC the author of the change and include its subject and the shortened
> +commit-id.
> +
> +Ask for advice
> +~~~~~~~~~~~~~~
> +
> +    *One of the former steps should lead to a solution. If that doesn't work
> +    out, ask the maintainers for the subsystem that seems to be causing the
> +    issue for advice; CC the mailing list for the particular subsystem as well
> +    as the stable mailing list.*
> +
> +If the previous three steps didn't get you closer to a solution there is only
> +one option left: ask for advice. Do that in a mail you sent to the maintainers
> +for the subsystem where the issue seems to have its roots; CC the mailing list
> +for the subsystem as well as the stable mailing list the `MAINTAINERS file
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
> +mention in the section "STABLE BRANCH".
> +
> +


-- 
~Randy

