Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B662929C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgJSOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:51:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653BCC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:51:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07840018db507abdfe4647.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8400:18db:507a:bdfe:4647])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 423D91EC0258;
        Mon, 19 Oct 2020 16:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603119086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=55DcUWTTEf6LYwS1k2VcM5sfD39qw4yGxz0DPc+2a10=;
        b=hcNLIxly52TuMvvFbzsglwPvifTiltSz24mrDOCkwmrZN8Nbbsu96c25wNNF3rD9GbtkAb
        vh/3aGI7RkvdaxR+i/Wto89KNwOmazAHG269qLLE4rhbWnL1LpYxr7g0kwpdR2IVMnQqOO
        ajDynDTK/Zg2OxCJv5VpGIZmpKHYsB4=
Date:   Mon, 19 Oct 2020 16:51:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201019145115.GB24325@zn.tnic>
References: <20201016173232.GI8483@zn.tnic>
 <20201016200404.1615994-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016200404.1615994-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 04:04:01PM -0400, Arvind Sankar wrote:
> Commits
> 
>   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
>   8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in KASLR code")
> 
> set up a new page table in the decompressor stub, but without explicit
> mappings for boot_params and the kernel command line, relying on the #PF
> handler instead.
> 
> This is fragile, as boot_params and the command line mappings are
> required for the main kernel. If EARLY_PRINTK and RANDOMIZE_BASE are
> disabled, a QEMU/OVMF boot never accesses the command line in the
> decompressor stub, and so it never gets mapped. The main kernel accesses
> it from the identity mapping if AMD_MEM_ENCRYPT is enabled, and will
> crash.
> 
> Fix this by adding back the explicit mapping of boot_params and the
> command line.
> 
> Note: the changes also removed the explicit mapping of the main kernel,
> with the result that .bss and .brk may not be in the identity mapping,
> but those don't get accessed by the main kernel before it switches to
> its own page tables.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/head_64.S      |  3 +++
>  arch/x86/boot/compressed/ident_map_64.c | 24 +++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 1c80f1738fd9..3976b4e92e1b 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -544,6 +544,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  	pushq	%rsi
>  	call	set_sev_encryption_mask
>  	call	load_stage2_idt
> +	/* Pass boot_params to initialize_identity_maps */
> +	popq	%rdi
> +	pushq	%rdi

Any reason why you're not doing

	movq    (%rsp), %rdi

here instead?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
