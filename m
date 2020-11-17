Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8F2B5C53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgKQJzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgKQJzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:55:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA862C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:54:59 -0800 (PST)
Received: from zn.tnic (p200300ec2f1013008dee3addeed0ca22.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:8dee:3add:eed0:ca22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39AFC1EC03E3;
        Tue, 17 Nov 2020 10:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605606898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zUTrFpm6HZ5k+ZqW/hVJs3mXx/EpUmyX6SBc5SLzM/M=;
        b=UC2uFioX1J52/6OPMTk5KTxEuIgSg/OPsmnSS1wvZt6MnestI+C3588N7PkRDukLhGFbsb
        gTQ28PIu6jjf7GR18FK8+l8VfQOc4+UlLR1Z/VHhTVRj4ds58UNmAqS31jDhsOTAd3ham0
        CLwLPLy3WApoiwmA2W5bDm4ConpXAYs=
Date:   Tue, 17 Nov 2020 10:54:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Mark Mossberg <mark.mossberg@gmail.com>, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201117095453.GB5719@zn.tnic>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com>
 <20201103171537.GC4111@zn.tnic>
 <20201103174744.GB23992@redhat.com>
 <20201103175237.GD4111@zn.tnic>
 <20201103181114.GC23992@redhat.com>
 <20201103182018.GE4111@zn.tnic>
 <87blfxx8ps.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blfxx8ps.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:01:03PM +0100, Thomas Gleixner wrote:
> Subject: x86/dumpstack: Don't try to access user space code of other tasks
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 16 Nov 2020 22:26:52 +0100
> 
> sysrq-t ends up invoking show_opcodes() for each task which tries to access
> the user space code of other processes which is obviously bogus.
> 
> It either manages to dump where the foreign tasks regs->ip points to in

I guess you mean here "points to valid mapping of current" or so.

> currents mapping or triggers a pagefault and prints "Code: Bad RIP
> value.". Both is just wrong.
> 
> Add a safeguard in copy_code() and check whether the @regs pointer matches
> currents pt_regs. If not, do not even try to access it.
> 
> While at it, add commentry why using copy_from_user_nmi() is safe in

s/commentry/commentary/

> copy_code() even if the function name suggests otherwise.
> 
> Reported-by: Mark Mossberg <mark.mossberg@gmail.com>

This is Reported-by: Oleg

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/dumpstack.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -78,6 +78,9 @@ static int copy_code(struct pt_regs *reg
>  	if (!user_mode(regs))
>  		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
>  
> +	/* The user space code from other tasks cannot be accessed. */
> +	if (regs != task_pt_regs(current))
> +		return -EPERM;
>  	/*
>  	 * Make sure userspace isn't trying to trick us into dumping kernel
>  	 * memory by pointing the userspace instruction pointer at it.
> @@ -85,6 +88,12 @@ static int copy_code(struct pt_regs *reg
>  	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
>  		return -EINVAL;
>  
> +	/*
> +	 * Even if named copy_from_user_nmi() this can be invoked from
> +	 * other contexts and will not try to resolve a pagefault, which is
> +	 * the correct thing to do here as this code can be called from any
> +	 * context.
> +	 */

Can we stick the first part of this comment about "this can be invoked
from other contexts" over the function definition?

>  	return copy_from_user_nmi(buf, (void __user *)src, nbytes);
>  }

...

With this, I see Code: only once with Sysrq-T:

[   25.491878] task:bash            state:R  running task     stack:    0 pid: 4267 ppid:  4187 flags:0x00004000

...

[   25.497740] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53

which is the shell doing the

$ echo t > /proc/sysrq-trigger

So

Reviewed-by: Borislav Petkov <bp@suse.de>
Tested-by: Borislav Petkov <bp@suse.de>

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
