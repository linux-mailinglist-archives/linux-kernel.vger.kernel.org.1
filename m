Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10D62920F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 03:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgJSBw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 21:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgJSBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 21:52:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968E4C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 18:52:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k21so11175627ioa.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8RjI3su9NyNGK81Jv8KYmxF0xwTum8c245cu02RISJg=;
        b=Oo2HlxkWSe+XiMz09KE9wQIJXDKl3vDrsdA7wavTwX60ekq4DskLJSRlSzdkt7S/G6
         /Q6RKf0EfSRfH9HG63ypl6hqYSEPQzyqae/C/BA79IHVzlFDG62TOdLbzMGEaaCo0i1g
         y1Qx7GdsBWEPyMyjJ1ULeFYgbWhz38ziDXwXhEIDyZSkfpnM6wPh6GEMwdnZyFlFVX3r
         /2/fZR876mKxD45pT9sA+piBTIJW6MJJ6JkSVwxh8gudnG1ute7aBxP9z8jagpg3Cloc
         uGhUZrwAnC1hsyleiO8OssIiEydPI3jZuV0U68Hr7rIW4sbmcEMCV5HOqDbUHtjXo3ai
         O3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RjI3su9NyNGK81Jv8KYmxF0xwTum8c245cu02RISJg=;
        b=D88wTM+KgGqGwdx6Nn2Pm/iP06xhprXguZe1B7Mddx/Jz/WaDR0V51LkliWOfZk99y
         7lH8b7BLqwzM2zGQRPe2HzFVpI0u5tn2/g+uL1AJmdETgKzqA6zhyHlnOUDM1xU7a+VT
         kJ2PCcfBhTFdxr3woOlNxtA76oPnII9A6sgLYjURD7yBMNqVy6XLyIbkao6LsVtMnB1e
         BgqIHW5d+tZrEdKd5tI+nTlwnhoMH2MJBttb9cdhtChA+sXQn9hsdgWJP+pUxo5++FqL
         oo1vp+T3GhW1Gb6XEHN2ledU0ag0rLR4GviZzgFAjTtN7lknkBoNABj6nkpYKmMnQCCk
         ZRqg==
X-Gm-Message-State: AOAM530zCWoycaXXRNBvaRATwT/+gREbe1W6+rr3RJp7PQO2KbkygJ+P
        EJvc6Llm4nQ5Nn5dyVZJECjT9w==
X-Google-Smtp-Source: ABdhPJxLzcnvWsDqX3y/N+tZofEUPmAG01HPspRTMwTfb8SxXlu2WcKw2WXo8wa+EoZx0karE2044Q==
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr9170682iod.130.1603072377659;
        Sun, 18 Oct 2020 18:52:57 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id f16sm7124019ilq.86.2020.10.18.18.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 18:52:56 -0700 (PDT)
Date:   Sun, 18 Oct 2020 19:52:52 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 7/7] zram: Use local lock to protect per-CPU data
Message-ID: <20201019015252.GA61728@google.com>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
 <20200527201119.1692513-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527201119.1692513-8-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:11:19PM +0200, Sebastian Andrzej Siewior wrote:
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> The zcomp driver uses per-CPU compression. The per-CPU data pointer is
> acquired with get_cpu_ptr() which implicitly disables preemption.
> It allocates memory inside the preempt disabled region which conflicts
> with the PREEMPT_RT semantics.
> 
> Replace the implicit preemption control with an explicit local lock.
> This allows RT kernels to substitute it with a real per CPU lock, which
> serializes the access but keeps the code section preemptible. On non RT
> kernels this maps to preempt_disable() as before, i.e. no functional
> change.

Hi,

This change seems to have introduced a potential deadlock. Can you
please take a look?

Thank you.

[   40.030778] ======================================================
[   40.037706] WARNING: possible circular locking dependency detected
[   40.044637] 5.9.0-74216-g5c9472ed6825 #1 Tainted: G        W        
[   40.051759] ------------------------------------------------------
[   40.058685] swapon/586 is trying to acquire lock:
[   40.063950] ffffe8ffffc0ee60 (&zstrm->lock){+.+.}-{2:2}, at: local_lock_acquire+0x5/0x70 [zram]
[   40.073739] 
[   40.073739] but task is already holding lock:
[   40.080277] ffff888101a1f438 (&zspage->lock){.+.+}-{2:2}, at: zs_map_object+0x73/0x28d
[   40.089182] 
[   40.089182] which lock already depends on the new lock.
[   40.089182] 
[   40.098344] 
[   40.098344] the existing dependency chain (in reverse order) is:
[   40.106715] 
[   40.106715] -> #1 (&zspage->lock){.+.+}-{2:2}:
[   40.113386]        lock_acquire+0x1cd/0x2c3
[   40.118083]        _raw_read_lock+0x44/0x78
[   40.122781]        zs_map_object+0x73/0x28d
[   40.127479]        zram_bvec_rw+0x42e/0x75d [zram]
[   40.132855]        zram_submit_bio+0x1fc/0x2d7 [zram]
[   40.138526]        submit_bio_noacct+0x11b/0x372
[   40.143709]        submit_bio+0xfd/0x1b5
[   40.148113]        __block_write_full_page+0x302/0x56f
[   40.153877]        __writepage+0x1e/0x74
[   40.158281]        write_cache_pages+0x404/0x59a
[   40.163461]        generic_writepages+0x53/0x82
[   40.168545]        do_writepages+0x33/0x74
[   40.173145]        __filemap_fdatawrite_range+0x91/0xac
[   40.179005]        file_write_and_wait_range+0x39/0x87
[   40.184769]        blkdev_fsync+0x19/0x3e
[   40.189272]        do_fsync+0x39/0x5c
[   40.193384]        __x64_sys_fsync+0x13/0x17
[   40.198178]        do_syscall_64+0x37/0x45
[   40.202776]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   40.209022] 
[   40.209022] -> #0 (&zstrm->lock){+.+.}-{2:2}:
[   40.215589]        validate_chain+0x1966/0x21a8
[   40.220673]        __lock_acquire+0x941/0xbba
[   40.225552]        lock_acquire+0x1cd/0x2c3
[   40.230250]        local_lock_acquire+0x21/0x70 [zram]
[   40.236015]        zcomp_stream_get+0x33/0x4d [zram]
[   40.241585]        zram_bvec_rw+0x476/0x75d [zram]
[   40.246963]        zram_rw_page+0xd8/0x17c [zram]
[   40.252240]        bdev_read_page+0x7a/0x9d
[   40.256933]        do_mpage_readpage+0x6b2/0x860
[   40.262101]        mpage_readahead+0x136/0x245
[   40.267089]        read_pages+0x60/0x1f9
[   40.271492]        page_cache_ra_unbounded+0x211/0x27b
[   40.277251]        generic_file_buffered_read+0x188/0xd4d
[   40.283296]        new_sync_read+0x10c/0x143
[   40.288088]        vfs_read+0xf4/0x1a5
[   40.292285]        ksys_read+0x73/0xd3
[   40.296483]        do_syscall_64+0x37/0x45
[   40.301072]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   40.307319] 
[   40.307319] other info that might help us debug this:
[   40.307319] 
[   40.316285]  Possible unsafe locking scenario:
[   40.316285] 
[   40.322907]        CPU0                    CPU1
[   40.327972]        ----                    ----
[   40.333041]   lock(&zspage->lock);
[   40.336874]                                lock(&zstrm->lock);
[   40.343424]                                lock(&zspage->lock);
[   40.350071]   lock(&zstrm->lock);
[   40.353803] 
[   40.353803]  *** DEADLOCK ***
