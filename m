Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D22818D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbgJBRIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJBRIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:08:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1726C0613D0;
        Fri,  2 Oct 2020 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Ca8sKDCw0GHjZBhcGIIj3L8CqwOb97DQ3AjGP71wsRg=; b=Uy7vywT3YdKEfwIHdRjlWzGj8r
        5acepEv+e/R3YyxjVPM//7PqryrPI5ejKkQIruJYL6PNzNMck0cMhbu+Ain7vJPMNlBhbhhMUb3e2
        X7xE5v9+lQin7WW5HME2RJqjE/1cVO3iSstIQ156iUcsEjfQeHrTWWGbv++5ZoagWV43rjWuoosWe
        vUqgkEXAo9/40kbLE+qm22yUN8GIiZyxNvHVnLvM5oNtt5X82TzhdWfwimL/H3b22ryh4e+TsDgmU
        z/d5rwTY/SEqGxJ34NQUNh1myHxa9uCwaPFruOgIFZAqF8lfbbg57USNXTe4qe5D9lX+rrVcOpjC9
        LjyMnNZA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOXd-0003Pa-4g; Fri, 02 Oct 2020 17:08:21 +0000
Subject: Re: [RFC PATCH v1 08/26] docs: reporting-bugs: make readers check the
 taint flag
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <eed27c4faa31d98bd37db18ba2ae90f1767c7102.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8129d3a7-3649-b9cc-1615-402f12ee370a@infradead.org>
Date:   Fri, 2 Oct 2020 10:08:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <eed27c4faa31d98bd37db18ba2ae90f1767c7102.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Tell users early in the process to check the taint flag, as that will
> prevent them from investing time into a report that might be worthless.
> That way users for example will notice that the issue they face is in
> fact caused by an add-on kernel module or and Oops that happened
> earlier.
> 
> This approach has a downside: users will later have to check the flag
> again with the mainline kernel the guide tells them to install. But that
> is an acceptable trade-off here, as checking only takes a few seconds
> and can easily prevent wasting time in useless testing and debugging.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> 
> = RFC =
> 
> Should "disable DKMS" come before this step? But then the backup step right
> before that one would need to be moved as well, as disabling DKMS can mix things
> up.
> ---
>  Documentation/admin-guide/reporting-bugs.rst  | 59 +++++++++++++++++++
>  Documentation/admin-guide/tainted-kernels.rst |  2 +
>  2 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 430a0c3ee0ad..61b6592ddf74 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -311,6 +311,65 @@ fatal error where the kernels stop itself) with a 'Oops' (a recoverable error),
>  as the kernel remains running after an 'Oops'.
>  
>  
> +Check 'taint' flag
> +------------------
> +
> +    *Check if your kernel was 'tainted' when the issue occurred, as the event
> +    that made the kernel set this flag might be causing the issue you face.*
> +
> +The kernel marks itself with a 'taint' flag when something happens that might
> +lead to follow-up errors that look totally unrelated. The issue you face might
> +be such an error if your kernel is tainted. That's why it's in your interest to
> +rule this out early before investing more time into this process. This is the
> +only reason why this step is here, as this process later will tell you to
> +install the latest mainline kernel and check its taint flag, as that's the
> +kernel the report will be mainly about.
> +
> +On a running system is easy to check if the kernel tainted itself: it's not
> +tainted if ``cat /proc/sys/kernel/tainted`` returns '0'. Checking that file is
> +impossible in some situations, that's why the kernel also mentions the taint

                      situations;

> +status when it reports an internal problem (a 'kernel bug'), a recoverable
> +error (a 'kernel Oops') or a non-recoverable error before halting operation (a
> +'kernel panic'). Look near the top of the error messages printed when one of
> +these occurs and search for a line starting with 'CPU:'. It should end with
> +'Not tainted' if the kernel was not tainted beforehand; it was tainted if you
> +see 'Tainted:' followed by a few spaces and some letters.
> +
> +If your kernel is tainted study

                     tainted, study

> +:ref:`Documentation/admin-guide/tainted-kernels.rst <taintedkernels>` to find
> +out why and try to eliminate the reason. Often it's because a recoverable error
> +(a 'kernel Oops') occurred and the kernel tainted itself, as the kernel knows
> +it might misbehave in strange ways after that point. In that case check your
> +kernel or system log and look for a section that starts with this::
> +
> +       Oops: 0000 [#1] SMP
> +
> +That's the first Oops since boot-up, as the '#1' between the brackets shows.
> +Every Oops and any other problem that happen after that point might be a
> +follow-up problem to that first Oops, even if they look totally unrelated. Try
> +to rule this out by getting rid of that Oops and reproducing the issue
> +afterwards. Sometimes simply restarting will be enough, sometimes a change to
> +the configuration followed by a reboot can eliminate the Oops. But don't invest
> +too much time into this at this point of the process, as the cause for the Oops
> +might already be fixed in the newer Linux kernel version you are going to
> +install later in this process.
> +
> +Quite a few kernels are also tainted because an unsuitable kernel modules was

                                                                     module

> +loaded. This for example is the case if you use Nvidias proprietary graphics

                                                   Nvidia's

> +driver, VirtualBox, or other software that installs its own kernel modules: you
> +will have to remove these modules and reboot the system, as they might in fact
> +be causing the issue you face.

You will need to reboot the system and try to reproduce the issue without loading
any of these proprietary modules.

> +
> +The kernel also taints itself when it's loading a module that resists in the

                                                                 resides

> +staging tree of the Linux kernel source. That's a special area for code (mostly
> +drivers) that does not yet fulfill the normal Linux kernel quality standards.
> +When you report an issue with such a module it's obviously okay if the kernel is
> +tainted, just make sure the module in question is the only reason for the taint.

   tainted;

> +If the issue happens in an unrelated area reboot and temporary block the module

                                                        temporarily

> +from being loaded by specifying ``foo.blacklist=1`` as kernel parameter (replace
> +'foo' with the name of the module in question).
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index abf804719890..2900f477f42f 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -1,3 +1,5 @@
> +.. _taintedkernels:
> +
>  Tainted kernels
>  ---------------
>  
> 


-- 
~Randy

