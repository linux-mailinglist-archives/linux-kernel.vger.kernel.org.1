Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58B728287C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 06:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJDEDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 00:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgJDEDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 00:03:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0EC0613CE;
        Sat,  3 Oct 2020 21:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uosIuGqo5WrSfn/X7dmY/Vzi0c2BvZ+1dVG4/rwapaw=; b=Jl3WI5+2o9Xzmu2oBODrs461CX
        zvvloen5rtwR2vOKR0NVhpTkgA1hw4xYzDb9MDPrOQDwDJLdwcw20zNs0ha9yBUSJMNSuQEOTrRPp
        K7AqNWVS9Tb37l9KEu4N0bIFV/QJ+NVZ6WsJ07Rte1JmzWvF6qN3KerGVqbcwn6R+rpcej/XqH5D7
        3slSUPVO00WYN9kaIBVYZ5tu1GKb2QkkKZ8LNVSaUCYlgs71O12PB1oE1jJR3hnaB/UpmFXFalfxU
        oSIaXoGAj4qFBTWGPMUIu9AOBaQwOcxMwusrD3HsoegMoyvjHA0FSZGoTuoEeqye91z1rJS0UoPRY
        w4vIzR1A==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOvEu-00056B-GD; Sun, 04 Oct 2020 04:03:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v1 24/26] docs: reporting-bugs: explain why users
 might get neither reply nor fix
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <aac1d02c1ca7d4a20dfe47ae6f824e1091c654e3.1601541165.git.linux@leemhuis.info>
Message-ID: <3f495f9f-7daf-861f-6c84-e28eb91e7a4e@infradead.org>
Date:   Sat, 3 Oct 2020 21:03:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <aac1d02c1ca7d4a20dfe47ae6f824e1091c654e3.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:50 AM, Thorsten Leemhuis wrote:
> Not even getting a reply after one invested quite a bit of time with
> preparing and writing a report can be quite devastating. But when it
> comes to Linux, this can easily happen for good or bad reasons. Hence,
> use this opportunity to explain why this might happen, hopefully some
> people then will be less disappointed if it happens.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 56 ++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 340fa44b352c..8f60af27635b 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -1402,6 +1402,62 @@ for the subsystem as well as the stable mailing list the `MAINTAINERS file
>  mention in the section "STABLE BRANCH".
>  
>  
> +Why some issues won't get any reaction or remain unfixed after being reported
> +=============================================================================
> +
> +When reporting a problem to the Linux developers, be aware only 'issues of high
> +priority' (regression, security issue, severe problems) are definitely going to
> +get resolved. The maintainers or if all else fails Linus Torvalds himself will
> +make sure of that. They and the other kernel developers will fix a lot of other
> +issues as well. But be aware that sometimes they can't or won't help; and
> +sometimes there isn't even anyone to send a report to.
> +
> +This is best explained with kernel developers that contribute to the Linux
> +kernel in their spare time. Quite a few of the drivers in the kernel were
> +written by such programmers, often because they simply wanted to make their
> +hardware usable on their favorite operating system.
> +
> +These programmers most of the time will happily fix problems other people
> +report. But nobody can force them to do, as they are contributing voluntarily.
> +
> +Then there are situations where such developers really want to fix an issue,
> +but can't: they lack hardware programming documentation to do so. This often
> +happens when the publicly available docs are superficial or the driver was
> +written with the help of reverse engineering.
> +
> +Sooner or later spare time developers will also stop caring for the driver.
> +Maybe their test hardware broke, got replaced by something more fancy, or is so
> +old that it's something you don't find much outside of computer museums
> +anymore. Or the developer stops caring for their code and Linux at all, as
> +something different in their life became way more important. Sometimes nobody
> +is willing to take over the job as maintainer – and nobody can be forced to, as
> +contributing to the Linux kernel is done on a voluntary basis. Abandoned
> +drivers nevertheless remain in the kernel: they are still useful for people and
> +removing would be a regression.
> +
> +The situation is not that different with developers that are paid for their
> +work on the Linux kernel. Those contribute most changes these days. But their
> +employers sooner or later also stop caring for some code and make its programmer
> +focus on other thing. Hardware vendors for example earn their money mainly by

         on other things.

> +selling new hardware; quite a few of them hence are not investing much time and
> +energy in maintaining a Linux kernel driver for something they sold years ago.
> +Enterprise Linux distributors often care for a longer time period, but in new
> +version often leave support for old and rare hardware aside to limit the scope.
> +Often spare time contributors take over once a company leaves some orphan some

                                                                  drop last: some

> +code, but as mentioned above: sooner or later will leave the code behind, too.

                                           later they will leave the code behind, too.

> +
> +Priorities are another reason why some issues are not fixed, as maintainers
> +quite often are forced to set those, as time to work on Linux is limited. That's
> +true for spare time or the time employers grant their developers to spend on
> +maintenance work on the upstream kernel. Sometimes maintainers also get
> +overwhelmed with reports, even if a driver is working nearly perfectly. To not
> +get completely stuck, the programmer thus might have no other choice then to

                                                                        than to

> +prioritize issue reports and reject some of them.
> +
> +But don't worry too much about all of this, a lot of drivers have active
> +maintainers who are quite interested in fixing as many issues as possible.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

