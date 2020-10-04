Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7522B28287A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 06:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJDEDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 00:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgJDEDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 00:03:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A63C0613CE;
        Sat,  3 Oct 2020 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eVh3e7AfStrrTBvDoNAkIk/GhPVsgabPyX7WZ1hyuo0=; b=zQNUmIwxewnBI4vSOjy4AcQ4Wh
        HE5P/lDakCLoGH3+n0LgblCZw8GwYkRDFutBaTovnYZwgJvK8QwgPP+YWrtrxSG4/98fZleuI7MMG
        gTXzdqy/1OSCyfWIGVjpaiw7jvKGmMDlQz/FKnR/cHmn4gR8TU2Z1i6Y975c+4FUcWJVXM4ErgPSd
        cPbjzahIyDAHTmkTrpA6fK2YjOLln0/BlLRCPbj4ChQdgIsxUEUNGD46Oa+FEv1roQ5T2V4ImsLbI
        VXTzqUUfLPcFbiBF6J84EvRMb5D3n4xaK4RzMfoF+ubQV92kwEdnJrQ2Na7gMQs1c9Cwn1ALxN8C5
        16zkd2tA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOvEm-00054b-CY; Sun, 04 Oct 2020 04:03:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v1 20/26] docs: reporting-bugs: instructions for
 handling regressions
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <7071ace5086f39ceaa2b1ffcc3bc774f362b4aa7.1601541165.git.linux@leemhuis.info>
Message-ID: <06589a41-94c8-dc94-247f-71390a5d99c9@infradead.org>
Date:   Sat, 3 Oct 2020 21:03:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7071ace5086f39ceaa2b1ffcc3bc774f362b4aa7.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Describe what users will have to do if they deal with a regression.
> Point out that bisection is really important.
> 
> While at it explicitly mention the .config files for the newer kernel
> needs to be similar to the old kernel, as that's an important detail
> quite a few people seem to miss sometimes.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/bug-bisect.rst     |  2 +
>  Documentation/admin-guide/reporting-bugs.rst | 53 ++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
> index 59567da344e8..38d9dbe7177d 100644
> --- a/Documentation/admin-guide/bug-bisect.rst
> +++ b/Documentation/admin-guide/bug-bisect.rst
> @@ -1,3 +1,5 @@
> +.. _bugbisect:
> +
>  Bisecting a bug
>  +++++++++++++++
>  
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index e1219e56979f..71c49347c544 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -792,6 +792,59 @@ sometimes needs to get decoded to be readable, which is explained in
>  admin-guide/bug-hunting.rst.
>  
>  
> +Special care for regressions
> +----------------------------
> +
> +    *If your problem is a regression, try to narrow down when the issue was
> +    introduced as much as possible.*
> +
> +Linux lead developer Linus Torvalds insists that the Linux kernel never
> +worsens, that's why he deems regressions as unacceptable and wants to see them
> +fixed quickly. That's why changes that introduced a regression are often
> +promptly reverted if the issue they cause can't get solved quickly any other
> +way. Reporting a regression is thus a bit like playing a kind of trump card to
> +get something quickly fixed. But for that to happen the culprit needs to be
> +known. Normally it's up to the reporter to track down the change that's causing
> +the regression, as maintainers often won't have the time or setup at hand to
> +reproduce it themselves.
> +
> +To find the culprit there is a process called 'bisection' which the document
> +:ref:`Documentation/admin-guide/bug-bisect.rst <bugbisect>` describes in detail.
> +That process will often require you to build about ten to twenty kernel images
> +and test each of them for the issue. Yes, that takes some time, but 't worry,

                                                                   but don't worry,

> +it works a lot quicker than most people assume. Thanks to a 'binary search' this
> +will lead you to the one commit in the source code management system that's
> +causing the regression. Once you found it, serch the net for the subject of the

                                    find it, search

Often it can find the bad commit, but sometimes it fails. It's not always perfect.

> +change, its commit id and the shortened commit id (the first 12 characters of
> +the commit id). This will lead you to exisiting reports about it, if there are

                                         existing

> +any.
> +
> +Note, a bisection needs a bit of know-how, which not everyone has, and quite a
> +bit of effort, which not everyone is willing to invest. Nevertheless, it's
> +highly recommended performing a bisection yourself. If you really can't or don't

I would say:
   highly recommended to perform a bisection yourself.

> +want to go down that route at least find out which mainline kernel introduced
> +the regression. If something for example breaks when switching from 5.5.15 to
> +5.8.4, then try at least all the mainline releases in that area (5.6, 5.7 and
> +5.8) to check when it first showed up. Unless you're trying to find a regression
> +in a stable or longterm kernel, avoid testing versions which number has three
> +sections (5.6.12, 5.7.8), as that can lead to confusion and might make your
> +testing useless. Then feel free to go further in the reporting process. But
> +keep in mind: if the developers will be able to help depend on the issue at

                                                        depends

> +hand. Sometimes the developers from the report will be able to recognize want
> +went wrong and fix it; other times they might be unable to help unless the
> +reporter performs a bisection.
> +
> +When dealing with regressions make sure the issue you face is really caused by
> +the kernel and not by something else, as outlined above already.
> +
> +In the whole process keep in mind: an issue only qualifies as regression if the
> +older and the newer kernel got build with a similar configuration. The best way

                                  built

> +to archive this: copy the configuration file (``.config``) from the old kernel
> +freshly to each newer kernel version you try. Afterwards run
> +``make oldnoconfig`` to adjust it for the needs of the new version without
> +enabling any new feature, as those are allowed to cause regressions.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

