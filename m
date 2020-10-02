Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677EE281A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgJBRvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbgJBRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:51:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C4BC0613D0;
        Fri,  2 Oct 2020 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EEZmQARKM0eSEl3lpWdQ92Pu0V+oAW6k2XrCDHUZXrw=; b=KwhW8VX5PFWlEurekbN1+z9kWU
        K9lxEvKq1RI6kq9w8QzAU1bKqPki6v1DWBNzsruCrx+0Aau2F9P37es9WXdOIKv9QVG+9hqYdeuu3
        ZR5UyyBge+6Ha/A3P2oqKB6fTKakMqZ3AWiRalJhImacBJbJXJq9hN1AordNmN8ESwgy6m3/pd5I+
        /Q+KElXKWAoXk0q3LdWQi3r5Li7FF9lj8IvjN5NJjYrtDT7zzrJptiSuzKs1odaoXzZnk/oN+L2/a
        iU0kL3is2eMjTjHc7N01e9uMdd49gGAlHtz3Y5KPiCzVHlrH4FX/OAp/L5UUU7mETr/CfjQ6ZCSJV
        lKxRY/Uw==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOPD4-0006wo-9a; Fri, 02 Oct 2020 17:51:10 +0000
Subject: Re: [RFC PATCH v1 15/26] docs: reporting-bugs: make readers test
 mainline, but leave a loophole
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <e9166fcbb777e9b7685745e572ab7c7322596ec2.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <275187e0-92b5-d0a6-0bf7-76c827e2c808@infradead.org>
Date:   Fri, 2 Oct 2020 10:51:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e9166fcbb777e9b7685745e572ab7c7322596ec2.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Now that the document described all preparatory steps tell users to
> install the latest kernel. Try pretty hard to motivate them installing a
> mainline kernel, as that is best for reporting issues. Mention the
> latest stable kernel as an acceptable alternative, but discourage this
> option. Point out that longterm kernels are unsuitable.
> 
> While at it, provide a few hints how to obtain a fresh kernel. Also
> explain how to find out what the latest version actually is. And mention
> why it might be a good idea to wait till the end of the merge window
> when reporting issues.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> 
> = RFC =
> 
> Am I asking for too much from users by telling them to test mainline? But most
> will likely have an outdated and heavily patched vendor kernel anyway, so they
> have to install a vanilla kernel if they want to report something upstream;
> that's why I thought "well, then let's go all in and make them test mainline.

That is appropriate IMO.

> ---
>  Documentation/admin-guide/reporting-bugs.rst | 88 ++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index f99d92a05bca..dee6d65aa95c 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -643,6 +643,94 @@ hardware apart from a kernel issue that rarely happens and thus is hard to
>  reproduce.
>  
>  
> +Install the latest mainline kernel
> +----------------------------------
> +
> +    *Install the latest Linux mainline kernel: that's where all issue get fixed

                                                                   issues

> +    first, because it's the version line the kernel developers mainly care
> +    about. Testing and reporting with the latest Linux stable kernel can be
> +    acceptable alternative in some situations, but is best avoided.*

       an acceptable

> +
> +Reporting an issue to the Linux kernel developers they fixed a while ago is
> +annoying for them and wasting their and your time. That's why it's in
> +everybody's interest to check if the issue occurs with the latest version before
> +reporting it.
> +
> +In the scope of the Linux kernel the term 'latest' means: a kernel version
> +recently created from the main line of development, as this 'mainline' tree is
> +where every fix gets applied to first; only later they are allowed to get
> +backported to older, still support version lines called 'stable' and 'longterm'

                              supported

> +kernels. That's why it's a prerequisite to check mainline even if just want to

                                                             even if you just want to

> +see the issue fixed in one of those. Another reasons: sometimes fixes for an

                       in one of those other version lines. Another reason:


> +issue are only applied to mainline, as they are too risky to get backported
> +into older version lines where they thus remain unfixed.
> +
> +It's thus in your and everybody's else interest to reproduce the issue with a

                         everybody else's

> +fresh mainline kernel before reporting it. Reproducing it with the latest Linux
> +'stable' kernel can be acceptable alternative, if you can't test mainline for
> +some reason; this is not ideal, but better than not reporting the issue at all.
> +
> +Avoid testing with one of the longterm kernels (sometimes called "LTS kernels"),
> +they are too distant from current development; the same is also true for

   as they are too distant

> +mainline or stable kernels that are not very recent, as there is a new release
> +of those nearly every week.
> +
> +Ways to obtains a fresh vanilla kernel
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +One way to get the latest mainline or stable kernel in a vanilla fashion is to
> +download the Linux sources from `kernel.org <https://kernel.org/>`_ and build a
> +kernel image and modules from them yourself. How to do that is not described
> +here, as many texts on the internet explain the necessary steps already. If you
> +are new to it, consider following one of those how-to's that suggest to use
> +``make localmodconfig``, as that tries to pick up the configuration of your
> +current kernel and then tries to adjust it somewhat for your system. That does
> +not make the resulting kernel any better, but makes it compile a lot faster.
> +
> +There might be a way around building your own kernel, if you are in a luck: for

                                                                    in luck: for

> +popular Linux distribution you'll find repositories on the net that offer
> +packages with of the latest mainline or stable Linux vanilla kernels for easy
> +installation. It's totally okay to use packages with these pre-compiled kernels,
> +just make sure from the repository's documentation they are supposed to be
> +'vanilla', for reasons outlined in the first step of this process. And be aware
> +that you might need to build your own kernel later anyway when it comes to
> +testing fixes, as described later in this document.
> +
> +Finding the latest Linux version
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To check what the latest mainline release actually is, go to `kernel.org
> +<https://kernel.org/>`_. Ignore the big yellow button that says 'Latest
> +release': that points to the latest stable release, which you normally don't
> +want to use.
> +
> +Instead, look a little lower for a table for a line with the description

                                            with a line with the description

> +'mainline', which you'll find at the top of that table. Most of the time
> +'mainline' will point to a pre-release with a version number like '5.8-rc2'. In
> +that case that's the version you want to test. Do not let that 'rc' scare you,
> +these 'development kernels' are pretty reliable — and you have a backup, like we
> +told you above, don't you?
> +
> +In about two out of every nine to ten weeks, 'mainline' might point you to a
> +proper release with a version number like '5.7'. If that happens consider
> +suspending the reporting process for a while, as the Linux development cycle is
> +currently in its two-week long 'merge window'. That's where the bulk of the
> +changes (and all intrusive ones) get merged for the next release, before its
> +first pre-release is published (5.8-rc1). Kernel developers are often quite
> +busy during this time period and might have no spare time to deal with issue
> +reports. It's also quite possible that one of the many changes applied during
> +the merge window fixes the issue you face; that's why you soon would have to
> +retest with a newer kernel version anyway, as outlined below in the section
> +'Duties after the report when out'. Therefor it's often wise to wait for the

                                       Therefore

> +first pre-release before proceeding with this step, unless you're dealing with
> +one of those 'issues of high priority' or one that can't wait for a good reason.
> +
> +Feel free to ignore the past three paragraphs if you are a developer, Linux
> +kernel expert, or brave; instead simply get the latest Linux kernel sources
> +using ``git`` straight from the `official development repository on kernel.org
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

