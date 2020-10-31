Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA992A22C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 02:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgKBBbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 20:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgKBBbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 20:31:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55AC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 17:31:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m14so8258721qtc.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 17:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=98DhkpZPP0Eess4cPK3/X1anWRDvXz78q3K5l0cr4uE=;
        b=DqC65YUGjTQXOPbZrrJtysxCDX/s76Or5wBtJImIxBbN5f5NSJ+TuuD4jgH8Kvsiko
         XyBqXkKL+vLG8dDWAXtxO16+PA7F3EmyYmO9tc36o5XFA2q2yJ3MBnnc8iW3KjLT7ZvT
         KwzxRQkgzLNq86VejZPYBOrEg3Zt9+eP/Cdk0E4AVCZO4akGEt1G+vkuqH6LZhR63x3O
         0hyApezgWqvHY2Br7BxHxgKynpbGuuVaMuX17z8ygWrJVspVHGOPkjrYPMA+2A54dnH0
         jqGQ2RYjCEyFu/noqZ57fq448i+aDZj5ZhgyV9+Xy1SIIWAHiZOD+T+ArlitzkMDbRrG
         QklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=98DhkpZPP0Eess4cPK3/X1anWRDvXz78q3K5l0cr4uE=;
        b=pYt/qqMAFVCXPwC9XWSQxhrEGnVpP1GSyJzx595vCOxo8zcYAgBf0yuLE4xvYmC0Vk
         WMMJF0Vazf5P6gQfvGSbUPBBNIv29o4bUeE9OrWYEdAr05rnrxOLNgceP2dqzM+YCRta
         baGGz/r2EoVdVhEc8VrviPqtSlpNpKdZXIMs5mve4ig5TZ2wLzOjXT9ZPvBI+60At+jb
         Bp1xnsx1no1ybtxyMr0m7fV1/vcGCov+L9G3E20ZwzWDQDVjRShtDOyuNyl+pW+Nde58
         CY3ors+S3o4Ea7sMvIywLeO2MfdjNrq7f0GP/mSdP29ogkm+kSWLAloq8UajzgAVzj7H
         jFMg==
X-Gm-Message-State: AOAM530Z9nXtY30HIAHoBgDiH9yNSHw5fTINRzqEtFnZdTb5cDuc55GZ
        WFviDzCl57RjVdtKP0a4eWY=
X-Google-Smtp-Source: ABdhPJzDu3dRATZ6eghZcJrRD9hIOeLgiawWbmhuJgQvFEVNV+NlUE4rnlx7SxG/Xl/0VyE9gzv6JA==
X-Received: by 2002:ac8:75c9:: with SMTP id z9mr3355138qtq.363.1604280676997;
        Sun, 01 Nov 2020 17:31:16 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 19sm6211687qkj.69.2020.11.01.17.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 17:31:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C9D2827C0054;
        Sun,  1 Nov 2020 20:31:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 01 Nov 2020 20:31:15 -0500
X-ME-Sender: <xms:Y2GfXwmEAQsTpfUhdjg_31Cj_d2XibqJijV2Y3z3O6fAGGFpPkenKg>
    <xme:Y2GfX_1ph9oTfJPjsioMwH-KhBlfCu0e3hRYbMB2op9QuADVAFZipmQ5xTs9CAYSD
    NunSWKG2bHA8JX9Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeduieejrddvvddtrddvheehrddutdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Y2GfX-rGfcd0qz12YaO0hbUg37BkJosPJDk0P4dxvww6P1lCO0GhVg>
    <xmx:Y2GfX8lZ34EASXTce4wNzv1pzj-koEOQPEBEzhE7jSPPsQYmAIzIfw>
    <xmx:Y2GfX-2UU0ZcBVpEiA1wa5YGUy6zhNV1FMi77FEzeiKFwX83Jo6hfA>
    <xmx:Y2GfXxSi4-uyoCwBPspztG4tFHNx_I1A-Sl7ZgHraFPUOYllWndlGA>
Received: from localhost (unknown [167.220.255.106])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F1BC3280063;
        Sun,  1 Nov 2020 20:31:14 -0500 (EST)
Date:   Sat, 31 Oct 2020 18:17:40 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201031101740.GA1875@boqun-laptop.fareast.corp.microsoft.com>
References: <20201101092614.GB3989@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101092614.GB3989@xps-13-7390>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Sun, Nov 01, 2020 at 10:26:14AM +0100, Andrea Righi wrote:
> I'm getting the following lockdep splat (see below).
> 
> Apparently this warning starts to be reported after applying:
> 
>  e918188611f0 ("locking: More accurate annotations for read_lock()")
> 
> It looks like a false positive to me, but it made me think a bit and
> IIUC there can be still a potential deadlock, even if the deadlock
> scenario is a bit different than what lockdep is showing.
> 
> In the assumption that read-locks are recursive only in_interrupt()
> context (as stated in e918188611f0), the following scenario can still
> happen:
> 
>  CPU0                                     CPU1
>  ----                                     ----
>  read_lock(&trig->leddev_list_lock);
>                                           write_lock(&trig->leddev_list_lock);
>  <soft-irq>
>  kbd_bh()
>    -> read_lock(&trig->leddev_list_lock);
> 
>  *** DEADLOCK ***
> 
> The write-lock is waiting on CPU1 and the second read_lock() on CPU0
> would be blocked by the write-lock *waiter* on CPU1 => deadlock.
> 

No, this is not a deadlock, as a write-lock waiter only blocks
*non-recursive* readers, so since the read_lock() in kbd_bh() is called
in soft-irq (which in_interrupt() returns true), so it's a recursive
reader and won't get blocked by the write-lock waiter.

> In that case we could prevent this deadlock condition using a workqueue
> to call kbd_propagate_led_state() instead of calling it directly from
> kbd_bh() (even if lockdep would still report the false positive).
> 

The deadlock senario reported by the following splat is:

	
	CPU 0:				CPU 1:					CPU 2:
	-----				-----					-----
	led_trigger_event():
	  read_lock(&trig->leddev_list_lock);
					<work queue processing>
	  				ata_hsm_qs_complete():
					  spin_lock_irqsave(&host->lock);
					  					write_lock(&trig->leddev_list_lock);
					  ata_port_freeze():
					    ata_do_link_abort():
					      ata_qc_complete():
					        ledtrig_disk_activity():
						  led_trigger_blink_oneshot():
						    read_lock(&trig->leddev_list_lock);
						    // ^ not in in_interrupt() context, so could get blocked by CPU 2
	<interrupt>
	  ata_bmdma_interrupt():
	    spin_lock_irqsave(&host->lock);
	  
, where CPU 0 is blocked by CPU 1 because of the spin_lock_irqsave() in
ata_bmdma_interrupt() and CPU 1 is blocked by CPU 2 because of the
read_lock() in led_trigger_blink_oneshot() and CPU 2 is blocked by CPU 0
because of an arbitrary writer on &trig->leddev_list_lock.

So I don't think it's false positive, but I might miss something
obvious, because I don't know what the code here actually does ;-)

Regards,
Boqun

> Can you help me to understand if this assumption is correct or if I'm
> missing something?
> 
> Thanks,
> -Andrea
> 
> Lockdep trace:
> 
> [    1.087260] WARNING: possible irq lock inversion dependency detected
> [    1.087267] 5.10.0-rc1+ #18 Not tainted
> [    1.088829] softirqs last  enabled at (0): [<ffffffff8108ea17>] copy_process+0x6c7/0x1c70
> [    1.089662] --------------------------------------------------------
> [    1.090284] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.092766] swapper/3/0 just changed the state of lock:
> [    1.093325] ffff888006394c18 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x27/0x200
> [    1.094190] but this lock took another, HARDIRQ-READ-unsafe lock in the past:
> [    1.094944]  (&trig->leddev_list_lock){.+.?}-{2:2}
> [    1.094946] 
> [    1.094946] 
> [    1.094946] and interrupts could create inverse lock ordering between them.
> [    1.094946] 
> [    1.096600] 
> [    1.096600] other info that might help us debug this:
> [    1.097250]  Possible interrupt unsafe locking scenario:
> [    1.097250] 
> [    1.097940]        CPU0                    CPU1
> [    1.098401]        ----                    ----
> [    1.098873]   lock(&trig->leddev_list_lock);
> [    1.099315]                                local_irq_disable();
> [    1.099932]                                lock(&host->lock);
> [    1.100527]                                lock(&trig->leddev_list_lock);
> [    1.101219]   <Interrupt>
> [    1.101490]     lock(&host->lock);
> [    1.101844] 
> [    1.101844]  *** DEADLOCK ***
> [    1.101844] 
> [    1.102447] no locks held by swapper/3/0.
> [    1.102858] 
> [    1.102858] the shortest dependencies between 2nd lock and 1st lock:
> [    1.103646]  -> (&trig->leddev_list_lock){.+.?}-{2:2} ops: 46 {
> [    1.104248]     HARDIRQ-ON-R at:
> [    1.104600]                       lock_acquire+0xec/0x430
> [    1.105120]                       _raw_read_lock+0x42/0x90
> [    1.105839]                       led_trigger_event+0x2b/0x70
> [    1.106348]                       rfkill_global_led_trigger_worker+0x94/0xb0
> [    1.106970]                       process_one_work+0x240/0x560
> [    1.107498]                       worker_thread+0x58/0x3d0
> [    1.107984]                       kthread+0x151/0x170
> [    1.108447]                       ret_from_fork+0x1f/0x30
> [    1.108924]     IN-SOFTIRQ-R at:
> [    1.109227]                       lock_acquire+0xec/0x430
> [    1.109820]                       _raw_read_lock+0x42/0x90
> [    1.110404]                       led_trigger_event+0x2b/0x70
> [    1.111051]                       kbd_bh+0x9e/0xc0
> [    1.111558]                       tasklet_action_common.constprop.0+0xe9/0x100
> [    1.112265]                       tasklet_action+0x22/0x30
> [    1.112917]                       __do_softirq+0xcc/0x46d
> [    1.113474]                       run_ksoftirqd+0x3f/0x70
> [    1.114033]                       smpboot_thread_fn+0x116/0x1f0
> [    1.114597]                       kthread+0x151/0x170
> [    1.115118]                       ret_from_fork+0x1f/0x30
> [    1.115674]     SOFTIRQ-ON-R at:
> [    1.115987]                       lock_acquire+0xec/0x430
> [    1.116468]                       _raw_read_lock+0x42/0x90
> [    1.116949]                       led_trigger_event+0x2b/0x70
> [    1.117454]                       rfkill_global_led_trigger_worker+0x94/0xb0
> [    1.118070]                       process_one_work+0x240/0x560
> [    1.118659]                       worker_thread+0x58/0x3d0
> [    1.119225]                       kthread+0x151/0x170
> [    1.119740]                       ret_from_fork+0x1f/0x30
> [    1.120294]     INITIAL READ USE at:
> [    1.120639]                           lock_acquire+0xec/0x430
> [    1.121141]                           _raw_read_lock+0x42/0x90
> [    1.121649]                           led_trigger_event+0x2b/0x70
> [    1.122177]                           rfkill_global_led_trigger_worker+0x94/0xb0
> [    1.122841]                           process_one_work+0x240/0x560
> [    1.123375]                           worker_thread+0x58/0x3d0
> [    1.123880]                           kthread+0x151/0x170
> [    1.124354]                           ret_from_fork+0x1f/0x30
> [    1.124853]   }
> [    1.125016]   ... key      at: [<ffffffff83da4c00>] __key.0+0x0/0x10
> [    1.125564]   ... acquired at:
> [    1.125836]    _raw_read_lock+0x42/0x90
> [    1.126176]    led_trigger_blink_oneshot+0x3b/0x90
> [    1.126596]    ledtrig_disk_activity+0x3c/0xa0
> [    1.126985]    ata_qc_complete+0x26/0x450
> [    1.127347]    ata_do_link_abort+0xa3/0xe0
> [    1.127705]    ata_port_freeze+0x2e/0x40
> [    1.128050]    ata_hsm_qc_complete+0x94/0xa0
> [    1.128431]    ata_sff_hsm_move+0x177/0x7a0
> [    1.128796]    ata_sff_pio_task+0xc7/0x1b0
> [    1.129154]    process_one_work+0x240/0x560
> [    1.129519]    worker_thread+0x58/0x3d0
> [    1.129857]    kthread+0x151/0x170
> [    1.130156]    ret_from_fork+0x1f/0x30
> [    1.130484] 
> [    1.130622] -> (&host->lock){-...}-{2:2} ops: 69 {
> [    1.131043]    IN-HARDIRQ-W at:
> [    1.131322]                     lock_acquire+0xec/0x430
> [    1.131777]                     _raw_spin_lock_irqsave+0x52/0xa0
> [    1.132303]                     ata_bmdma_interrupt+0x27/0x200
> [    1.132807]                     __handle_irq_event_percpu+0xd5/0x2b0
> [    1.133359]                     handle_irq_event+0x57/0xb0
> [    1.133837]                     handle_edge_irq+0x8c/0x230
> [    1.134314]                     asm_call_irq_on_stack+0xf/0x20
> [    1.134819]                     common_interrupt+0x100/0x1c0
> [    1.135328]                     asm_common_interrupt+0x1e/0x40
> [    1.135879]                     native_safe_halt+0xe/0x10
> [    1.136539]                     arch_cpu_idle+0x15/0x20
> [    1.137090]                     default_idle_call+0x59/0x1c0
> [    1.137584]                     do_idle+0x22c/0x2c0
> [    1.138013]                     cpu_startup_entry+0x20/0x30
> [    1.138507]                     start_secondary+0x11d/0x150
> [    1.138992]                     secondary_startup_64_no_verify+0xa6/0xab
> [    1.139572]    INITIAL USE at:
> [    1.139843]                    lock_acquire+0xec/0x430
> [    1.140303]                    _raw_spin_lock_irqsave+0x52/0xa0
> [    1.140865]                    ata_dev_init+0x54/0xe0
> [    1.141376]                    ata_link_init+0x8b/0xd0
> [    1.141857]                    ata_port_alloc+0x1f1/0x210
> [    1.142417]                    ata_host_alloc+0xf1/0x130
> [    1.142932]                    ata_host_alloc_pinfo+0x14/0xb0
> [    1.143453]                    ata_pci_sff_prepare_host+0x41/0xa0
> [    1.144031]                    ata_pci_bmdma_prepare_host+0x14/0x30
> [    1.144591]                    piix_init_one+0x21f/0x600
> [    1.145063]                    local_pci_probe+0x48/0x80
> [    1.145524]                    pci_device_probe+0x105/0x1c0
> [    1.146006]                    really_probe+0x221/0x490
> [    1.146459]                    driver_probe_device+0xe9/0x160
> [    1.146953]                    device_driver_attach+0xb2/0xc0
> [    1.147449]                    __driver_attach+0x91/0x150
> [    1.147916]                    bus_for_each_dev+0x81/0xc0
> [    1.148392]                    driver_attach+0x1e/0x20
> [    1.148893]                    bus_add_driver+0x138/0x1f0
> [    1.149447]                    driver_register+0x91/0xf0
> [    1.149964]                    __pci_register_driver+0x73/0x80
> [    1.150522]                    piix_init+0x1e/0x2e
> [    1.150999]                    do_one_initcall+0x5f/0x2d0
> [    1.151549]                    kernel_init_freeable+0x26f/0x2cf
> [    1.152127]                    kernel_init+0xe/0x113
> [    1.152638]                    ret_from_fork+0x1f/0x30
> [    1.153097]  }
> [    1.153262]  ... key      at: [<ffffffff83d9fdc0>] __key.6+0x0/0x10
> [    1.153890]  ... acquired at:
> [    1.154204]    __lock_acquire+0x9da/0x2370
> [    1.154588]    lock_acquire+0xec/0x430
> [    1.154973]    _raw_spin_lock_irqsave+0x52/0xa0
> [    1.155418]    ata_bmdma_interrupt+0x27/0x200
> [    1.155857]    __handle_irq_event_percpu+0xd5/0x2b0
> [    1.156312]    handle_irq_event+0x57/0xb0
> [    1.156701]    handle_edge_irq+0x8c/0x230
> [    1.157087]    asm_call_irq_on_stack+0xf/0x20
> [    1.157524]    common_interrupt+0x100/0x1c0
> [    1.157914]    asm_common_interrupt+0x1e/0x40
> [    1.158298]    native_safe_halt+0xe/0x10
> [    1.158679]    arch_cpu_idle+0x15/0x20
> [    1.159051]    default_idle_call+0x59/0x1c0
> [    1.159427]    do_idle+0x22c/0x2c0
> [    1.159768]    cpu_startup_entry+0x20/0x30
> [    1.160154]    start_secondary+0x11d/0x150
> [    1.160551]    secondary_startup_64_no_verify+0xa6/0xab
> 
