Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A002D09C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 05:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgLGEhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 23:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgLGEhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:37:14 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A40C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 20:36:34 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id x13so5940315qvk.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 20:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PoCu/gkPCtJA4+Ph0vwwuZbEYcCZQAZIGlTEAffIyVI=;
        b=sj1rdYyCVqWkpObdPWhpFa/9QBhwSqlgONNcnu39rV/TLPr1LHeOAw3kmgirAKUL4H
         1dwONTaP4p8xTThwJ6DNTYGJ0hqoX9EVhqAO8QRoZ8c7xjSxAdMCVN18aCQbp+ka7k9u
         B9Qb1sXjzbk7EmpsF9g0Lgy7MpHuKc4hO/K074lncpPrizCDqE6tKWGkQEnVtEfoaLwj
         ASqqYC1W3fph7zvmGQO0uL1Cl5KLkEaKby1IPOcQp3aLFE2oJqnHpY+jA/tJH4jFXEy/
         cjGAC2nMbwO0rXA6Ra6Xe3GR6nUYYFHRMoVyymMMU3sCsAT3qnMMV3hNT2O/oVQ+dQ56
         3FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PoCu/gkPCtJA4+Ph0vwwuZbEYcCZQAZIGlTEAffIyVI=;
        b=snCyTxzUYlOJGMswCF1Yw0pRffwMXb0RJNQBPJXUfOGq82zos2dWdQtHsqdC8K5r1d
         mMYLqhMsU3eK/JnWbgpMs/RCOL2iRYhmBI7gCVVfMuMSFKB4VEsw7aj0dznXhtJmuCGd
         irSPwkZzNxgjVLz8/JBQ/ux/bK0bx88yZ1iaoM0a/q6OSlRHU7YI+ZrnJtFncICPnpvk
         bnu/2eeA/Yjv0DmwFHZ+WWGmiGEHyYeKRl3oUxWIrxCIosrwxJDz+HHjBnLcmf4PgQbl
         Uk5J6ZLM7mb+WdIkcsGOuUIevL6btp5NkcNMr/M6Dy7fThvzoBmlerQTYcMZukDSuOzx
         W3Pw==
X-Gm-Message-State: AOAM531u8BQkkk5yTPkZdmWPtCPAHq5iZXVz/WZJii0H0HJSojK6GTay
        DyVSY4UXX4aqw5xd5wqDpG4=
X-Google-Smtp-Source: ABdhPJzq3tCSXNMeWUbXyR+2Qn5KB5Tqls4wcIGNtAKTKUq9Q5vjHLwfKZcC2fSoJWus75KfK7LFJA==
X-Received: by 2002:a05:6214:a69:: with SMTP id ef9mr19584244qvb.50.1607315793282;
        Sun, 06 Dec 2020 20:36:33 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 97sm11085298qte.34.2020.12.06.20.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 20:36:32 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id DD31527C0054;
        Sun,  6 Dec 2020 23:36:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 06 Dec 2020 23:36:30 -0500
X-ME-Sender: <xms:TrHNXz17NTmjBd8wE76nEExPyjVL6lPim4p_iQJ2LiGO9Y3Iv7xrTQ>
    <xme:TrHNXyFjsDKFbiFgp836LESHmqxShyHh9KpcYDp7FBt3vcXtDdeEbByhK_J2yqfOI
    ymILOeETSU7JU1Muw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeekgeffffefudeuhfekveehieevffelteegffehhfelgfevteeukeejfedt
    keefnecuffhomhgrihhnpehophgvnhhsuhhsvgdrohhrghenucfkphepudefuddruddtje
    drudegjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:TrHNXz4z9gXfO61knisO6uYhQ3gfwVcQsRbv15dBy9p6pHa8OYd9nA>
    <xmx:TrHNX43x6AGLWgzDFMqkv2tD-VVYN2W4OrY5Sn4kC8kMLFFRApmYdQ>
    <xmx:TrHNX2FLc0lMUpaTZq1SbS7OF3dldQ9DDOXaCrAuyFI64YZo890Cnw>
    <xmx:TrHNX5337Hyf0XU_a0Afmg1VqVFhaO_zWbVePRTYIB0fq28Na57fRQ>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2F96108005B;
        Sun,  6 Dec 2020 23:36:29 -0500 (EST)
Date:   Mon, 7 Dec 2020 12:35:18 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: Invalid wait context with KMEMLEAK and KASAN enabled
Message-ID: <20201207043518.GA1819081@boqun-archlinux>
References: <CAFLxGvwienJ7sU2+QAhFt+ywS9iYkbAXDGviuTC-4CVwLOhXfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvwienJ7sU2+QAhFt+ywS9iYkbAXDGviuTC-4CVwLOhXfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Sun, Dec 06, 2020 at 11:59:16PM +0100, Richard Weinberger wrote:
> Hi!
> 
> With both KMEMLEAK and KASAN enabled, I'm facing the following lockdep
> splat at random times on Linus' tree as of today.
> Sometimes it happens at bootup, sometimes much later when userspace has started.
> 
> Does this ring a bell?
> 
> [    2.298447] =============================
> [    2.298971] [ BUG: Invalid wait context ]
> [    2.298971] 5.10.0-rc6+ #388 Not tainted
> [    2.298971] -----------------------------
> [    2.298971] ksoftirqd/1/15 is trying to lock:
> [    2.298971] ffff888100b94598 (&n->list_lock){....}-{3:3}, at:
> free_debug_processing+0x3d/0x210

I guest you also had CONFIG_PROVE_RAW_LOCK_NESTING=y, right? With that
config, the wait context detetion of lockdep will treat spinlock_t as
sleepable locks (considering PREEMPT_RT kernel), and here it complained
about trying to acquire a sleepable lock (in PREEMPT_RT kernel) inside a
irq context which cannot be threaded (in this case, it's the IPI). A
proper fix will be modifying kmem_cache_node->list_lock to
raw_spinlock_t.

Regards,
Boqun

> [    2.298971] other info that might help us debug this:
> [    2.298971] context-{2:2}
> [    2.298971] 1 lock held by ksoftirqd/1/15:
> [    2.298971]  #0: ffffffff835f4140 (rcu_callback){....}-{0:0}, at:
> rcu_core+0x408/0x1040
> [    2.298971] stack backtrace:
> [    2.298971] CPU: 1 PID: 15 Comm: ksoftirqd/1 Not tainted 5.10.0-rc6+ #388
> [    2.298971] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-0-ga698c89-rebuilt.opensuse.org 04/01/2014
> [    2.298971] Call Trace:
> [    2.298971]  <IRQ>
> [    2.298971]  dump_stack+0x9a/0xcc
> [    2.298971]  __lock_acquire.cold+0xce/0x34b
> [    2.298971]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
> [    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
> [    2.298971]  lock_acquire+0x153/0x4c0
> [    2.298971]  ? free_debug_processing+0x3d/0x210
> [    2.298971]  ? lock_release+0x690/0x690
> [    2.298971]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [    2.298971]  ? pvclock_clocksource_read+0xd9/0x1a0
> [    2.298971]  _raw_spin_lock_irqsave+0x3b/0x80
> [    2.298971]  ? free_debug_processing+0x3d/0x210
> [    2.298971]  ? qlist_free_all+0x35/0xd0
> [    2.298971]  free_debug_processing+0x3d/0x210
> [    2.298971]  __slab_free+0x286/0x490
> [    2.298971]  ? lockdep_enabled+0x39/0x50
> [    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
> [    2.298971]  ? run_posix_cpu_timers+0x256/0x2c0
> [    2.298971]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [    2.298971]  ? posix_cpu_timers_exit_group+0x30/0x30
> [    2.298971]  qlist_free_all+0x59/0xd0
> [    2.298971]  ? qlist_free_all+0xd0/0xd0
> [    2.298971]  per_cpu_remove_cache+0x47/0x50
> [    2.298971]  flush_smp_call_function_queue+0xea/0x2b0
> [    2.298971]  __sysvec_call_function+0x6c/0x250
> [    2.298971]  asm_call_irq_on_stack+0x12/0x20
> [    2.298971]  </IRQ>
> [    2.298971]  sysvec_call_function+0x84/0xa0
> [    2.298971]  asm_sysvec_call_function+0x12/0x20
> [    2.298971] RIP: 0010:__asan_load4+0x1d/0x80
> [    2.298971] Code: 10 00 75 ee c3 0f 1f 84 00 00 00 00 00 4c 8b 04
> 24 48 83 ff fb 77 4d 48 b8 ff ff ff ff ff 7f ff ff 48 39 c7 76 3e 48
> 8d 47 03 <48> 89 c2 83 e2 07 48 83 fa 02 76 17 48 b9 00 00 00 00 00 fc
> ff df
> [    2.298971] RSP: 0000:ffff888100e4f858 EFLAGS: 00000216
> [    2.298971] RAX: ffffffff83c55773 RBX: ffffffff81002431 RCX: dffffc0000000000
> [    2.298971] RDX: 0000000000000001 RSI: ffffffff83ee8d78 RDI: ffffffff83c55770
> [    2.298971] RBP: ffffffff83c5576c R08: ffffffff81083433 R09: fffffbfff07e333d
> [    2.298971] R10: 000000000001803d R11: fffffbfff07e333c R12: ffffffff83c5575c
> [    2.298971] R13: ffffffff83c55774 R14: ffffffff83c55770 R15: ffffffff83c55770
> [    2.298971]  ? ret_from_fork+0x21/0x30
> [    2.298971]  ? __orc_find+0x63/0xc0
> [    2.298971]  ? stack_access_ok+0x35/0x90
> [    2.298971]  __orc_find+0x63/0xc0
> [    2.298971]  unwind_next_frame+0x1ee/0xbd0
> [    2.298971]  ? ret_from_fork+0x22/0x30
> [    2.298971]  ? ret_from_fork+0x21/0x30
> [    2.298971]  ? deref_stack_reg+0x40/0x40
> [    2.298971]  ? __unwind_start+0x2e8/0x370
> [    2.298971]  ? create_prof_cpu_mask+0x20/0x20
> [    2.298971]  arch_stack_walk+0x83/0xf0
> [    2.298971]  ? ret_from_fork+0x22/0x30
> [    2.298971]  ? rcu_core+0x488/0x1040
> [    2.298971]  stack_trace_save+0x8c/0xc0
> [    2.298971]  ? stack_trace_consume_entry+0x80/0x80
> [    2.298971]  ? sched_clock_local+0x99/0xc0
> [    2.298971]  kasan_save_stack+0x1b/0x40
> [    2.298971]  ? kasan_save_stack+0x1b/0x40
> [    2.298971]  ? kasan_set_track+0x1c/0x30
> [    2.298971]  ? kasan_set_free_info+0x1b/0x30
> [    2.298971]  ? __kasan_slab_free+0x10f/0x150
> [    2.298971]  ? kmem_cache_free+0xa8/0x350
> [    2.298971]  ? rcu_core+0x488/0x1040
> [    2.298971]  ? __do_softirq+0x101/0x573
> [    2.298971]  ? run_ksoftirqd+0x21/0x50
> [    2.298971]  ? smpboot_thread_fn+0x1fc/0x380
> [    2.298971]  ? kthread+0x1c7/0x220
> [    2.298971]  ? ret_from_fork+0x22/0x30
> [    2.298971]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
> [    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
> [    2.298971]  ? lock_acquire+0x153/0x4c0
> [    2.298971]  ? rcu_core+0x408/0x1040
> [    2.298971]  ? lock_release+0x690/0x690
> [    2.298971]  ? lockdep_enabled+0x39/0x50
> [    2.298971]  ? mark_held_locks+0x49/0x90
> [    2.298971]  kasan_set_track+0x1c/0x30
> [    2.298971]  kasan_set_free_info+0x1b/0x30
> [    2.298971]  __kasan_slab_free+0x10f/0x150
> [    2.298971]  ? rcu_core+0x488/0x1040
> [    2.298971]  kmem_cache_free+0xa8/0x350
> [    2.298971]  ? __ia32_compat_sys_move_pages+0x130/0x130
> [    2.298971]  rcu_core+0x488/0x1040
> [    2.298971]  ? call_rcu+0x5d0/0x5d0
> [    2.298971]  ? rcu_read_lock_sched_held+0x9c/0xd0
> [    2.298971]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [    2.298971]  __do_softirq+0x101/0x573
> [    2.298971]  ? trace_event_raw_event_irq_handler_exit+0x150/0x150
> [    2.298971]  run_ksoftirqd+0x21/0x50
> [    2.298971]  smpboot_thread_fn+0x1fc/0x380
> [    2.298971]  ? smpboot_register_percpu_thread+0x180/0x180
> [    2.298971]  ? __kthread_parkme+0xbb/0xd0
> [    2.298971]  ? smpboot_register_percpu_thread+0x180/0x180
> [    2.298971]  kthread+0x1c7/0x220
> [    2.298971]  ? kthread_create_on_node+0xd0/0xd0
> [    2.298971]  ret_from_fork+0x22/0x30
> 
> -- 
> Thanks,
> //richard
