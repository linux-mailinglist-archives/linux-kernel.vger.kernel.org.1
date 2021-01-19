Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BFF2FC0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391826AbhASUKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390152AbhASTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:46:03 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CECC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:45:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n7so13633031pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TZWPmeK6nXakTnptNSiDMwmmfuwKT59whEZJ3rHxaLw=;
        b=TaMSshX4B2n3vFKApyAfeBOtLDmP9J8gTr+lW7M5qmFsq1Iu5oIS2cAbdh+m+ygRMA
         SYAk2DeKQUExNPiEVdZWzlsy9VA8O1OnQYQx5IBoaogF2hXo5nselpRh0r0wc3iO0+hL
         HcNIHqDDFovEbhw27QUGrQZcFIZa8mMgo3gK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TZWPmeK6nXakTnptNSiDMwmmfuwKT59whEZJ3rHxaLw=;
        b=KpuZFPoZ6f2UCkfKZc4l1UX2VZu6gOHjkXyNncVyPRgDNBqCXHlGdNNeAKzpw7+rAQ
         ZYd7MzSZl5jI794vfkARkblk54++f+4YsC+AgQZiILXFtBKse69sX3b9b4waOwvrT18B
         27TLOhichacz1WFo6qmuWfND2879qKSXp4TSUFhyp8MtpJkzzMpBFHaUU//W8Jrl/CjO
         ixVFINFKow7dlcysAIUt8BL6bK6ZIpj03ormc2FKwdiNx1xYBTH2WbRxcXOHG+okZ748
         HYjnVWh6goeZF/RY1Vke5e9/dXfdjzRRf5WEYgQpEG59D1whiNyXgDUoemZjDXfsYiSp
         tjhA==
X-Gm-Message-State: AOAM533cgCdbZ9WtuD0V9QWwqsoxxJpZrThTBjeGi+BwtVJtaVf3bUx5
        /OlM6vd6Qw/Sv1egaG8nuarhqg==
X-Google-Smtp-Source: ABdhPJykeUe7VPA5lRIwyEFZ7G5haUHZJx1AiWjgDLdACfjZ80+WTKMRpIgdowymxogDkkcDmHUg7w==
X-Received: by 2002:a63:5a08:: with SMTP id o8mr5915862pgb.118.1611085514157;
        Tue, 19 Jan 2021 11:45:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 76sm2838040pfz.174.2021.01.19.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:45:13 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:45:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <202101191135.A78A570@keescook>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210119014725.GH2260413@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 01:47:25AM +0000, Matthew Wilcox wrote:
> On Tue, Jan 19, 2021 at 09:53:01AM +0900, Sergey Senozhatsky wrote:
> > On (21/01/18 13:03), Timur Tabi wrote:
> > > On 1/18/21 12:26 PM, Matthew Wilcox wrote:
> > > > Don't make it easy.  And don't make it look like they're doing
> > > > something innocent.  DUMP_PREFIX_SECURITY_HOLE would be OK
> > > > by me.  DUMP_PREFIX_LEAK_INFORMATION would work fine too.
> > > > DUMP_PREFIX_MAKE_ATTACKERS_LIFE_EASY might be a bit too far.
> > > 
> > > It's already extremely easy to replace %p with %px in your own printks, so I
> > > don't really understand your argument.
> > 
> > I like the idea of a more radical name, e.g. DUMP_PREFIX_RAW_POINTERS or
> > something similar.
> > 
> > > Seriously, this patch should not be so contentious.  If you want hashed
> > > addresses, then nothing changes.  If you need unhashed addresses while
> > > debugging, then use DUMP_PREFIX_UNHASHED.  Just like you can use %px in
> > > printk.  I never use %p in my printks, but then I never submit code upstream
> > > that prints addresses, hashed or unhashed.
> 
> I'm glad to hear you never make mistakes.  I make lots of mistakes, so
> I prefer them to be big, loud and obvious so they're easy for people
> to spot.
> 
> > So maybe DUMP_PREFIX_UNHASHED can do the unhashed dump only when
> > CONFIG_DEBUG_KERNEL=y and fallback to DUMP_PREFIX_ADDRESS otherwise?
> 
> Distros enable CONFIG_DEBUG_KERNEL.  If you want to add
> CONFIG_DEBUG_LEAK_ADDRESSES, then that's great, and you won't even have
> to change users, you can just change how %p behaves.

Following Linus's guidance[1] on this kind of thing, I think the correct
patch would be to actually _remove_ DUMP_PREFIX_ADDRESS entirely (or
make the offset math be hash-based). There isn't a strong enough reason
for it to exist in the first place:

- If the hashed “%p” value is pointless, ask yourself whether the pointer
  itself is important. Maybe it should be removed entirely?
- If you really think the true pointer value is important, why is some
  system state or user privilege level considered “special”? If you think
  you can justify it (in comments and commit log) well enough to stand up
  to Linus’s scrutiny, maybe you can use “%px”, along with making sure you
  have sensible permissions.
- A toggle for “%p” hashing will not be accepted.

How about this so the base address is hashed once, with the offset added
to it for each line instead of each line having a "new" hash that makes
no sense:

diff --git a/lib/hexdump.c b/lib/hexdump.c
index 9301578f98e8..20264828752d 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -242,12 +242,17 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    const void *buf, size_t len, bool ascii)
 {
 	const u8 *ptr = buf;
+	const u8 *addr;
 	int i, linelen, remaining = len;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
 
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
 
+	if (prefix_type == DUMP_PREFIX_ADDRESS &&
+	    ptr_to_hashval(ptr, &addr))
+		addr = 0;
+
 	for (i = 0; i < len; i += rowsize) {
 		linelen = min(remaining, rowsize);
 		remaining -= rowsize;
@@ -258,7 +263,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		switch (prefix_type) {
 		case DUMP_PREFIX_ADDRESS:
 			printk("%s%s%p: %s\n",
-			       level, prefix_str, ptr + i, linebuf);
+			       level, prefix_str, addr + i, linebuf);
 			break;
 		case DUMP_PREFIX_OFFSET:
 			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#p-format-specifier

-- 
Kees Cook
