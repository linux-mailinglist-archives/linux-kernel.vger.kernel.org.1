Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9375E2FC061
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbhASTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbhASTqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:46:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2455FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:45:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id t6so11140672plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j1wetYO36UaWe02LKLO5JOOk43Nsnbf+M6tRDh80Z4o=;
        b=OUX5tjdXRfLznD8jIANBdiWUxte6jruaZKP8XaWopCFLIS+gZ/eFfduPojDdaqyM61
         mKVv/HPl8C5ipjrgekEDwkMonO/KgKxtmfrej7YMS527qKEaKE591YkNitfYFrwFCP2W
         RGkDF26DwzK7GeUPJCMylj/jP5ZQS4P3LA1os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j1wetYO36UaWe02LKLO5JOOk43Nsnbf+M6tRDh80Z4o=;
        b=eLJpK3pN8Pd4/OvgehvtuymaKrLNL1YAl0G8uv/qOlsipk0yn2ct06UHKc+PCKTyqd
         89Cyx3rLIiH+W2BJAtQ/33E+nTnj181SDOVWwjOXvqPL1PEPEOrrKc2O7+H5KE6u6hRK
         GJK+Y44djGsB9tTxzGLkdVtIpju5NmaW/zHA/wdIcifAmOy9o352DEmkWgwKiurBh2De
         /sCWeQcJ92cpw6Kp3rFoOv4y7j5zzKXxyg7B5TPubrmdtBs95VJz5XJOTepHgYfAWMj5
         46Rf4kA1gs1oOPbn6iES3q8D3dA5s+JofHZJc4oVJQnVLrlddGcEhP4Cg3lnEtAJIBxM
         N/FA==
X-Gm-Message-State: AOAM533puiJJ9TPcB6Lt3noAlOglWNQoY3B+fzsjR1yoOYDvcQ/Sopiw
        OD8arG0iiJbHRWZEQ+gMMApm/oMV1hxhOg==
X-Google-Smtp-Source: ABdhPJzNu0666uPUGZSh8cSOuQ0fGaNEAz/2rp0GooPV2Bekf0Z56+42DAxbMqo8Jmmnj/KXmtKY6Q==
X-Received: by 2002:a17:90b:4c85:: with SMTP id my5mr1372206pjb.225.1611085551698;
        Tue, 19 Jan 2021 11:45:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kr9sm4210380pjb.0.2021.01.19.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:45:50 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:45:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Timur Tabi <timur@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <202101191145.FE17081@keescook>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 07:38:24PM +0900, Sergey Senozhatsky wrote:
> On (21/01/19 01:47), Matthew Wilcox wrote:
> [..]
> > 
> > > So maybe DUMP_PREFIX_UNHASHED can do the unhashed dump only when
> > > CONFIG_DEBUG_KERNEL=y and fallback to DUMP_PREFIX_ADDRESS otherwise?
> > 
> > Distros enable CONFIG_DEBUG_KERNEL.
> 
> Oh, I see.
> 
> > If you want to add CONFIG_DEBUG_LEAK_ADDRESSES, then that's great,
> > and you won't even have to change users, you can just change how %p
> > behaves.
> 
> I like the name. config dependent behaviour of %p wouldn't be new,
> well, to some extent, e.g. XFS does something similar (see below).
> I don't think Linus will be sold on this, however.
> 
> 
> fs/xfs/xfs_linux.h:
> 
> /*
>  * Starting in Linux 4.15, the %p (raw pointer value) printk modifier
>  * prints a hashed version of the pointer to avoid leaking kernel
>  * pointers into dmesg.  If we're trying to debug the kernel we want the
>  * raw values, so override this behavior as best we can.
>  */
> #ifdef DEBUG
> # define PTR_FMT "%px"
> #else
> # define PTR_FMT "%p"
> #endif
> 
> And then they just use it as
> 
> 	xfs_alert(mp, "%s: bad inode magic number, dip = "ptr_fmt",
> 		  dino bp = "ptr_fmt", ino = %ld",
> 		  __func__, dip, bp, in_f->ilf_ino);
> 
> 	-ss

Please no, this is effectively a toggle.

-- 
Kees Cook
