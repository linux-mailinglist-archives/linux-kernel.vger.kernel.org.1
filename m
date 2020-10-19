Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40BF292129
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 04:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgJSCdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 22:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgJSCdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:33:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E4C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 19:33:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p15so8785999wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 19:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBN/6CP/+ltPqdamjKu98WNiNi7S6ZEKhupkah4Br1c=;
        b=hV63/hxW3sBUBXLnuV54MuJa2DdDe7YEv/dYeKTGNfQvDOv3Ui+Ggz7T7AAyMX2isX
         VdYbmBeSqXJqfT32pfF+YbRk4kino2tGi9nWzLmzqAEg7OSzMEFy/W4nqugmkBsU5nqx
         07yGPNKxCy7WEch9pi0GKaOxelBIwUcW1xElYftBxEPtvfDOO8n36H1Fd980GZacGDEk
         VvT6+p+eo7oajZPaU5gfmDQ9boYl51YTWsN6CaC/kFLQ6Vkmj4JsnaKv20/xt40GtUlX
         ljvwOOOvDAzxehh1nSg8I9qavUIRGO8LwACuk3F7nrZCsFFiL6ELNehxggDAOacp4+xS
         1t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBN/6CP/+ltPqdamjKu98WNiNi7S6ZEKhupkah4Br1c=;
        b=XhitX2i6Bm+x7zWqvsA9YD2Jeufq5oWn9lsZ/8jKOtURFqEWBMAtdZDVaEGxRU0wNx
         Ds7Q1ex8yxM04gymEDPTsvzqHiUVTseIViw9Mc8Nv+G/BvvZsH+IKNZVwnGIddK9xJwS
         tldlGKhIvqItEECCtL1pkCrYWsxEjJ9OcqKK5yURtWkUZtHTBN0lOMxgZ4CwWlUYq1K5
         h4/60hKDvTkljQ5GEbidS3UeTcJ3RBjNiSAaYhQzl7B+lKCg22SbIuMam8KACgrFvCgD
         kPEfz4jAoI2gU87EchMFCjqBYFt3EbQ0xVU87De13roGqqK5zMvPz9UyK79eflSD7pf0
         19PQ==
X-Gm-Message-State: AOAM531xYSVwTYyULEgyQbxIraYr0tuG8Y1mNEBzpWsZS1Bv8ccSbAaf
        Xj0sqiQRml9QGigM68PfSlVFJrk0cv/S32PFYZCjhkTzHGqRSA==
X-Google-Smtp-Source: ABdhPJzB5DOvyDDSp7xrHu51FkKWPOlUT1KhYRd62+NKzH8xN0RiVPg6E7qSaODPdlUXlyjb34W2tfyApr6feUN4rkY=
X-Received: by 2002:a1c:e256:: with SMTP id z83mr14534843wmg.37.1603074822730;
 Sun, 18 Oct 2020 19:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
 <20200527201119.1692513-8-bigeasy@linutronix.de> <20201019015252.GA61728@google.com>
In-Reply-To: <20201019015252.GA61728@google.com>
From:   Hugh Dickins <hughd@google.com>
Date:   Sun, 18 Oct 2020 19:33:15 -0700
Message-ID: <CANsGZ6Z1pHJ-y+AZBngXbZnZC2yhOFtqT1RpP9FHCVdw3EYtRA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] zram: Use local lock to protect per-CPU data
To:     Yu Zhao <yuzhao@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 6:53 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, May 27, 2020 at 10:11:19PM +0200, Sebastian Andrzej Siewior wrote:
> > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> >
> > The zcomp driver uses per-CPU compression. The per-CPU data pointer is
> > acquired with get_cpu_ptr() which implicitly disables preemption.
> > It allocates memory inside the preempt disabled region which conflicts
> > with the PREEMPT_RT semantics.
> >
> > Replace the implicit preemption control with an explicit local lock.
> > This allows RT kernels to substitute it with a real per CPU lock, which
> > serializes the access but keeps the code section preemptible. On non RT
> > kernels this maps to preempt_disable() as before, i.e. no functional
> > change.
>
> Hi,
>
> This change seems to have introduced a potential deadlock. Can you
> please take a look?

Probably needs Peter's fix
https://lore.kernel.org/lkml/20201016124009.GQ2611@hirez.programming.kicks-ass.net/

>
> Thank you.
>
> [   40.030778] ======================================================
> [   40.037706] WARNING: possible circular locking dependency detected
> [   40.044637] 5.9.0-74216-g5c9472ed6825 #1 Tainted: G        W
> [   40.051759] ------------------------------------------------------
> [   40.058685] swapon/586 is trying to acquire lock:
> [   40.063950] ffffe8ffffc0ee60 (&zstrm->lock){+.+.}-{2:2}, at: local_lock_acquire+0x5/0x70 [zram]
> [   40.073739]
> [   40.073739] but task is already holding lock:
> [   40.080277] ffff888101a1f438 (&zspage->lock){.+.+}-{2:2}, at: zs_map_object+0x73/0x28d
> [   40.089182]
> [   40.089182] which lock already depends on the new lock.
> [   40.089182]
> [   40.098344]
> [   40.098344] the existing dependency chain (in reverse order) is:
> [   40.106715]
> [   40.106715] -> #1 (&zspage->lock){.+.+}-{2:2}:
> [   40.113386]        lock_acquire+0x1cd/0x2c3
> [   40.118083]        _raw_read_lock+0x44/0x78
> [   40.122781]        zs_map_object+0x73/0x28d
> [   40.127479]        zram_bvec_rw+0x42e/0x75d [zram]
> [   40.132855]        zram_submit_bio+0x1fc/0x2d7 [zram]
> [   40.138526]        submit_bio_noacct+0x11b/0x372
> [   40.143709]        submit_bio+0xfd/0x1b5
> [   40.148113]        __block_write_full_page+0x302/0x56f
> [   40.153877]        __writepage+0x1e/0x74
> [   40.158281]        write_cache_pages+0x404/0x59a
> [   40.163461]        generic_writepages+0x53/0x82
> [   40.168545]        do_writepages+0x33/0x74
> [   40.173145]        __filemap_fdatawrite_range+0x91/0xac
> [   40.179005]        file_write_and_wait_range+0x39/0x87
> [   40.184769]        blkdev_fsync+0x19/0x3e
> [   40.189272]        do_fsync+0x39/0x5c
> [   40.193384]        __x64_sys_fsync+0x13/0x17
> [   40.198178]        do_syscall_64+0x37/0x45
> [   40.202776]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   40.209022]
> [   40.209022] -> #0 (&zstrm->lock){+.+.}-{2:2}:
> [   40.215589]        validate_chain+0x1966/0x21a8
> [   40.220673]        __lock_acquire+0x941/0xbba
> [   40.225552]        lock_acquire+0x1cd/0x2c3
> [   40.230250]        local_lock_acquire+0x21/0x70 [zram]
> [   40.236015]        zcomp_stream_get+0x33/0x4d [zram]
> [   40.241585]        zram_bvec_rw+0x476/0x75d [zram]
> [   40.246963]        zram_rw_page+0xd8/0x17c [zram]
> [   40.252240]        bdev_read_page+0x7a/0x9d
> [   40.256933]        do_mpage_readpage+0x6b2/0x860
> [   40.262101]        mpage_readahead+0x136/0x245
> [   40.267089]        read_pages+0x60/0x1f9
> [   40.271492]        page_cache_ra_unbounded+0x211/0x27b
> [   40.277251]        generic_file_buffered_read+0x188/0xd4d
> [   40.283296]        new_sync_read+0x10c/0x143
> [   40.288088]        vfs_read+0xf4/0x1a5
> [   40.292285]        ksys_read+0x73/0xd3
> [   40.296483]        do_syscall_64+0x37/0x45
> [   40.301072]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   40.307319]
> [   40.307319] other info that might help us debug this:
> [   40.307319]
> [   40.316285]  Possible unsafe locking scenario:
> [   40.316285]
> [   40.322907]        CPU0                    CPU1
> [   40.327972]        ----                    ----
> [   40.333041]   lock(&zspage->lock);
> [   40.336874]                                lock(&zstrm->lock);
> [   40.343424]                                lock(&zspage->lock);
> [   40.350071]   lock(&zstrm->lock);
> [   40.353803]
> [   40.353803]  *** DEADLOCK ***
>
