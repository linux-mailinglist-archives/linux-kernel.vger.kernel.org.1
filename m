Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88962288BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbgJIOtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:49:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbgJIOtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:49:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FBAEAD73;
        Fri,  9 Oct 2020 14:49:09 +0000 (UTC)
Date:   Fri, 9 Oct 2020 16:49:07 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201009144907.GB3302@suse.de>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008191623.2881677-5-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:16:22PM -0400, Arvind Sankar wrote:
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
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index fd957b2625e9..a3613857c532 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -21,6 +21,7 @@
>  
>  #include "error.h"
>  #include "misc.h"
> +#include "cmdline.h"
>  
>  /* These actually do the work of building the kernel identity maps. */
>  #include <linux/pgtable.h>
> @@ -109,6 +110,8 @@ static void add_identity_map(unsigned long start, unsigned long end)
>  /* Locates and clears a region for a new top level page table. */
>  void initialize_identity_maps(void)
>  {
> +	unsigned long cmdline;
> +
>  	/* Exclude the encryption mask from __PHYSICAL_MASK */
>  	physical_mask &= ~sme_me_mask;
>  
> @@ -149,10 +152,19 @@ void initialize_identity_maps(void)
>  	}
>  
>  	/*
> -	 * New page-table is set up - map the kernel image and load it
> -	 * into cr3.
> +	 * New page-table is set up - map the kernel image, boot_params and the
> +	 * command line.
> +	 * The uncompressed kernel requires boot_params and the command line to
> +	 * be mapped in the identity mapping.
> +	 * Map them explicitly here in case the compressed kernel does not
> +	 * touch them, or does not touch all the pages covering them.
>  	 */
>  	add_identity_map((unsigned long)_head, (unsigned long)_end);
> +	add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
> +	cmdline = get_cmd_line_ptr();
> +	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
> +
> +	/* Load the new page-table. */
>  	write_cr3(top_level_pgt);
>  }

Reviewed-by: Joerg Roedel <jroedel@suse.de>

