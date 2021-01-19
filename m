Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7292FB769
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbhASKws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732309AbhASKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:39:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA0C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:38:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so11973269pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ejd8L+qRikTAX4gXzqidXEApmypCJiiNo1NE206AbrU=;
        b=TrGffkS01nDzRU7dB1hHdZmPTZLmx/da9Ynj+GGoboJow3+onFraH7/z5rJ8r4l7jv
         31Wg5dZGXKp09MUvj83JMo942VlkIKRNqSFlUJ9D+g+8ZUu5apJdtB7uIfyRrWA2PAiD
         2aC6u0Ql0J6m40Iw6Sn9broA6Q5kLHAs3QXJHMbFJdWxjAATIfBkavJx4uZ2TXGpXxKt
         xdp1btuYiN4UFX2NjSPO+LeeHde5uO1ug9RmdVIgKhdtI0glVz6Yb6+d4NPTUtBBqoO8
         QMINwq0yHsLRoMdkzzrPn7M872w2ZgqIevFGJ8XBDAYzlZzKVwwkQiNWTnOtt280gTdm
         xo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ejd8L+qRikTAX4gXzqidXEApmypCJiiNo1NE206AbrU=;
        b=Xg4FB1v2o/8GRAKPP3fA9D5yacVJ5kSlel2XDeXONTW2G0c87cm2Nzxz5mdg2W3YQE
         0C9L3hQ0saHs2k9A5L5OaYRKsHSJ3TKvIeMXNmi/33E9W5oT8ucpc7zrTs5PHUt2Dd5+
         g+cyB4euNya4DyfysS+CR1R3q2nmTuFl/TFJZjnhJPwzH+sjZnQXyb8WUWofgJR6ULkG
         RvK4xy8mwckyF9hGlBpxKtX7As2RdlYevXL4azfEaNz9OhVPRC/RYlOMToyJ6wuGuE8S
         1X12rZDTMvzk+Wfp7DOKky9O0kKgTjFTXLejDoZuFUOutj9PcymrRZg8ppHuYIXBoYzw
         VW6g==
X-Gm-Message-State: AOAM532wWqhjGfGRT3KbHpS+w2TT/ibNMd8tAp0zratbCNebMlbkvXlT
        OG9D1HZKA+y05f4UJVvysk5hsaqwKgeHng==
X-Google-Smtp-Source: ABdhPJySP5Rw43ok+Y96nXNziyr2vBqLw0NM1092NvgvoyFuLMZ8pxmbMOjvCgu1t5gJvLHfg5pBRA==
X-Received: by 2002:a63:3049:: with SMTP id w70mr3816048pgw.224.1611052708331;
        Tue, 19 Jan 2021 02:38:28 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id t8sm2753229pjm.45.2021.01.19.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 02:38:27 -0800 (PST)
Date:   Tue, 19 Jan 2021 19:38:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119014725.GH2260413@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/19 01:47), Matthew Wilcox wrote:
[..]
> 
> > So maybe DUMP_PREFIX_UNHASHED can do the unhashed dump only when
> > CONFIG_DEBUG_KERNEL=y and fallback to DUMP_PREFIX_ADDRESS otherwise?
> 
> Distros enable CONFIG_DEBUG_KERNEL.

Oh, I see.

> If you want to add CONFIG_DEBUG_LEAK_ADDRESSES, then that's great,
> and you won't even have to change users, you can just change how %p
> behaves.

I like the name. config dependent behaviour of %p wouldn't be new,
well, to some extent, e.g. XFS does something similar (see below).
I don't think Linus will be sold on this, however.


fs/xfs/xfs_linux.h:

/*
 * Starting in Linux 4.15, the %p (raw pointer value) printk modifier
 * prints a hashed version of the pointer to avoid leaking kernel
 * pointers into dmesg.  If we're trying to debug the kernel we want the
 * raw values, so override this behavior as best we can.
 */
#ifdef DEBUG
# define PTR_FMT "%px"
#else
# define PTR_FMT "%p"
#endif

And then they just use it as

	xfs_alert(mp, "%s: bad inode magic number, dip = "ptr_fmt",
		  dino bp = "ptr_fmt", ino = %ld",
		  __func__, dip, bp, in_f->ilf_ino);

	-ss
