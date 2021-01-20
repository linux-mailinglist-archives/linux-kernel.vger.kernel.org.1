Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4642FCDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbhATKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:14:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:43942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731181AbhATJUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:20:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611134358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=52em1yn/Qr5akNgNbjF28oF+osSjM05q1X0waiVX+8Y=;
        b=uAubqB3b+wP1NRPQjAFc1KnUyU92GvRYO4WPyNa1wjhvNCkhOmKBG8nLkR8duTbhMpcW3Z
        d9gsXFWpuv7yaKythsHoIn3i7J/k36UlKernz0z9tjTlSI2INh4OzRMOf1BiKZCMHsMkfb
        Nv9TKsPH1rMx5a7dp52QhLUseUnNFyc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37CE7AF3E;
        Wed, 20 Jan 2021 09:19:18 +0000 (UTC)
Date:   Wed, 20 Jan 2021 10:19:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        roman.fietze@magna.com, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <YAf1lS8zsHwhShCr@alley>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <202101191135.A78A570@keescook>
 <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-19 13:55:29, Timur Tabi wrote:
> On 1/19/21 1:45 PM, Kees Cook wrote:
> > How about this so the base address is hashed once, with the offset added
> > to it for each line instead of each line having a "new" hash that makes
> > no sense:
> > 
> > diff --git a/lib/hexdump.c b/lib/hexdump.c
> > index 9301578f98e8..20264828752d 100644
> > --- a/lib/hexdump.c
> > +++ b/lib/hexdump.c
> > @@ -242,12 +242,17 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
> >   		    const void *buf, size_t len, bool ascii)
> >   {
> >   	const u8 *ptr = buf;
> > +	const u8 *addr;
> >   	int i, linelen, remaining = len;
> >   	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> >   	if (rowsize != 16 && rowsize != 32)
> >   		rowsize = 16;
> > +	if (prefix_type == DUMP_PREFIX_ADDRESS &&
> > +	    ptr_to_hashval(ptr, &addr))
> > +		addr = 0;
> > +
> >   	for (i = 0; i < len; i += rowsize) {
> >   		linelen = min(remaining, rowsize);
> >   		remaining -= rowsize;
> > @@ -258,7 +263,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
> >   		switch (prefix_type) {
> >   		case DUMP_PREFIX_ADDRESS:
> >   			printk("%s%s%p: %s\n",
> > -			       level, prefix_str, ptr + i, linebuf);
> > +			       level, prefix_str, addr + i, linebuf);
> 
> Well, this is better than nothing, but not by much.  Again, as long as %px
> exists for printk(), I just cannot understand any resistance to allowing it
> in print_hex_dump().
> 
> Frankly, I think this patch and my patch should both be added.  During
> debugging, it's very difficult if not impossible to work with hashed
> addresses.  I use print_hex_dump() with an unhashed address all the time,
> either by applying my patch to my own kernel or just replacing the %p with
> %px.

This was my view as well. People should not need to add features into
hexdump code when they want to use is for debugging. And the address
is pretty useful.

A solution might be to prevent using this in the mainline:

   + it might be reported by checkpatch.pl

   + it might print some bold warning on the first use, similar to
     trace_printk().

Or we need this in the mainline. Then the use of %pK looks
like the best compromise to me. We could also add some warning
as a comment and use some provocative name for the flag
as suggested by Matthew.

And we should definitely add Linus into CC when sending v2.
His expected opinion has been mentioned several times in this
thread. It would be better to avoid these speculations
and get his real opinion. IMHO, it is too late to add
him in this long thread.

Best Regards,
Petr
