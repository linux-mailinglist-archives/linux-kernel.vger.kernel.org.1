Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E0293E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407887AbgJTOND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407839AbgJTOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:13:03 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:13:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so3537792ior.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tRvlald5laGH28GDIXNHVNkW5XHC31ql+vnZ1YgHACI=;
        b=g9LTFl6n0cIXYInlTv1T0X1G5V1b6EF7Osguj0mWOeRYkZShg4ObSHXzO5n+MK+uB6
         Dq8tPlDHawlKiSDGEfB8FLfO4Avv3vbNFaxy1DAfGRY0atDs6WAfJ0ZV20v7tWYK3CBT
         FKTYgZxdk3VgvCNZ/6rxUeyHXtaSVBwKcWR09/wHO7LDHloUm3wYmQNj21vfqOZR8Mya
         7ohuISp1Sw9FPeWN1P/reiaeRpcbpa4m5i7hK2Nj9OtvoKh18jCdxWKv4VytfejKvnRe
         Yqsf+ZopC8ZWmMzQ28yYjwHdY04S5yeqYd9BJyxUYeh54+yhJlpLx80P6SsZwVOYXfIT
         3t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tRvlald5laGH28GDIXNHVNkW5XHC31ql+vnZ1YgHACI=;
        b=ayPnzLaGDHS1Q6K9ATjLQLuL+zstKra2WN+YihxB8juhbT2ni49kKWj9YstTp7ob9+
         SIaoF9o9m1njSAy/NT4aWasCEhoxwQJVrX2wG/hMF2hb4P9jjal1TIAw5LEipHEmJiZ+
         TBHmU0m7BZtSABCqzqGdEhifNVkjVJX1wusmdfar5GosbktEltyfCzWsNOD1BNtPqbIX
         nwLpS4eJ84jaBhov1MjzVtDHNiH0Je/OciMPYuqzHJ9ypSTQD76+WPSt3VvWhgEJRGSV
         dvcbzrTJV+CTx8qjV37/Hg5UH4muc40k3rpbKII7Z4t+HFWsA+c/GKdVfIVNigiU585+
         KvMQ==
X-Gm-Message-State: AOAM530DGADK5C5XkKSgaOKtLR7J6UpFW0CkRMRbZ1MmW16HRUZGRrwI
        4ND8oGSq2fStiyZbrEnBkWY=
X-Google-Smtp-Source: ABdhPJyvIGAQzvM69Cyzj4cXww7WnE5JhoSMCaDeOAwDKB6XuwT0csEZIpnfPtcxzIWO+ST7vx7xdQ==
X-Received: by 2002:a05:6638:1381:: with SMTP id w1mr2254080jad.79.1603203182580;
        Tue, 20 Oct 2020 07:13:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d7sm1934345ilr.31.2020.10.20.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 07:13:01 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 20 Oct 2020 10:12:59 -0400
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201020141259.GC2996696@rani.riverdale.lan>
References: <20201020121856.19427-1-joro@8bytes.org>
 <20201020121856.19427-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020121856.19427-4-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:18:54PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Check whether the hypervisor reported the correct C-bit when running as
> an SEV guest. Using a wrong C-bit position could be used to leak
> sensitive data from the guest to the hypervisor.
> 
> The check function is in arch/x86/kernel/sev_verify_cbit.S so that it
> can be re-used in the running kernel image.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/ident_map_64.c |  1 +
>  arch/x86/boot/compressed/mem_encrypt.S  |  4 ++
>  arch/x86/boot/compressed/misc.h         |  2 +
>  arch/x86/kernel/sev_verify_cbit.S       | 91 +++++++++++++++++++++++++
>  4 files changed, 98 insertions(+)
>  create mode 100644 arch/x86/kernel/sev_verify_cbit.S
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index 063a60edcf99..73abba3312a7 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -153,6 +153,7 @@ void initialize_identity_maps(void)
>  	 * into cr3.
>  	 */
>  	add_identity_map((unsigned long)_head, (unsigned long)_end);
> +	sev_verify_cbit(top_level_pgt);
>  	write_cr3(top_level_pgt);
>  }
>  
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index 2192b3bd78d8..7409f2343d38 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -68,6 +68,9 @@ SYM_FUNC_START(get_sev_encryption_bit)
>  SYM_FUNC_END(get_sev_encryption_bit)
>  
>  	.code64
> +
> +#include "../../kernel/sev_verify_cbit.S"
> +
>  SYM_FUNC_START(set_sev_encryption_mask)
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	push	%rbp
> @@ -105,4 +108,5 @@ SYM_FUNC_END(set_sev_encryption_mask)
>  	.balign	8
>  SYM_DATA(sme_me_mask,		.quad 0)
>  SYM_DATA(sev_status,		.quad 0)
> +SYM_DATA(sev_check_data,	.quad 0)
>  #endif
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 6d31f1b4c4d1..53f4848ad392 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -159,4 +159,6 @@ void boot_page_fault(void);
>  void boot_stage1_vc(void);
>  void boot_stage2_vc(void);
>  
> +void sev_verify_cbit(unsigned long cr3);
> +
>  #endif /* BOOT_COMPRESSED_MISC_H */
> diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
> new file mode 100644
> index 000000000000..3f7153607956
> --- /dev/null
> +++ b/arch/x86/kernel/sev_verify_cbit.S
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *	sev_verify_cbit.S - Code for verification of the C-bit position reported
> + *			    by the Hypervisor when running with SEV enabled.
> + *
> + *	Copyright (c) 2020  Joerg Roedel (jroedel@suse.de)
> + *
> + * Implements sev_verify_cbit() which is called before switching to a new
> + * long-mode page-table at boot.
> + *
> + * It verifies that the C-bit position is correct by writing a random value to
> + * an encrypted memory location while on the current page-table. Then it
> + * switches to the new page-table to verify the memory content is still the
> + * same. After that it switches back to the current page-table and when the
> + * check succeeded it returns. If the check failed the code invalidates the
> + * stack pointer and goes into a hlt loop. The stack-pointer is invalidated to
> + * make sure no interrupt or exception can get the CPU out of the hlt loop.
> + *
> + * New page-table pointer is expected in %rdi (first parameter)
> + *
> + */
> +SYM_FUNC_START(sev_verify_cbit)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/* First check if a C-bit was detected */
> +	movq	sme_me_mask(%rip), %r10
> +	testq	%r10, %r10
> +	jz	3f
> +
> +	/* sme_me_mask != 0 could mean SME or SEV - Check also for SEV */
> +	movq	sev_status(%rip), %r10
> +	testq	%r10, %r10
> +	jz	3f
> +
> +	/* Save CR4 in %r12 */
> +	pushq	%r12
> +	movq	%cr4, %r12
> +
> +	/* Disable Global Pages */
> +	pushq	%r12
> +	andq	$(~X86_CR4_PGE), %r12
> +	movq	%r12, %cr4
> +	popq	%r12
> +
> +	/*
> +	 * Verified that running under SEV - now get a random value using
> +	 * RDRAND. This instruction is mandatory when running as an SEV guest.
> +	 *
> +	 * Don't bail out of the loop if RDRAND returns errors. It is better to
> +	 * prevent forward progress than to work with a non-random value here.
> +	 */
> +1:	rdrand	%r10
> +	jnc	1b
> +
> +	/* Store value to memory and keep it in %r10 */
> +	movq	%r10, sev_check_data(%rip)
> +
> +	/* Backup current %cr3 value to restore it later */
> +	movq	%cr3, %r11
> +
> +	/* Switch to new %cr3 - This might unmap the stack */
> +	movq	%rdi, %cr3
> +
> +	/*
> +	 * Compare value in %r10 with memory location - If C-Bit is incorrect
> +	 * this would read the encrypted data and make the check fail.
> +	 */
> +	cmpq	%r10, sev_check_data(%rip)
> +
> +	/* Restore old %cr3 */
> +	movq	%r11, %cr3
> +
> +	/* Restore previous CR4 and %r12 */
> +	movq	%r12, %cr4
> +	popq	%r12
> +
> +	/* Check CMPQ result */
> +	je	3f
> +
> +	/*
> +	 * The check failed - Prevent any forward progress to prevent ROP
> +	 * attacks, invalidate the stack and go into a hlt loop.
> +	 */
> +	xorq	%rsp, %rsp
> +	subq	$0x1000, %rsp
> +2:	hlt
> +	jmp 2b
> +3:
> +#endif
> +	ret
> +SYM_FUNC_END(sev_verify_cbit)
> +
> -- 
> 2.28.0
> 

Why use r10-r12 rather than the caller-save registers? Even for the head
code where you need to perserve the cr3 value you can just return it in
rax?
