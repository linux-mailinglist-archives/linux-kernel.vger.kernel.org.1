Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA933288BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbgJIOmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbgJIOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D67AAF2D;
        Fri,  9 Oct 2020 14:42:17 +0000 (UTC)
Date:   Fri, 9 Oct 2020 16:42:15 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] x86/boot/64: Show original faulting address in
 case of error
Message-ID: <20201009144215.GA3302@suse.de>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008191623.2881677-4-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:16:21PM -0400, Arvind Sankar wrote:
> This makes the #PF handler print the original CR2 value in case of
> error, instead of after aligning to PMD_SIZE.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index 063a60edcf99..fd957b2625e9 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -327,9 +327,6 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
>  
>  	ghcb_fault = sev_es_check_ghcb_fault(address);
>  
> -	address   &= PMD_MASK;
> -	end        = address + PMD_SIZE;
> -
>  	/*
>  	 * Check for unexpected error codes. Unexpected are:
>  	 *	- Faults on present pages
> @@ -345,5 +342,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
>  	 * Error code is sane - now identity map the 2M region around
>  	 * the faulting address.
>  	 */
> +	address   &= PMD_MASK;
> +	end        = address + PMD_SIZE;
> +
>  	add_identity_map(address, end);
>  }

Reviewed-by: Joerg Roedel <jroedel@suse.de>

