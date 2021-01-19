Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635912FC0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbhASUUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbhASUUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:20:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9BB3e4UOa89CNZRt/E7K2g+oaXMqtqe9Q/oLhFogx1k=; b=Azet/fAOXpIaVhDt6xN2dW+n2b
        NqMosDlyUbMALkIWccg5H4tO1SDLbdeyIVM5AdM9OtPzmvA3XePUeKGzWrepgk/tmv+aGF6znJZ9D
        36XmkLRTjQHdPIX40wi3+39a8WSp643iUpwqH3Svd7MP/wyEQuOuIxDazdaaotTjyW/xMQA1dtxrD
        3svt36BGHaPhChAjiiKrS91usls3C1NkhsPGWa3KbUtNc6ouevTCrcw2ZG9uZkr6EyUNAYtaAPquY
        PerdJlcTffwEAcnLExsPPh+5o1yGOehI5i65UQSspDcSqZiAPQ/8u0HeDGOrSb/CE/p7xz7QxqCtD
        gIav+2Lg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1xSK-0007gM-Vw; Tue, 19 Jan 2021 20:18:25 +0000
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Timur Tabi <timur@kernel.org>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <82e1f2f3-77c3-ffb4-34b2-0e6f23e6195d@infradead.org>
Date:   Tue, 19 Jan 2021 12:18:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202101191135.A78A570@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 11:45 AM, Kees Cook wrote:
> 
> How about this so the base address is hashed once, with the offset added
> to it for each line instead of each line having a "new" hash that makes
> no sense:

Yes, good patch. Should have been like this to begin with IMO.

> diff --git a/lib/hexdump.c b/lib/hexdump.c
> index 9301578f98e8..20264828752d 100644
> --- a/lib/hexdump.c
> +++ b/lib/hexdump.c
> @@ -242,12 +242,17 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>  		    const void *buf, size_t len, bool ascii)
>  {
>  	const u8 *ptr = buf;
> +	const u8 *addr;
>  	int i, linelen, remaining = len;
>  	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
>  
>  	if (rowsize != 16 && rowsize != 32)
>  		rowsize = 16;
>  
> +	if (prefix_type == DUMP_PREFIX_ADDRESS &&
> +	    ptr_to_hashval(ptr, &addr))
> +		addr = 0;
> +
>  	for (i = 0; i < len; i += rowsize) {
>  		linelen = min(remaining, rowsize);
>  		remaining -= rowsize;
> @@ -258,7 +263,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>  		switch (prefix_type) {
>  		case DUMP_PREFIX_ADDRESS:
>  			printk("%s%s%p: %s\n",
> -			       level, prefix_str, ptr + i, linebuf);
> +			       level, prefix_str, addr + i, linebuf);

Is 'addr' always set here?
It is only conditionally set above.

>  			break;
>  		case DUMP_PREFIX_OFFSET:
>  			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
> 
> -Kees
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#p-format-specifier
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
