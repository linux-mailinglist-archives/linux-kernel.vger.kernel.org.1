Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9182FC072
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbhAST5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392147AbhAST4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:56:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5233423104;
        Tue, 19 Jan 2021 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611086132;
        bh=5OONEVY+UXy6TZlBP5jOksmHE3/6yEFjijufZCWKRSk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mM6GekNo7M7nZMz3BIKqqTmHjNWaC+UHwfBf/Ym4I4WwPC4O8j/MXCfsZGMA4ABeg
         cSR04o38SZOmkPccHe+BYj6DmehUbJP+kMDnqsmmHMYX8LYUA6/M1DKIHPd5u7P/Vk
         2WOqFC8yWm7ykWYWlyzGkpUyAJHkEFNvUCnWZG1CgAI0NH47RSJWjsPqop8kU6R09+
         7HvpHlS8r2BMv74iDfrQ1i2befSznTzu74rUbq38byvL8S4oOOexaUt4QwekjFZrvH
         EjKS0NAfboOkX1Finu1tpqNThU4ahql1a6MHnw0c21vEXtoeXxay335c8kMCe7uBwn
         7Ov6djH6k3J1Q==
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <202101191135.A78A570@keescook>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
Date:   Tue, 19 Jan 2021 13:55:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202101191135.A78A570@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 1:45 PM, Kees Cook wrote:
> How about this so the base address is hashed once, with the offset added
> to it for each line instead of each line having a "new" hash that makes
> no sense:
> 
> diff --git a/lib/hexdump.c b/lib/hexdump.c
> index 9301578f98e8..20264828752d 100644
> --- a/lib/hexdump.c
> +++ b/lib/hexdump.c
> @@ -242,12 +242,17 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>   		    const void *buf, size_t len, bool ascii)
>   {
>   	const u8 *ptr = buf;
> +	const u8 *addr;
>   	int i, linelen, remaining = len;
>   	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
>   
>   	if (rowsize != 16 && rowsize != 32)
>   		rowsize = 16;
>   
> +	if (prefix_type == DUMP_PREFIX_ADDRESS &&
> +	    ptr_to_hashval(ptr, &addr))
> +		addr = 0;
> +
>   	for (i = 0; i < len; i += rowsize) {
>   		linelen = min(remaining, rowsize);
>   		remaining -= rowsize;
> @@ -258,7 +263,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>   		switch (prefix_type) {
>   		case DUMP_PREFIX_ADDRESS:
>   			printk("%s%s%p: %s\n",
> -			       level, prefix_str, ptr + i, linebuf);
> +			       level, prefix_str, addr + i, linebuf);

Well, this is better than nothing, but not by much.  Again, as long as 
%px exists for printk(), I just cannot understand any resistance to 
allowing it in print_hex_dump().

Frankly, I think this patch and my patch should both be added.  During 
debugging, it's very difficult if not impossible to work with hashed 
addresses.  I use print_hex_dump() with an unhashed address all the 
time, either by applying my patch to my own kernel or just replacing the 
%p with %px.
