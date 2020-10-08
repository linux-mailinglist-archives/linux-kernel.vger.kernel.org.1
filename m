Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD7287141
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgJHJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:11:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgJHJLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:11:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1143EAD32;
        Thu,  8 Oct 2020 09:11:34 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:11:32 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/boot: Move get_cmd_line_ptr() and
 COMMAND_LINE_SIZE into misc.h
Message-ID: <20201008091132.GE3209@suse.de>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007195351.776555-3-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:53:48PM -0400, Arvind Sankar wrote:
> Move get_cmd_line_ptr() and COMMAND_LINE_SIZE into misc.h for easier
> use from multiple files.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/cmdline.c |  8 --------
>  arch/x86/boot/compressed/kaslr.c   |  6 ------
>  arch/x86/boot/compressed/misc.h    | 13 +++++++++++++
>  3 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
> index f1add5d85da9..d0e1d386749d 100644
> --- a/arch/x86/boot/compressed/cmdline.c
> +++ b/arch/x86/boot/compressed/cmdline.c
> @@ -12,14 +12,6 @@ static inline char rdfs8(addr_t addr)
>  	return *((char *)(fs + addr));
>  }
>  #include "../cmdline.c"
> -unsigned long get_cmd_line_ptr(void)
> -{
> -	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
> -
> -	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
> -
> -	return cmd_line_ptr;
> -}
>  int cmdline_find_option(const char *option, char *buffer, int bufsize)
>  {
>  	return __cmdline_find_option(get_cmd_line_ptr(), option, buffer, bufsize);
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index b59547ce5b19..f3286a3bef36 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -36,12 +36,6 @@
>  #define STATIC
>  #include <linux/decompress/mm.h>
>  
> -#define _SETUP
> -#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
> -#undef _SETUP
> -
> -extern unsigned long get_cmd_line_ptr(void);
> -
>  /* Simplified build-specific string for starting entropy. */
>  static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
>  		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 6d31f1b4c4d1..95aacc361f78 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -25,6 +25,10 @@
>  #include <asm/bootparam.h>
>  #include <asm/desc_defs.h>
>  
> +#define _SETUP
> +#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
> +#undef _SETUP
> +
>  #define BOOT_CTYPE_H
>  #include <linux/acpi.h>
>  
> @@ -70,6 +74,15 @@ static inline void debug_puthex(unsigned long value)
>  #endif
>  
>  /* cmdline.c */
> +static inline
> +unsigned long get_cmd_line_ptr(void)
> +{
> +	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
> +
> +	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
> +
> +	return cmd_line_ptr;
> +}
>  int cmdline_find_option(const char *option, char *buffer, int bufsize);
>  int cmdline_find_option_bool(const char *option);

Reviewed-by: Joerg Roedel <jroedel@suse.de>
