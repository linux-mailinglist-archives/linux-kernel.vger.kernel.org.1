Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464282FDAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbhATUe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbhATU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:29:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672EC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:28:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e9so8993099plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fioXcQ/rcCDFe0T/YIUHW/M/p9VSUety2UTjxNg3ziA=;
        b=bCfQkCywAIsP3lLuxqsl0MQ4KwOBlshIphqvfRTMiI1aefaiNetuMamFqp9X7i1+o9
         1TtsFuxQFB8lsmHffvaLidYS/t+vAjbvQmbvthtopcqayQWW7aTWeSErW68yzO+/e7/s
         mm8mHyRbr9K5B2a05j+T1hkcJt2yxcWFNMmzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fioXcQ/rcCDFe0T/YIUHW/M/p9VSUety2UTjxNg3ziA=;
        b=b9H+PfJa7KvXk49QVbM9lQept6vKIBSnO5EvnLwp0CD8/7I5rAAzVvV5EbiJYlvRxW
         bX4yWzI4LXLpzriC6xxw0GlXIcRGoh6tYDDwKN8zz2Ma/DWy40tEl9YsACYyaFIgol3D
         sJCu3hVXhcr4Xd8er8cYVFrLzxwQ+/Z1eT7EYRn9jgctEpVvx5EkRqmVpAIJeevcl7Q+
         LBYMgZ7T+U5muF71G9JmZYuGrKXtzG1RZD5p/TBWhAmpLQw49tY9XoXDbd64S/f5oyj7
         nVSwnGIpDiC0XxWSXPMpDFcYUCjSVrqct9unmWdzy+K735VSA/j2ksIebBdBP4U1lSAR
         /uvQ==
X-Gm-Message-State: AOAM532M+yG0q8HOVhtg3Ad7rPVmYS79neiXp8hDDHTH6be/7chhxVhu
        9RhBVcrdho2hpkn3r3ZblFIKQA==
X-Google-Smtp-Source: ABdhPJz3vqbaKQGcB2+3zZJBFP9PcA+uju+6kutWdGzJQdggXuGIMQNlyI67aU9SoP9c4TvAk4Zhwg==
X-Received: by 2002:a17:90a:d3c7:: with SMTP id d7mr7441076pjw.169.1611174532698;
        Wed, 20 Jan 2021 12:28:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 145sm3073897pfu.8.2021.01.20.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:28:51 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:28:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <202101201226.A03F16DF24@keescook>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <202101191135.A78A570@keescook>
 <82e1f2f3-77c3-ffb4-34b2-0e6f23e6195d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e1f2f3-77c3-ffb4-34b2-0e6f23e6195d@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:18:17PM -0800, Randy Dunlap wrote:
> On 1/19/21 11:45 AM, Kees Cook wrote:
> > 
> > How about this so the base address is hashed once, with the offset added
> > to it for each line instead of each line having a "new" hash that makes
> > no sense:
> 
> Yes, good patch. Should have been like this to begin with IMO.
> 
> > diff --git a/lib/hexdump.c b/lib/hexdump.c
> > index 9301578f98e8..20264828752d 100644
> > --- a/lib/hexdump.c
> > +++ b/lib/hexdump.c
> > @@ -242,12 +242,17 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
> >  		    const void *buf, size_t len, bool ascii)
> >  {
> >  	const u8 *ptr = buf;
> > +	const u8 *addr;
> >  	int i, linelen, remaining = len;
> >  	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> >  
> >  	if (rowsize != 16 && rowsize != 32)
> >  		rowsize = 16;
> >  
> > +	if (prefix_type == DUMP_PREFIX_ADDRESS &&
> > +	    ptr_to_hashval(ptr, &addr))
> > +		addr = 0;
> > +
> >  	for (i = 0; i < len; i += rowsize) {
> >  		linelen = min(remaining, rowsize);
> >  		remaining -= rowsize;
> > @@ -258,7 +263,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
> >  		switch (prefix_type) {
> >  		case DUMP_PREFIX_ADDRESS:
> >  			printk("%s%s%p: %s\n",
> > -			       level, prefix_str, ptr + i, linebuf);
> > +			       level, prefix_str, addr + i, linebuf);
> 
> Is 'addr' always set here?
> It is only conditionally set above.

It should be, yes. Though I agree, it's not obvious. ptr_to_hashval()
will write to it when returning 0. So if that fails, addr will have 0
written. Both only happen under DUMP_PREFIX_ADDRESS.


-- 
Kees Cook
