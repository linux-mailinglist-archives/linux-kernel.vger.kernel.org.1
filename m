Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41A3280C69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 05:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgJBDCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 23:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBDCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 23:02:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E4C0613D0;
        Thu,  1 Oct 2020 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=pd+j3bMFafn0zVlS2meL8ct9XbbxZuMfPtMJZP0ojqU=; b=VQNWcPb2WEviNMgJDn0kV9Fpt6
        nB9ycMWHfABAXF11cpkwpNJVdWtSbVZ5v+5wVA8vFojZKTb7wIziDP+JcqIdXX5VZEX3K1wm2vWn/
        oiv8phP8iaIJ7Mr4tnxgtcJqlshdbg0tfwouwWu1pShtgGgJhEAd+XmCvCDzaMmB/XtLk/JS+9AzC
        jEwWpxk/FoiCTe3rwk41EXqO/DQwBeKXkjYZLJyxFNJ1Syk8L/Yo6W/jgGK5uvcD79qagSV7j3fcL
        X5ZlmHB6s/yGkAkoMnbPuMC8YdghT6xjCBDrVYV3Kaca5h5/+9ntJdDOGLjqWlEf0XHEmH5/+Xa+C
        W+1dtsFg==;
Received: from [2601:1c0:6280:3f0::863]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOBKr-0005uD-Ev; Fri, 02 Oct 2020 03:02:17 +0000
Subject: Re: [RFC PATCH v1 03/26] docs: reporting-bugs: step-by-step guide on
 how to report issues
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <0c647add40e56b403bc17e9de1430917aa88bacb.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3f8a3a67-9e04-80a6-e540-c4c511dc4546@infradead.org>
Date:   Thu, 1 Oct 2020 20:02:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0c647add40e56b403bc17e9de1430917aa88bacb.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 103 +++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 7bde6f32ff72..203df36af55f 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -53,6 +53,109 @@ Security issues are typically best report privately; also CC the security team
>  or forward your report there.
>  
>  
> +Step-by-step guide how to report issues to the kernel maintainers
> +=================================================================
> +
> +Above TL;DR outlines roughly how to report issues to the Linux kernel

   The above

> +developers. It might be all that's needed for people already familiar with
> +reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
> +everyone else there is this section. It is more detailed and uses a
> +step-by-step approach. It still tries to be brief for readability; if it's to

                                                                              too

> +brief for you, look up the details in the reference section below, where each
> +of the steps is explained in more detail.
> +
> +Note, this section covers a few more aspects than the TL;DR and does things in a

   Note:

> +slightly different order. That's in your interest, to make sure you notice early
> +if an issue that looks like a Linux kernel problem is actually caused by
> +something else. These steps thus help to ensure the time you invest in this
> +process won't feel wasted in the end:
> +
> + * Stop reading this document and report the problem to your vendor instead,
> +   unless you are running a vanilla mainline kernel already or are willing to
> +   install it.
> +
> + * See if the issue you are dealing with qualifies as regression, security
> +   issue, or a really severe problem: those are 'issues of high priority' that
> +   need special handling in some steps that are about to follow.
> +
> + * Check if your kernel was 'tainted' when the issue occurred, as the event that
> +   made the kernel set this flag might be causing the issue you face.
> +
> + * Locate the driver or kernel subsystem that seems to be causing the issue.
> +   Find out how and where its developers expect reports. Note: most of the time
> +   this won't be `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as issues
> +   typically need to be sent by mail to a maintainer and a public mailing list.
> +
> + * Search the archives of the bug tracker or mailing list in question
> +   thoroughly for reports that might match your issue. Also check if you find
> +   something with your favorite internet search engine or in the `Linux Kernel
> +   Mailing List (LKML) archives <https://lore.kernel.org/lkml/>`_. If you find
> +   anything, join the discussion instead of sending a new report.
> +
> + * Create a fresh backup and put system repair and restore tools at hand.
> +
> + * Ensure your system does not enhance its kernels by building additional
> +   kernel modules on-the-fly locally, which solutions like DKMS might be doing
> +   without your knowledge.
> +
> + * Make sure it's not the kernels surroundings that are causing the issue you

                             kernel's

> +   face.
> +
> + * Write down coarsely how to reproduce the issue. If you deal with multiple
> +   issue at once, create separate notes for each of them and make sure they

      issues

> +   work independently on a freshly booted system. That's needed, as each issue
> +   needs to get reported to the kernel developers separately, unless they are
> +   strongly entangled.
> +
> +After these preparations you'll now enter the main part:
> +
> + * Install the latest Linux mainline kernel: that's where all issue get fixed
> +   first, because it's the version line the kernel developers mainly care about.
> +   Testing and reporting with the latest Linux stable kernel can be acceptable

                                                                can be an acceptable

> +   alternative in some situations, but is best avoided.
> +
> + * Ensure the kernel you just installed does not 'taint' itself when running.
> +
> + * Reproduce the issue with the kernel you just installed. If it doesn't show up
> +   there, head over to the instructions for issues only happening with stable
> +   and longterm kernels if you want to see it fixed there.

Can you link (reference) to that section?

> +
> + * Optimize your notes: try to find and write the most straightforward way to
> +   reproduce your issue. Make sure the end result has all the important details,
> +   and at the same time is easy to read and understand for others that hear
> +   about it for the first time. And if you learned something in this process,
> +   consider searching again for existing reports about the issue.
> +
> + * If the failure includes a stack dump, like an Oops does, consider decoding it
> +   to find the offending line of code.

Refer to scripts/decodecode ?
or is that done elsewhere?

> +
> + * If your problem is a regression, try to narrow down when the issue was
> +   introduced as much as possible.
> +
> + * Start to compile the report by writing a detailed description about the
> +   issue. Always mentions a few things: the latest kernel version you installed
> +   for reproducing, the Linux Distribution used, and your notes how to

I would say:                                                 notes on how to
Maybe it's just me.

> +   reproduce the issue. Ideally, make the kernels build configuration (.config)

                                             kernel's

> +   and the output from ``dmesg`` available somewhere on the net and link to it.
> +   Include or upload all other information that might be relevant, like the
> +   output/screenshot of an Oops or the output from ``lspci``. Once you
> +   wrote this main part insert a normal length paragraph on top of it outlining

                      part, insert

> +   the issue and the impact quickly. On top of this add one sentence that
> +   briefly describes the problem and gets people to read on. Now give the thing
> +   a descriptive title or subject that yet again is shorter. Then you're ready
> +   to send or file the report like the `MAINTAINERS file
> +   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
> +   told you, unless you are dealing with one of those 'issues of high priority':

      tells you,

OK, I like present tense as much as possible.

> +   they need special care which is explained in 'Special handling for high
> +   priority issues' below.

Can we provide a link to that section here?

> +
> + * Wait for reactions and keep the thing rolling until you can accept the
> +   outcome in one way or the other. Thus react publicly and in a timely manner
> +   to any inquiries. Test proposed fixes. Do proactive testing when a new rc1

                                                                  when a new -rc
(release candidate) is released. Send

> +   gets released. Sent friendly reminders if things stall. And try to help
> +   yourself, if you don't get any help or if it is unsatisfying.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

