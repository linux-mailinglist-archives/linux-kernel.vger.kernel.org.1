Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43E28193B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgJBR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:28:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8DAC0613D0;
        Fri,  2 Oct 2020 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=feK8WlxbWzadA8OQDHYoxqGoR3FsSkq+H/fGH7x4bl8=; b=iZKk/p34OUO73OB8i1AJsLINlm
        gQP/HEEBMYqlPpawjojtPdwcBvO9whovHcRmer7HVpAZOb1jkjPmUqNqOHC8084luMKmMBxVPmW7E
        +8XCQhUKG5GJFNwBVqt29O7dMnfvJmH5mPxyRFih0ib39qZ3uLEM/1yAq9GH1wvGOr4rSTPKvwlMv
        wmOXMvsM6gyCY/b8rZGB6nN+OjRTIr90ytwBRiTbzEa7ewuyb1IDgm0gaosJtfV3L+74p71uoNNHF
        59iLe131ql+mUEz6+ZfixVXkqLvGhh5EY80hFZpS0NEkV6er9RoAykOoK4Kng4KTjIoQ0L0m4lrAr
        gbrhcgew==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOrW-0004ts-FS; Fri, 02 Oct 2020 17:28:54 +0000
Subject: Re: [RFC PATCH v1 12/26] docs: reporting-bugs: tell users to disable
 DKMS et al.
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <51574b968a9b78a5ce1056acdfa871d4a03d60c7.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c34bb102-613b-5713-4e96-aa99a3e3c6d2@infradead.org>
Date:   Fri, 2 Oct 2020 10:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <51574b968a9b78a5ce1056acdfa871d4a03d60c7.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Tell users to disable solutions like DKMS to make sure the mainline
> kernel they have to install later remains vanilla. The old text did not
> do that, but back when it was written these solutions were not that
> widespread.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 05de4e0259cb..d96b21512c03 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -562,6 +562,27 @@ or reinstall the operating system as well as everything you need to restore the
>  backup.
>  
>  
> +Make sure your kernel doesn't get enhanced
> +------------------------------------------
> +
> +    *Ensure your system does not enhance its kernels by building additional
> +    kernel modules on-the-fly locally, which solutions like DKMS might be doing
> +    without your knowledge.*
> +
> +Your kernel will stop being 'vanilla' as soon as it loads a kernel module not
> +build from the sources used to compile the kernel image itself. That why you

   built                                                           That is why you

> +need to ensure your Linux kernel stays vanilla by removing or disabling
> +mechanisms like akmods and DKMS: those might build additional kernel modules
> +automatically, for example when your boot into a newly installed Linux kernel
> +the first time. Reboot after removing them and any modules they installed.
> +
> +Note, you might not be aware that your system is using one of these solutions:
> +they often get set up silently when you install Nvidias proprietary graphics

                                                   Nvidia's

> +driver, VirtualBox, or other Software that requires a some support from a module
> +not part of the Linux kernel. Your package manager might thus force you to
> +remove those, too.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

