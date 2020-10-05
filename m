Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34A283C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgJEQbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:31:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgJEQbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:31:40 -0400
Received: from zn.tnic (p200300ec2f07d500f39533324043f5fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d500:f395:3332:4043:f5fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CC081EC02FC;
        Mon,  5 Oct 2020 18:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601915499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nzw4PA3rfl7jzqHX81ye9k74DOdKxMo6vzCUsJL4yag=;
        b=rvs86EE6OXiwWfkAh3cYGJfp6SzXzhsI92FUhKv5334PHeBJK+bwCtMFkJdRDl8WRStCOG
        +DmzLcFwTe+Aig4PiXC5EgG5X8xoO+UuHLPoJ/HzSiYPExF9w4E28e+XFRmhqczYQcpLbY
        FLdeSvNnyNGs4lxekZdV/5TKLq4oRuM=
Date:   Mon, 5 Oct 2020 18:31:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/mce: Decode a kernel instruction to determine
 if it is copying from user
Message-ID: <20201005163130.GD21151@zn.tnic>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
 <20200930232611.15355-8-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930232611.15355-8-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:26:11PM -0700, Tony Luck wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 9713825e6745..60bacf6e0501 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1236,14 +1236,19 @@ static void kill_me_maybe(struct callback_head *cb)
>  	if (!p->mce_ripv)
>  		flags |= MF_MUST_KILL;
>  
> -	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
> +	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> +	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
>  		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
>  		sync_core();
>  		return;
>  	}
>  
> -	pr_err("Memory error not recovered");
> -	kill_me_now(cb);
> +	if (p->mce_vaddr != (void __user *)~0ul) {

As previously pointed out, pls test against -1L even if it is the
same value so that it is obvious this is the error value coming from
insn_get_addr_ref().

> +		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
> +	} else {
> +		pr_err("Memory error not recovered");
> +		kill_me_now(cb);
> +	}
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index 8517cbf7b184..6e8b38cf52d9 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -10,6 +10,9 @@
>  #include <linux/init.h>
>  #include <linux/debugfs.h>
>  #include <asm/mce.h>
> +#include <asm/traps.h>
> +#include <asm/insn.h>
> +#include <asm/insn-eval.h>
>  #include <linux/uaccess.h>
>  
>  #include "internal.h"
> @@ -198,6 +201,45 @@ static struct severity {
>  #define mc_recoverable(mcg) (((mcg) & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) == \
>  				(MCG_STATUS_RIPV|MCG_STATUS_EIPV))
>  
> +static bool is_copy_from_user(struct pt_regs *regs)
> +{
> +	u8 insn_buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +	unsigned long addr;
> +
> +	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
> +		return false;
> +
> +	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
> +	insn_get_opcode(&insn);
> +	if (!insn.opcode.got)
> +		return false;
> +
> +	switch (insn.opcode.value) {
> +	/* MOV mem,reg */
> +	case 0x8A: case 0x8B:
> +	/* MOVZ mem,reg */
> +	case 0xB60F: case 0xB70F:
> +		insn_get_modrm(&insn);
> +		insn_get_sib(&insn);

You need to test here:

		insn->modrm.got = 1;

and
		insn->sib.got = 1;

I know, this is weird - those functions should return an error value
instead of being void and I've asked Masami in the past but no reply.

Who knows, one fine day I might convert the crap to do that instead.

> +		addr = (unsigned long)insn_get_addr_ref(&insn, regs);
> +		break;
> +	/* REP MOVS */
> +	case 0xA4: case 0xA5:
> +		addr = regs->si;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	if (fault_in_kernel_space(addr))
> +		return false;
> +
> +	current->mce_vaddr = (void __user *)addr;
> +
> +	return true;
> +}
> +
>  /*
>   * If mcgstatus indicated that ip/cs on the stack were
>   * no good, then "m->cs" will be zero and we will have

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
