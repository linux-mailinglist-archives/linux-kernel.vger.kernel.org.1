Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB6281951
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbgJBRcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgJBRcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:32:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DA1C0613D0;
        Fri,  2 Oct 2020 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nJi1k+MxQc2I6nh3mpCm/yq0hw/XmGot+Y/796SGQlk=; b=gc8eH01GUrw8PlBjvLPULw+IVL
        EL2eLzkGIbJbfUnl8jfGHsTF3RJYY2I5QGWhvZHSEMyY8VI1oihI11iQ/Am4ldLHQ1Ab7YpnRrKw9
        VJV4ry5mXW8t4xxnJGEw3QQJLUctGMCXbXNeYODx7PtFl8Hpts7sJo9UZswE8k6aK/5A1VaSG3w/i
        mOZxSudRJ+k3lp5Ln9OikQQxpXFzN5V8TOvD/yL2GU3LnCa87a4u6IzLmpqOO6N1Nf1qLP10PLPBQ
        QStpxTLilPwQKycBO5EdPqK9Y6USABXEM4QG1Ft+xAF/K+7tIQTcCAMpAvOwhU3l5IBPRHsASpz1Y
        8tEbWAFA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOv9-00058H-E5; Fri, 02 Oct 2020 17:32:39 +0000
Subject: Re: [RFC PATCH v1 13/26] docs: reporting-bugs: point out the
 environment might be causing issue
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <6dab906efb915c6cd6733df525b1f3da3753c4b4.1601541165.git.linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a226274e-7bda-bd27-a0a5-1f1bb165fcd1@infradead.org>
Date:   Fri, 2 Oct 2020 10:32:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6dab906efb915c6cd6733df525b1f3da3753c4b4.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> Help users to avoid a few pitfalls, as they might be the real reason why
> the kernel is acting up somehow.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index d96b21512c03..2292b79cf462 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -583,6 +583,40 @@ not part of the Linux kernel. Your package manager might thus force you to
>  remove those, too.
>  
>  
> +Ensure a healthy environment
> +----------------------------
> +
> +    *Make sure it's not the kernels surroundings that are causing the issue you

                               kernel's

> +    face.*
> +
> +Problems that look a lot like a kernel issue are sometimes caused by build
> +or runtime environment. It's hard to rule out that problem completely, but you
> +should minimize it:
> +
> + * Use proven tools when building your kernel, as bugs in the compiler or the
> +   binutils can cause the resulting kernel to misbehave.
> +
> + * Ensure your computer components runs within their design specifications;

                                      run

> +   that's especially important for the main processor, the main memory, and the
> +   motherboard. Therefore, stop overclocking when facing a potential kernel
> +   issue.
> +
> + * Try to make sure it's not faulty hardware that is causing your issue. Bad
> +   main memory for example can result in a multitude of issues that will
> +   manifest itself in problems looking like kernel issues.
> +
> + * If you're dealing with a filesystem issue, you might want to check the file
> +   system in question with ``fsck`` before trying to reproduce it again.
> +
> + * When dealing with a regression, make sure it's not something else that
> +   changed in parallel to updating the kernel. The problem for example might be
> +   caused by another software that was updated at the same time. It can also

             by other software

> +   happen that a hardware component coincidentally just broke when you rebooted
> +   into a new kernel for the first time. Updating the systems BIOS or changing
> +   something in the BIOS Setup can also lead to problems that on the first sight
> +   look like a regression.
> +
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

