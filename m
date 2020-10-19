Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F071292A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgJSPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbgJSPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:11:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28699C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:11:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b6so125701pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRF1c5DvJ2k0xtgiFCBpM8FTbcAucOYZGdY9IkjWwK0=;
        b=rnho9+h9h549976m5EuvzBhToDYxAzJi4uU9NCjZQ3D+SQGUqLQiFio+UcuoHVxgBm
         iLlrXINPkO/Px5dsrLR5iRzvhBahE1ZAj1GHteiqhVrmgv74c+W2noaLPWN5Sfusu+TM
         /kKEMH/AQMUEZJqRFV8sikBQPMntvl5tB7zGKLyC2rtiz8p5O3Ajnw6eH9zwWyZGMNeh
         6anllb/0W9+76zZLWpme6OPdjXAzs/JJ9PJ2a/e6NKIYU0Sy6FWmjEnTJH8vz+Y+PSCW
         HZUBzuzx6IN3F7MIEP3BTeorNMk/JMuH06j2KbIkUV1jNj6JOaG+JYAljzHnOjD78L5L
         5M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRF1c5DvJ2k0xtgiFCBpM8FTbcAucOYZGdY9IkjWwK0=;
        b=r+6eu65Uil2LkvdxgDN6iqdtX4uUT4/oSFY7G7oIeqZ/MbhCu4x6pWFKbJokHFyVYZ
         e/8MP8xMLBn4mwwJe+Lbd3EJ48KvpgWkDxYGzbnIyR5sBFqIKfCeL01EiqXJo7FeuiP1
         fNzV3tT/ZDlEeWKt9kvMIJ7EPkgcJH79O7BYJ9gEegzkAwM1f//AeFgnqk9NjktDO7rL
         uW04CGhKAZv+BWGCaAghNoloiOBlwGSi3tJKQBcHz4ydkQvveMa9Sdz9iIkr/5q89+yo
         00c9J82pJ31N5VqksM2/Fk48LcXDsxuQI2iGvdvx7M0IpPNWgNjzOYoTiXSq5vxVFz67
         LsCw==
X-Gm-Message-State: AOAM531XTYQYtBbP+X/CEFSSagyqXugVaTCUaunqqywcjNoqJeTLiNf6
        zEoCDx/Q8UugHQJwaW+TctOTMFoPrfK+vHepn8uwag==
X-Google-Smtp-Source: ABdhPJzQOXixEUWET+yFnpTEwP6b1ucwjhmqq4XKTA2J7zZg2ERaGT3ZvQ8lTvAarqE6KEvr95Q3SjX8WpJOKTGx1DE=
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id
 b8-20020a170902d888b02900d0cb2df274mr246188plz.13.1603120264396; Mon, 19 Oct
 2020 08:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000810a4405b0ece316@google.com> <CAAeHK+xWQp87S=bF2RfUjcudGaLVjk3yKLL-bxRzVM=YNRtzRA@mail.gmail.com>
 <2947473d-76cd-a663-049a-4d51a97e2a3e@linuxfoundation.org>
 <4b6c9d53-a4de-8749-e0b1-055dbb42703b@linuxfoundation.org>
 <CAAeHK+wZGwovnT969F-aq+EzH8-K21GxJ7YJ0S0Ynd4GM_B4kA@mail.gmail.com>
 <5e0e21bd-5cc9-f1d8-d45e-ec7f10edbfba@linuxfoundation.org> <9256b41b-fe27-a453-ab30-8999379bc1e3@linuxfoundation.org>
In-Reply-To: <9256b41b-fe27-a453-ab30-8999379bc1e3@linuxfoundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Oct 2020 17:10:53 +0200
Message-ID: <CAAeHK+xpbCExXG2xP5xGBbMpJg4sesHLsMn++Qz47jfNELhXjQ@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in event_handler
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 9:48 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Andrey,
>
> I am unable to reproduce the problem. I even tweaked the reproducer
> to launch 10 procs and 100 threads.
>
> Can you test the following patch with your setup
>
> Here it is - also attached.

Hi Shuah,

I get the crash below with this change. It complains about
kthread_stop_put() being called in atomic context.

BUG: sleeping function called from invalid context at
kernel/sched/completion.c:101
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 112, name: kworker/u4:2
4 locks held by kworker/u4:2/112:
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
process_one_work+0x841/0x15c0 kernel/workqueue.c:2243
 #1: ffffc900001dfdc0 (usbip_work){+.+.}-{0:0}, at:
process_one_work+0x874/0x15c0 kernel/workqueue.c:2247
 #2: ffff88801371d280 (&vhci_hcd->vhci->lock){....}-{2:2}, at:
vhci_shutdown_connection+0xd2/0x360 drivers/usb/usbip/vhci_hcd.c:1019
 #3: ffff88801a904890 (&vdev->priv_lock){....}-{2:2}, at: spin_lock
include/linux/spinlock.h:354 [inline]
 #3: ffff88801a904890 (&vdev->priv_lock){....}-{2:2}, at:
vhci_shutdown_connection+0xeb/0x360 drivers/usb/usbip/vhci_hcd.c:1020
irq event stamp: 1298372
hardirqs last  enabled at (1298371): [<ffffffff81b6ebd6>]
kfree+0x236/0x290 mm/slab.c:3759
hardirqs last disabled at (1298372): [<ffffffff8844b5f9>]
__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (1298372): [<ffffffff8844b5f9>]
_raw_spin_lock_irqsave+0xa9/0xd0 kernel/locking/spinlock.c:159
softirqs last  enabled at (1298362): [<ffffffff87fdcae1>]
spin_unlock_bh include/linux/spinlock.h:399 [inline]
softirqs last  enabled at (1298362): [<ffffffff87fdcae1>]
batadv_nc_purge_paths+0x2d1/0x400 net/batman-adv/network-coding.c:470
softirqs last disabled at (1298360): [<ffffffff87fdc8ef>] spin_lock_bh
include/linux/spinlock.h:359 [inline]
softirqs last disabled at (1298360): [<ffffffff87fdc8ef>]
batadv_nc_purge_paths+0xdf/0x400 net/batman-adv/network-coding.c:441
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 112 Comm: kworker/u4:2 Not tainted 5.9.0+ #29
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
Workqueue: usbip_event event_handler
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 ___might_sleep.cold+0x1ef/0x235 kernel/sched/core.c:7298
 __wait_for_common kernel/sched/completion.c:101 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x85/0x270 kernel/sched/completion.c:138
 kthread_stop+0x17d/0x720 kernel/kthread.c:596
 vhci_shutdown_connection+0x121/0x360 drivers/usb/usbip/vhci_hcd.c:1024
 event_handler+0x1a4/0x3b0 drivers/usb/usbip/usbip_event.c:78
 process_one_work+0x953/0x15c0 kernel/workqueue.c:2272
 worker_thread+0x96/0xe20 kernel/workqueue.c:2418
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
BUG: scheduling while atomic: kworker/u4:2/112/0x00000003
4 locks held by kworker/u4:2/112:
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888012a7b138 ((wq_completion)usbip_event){+.+.}-{0:0}, at:
process_one_work+0x841/0x15c0 kernel/workqueue.c:2243
 #1: ffffc900001dfdc0 (usbip_work){+.+.}-{0:0}, at:
process_one_work+0x874/0x15c0 kernel/workqueue.c:2247
 #2: ffff88801371d280 (&vhci_hcd->vhci->lock){+.+.}-{2:2}, at:
vhci_shutdown_connection+0xd2/0x360 drivers/usb/usbip/vhci_hcd.c:1019
 #3: ffff88801a904890 (&vdev->priv_lock){+.+.}-{2:2}, at: spin_lock
include/linux/spinlock.h:354 [inline]
 #3: ffff88801a904890 (&vdev->priv_lock){+.+.}-{2:2}, at:
vhci_shutdown_connection+0xeb/0x360 drivers/usb/usbip/vhci_hcd.c:1020
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0
