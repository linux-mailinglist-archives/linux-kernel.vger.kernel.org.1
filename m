Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D58029AA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898993AbgJ0LIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:08:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898975AbgJ0LIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:08:21 -0400
Received: from zn.tnic (p200300ec2f0dae00bd0b3d5f265e51fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:bd0b:3d5f:265e:51fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5DF81EC0434;
        Tue, 27 Oct 2020 12:08:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603796900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DnyVgLQB3wEQsPQikbDwd8/lw4ODrYHKFa5CtrZsgNE=;
        b=Jn0FrpMLLYZoZ6WkywIwgtMn1yQB+HRIaeI2qElF6F3m7znwuPJGFNjkl5EcHCKje7Ojb/
        /1OE4xVAzVkzmDtIWDdfW3DYMmSbXfld5cfSTrQqMbEj5l46J+GJDrsbK0I2MvoVgCNSiB
        nCuVXOEBu47m071KlrUWOzg9cNsSfas=
Date:   Tue, 27 Oct 2020 12:08:12 +0100
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
Subject: Re: [PATCH v3 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201027110812.GC15580@zn.tnic>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021123938.3696-4-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:39:36PM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
> new file mode 100644
> index 000000000000..5075458ecad0
> --- /dev/null
> +++ b/arch/x86/kernel/sev_verify_cbit.S

Why a separate file? You're using it just like verify_cpu.S and this is
kinda verifying CPU so you could simply add the functionality there...

> @@ -0,0 +1,90 @@
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

Yeah, can you please use the callee-clobbered registers in the order as
they're used by the ABI, see arch/x86/entry/calling.h.

Because I'm looking at this and wondering are rsi, rdx and rcx somehow
live here and you're avoiding them...

Otherwise nice commenting - I like when it is properly explained what
the asm does and what it expects as input, cool.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
