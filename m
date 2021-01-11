Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB22F0FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbhAKKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:11:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:49142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbhAKKLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:11:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610359857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGjiobEfDCQdR/m8j9FCWCG7QniulgSRXabjTM/QsKA=;
        b=pzwcpNtct48o/b5Ol2JUjENEcabF3Ukd6DKP293/TrfSoskWmjbZHXjiqmkzxi4+C5DLfq
        O7NnUOtqU+LPBWu5hJK/NudKyPSl/pvPBYe2zSQSGOZa6W6C7dVeOuV3U/IzLV2dqYB9MC
        bR+tOj+LOPGpOXEjmlEymUGOggROj50=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1D55ABC4;
        Mon, 11 Jan 2021 10:10:56 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:10:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@tabi.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Roman Fietze <roman.fietze@magna.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for unhashed
 addresses
Message-ID: <X/wkMMiPPBAJb9+A@alley>
References: <20210106213547.1077789-1-timur@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106213547.1077789-1-timur@tabi.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Kees into CC because it is security related.
Adding Andrew into CC because he usually takes patches for hexdump.

On Wed 2021-01-06 15:35:47, Timur Tabi wrote:
> Hashed addresses are useless in hexdumps unless you're comparing
> with other hashed addresses, which is unlikely.  However, there's
> no need to break existing code, so introduce a new prefix type
> that prints unhashed addresses.
> 
> Signed-off-by: Timur Tabi <timur@tabi.org>
> Cc: Roman Fietze <roman.fietze@magna.com>

I agree that there should be way to print the real address.

And it is sane to add a new mode so that the current
users stay hashed.

Reviewed-by: Petr Mladek <pmladek@suse.com>

> ---
>  include/linux/printk.h | 3 ++-
>  lib/hexdump.c          | 9 +++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index fe7eb2351610..5d833bad785c 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -567,7 +567,8 @@ extern const struct file_operations kmsg_fops;
>  enum {
>  	DUMP_PREFIX_NONE,
>  	DUMP_PREFIX_ADDRESS,
> -	DUMP_PREFIX_OFFSET
> +	DUMP_PREFIX_OFFSET,
> +	DUMP_PREFIX_UNHASHED,
>  };
>  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
>  			      int groupsize, char *linebuf, size_t linebuflen,
> diff --git a/lib/hexdump.c b/lib/hexdump.c
> index 9301578f98e8..b5acfc4168a8 100644
> --- a/lib/hexdump.c
> +++ b/lib/hexdump.c
> @@ -211,8 +211,9 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
>   * @level: kernel log level (e.g. KERN_DEBUG)
>   * @prefix_str: string to prefix each line with;
>   *  caller supplies trailing spaces for alignment if desired
> - * @prefix_type: controls whether prefix of an offset, address, or none
> - *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
> + * @prefix_type: controls whether prefix of an offset, hashed address,
> + *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
> + *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)
>   * @rowsize: number of bytes to print per line; must be 16 or 32
>   * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
>   * @buf: data blob to dump
> @@ -256,6 +257,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>  				   linebuf, sizeof(linebuf), ascii);
>  
>  		switch (prefix_type) {
> +		case DUMP_PREFIX_UNHASHED:
> +			printk("%s%s%px: %s\n",
> +			       level, prefix_str, ptr + i, linebuf);
> +			break;
>  		case DUMP_PREFIX_ADDRESS:
>  			printk("%s%s%p: %s\n",
>  			       level, prefix_str, ptr + i, linebuf);
> -- 
> 2.25.1
