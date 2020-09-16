Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F126CD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIPVBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIPQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD5AC06121C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 03:58:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e000ee699b54c433a91.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:ee6:99b5:4c43:3a91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 394371EC0118;
        Wed, 16 Sep 2020 12:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600253624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0eky5pw6XdBpBwN1EG2yefIbQmmc2AbaEkGFcUfgFkc=;
        b=VzLKez56SEZyu+khXjxCvAQakqscWxSwX0Qgo4OQFd7avfFIqUNhnW7k/tNqOgz1rK6dOY
        Oz6F1H1uENoj+t3MwB5M4qim0ziY80fgK9qa/6vhgaJIp0M2WUCQIGru+XptMzQszNjsb/
        MGydyqfLeVCWK88sJ9PMMLK4JicFFwE=
Date:   Wed, 16 Sep 2020 12:53:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Message-ID: <20200916105336.GF2643@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908175519.14223-6-tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:55:16AM -0700, Tony Luck wrote:
> In the page fault case it is ok to see if a few more unaligned bytes
> can be copied from the source address. Worst case is that the page fault
> will be triggered again.
> 
> Machine checks are more serious. Just give up at the point where the
> main copy loop triggered the #MC and return as if the copy succeeded.
> 
> [Tried returning bytes not copied here, but that puts the kernel
>  into a loop taking the machine check over and over. I don't know
>  at what level some code is retrying]
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/lib/copy_user_64.S | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index 5b68e945bf65..1a58946e7c4e 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -15,6 +15,7 @@
>  #include <asm/asm.h>
>  #include <asm/smap.h>
>  #include <asm/export.h>
> +#include <asm/trapnr.h>
>  
>  .macro ALIGN_DESTINATION
>  	/* check for bad alignment of destination */
> @@ -221,6 +222,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   * Try to copy last bytes and clear the rest if needed.
>   * Since protection fault in copy_from/to_user is not a normal situation,
>   * it is not necessary to optimize tail handling.
> + * Don't try to copy the tail if machine check happened
>   *
>   * Input:
>   * rdi destination
> @@ -232,10 +234,15 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   */
>  SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
>  	movl %edx,%ecx
> +	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
> +	je 3f
>  1:	rep movsb
>  2:	mov %ecx,%eax
>  	ASM_CLAC
>  	ret
> +3:	xorl %eax,%eax	/* pretend we succeeded? */

Hmm, but copy_*_user returns the uncopied bytes in eax. Users of this
need to handle the MC case properly but if you return 0, they would
think that they copied everything but there's some trailing stuff they
didn't manage to take.

And it's not like they *should* have to retry to copy it because they
will walk right into the faulty region and cause more MCEs.

So how is this "I-got-an-MCE-while-copying-from-user" handled on the
higher level?

Your 7/8 says:

"Add code to recover from a machine check while copying data from user
space to the kernel. Action for this case is the same as if the user
touched the poison directly; unmap the page and send a SIGBUS to the
task."

So how are users of copy_*_user() expected to handle the page
disappearing from under them?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
