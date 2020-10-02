Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA434280C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 04:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgJBCcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 22:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBCcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 22:32:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFDC0613D0;
        Thu,  1 Oct 2020 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wPGrTQdcs2/cO8Q649fYYzCOxPbUtGbjpgsn89Uuwyg=; b=O9oLmxe9/TKMeH/EETREHh6ANI
        nz2GmtUt4NPWo4UEMy2NVdHScYfKIiBTvLtQAJgfzTT2cNHIcoO6MFNzopuco4gUbO74rm4QLWKVa
        xcNGwoE7kgam/luHnTtWq4uE/SqW2TzDLpjw1nhKXQ5u2HedmCnDAjEQj5QDu2JCcf4j3gIxPpwLo
        RArCng+hMikFQZyUHdRkK580yzhWkBLFfypclVcoFAo3HhWGU1cGTgVSIqX4jf9YVHyhhY5LB4qJf
        4yvmLMKafZ6nQ7Zj4fhwOmoO1DLsLgaotDH9JYVTNY4oox7hiODlKoOsBJF+FbJgx6EomLsNDSL+h
        xr3XXzsA==;
Received: from [2601:1c0:6280:3f0::863]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOArh-00045V-1p; Fri, 02 Oct 2020 02:32:09 +0000
Subject: Re: [RFC PATCH v1 02/26] docs: reporting-bugs: Create a TLDR how to
 report issues
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <dc293f6d4f71ea827c861c64e88dfa0316f1d934.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f3fce56-fdc4-c248-05ec-4fda1ee6fc54@infradead.org>
Date:   Thu, 1 Oct 2020 19:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <dc293f6d4f71ea827c861c64e88dfa0316f1d934.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Get straight to the point in a few paragraphs instead of forcing users
> to read quite a bit of text, like the old approach did.
> 
> All normally needed fits into the first two paragraphs. The third is
> dedicated to issues only happening in stable and longterm kernels, as
> things otherwise get hard to follow. At the end explicitly spell out
> that some issues need to be handled slightly different.
> 
> This TLDR naturally leaves lots of details out. But it will be good
> enough in some situations, for example for users that recently reported
> an issue or are familiar with reporting issues to FLOSS projects.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 43 ++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 4bbb9132782b..7bde6f32ff72 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -10,6 +10,49 @@ Reporting bugs
>  .. inconsistent/not make sense before all patches of the rewrite got applied.
>  .. ###########################################################################
>  
> +
> +The short guide (aka TL;DR)
> +===========================
> +
> +This is how you report issues with the Linux kernel to its developers:
> +
> +If you deal with multiple issues at once, process each of them separately. Try
> +your best guess which area of the kernel might be responsible for your issue.
> +Check the `MAINTAINERS file
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
> +how developers of that particular area expect to be told about issues; note,

   for how
?

> +it's rarely `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as most
> +subsystems expect reports by mail sent to their maintainers and their public
> +mailing list!
> +
> +Check the archives of the determined destination thoroughly for existing
> +reports; also search the LKML archives and the internet as a whole. If you can't
> +find any, install the `latest Linux mainline version <https://kernel.org/>`_.
> +Make sure to use a vanilla kernel and avert any add-on kernel modules externally
> +developed; also ensure the kernel is running in a healthy environment and does
> +not 'taint' itself before the issue occurs. If you can reproduce it, write a

I don't care for "does not 'taint' itself". How about
                                                                         and is not
   already tainted before the issue occurs.

> +report to the destination you determined earlier. Afterwards keep the ball
> +rolling by proactive testing, a status update now and then, and helping where
> +you can.
> +
> +You can't reproduce an issue with mainline you want to see fixed in older
> +version lines? Then make sure the line you care about still gets support.
> +Install its latest release as vanilla kernel. If you can reproduce the issue

Is "vanilla" well understood?

> +there, try to find the commit that fixed it in mainline or any discussion
> +preceding it: those will often mention if backporting is planed or impossible;
> +if not, ask for it. In case you don't find anything, check if it's a regression
> +specific to the version line that need to be bisected and report just like a

                                that needs

> +problem in mainline with the stable mailing list CCed. If you reached this point
> +without a solution, ask for advice by mailing the subsystem maintainer with the
> +subsystem and stable mailing list in CC.
> +
> +If you deal with a regression, bisect it to find the culprit and CC or forward
> +your report to its developers.
> +
> +Security issues are typically best report privately; also CC the security team

                                      reported

> +or forward your report there.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

