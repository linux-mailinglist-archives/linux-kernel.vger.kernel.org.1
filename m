Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339D8272290
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIULby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIULby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:31:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 04:31:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e3003590c70b70be4695.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:3590:c70b:70be:4695])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 662611EC03CE;
        Mon, 21 Sep 2020 13:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600687912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/91U/5Gy/MHFLfKBLTrSBLDzSEBOu3RDyLYfiSJ1TDc=;
        b=NzPuYynx+v2qfrisE9nEni7kffRNISz6JtgKZcqwlOvlfpaN4iqzxw63H4QVaNPNf0HBg7
        u9q6j1ZfKY47cARradObM2aRW0oM825E98OCExce/uzaZSiAxWmSywSCGD8PM2H3zPt2ET
        /uMNuTnE1NF0fZ4f1PRmiLxkfn8VDb8=
Date:   Mon, 21 Sep 2020 13:31:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] x86/mce: Decode a kernel instruction to determine if
 it is copying from user
Message-ID: <20200921113144.GD5901@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-9-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908175519.14223-9-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:55:19AM -0700, Tony Luck wrote:
> +static bool is_copy_from_user(struct pt_regs *regs)
> +{
> +	u8 insn_buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +
> +	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
> +		return false;

<---- newline here.

> +	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
> +	insn_get_length(&insn);

insn_get_opcode() I guess.

> +
> +	switch (insn.opcode.value) {
> +	case 0x8A: case 0x8B:		/* MOV */

No side comments pls - put them ontop.

Also, this comment needs to say that you're looking for MOVs where the
source operand can also be a memory operand.

Now lemme stare at an example, let's look at this function:

static __always_inline __must_check unsigned long
raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
{
        return copy_user_generic((__force void *)dst, src, size);

In this case, we copy to user memory, so dst is the user pointer.

Comment over copy_user_generic_unrolled() says rsi is the source so
let's look at some of the insns in there:

ffffffff813accc2:       4c 8b 06                mov    (%rsi),%r8
ffffffff813accc5:       4c 8b 4e 08             mov    0x8(%rsi),%r9
ffffffff813accc9:       4c 8b 56 10             mov    0x10(%rsi),%r10
ffffffff813acccd:       4c 8b 5e 18             mov    0x18(%rsi),%r11

All those are at labels which are exception-handled with the new
_ASM_EXTABLE_CPY().

So according to the above check, this is a copy *from* user. But it
ain't. And to confirm that, I added a breakpoint at that insn:

(gdb) break *0xffffffff813accc2
Breakpoint 1 at 0xffffffff813accc2: file arch/x86/lib/copy_user_64.S, line 66.

and the first time it hit, it has this:

Dump of assembler code from 0xffffffff813accc2 to 0xffffffff813accd6:
=> 0xffffffff813accc2 <copy_user_generic_unrolled+50>:  4c 8b 06        mov    (%rsi),%r8
   0xffffffff813accc5 <copy_user_generic_unrolled+53>:  4c 8b 4e 08     mov    0x8(%rsi),%r9

rsi            0xffffc90000013e10
r8             0x7fff60425120

So this is reading from *kernel* memory and writing to *user* memory.
And I don't think you want that, according to the whole intent of those
series.

And it makes sense - getting an MCE while writing is probably going to
go boom.

> +	case 0xB60F: case 0xB70F:	/* MOVZ */

Ditto.

> +		return true;
> +	case 0xA4: case 0xA5:		/* MOVS */
> +		return !fault_in_kernel_space(regs->si);
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * If mcgstatus indicated that ip/cs on the stack were
>   * no good, then "m->cs" will be zero and we will have
> @@ -215,10 +238,17 @@ static int error_context(struct mce *m, struct pt_regs *regs)
>  
>  	if ((m->cs & 3) == 3)
>  		return IN_USER;
> +	if (!mc_recoverable(m->mcgstatus))
> +		return IN_KERNEL;
>  
>  	t = ex_fault_handler_type(m->ip);
> -	if (mc_recoverable(m->mcgstatus) && t == HANDLER_FAULT) {
> +	if (t == HANDLER_FAULT) {
> +		m->kflags |= MCE_IN_KERNEL_RECOV;
> +		return IN_KERNEL_RECOV;
> +	}
> +	if (t == HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
>  		m->kflags |= MCE_IN_KERNEL_RECOV;
> +		m->kflags |= MCE_IN_KERNEL_COPYIN;
>  		return IN_KERNEL_RECOV;

I'm guessing that should be generic enough to do on the other vendors
too...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
