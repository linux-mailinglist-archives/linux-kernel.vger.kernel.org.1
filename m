Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CFE2903E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405552AbgJPLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 07:17:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53042 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405440AbgJPLRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:17:14 -0400
Received: from zn.tnic (p200300ec2f0d0d0089517c9ee4bbfe7f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:8951:7c9e:e4bb:fe7f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C21E01EC02FC;
        Fri, 16 Oct 2020 13:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602847032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DSp5jyhBz5lmcIE51/qc1HjvR3vKwfjV8Tl+WwYmWpc=;
        b=PD6cu93G2MSWp99HVdE1p1Ci70myojYVHvMubArgWfmDidsri0msM3xn1Jwa0Y/1b8DPaT
        EEUjIdwHBMghFWdMhs8NxqkdO3rmEWI0N81NuNtKCAyg/BZ9c2Zzb/s39Yryio7jRPEkLG
        gA8nnh1Vh0DhHnnr+cX3kODuYnBUUIw=
Date:   Fri, 16 Oct 2020 13:17:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/head/64: Disable stack protection for
 head$(BITS).o
Message-ID: <20201016111703.GD8483@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008191623.2881677-6-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:16:23PM -0400, Arvind Sankar wrote:
> On 64-bit, the startup_64_setup_env() function added in
>   866b556efa12 ("x86/head/64: Install startup GDT")
> has stack protection enabled because of set_bringup_idt_handler().

Where? I don't see it.

I have

CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set

and a __stack_chk_fail call is nowhere to be found in the resulting
head64.s file.

startup_64_setup_env:
# arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
	leaq	startup_gdt(%rdi), %rax	#, tmp99
# arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
	subq	$_text, %rax	#, tmp101
	movq	%rax, startup_gdt_descr+2(%rip)	# tmp101, startup_gdt_descr.address
# ./arch/x86/include/asm/desc.h:209: 	asm volatile("lgdt %0"::"m" (*dtr));
#APP
# 209 "./arch/x86/include/asm/desc.h" 1
	lgdt startup_gdt_descr(%rip)		# startup_gdt_descr
# 0 "" 2
# arch/x86/kernel/head64.c:600: 	asm volatile("movl %%eax, %%ds\n"
#NO_APP
	movl	$24, %eax	#, tmp102
#APP
# 600 "arch/x86/kernel/head64.c" 1
	movl %eax, %ds
movl %eax, %ss
movl %eax, %es

# 0 "" 2
# arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
#NO_APP
	leaq	bringup_idt_table(%rdi), %r9	#, tmp105
	leaq	bringup_idt_descr(%rdi), %r8	#, tmp103
	leaq	vc_no_ghcb(%rdi), %rsi	#, tmp107
# arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
	subq	$_text, %r9	#, _11
	subq	$_text, %r8	#, _8
	subq	$_text, %rsi	#, tmp109
# arch/x86/kernel/head64.c:572: 		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
	movq	%r9, %rdi	# _11,
	call	set_bringup_idt_handler.constprop.0	#
# arch/x86/kernel/head64.c:575: 	desc->address = (unsigned long)idt;
	movq	%r9, 2(%r8)	# _11, MEM[(struct desc_ptr *)_8].address
# ./arch/x86/include/asm/desc.h:214: 	asm volatile("lidt %0"::"m" (*dtr));
#APP
# 214 "./arch/x86/include/asm/desc.h" 1
	lidt (%r8)		# MEM[(const struct desc_ptr *)_8]
# 0 "" 2
# arch/x86/kernel/head64.c:605: }
#NO_APP
	ret

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
