Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426082A1CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKAJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:26:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgKAJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:26:20 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kZ9cv-0003XL-J6
        for linux-kernel@vger.kernel.org; Sun, 01 Nov 2020 09:26:17 +0000
Received: by mail-wr1-f71.google.com with SMTP id h8so5015303wrt.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 01:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yaxnEBjBi39how5v/FvlVnX/rR0ebhWkvbZUhygor+k=;
        b=cUgYn9NrACdevL5YKJCga47m9L+fb5ZLuhfVQ+W+ILfbvjX18nvWrJ1fC55N2KMiU9
         2p/EtVTkxqXGTcxwmW/mLnxvQJV/+bi+xRVWMVRd8kBIi6HHmfId6R9/wa93z2Fb93Ic
         51eXB4pxrZvJh3d3lJOFxnF4yNlUfO8C5JeUeHrkzawTQc7iLpkQKYSm5ZCyOPX16UWf
         O7806YfF8ldnN24uWyx3AwWW8TdrCVYmjhOMVKOi8fGifC+IyUCOq9cMzogHM+ItnBch
         j8ctnctAtbYo3bcGH/U/duqU5FnwZUVnzZHrDXXli2c81vInWnN1qWWVPxcgQvcBjJYo
         vhVw==
X-Gm-Message-State: AOAM531MOiUGCMrzO9BxciRM1S3tIWWV6jRxQ0+q8wzVqFp1hIXAxHCO
        GveUdkZbiRUFpsariGASDRJBQ1ktdupZ3ddeFgO/GRjsfH8mUBXDgZszMp5P5D5My7LjiaA9J92
        RB7HSNKRMtins+WQRZHm1LdrnrzcK8kmrIb424h7ebw==
X-Received: by 2002:a1c:20c6:: with SMTP id g189mr12203829wmg.6.1604222777049;
        Sun, 01 Nov 2020 01:26:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwji9KsoxlU2zZJJe5DZy7++HoJYWV/i+EpLElUicSHZYEaVglrOmbeKuuMBy1ElPWfkzlEvQ==
X-Received: by 2002:a1c:20c6:: with SMTP id g189mr12203801wmg.6.1604222776678;
        Sun, 01 Nov 2020 01:26:16 -0800 (PST)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id y4sm10466419wmj.2.2020.11.01.01.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 01:26:15 -0800 (PST)
Date:   Sun, 1 Nov 2020 10:26:14 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201101092614.GB3989@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following lockdep splat (see below).

Apparently this warning starts to be reported after applying:

 e918188611f0 ("locking: More accurate annotations for read_lock()")

It looks like a false positive to me, but it made me think a bit and
IIUC there can be still a potential deadlock, even if the deadlock
scenario is a bit different than what lockdep is showing.

In the assumption that read-locks are recursive only in_interrupt()
context (as stated in e918188611f0), the following scenario can still
happen:

 CPU0                                     CPU1
 ----                                     ----
 read_lock(&trig->leddev_list_lock);
                                          write_lock(&trig->leddev_list_lock);
 <soft-irq>
 kbd_bh()
   -> read_lock(&trig->leddev_list_lock);

 *** DEADLOCK ***

The write-lock is waiting on CPU1 and the second read_lock() on CPU0
would be blocked by the write-lock *waiter* on CPU1 => deadlock.

In that case we could prevent this deadlock condition using a workqueue
to call kbd_propagate_led_state() instead of calling it directly from
kbd_bh() (even if lockdep would still report the false positive).

Can you help me to understand if this assumption is correct or if I'm
missing something?

Thanks,
-Andrea

Lockdep trace:

[    1.087260] WARNING: possible irq lock inversion dependency detected
[    1.087267] 5.10.0-rc1+ #18 Not tainted
[    1.088829] softirqs last  enabled at (0): [<ffffffff8108ea17>] copy_process+0x6c7/0x1c70
[    1.089662] --------------------------------------------------------
[    1.090284] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.092766] swapper/3/0 just changed the state of lock:
[    1.093325] ffff888006394c18 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x27/0x200
[    1.094190] but this lock took another, HARDIRQ-READ-unsafe lock in the past:
[    1.094944]  (&trig->leddev_list_lock){.+.?}-{2:2}
[    1.094946] 
[    1.094946] 
[    1.094946] and interrupts could create inverse lock ordering between them.
[    1.094946] 
[    1.096600] 
[    1.096600] other info that might help us debug this:
[    1.097250]  Possible interrupt unsafe locking scenario:
[    1.097250] 
[    1.097940]        CPU0                    CPU1
[    1.098401]        ----                    ----
[    1.098873]   lock(&trig->leddev_list_lock);
[    1.099315]                                local_irq_disable();
[    1.099932]                                lock(&host->lock);
[    1.100527]                                lock(&trig->leddev_list_lock);
[    1.101219]   <Interrupt>
[    1.101490]     lock(&host->lock);
[    1.101844] 
[    1.101844]  *** DEADLOCK ***
[    1.101844] 
[    1.102447] no locks held by swapper/3/0.
[    1.102858] 
[    1.102858] the shortest dependencies between 2nd lock and 1st lock:
[    1.103646]  -> (&trig->leddev_list_lock){.+.?}-{2:2} ops: 46 {
[    1.104248]     HARDIRQ-ON-R at:
[    1.104600]                       lock_acquire+0xec/0x430
[    1.105120]                       _raw_read_lock+0x42/0x90
[    1.105839]                       led_trigger_event+0x2b/0x70
[    1.106348]                       rfkill_global_led_trigger_worker+0x94/0xb0
[    1.106970]                       process_one_work+0x240/0x560
[    1.107498]                       worker_thread+0x58/0x3d0
[    1.107984]                       kthread+0x151/0x170
[    1.108447]                       ret_from_fork+0x1f/0x30
[    1.108924]     IN-SOFTIRQ-R at:
[    1.109227]                       lock_acquire+0xec/0x430
[    1.109820]                       _raw_read_lock+0x42/0x90
[    1.110404]                       led_trigger_event+0x2b/0x70
[    1.111051]                       kbd_bh+0x9e/0xc0
[    1.111558]                       tasklet_action_common.constprop.0+0xe9/0x100
[    1.112265]                       tasklet_action+0x22/0x30
[    1.112917]                       __do_softirq+0xcc/0x46d
[    1.113474]                       run_ksoftirqd+0x3f/0x70
[    1.114033]                       smpboot_thread_fn+0x116/0x1f0
[    1.114597]                       kthread+0x151/0x170
[    1.115118]                       ret_from_fork+0x1f/0x30
[    1.115674]     SOFTIRQ-ON-R at:
[    1.115987]                       lock_acquire+0xec/0x430
[    1.116468]                       _raw_read_lock+0x42/0x90
[    1.116949]                       led_trigger_event+0x2b/0x70
[    1.117454]                       rfkill_global_led_trigger_worker+0x94/0xb0
[    1.118070]                       process_one_work+0x240/0x560
[    1.118659]                       worker_thread+0x58/0x3d0
[    1.119225]                       kthread+0x151/0x170
[    1.119740]                       ret_from_fork+0x1f/0x30
[    1.120294]     INITIAL READ USE at:
[    1.120639]                           lock_acquire+0xec/0x430
[    1.121141]                           _raw_read_lock+0x42/0x90
[    1.121649]                           led_trigger_event+0x2b/0x70
[    1.122177]                           rfkill_global_led_trigger_worker+0x94/0xb0
[    1.122841]                           process_one_work+0x240/0x560
[    1.123375]                           worker_thread+0x58/0x3d0
[    1.123880]                           kthread+0x151/0x170
[    1.124354]                           ret_from_fork+0x1f/0x30
[    1.124853]   }
[    1.125016]   ... key      at: [<ffffffff83da4c00>] __key.0+0x0/0x10
[    1.125564]   ... acquired at:
[    1.125836]    _raw_read_lock+0x42/0x90
[    1.126176]    led_trigger_blink_oneshot+0x3b/0x90
[    1.126596]    ledtrig_disk_activity+0x3c/0xa0
[    1.126985]    ata_qc_complete+0x26/0x450
[    1.127347]    ata_do_link_abort+0xa3/0xe0
[    1.127705]    ata_port_freeze+0x2e/0x40
[    1.128050]    ata_hsm_qc_complete+0x94/0xa0
[    1.128431]    ata_sff_hsm_move+0x177/0x7a0
[    1.128796]    ata_sff_pio_task+0xc7/0x1b0
[    1.129154]    process_one_work+0x240/0x560
[    1.129519]    worker_thread+0x58/0x3d0
[    1.129857]    kthread+0x151/0x170
[    1.130156]    ret_from_fork+0x1f/0x30
[    1.130484] 
[    1.130622] -> (&host->lock){-...}-{2:2} ops: 69 {
[    1.131043]    IN-HARDIRQ-W at:
[    1.131322]                     lock_acquire+0xec/0x430
[    1.131777]                     _raw_spin_lock_irqsave+0x52/0xa0
[    1.132303]                     ata_bmdma_interrupt+0x27/0x200
[    1.132807]                     __handle_irq_event_percpu+0xd5/0x2b0
[    1.133359]                     handle_irq_event+0x57/0xb0
[    1.133837]                     handle_edge_irq+0x8c/0x230
[    1.134314]                     asm_call_irq_on_stack+0xf/0x20
[    1.134819]                     common_interrupt+0x100/0x1c0
[    1.135328]                     asm_common_interrupt+0x1e/0x40
[    1.135879]                     native_safe_halt+0xe/0x10
[    1.136539]                     arch_cpu_idle+0x15/0x20
[    1.137090]                     default_idle_call+0x59/0x1c0
[    1.137584]                     do_idle+0x22c/0x2c0
[    1.138013]                     cpu_startup_entry+0x20/0x30
[    1.138507]                     start_secondary+0x11d/0x150
[    1.138992]                     secondary_startup_64_no_verify+0xa6/0xab
[    1.139572]    INITIAL USE at:
[    1.139843]                    lock_acquire+0xec/0x430
[    1.140303]                    _raw_spin_lock_irqsave+0x52/0xa0
[    1.140865]                    ata_dev_init+0x54/0xe0
[    1.141376]                    ata_link_init+0x8b/0xd0
[    1.141857]                    ata_port_alloc+0x1f1/0x210
[    1.142417]                    ata_host_alloc+0xf1/0x130
[    1.142932]                    ata_host_alloc_pinfo+0x14/0xb0
[    1.143453]                    ata_pci_sff_prepare_host+0x41/0xa0
[    1.144031]                    ata_pci_bmdma_prepare_host+0x14/0x30
[    1.144591]                    piix_init_one+0x21f/0x600
[    1.145063]                    local_pci_probe+0x48/0x80
[    1.145524]                    pci_device_probe+0x105/0x1c0
[    1.146006]                    really_probe+0x221/0x490
[    1.146459]                    driver_probe_device+0xe9/0x160
[    1.146953]                    device_driver_attach+0xb2/0xc0
[    1.147449]                    __driver_attach+0x91/0x150
[    1.147916]                    bus_for_each_dev+0x81/0xc0
[    1.148392]                    driver_attach+0x1e/0x20
[    1.148893]                    bus_add_driver+0x138/0x1f0
[    1.149447]                    driver_register+0x91/0xf0
[    1.149964]                    __pci_register_driver+0x73/0x80
[    1.150522]                    piix_init+0x1e/0x2e
[    1.150999]                    do_one_initcall+0x5f/0x2d0
[    1.151549]                    kernel_init_freeable+0x26f/0x2cf
[    1.152127]                    kernel_init+0xe/0x113
[    1.152638]                    ret_from_fork+0x1f/0x30
[    1.153097]  }
[    1.153262]  ... key      at: [<ffffffff83d9fdc0>] __key.6+0x0/0x10
[    1.153890]  ... acquired at:
[    1.154204]    __lock_acquire+0x9da/0x2370
[    1.154588]    lock_acquire+0xec/0x430
[    1.154973]    _raw_spin_lock_irqsave+0x52/0xa0
[    1.155418]    ata_bmdma_interrupt+0x27/0x200
[    1.155857]    __handle_irq_event_percpu+0xd5/0x2b0
[    1.156312]    handle_irq_event+0x57/0xb0
[    1.156701]    handle_edge_irq+0x8c/0x230
[    1.157087]    asm_call_irq_on_stack+0xf/0x20
[    1.157524]    common_interrupt+0x100/0x1c0
[    1.157914]    asm_common_interrupt+0x1e/0x40
[    1.158298]    native_safe_halt+0xe/0x10
[    1.158679]    arch_cpu_idle+0x15/0x20
[    1.159051]    default_idle_call+0x59/0x1c0
[    1.159427]    do_idle+0x22c/0x2c0
[    1.159768]    cpu_startup_entry+0x20/0x30
[    1.160154]    start_secondary+0x11d/0x150
[    1.160551]    secondary_startup_64_no_verify+0xa6/0xab

