Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E626A28714E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgJHJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:17:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:43154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJHJRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:17:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5BF58AD32;
        Thu,  8 Oct 2020 09:17:31 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:17:29 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/boot/64: Explicitly map boot_params and command
 line
Message-ID: <20201008091729.GG3209@suse.de>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007195351.776555-5-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:53:50PM -0400, Arvind Sankar wrote:
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
>  arch/x86/boot/compressed/ident_map_64.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index 070cda70aef3..8edeff0d9324 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -150,10 +150,13 @@ void initialize_identity_maps(void)
>  	}
>  
>  	/*
> -	 * New page-table is set up - map the kernel image and load it
> -	 * into cr3.
> +	 * New page-table is set up - map the kernel image, boot_params and the
> +	 * command line, and load the new page-table into cr3.
>  	 */

Please extend this comment to state that boot_params and command-line
need to be mapped here because they might not be touched (and thus
mapped) before jumping to the uncompressed kernel image. Otherwise no
one will remember why those need to be pre-mapped in a couple of years.

With that change and the add_identity_map() call adjusted:

Reviewed-by: Joerg Roedel <jroedel@suse.de>

