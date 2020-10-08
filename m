Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27028712D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgJHJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:04:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgJHJEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:04:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AADB8AE95;
        Thu,  8 Oct 2020 09:04:21 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:04:20 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] x86/boot: Initialize boot_params in startup code
Message-ID: <20201008090420.GD3209@suse.de>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007195351.776555-2-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:53:47PM -0400, Arvind Sankar wrote:
> Save the boot_params pointer passed in by the bootloader in
> startup_32/64. This avoids having to initialize it in two different
> places in C code, and having to preserve SI through the early assembly
> code.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Nice cleanup!

>  /*
>   * Jump to the extracted kernel.
>   */
> -	xorl	%ebx, %ebx
> +	movl	boot_params@GOTOFF(%ebx), %esi
>  	jmp	*%eax
>  SYM_FUNC_END(.Lrelocated)
>  
> @@ -209,6 +208,8 @@ SYM_DATA_START_LOCAL(gdt)
>  	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
>  SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
>  
> +SYM_DATA(boot_params, .long 0)
> +

You should add a comment here that boot_params needs to be in the .data
section because in .bss it would get zeroed out again later. Same
applies to the 64bit version of this.

With that changed:

Reviewed-by: Joerg Roedel <jroedel@suse.de>

