Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0075299542
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789727AbgJZS1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:27:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784608AbgJZS1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:27:18 -0400
Received: from zn.tnic (p200300ec2f07cc006122e8911baeacc6.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:cc00:6122:e891:1bae:acc6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C30A51EC0269;
        Mon, 26 Oct 2020 19:27:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603736836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J7gB+xIiVP4/xXoJX7VDF5p2exgP9KcNKkar3A+uj5E=;
        b=D68MdNuX9FVQe7QzoiF0mlUCxpoCBaXh4LNRorj9TfVYqvP/3whRShOjrH0pIVTsniZAMt
        a219+d4JsOU4NBwSniPYxEghPuEYPderMUGvQ+UPQxSnrHb2Y4HchUGXfcgfRDkvvnWgWN
        D7HplpAhtMdk92Z2a50CaC/WfQDufUM=
Date:   Mon, 26 Oct 2020 19:27:06 +0100
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
Subject: Re: [PATCH v3 1/5] x86/boot/compressed/64: Introduce sev_status
Message-ID: <20201026182706.GG22116@zn.tnic>
References: <20201021123938.3696-1-joro@8bytes.org>
 <20201021123938.3696-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021123938.3696-2-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:39:34PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Introduce sev_status and initialize it together with sme_me_mask to have
> an indicator which SEV features are enabled.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/mem_encrypt.S | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index dd07e7b41b11..2192b3bd78d8 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -81,6 +81,13 @@ SYM_FUNC_START(set_sev_encryption_mask)
>  
>  	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
>  
> +	/* Read sev_status */
> +	movl	$MSR_AMD64_SEV, %ecx
> +	rdmsr
> +	shlq	$32, %rdx
> +	orq	%rdx, %rax
> +	movq	%rax, sev_status(%rip)

A couple of lines above you call get_sev_encryption_bit() which already
reads MSR_AMD64_SEV. Why not set sev_status there too instead of reading
that MSR again here?

It can read that MSR once and use sev_status(%rip) from then on to avoid
reading that MSR multiple times...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
