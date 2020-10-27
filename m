Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE47929A9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898639AbgJ0KkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:40:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898507AbgJ0Kiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:38:55 -0400
Received: from zn.tnic (p200300ec2f0dae00bd0b3d5f265e51fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:bd0b:3d5f:265e:51fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF2241EC038E;
        Tue, 27 Oct 2020 11:38:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603795134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XaOZ8iDEo6bzyk47Zcy/Tow7zQzmSGGtifM1Mj5WYTo=;
        b=hP7C/6JDx3RSdjXHeEtJkinSbE2r+NUTz9oJMB8vkFY9GBTxeyimfaHAELlVUb1dTQIbpq
        jKyc4c9OEuA4kfgg5X9+h1lswGWI6mPeGgfQtMakwC7TPUarlnhCA2AgqxLVWBmJ7tju53
        H6MLy+yo8u7ztUPzv7oyJvZVmbWVUt8=
Date:   Tue, 27 Oct 2020 11:38:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] x86/boot/compressed/64: Add CPUID sanity check to
 early #VC handler
Message-ID: <20201027103846.GB15580@zn.tnic>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021123938.3696-3-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:39:35PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The early #VC handler which doesn't have a GHCB can only handle CPUID
> exit codes. It is needed by the early boot code to handle #VC
> exceptions raised in verify_cpu() and to get the position of the C
> bit.
> 
> But the CPUID information comes from the hypervisor, which is untrusted
> and might return results which trick the guest into the no-SEV boot path
> with no C bit set in the page-tables. All data written to memory would
> then be unencrypted and could leak sensitive data to the hypervisor.
> 
> Add sanity checks to the early #VC handlers to make sure the hypervisor
> can not pretend that SEV is disabled.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/sev-es-shared.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
> index 5f83ccaab877..48bb14563dcd 100644
> --- a/arch/x86/kernel/sev-es-shared.c
> +++ b/arch/x86/kernel/sev-es-shared.c
> @@ -178,6 +178,32 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  		goto fail;
>  	regs->dx = val >> 32;
>  
> +	/*
> +	 * This is a VC handler and it is only raised when SEV-ES is active,

				and the #VC is only raised...

> +	 * which means SEV must be active too. Do sanity checks on the CPUID
> +	 * results to make sure the hypervisor does not trick the kernel into
> +	 * the no-sev path. This could map sensitive data unencrypted and make
> +	 * it accessible to the hypervisor.
> +	 *
> +	 * In particular, check for:
> +	 *	- Hypervisor CPUID bit
> +	 *	- Availability of CPUID leaf 0x8000001f
> +	 *	- SEV CPUID bit.
> +	 *
> +	 * The hypervisor might still report the wrong C-bit position, but this
> +	 * can't be checked here.

So why are we doing those checks here at all then? I mean, the HV
can tell us whatever it wants, i.e., make sure those checks pass but
still report the C-bit at the wrong position. Which means that those
checks are simply meh. So why are we doing them at all? To catch stupid
hypervisors who can't even lie properly to the guest? :-)

> +	 */
> +
> +	if ((fn == 1 && !(regs->cx & BIT(31))))
> +		/* Hypervisor Bit */

s/Bit/bit/g

> +		goto fail;
> +	else if (fn == 0x80000000 && (regs->ax < 0x8000001f))
> +		/* SEV Leaf check */
> +		goto fail;
> +	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
> +		/* SEV Bit */
> +		goto fail;
> +
>  	/* Skip over the CPUID two-byte opcode */
>  	regs->ip += 2;
>  
> -- 
> 2.28.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
