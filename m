Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02E12B9306
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKSNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKSNCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:02:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F322C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qDJ9dFT1TQeRLVCH6+gHWjIntmBnj22nN7yL7lZxrIw=; b=I+LDNZM0EOBRMSJ6c/WICiNebP
        akMOVO86TXH1VKDIEmFc8E/UEHs187pt48E9UOWnWBIX2pKDXJxrYCkjdUUMQxVLs2UBqvFXvQjVB
        SVdupqJxdRzV37PH2cMef6XtmVPpGy9T1lA9IUZZ4rMwJxrw3PMiSGp1CEmQelbVT7WDD4PzLZ4s6
        W770ZqkGCVpmw1YONfpZX8nZPgrs9PDl0ntKM48fWVc1QPNxXEgKAfbsPeManWXIo/hd0h6pqQb/R
        5xgFs6EGwKoC28TCr+r3Ufnv0M5oii6hZmSwaPCMh1fZ7QPLXjb30K0446C1+Edhbn2cG7b6tazX2
        QXKLLYgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfjaH-0002Z9-KJ; Thu, 19 Nov 2020 13:02:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 109C1300F7A;
        Thu, 19 Nov 2020 14:02:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA0FA2C125914; Thu, 19 Nov 2020 14:02:44 +0100 (CET)
Date:   Thu, 19 Nov 2020 14:02:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: Deadlock cpuctx_mutex / pmus_lock / &mm->mmap_lock#2
Message-ID: <20201119130244.GN3121392@hirez.programming.kicks-ass.net>
References: <1185a97a-3780-3bce-d97d-ff9c2830e35d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1185a97a-3780-3bce-d97d-ff9c2830e35d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chris, I suspect this is due to i915 calling stop machine with all sorts
of locks held. Is there anything to be done about this? stop_machine()
is really nasty to begin with.

What problem is it typing to solve?

On Thu, Nov 19, 2020 at 12:04:56AM +0100, Heiner Kallweit wrote:
> Just got the following when running perf.
> 
> [  648.247718] ======================================================
> [  648.247725] WARNING: possible circular locking dependency detected
> [  648.247734] 5.10.0-rc4-next-20201118+ #1 Not tainted
> [  648.247740] ------------------------------------------------------
> [  648.247748] perf/19761 is trying to acquire lock:
> [  648.247755] ffffa00200abad18 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x2f/0x80
> [  648.247777]
>                but task is already holding lock:
> [  648.247785] ffffa0027bc2edb0 (&cpuctx_mutex){+.+.}-{3:3}, at: perf_event_ctx_lock_nested+0xd8/0x1f0
> [  648.247801]
>                which lock already depends on the new lock.
> 
> [  648.247810]
>                the existing dependency chain (in reverse order) is:
> [  648.247818]
>                -> #5 (&cpuctx_mutex){+.+.}-{3:3}:
> [  648.247834]        __mutex_lock+0x88/0x900
> [  648.247840]        mutex_lock_nested+0x16/0x20
> [  648.247848]        perf_event_init_cpu+0x89/0x140
> [  648.247857]        perf_event_init+0x172/0x1a0
> [  648.247864]        start_kernel+0x655/0x7de
> [  648.247871]        x86_64_start_reservations+0x24/0x26
> [  648.247878]        x86_64_start_kernel+0x70/0x74
> [  648.247887]        secondary_startup_64_no_verify+0xb0/0xbb
> [  648.247894]
>                -> #4 (pmus_lock){+.+.}-{3:3}:
> [  648.247907]        __mutex_lock+0x88/0x900
> [  648.247914]        mutex_lock_nested+0x16/0x20
> [  648.247921]        perf_event_init_cpu+0x52/0x140
> [  648.247929]        cpuhp_invoke_callback+0xa4/0x810
> [  648.247937]        _cpu_up+0xaa/0x150
> [  648.247943]        cpu_up+0x79/0x90
> [  648.247949]        bringup_nonboot_cpus+0x4d/0x60
> [  648.247958]        smp_init+0x25/0x65
> [  648.247964]        kernel_init_freeable+0x144/0x267
> [  648.247972]        kernel_init+0x9/0xf8
> [  648.247978]        ret_from_fork+0x22/0x30
> [  648.247984]
>                -> #3 (cpu_hotplug_lock){++++}-{0:0}:
> [  648.247998]        cpus_read_lock+0x38/0xb0
> [  648.248006]        stop_machine+0x18/0x40
> [  648.248075]        bxt_vtd_ggtt_insert_entries__BKL+0x37/0x50 [i915]
> [  648.248129]        ggtt_bind_vma+0x43/0x60 [i915]
> [  648.248192]        __vma_bind+0x38/0x40 [i915]
> [  648.248242]        fence_work+0x21/0xac [i915]
> [  648.248292]        fence_notify+0x95/0x134 [i915]
> [  648.248342]        __i915_sw_fence_complete+0x3b/0x1d0 [i915]
> [  648.248394]        i915_sw_fence_commit+0x12/0x20 [i915]
> [  648.248458]        i915_vma_pin_ww+0x25c/0x8c0 [i915]
> [  648.248520]        i915_ggtt_pin+0x52/0xf0 [i915]
> [  648.248576]        intel_ring_pin+0x5b/0x110 [i915]
> [  648.248628]        __intel_context_do_pin_ww+0xd3/0x510 [i915]
> [  648.248681]        __intel_context_do_pin+0x55/0x90 [i915]
> [  648.248734]        intel_engines_init+0x43d/0x570 [i915]
> [  648.248787]        intel_gt_init+0x119/0x2d0 [i915]
> [  648.248848]        i915_gem_init+0x133/0x1c0 [i915]
> [  648.248895]        i915_driver_probe+0x68d/0xc90 [i915]
> [  648.248943]        i915_pci_probe+0x45/0x120 [i915]
> [  648.248952]        pci_device_probe+0xd8/0x150
> [  648.248960]        really_probe+0x259/0x460
> [  648.248967]        driver_probe_device+0x50/0xb0
> [  648.248973]        device_driver_attach+0xad/0xc0
> [  648.248980]        __driver_attach+0x75/0x110
> [  648.248988]        bus_for_each_dev+0x7c/0xc0
> [  648.248995]        driver_attach+0x19/0x20
> [  648.249001]        bus_add_driver+0x117/0x1c0
> [  648.249008]        driver_register+0x8c/0xe0
> [  648.249015]        __pci_register_driver+0x6e/0x80
> [  648.249022]        0xffffffffc0a5c061
> [  648.249028]        do_one_initcall+0x5a/0x2c0
> [  648.249036]        do_init_module+0x5d/0x240
> [  648.249043]        load_module+0x2367/0x2710
> [  648.249049]        __do_sys_finit_module+0xb6/0xf0
> [  648.249056]        __x64_sys_finit_module+0x15/0x20
> [  648.249064]        do_syscall_64+0x38/0x50
> [  648.249071]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  648.249078]
>                -> #2 (reservation_ww_class_mutex){+.+.}-{3:3}:
> [  648.249093]        __ww_mutex_lock.constprop.0+0xac/0x1090
> [  648.249100]        ww_mutex_lock+0x3d/0xa0
> [  648.249108]        dma_resv_lockdep+0x141/0x281
> [  648.249114]        do_one_initcall+0x5a/0x2c0
> [  648.249121]        kernel_init_freeable+0x220/0x267
> [  648.249129]        kernel_init+0x9/0xf8
> [  648.249135]        ret_from_fork+0x22/0x30
> [  648.249140]
>                -> #1 (reservation_ww_class_acquire){+.+.}-{0:0}:
> [  648.249155]        dma_resv_lockdep+0x115/0x281
> [  648.249162]        do_one_initcall+0x5a/0x2c0
> [  648.249168]        kernel_init_freeable+0x220/0x267
> [  648.249176]        kernel_init+0x9/0xf8
> [  648.249182]        ret_from_fork+0x22/0x30
> [  648.249188]
>                -> #0 (&mm->mmap_lock#2){++++}-{3:3}:
> [  648.249203]        __lock_acquire+0x125d/0x2160
> [  648.249210]        lock_acquire+0x137/0x3e0
> [  648.249217]        __might_fault+0x59/0x80
> [  648.249223]        perf_copy_attr+0x35/0x340
> [  648.249230]        _perf_ioctl+0x3e1/0xd40
> [  648.249237]        perf_ioctl+0x34/0x60
> [  648.249245]        __x64_sys_ioctl+0x8c/0xb0
> [  648.249252]        do_syscall_64+0x38/0x50
> [  648.249259]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  648.249265]
>                other info that might help us debug this:
> 
> [  648.249277] Chain exists of:
>                  &mm->mmap_lock#2 --> pmus_lock --> &cpuctx_mutex
> 
> [  648.249295]  Possible unsafe locking scenario:
> 
> [  648.249302]        CPU0                    CPU1
> [  648.249308]        ----                    ----
> [  648.249314]   lock(&cpuctx_mutex);
> [  648.249321]                                lock(pmus_lock);
> [  648.249330]                                lock(&cpuctx_mutex);
> [  648.249339]   lock(&mm->mmap_lock#2);
> [  648.249347]
>                 *** DEADLOCK ***
> 
> [  648.249355] 1 lock held by perf/19761:
> [  648.249360]  #0: ffffa0027bc2edb0 (&cpuctx_mutex){+.+.}-{3:3}, at: perf_event_ctx_lock_nested+0xd8/0x1f0
> [  648.249377]
>                stack backtrace:
> [  648.249386] CPU: 0 PID: 19761 Comm: perf Not tainted 5.10.0-rc4-next-20201118+ #1
> [  648.249395] Hardware name: NA ZBOX-CI327NANO-GS-01/ZBOX-CI327NANO-GS-01, BIOS 5.12 04/28/2020
> [  648.249405] Call Trace:
> [  648.249413]  dump_stack+0x7d/0x9f
> [  648.249420]  print_circular_bug.cold+0x13c/0x141
> [  648.249428]  check_noncircular+0xf1/0x110
> [  648.249435]  __lock_acquire+0x125d/0x2160
> [  648.249442]  lock_acquire+0x137/0x3e0
> [  648.249449]  ? __might_fault+0x2f/0x80
> [  648.249456]  __might_fault+0x59/0x80
> [  648.249463]  ? __might_fault+0x2f/0x80
> [  648.249469]  perf_copy_attr+0x35/0x340
> [  648.249476]  _perf_ioctl+0x3e1/0xd40
> [  648.249482]  ? __mutex_lock+0x88/0x900
> [  648.249489]  ? perf_event_ctx_lock_nested+0xd8/0x1f0
> [  648.249497]  ? perf_event_ctx_lock_nested+0x1a/0x1f0
> [  648.249504]  ? mutex_lock_nested+0x16/0x20
> [  648.249511]  perf_ioctl+0x34/0x60
> [  648.249518]  __x64_sys_ioctl+0x8c/0xb0
> [  648.249524]  do_syscall_64+0x38/0x50
> [  648.249531]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  648.249539] RIP: 0033:0x7f68dd378f6b
> [  648.249548] Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 ae 0c 00 f7 d8 64 89 01 48
> [  648.249566] RSP: 002b:00007ffd6c018c58 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [  648.249577] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f68dd378f6b
> [  648.249586] RDX: 00007ffd6c018c90 RSI: 000000004008240b RDI: 0000000000000003
> [  648.249594] RBP: 00007ffd6c018d40 R08: 0000000000000008 R09: 0000003000000018
> [  648.249602] R10: fffffffffffff8f8 R11: 0000000000000202 R12: 0000000000000003
> [  648.249611] R13: 00007ffd6c018c90 R14: 0000007800000005 R15: 000080056c01a5a0
