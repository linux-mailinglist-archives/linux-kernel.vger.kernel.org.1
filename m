Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49329AA50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437404AbgJ0LJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:09:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50742 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJ0LJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:09:49 -0400
Received: from zn.tnic (p200300ec2f0dae00bd0b3d5f265e51fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:bd0b:3d5f:265e:51fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEF051EC025D;
        Tue, 27 Oct 2020 12:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603796988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9iuKe50PCINPUavWE9M3TF4gl9XcnGVIa/w+9bYdrmg=;
        b=JdjsVB3Wiz2xxn67Z5yFHWC/AGtB5RoyE6Y2psWfMda1BRa74Z/NkicIaKK3M6SJYWfZdn
        J6TmQQuzfLzfCxIZRRCr7Y1F2cXS6R6/0TMn+bR5XL8j82xYYI6IExodZO6RX7TDcuEU/x
        KYgUIlGn6vSw7ESy5bihIFQ9VCHBlQc=
Date:   Tue, 27 Oct 2020 12:09:45 +0100
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
Message-ID: <20201027110945.GD15580@zn.tnic>
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
>  arch/x86/kernel/sev_verify_cbit.S       | 90 +++++++++++++++++++++++++
>  4 files changed, 97 insertions(+)
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

Btw, might wanna redo them ontop of -rc1 because this looks like this after
Arvind's three fixes:

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index a5e5db6ada3c..81f6003553f8 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -162,6 +162,7 @@ void initialize_identity_maps(void *rmode)
        add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
        cmdline = get_cmd_line_ptr();
        add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
+       sev_verify_cbit(top_level_pgt);
 
        /* Load the new page-table. */
        write_cr3(top_level_pgt);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
