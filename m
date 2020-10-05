Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985F6283746
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgJEOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgJEOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:04:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:04:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so5674286pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7k3Iq0WdPKvMtclmO+miPSypiVYJLITa1Qn3fNfnyew=;
        b=I0WKi0HUUi7WYcIFqh8PgdvSqyF0o/Sbhoi1aYxH0QtUG83neoRMYxgRj10bN5NgFq
         RPpv34DMtblMWNWmsvlZzc3/owkjyEbA8J0rxwLnikIkNwfUKydkelSKcWVzBBG7Kghu
         VJ81BCe3z3iWFZeg7+7J2Q1Iq92W9+3tco8wQ+6IY5mrjlQAbHXx9/ZJNgoZCMWjfyj/
         ykxCqrI1iboQu+3vyJQkHQKnPGGrhecneWZQ39McUbTCCWZYMdfnzVHxdvaQkmLuQuhM
         ugolOAijswT24Xfx0DvyoprBJN1gDbDmZu/YgfIpIlZvlRiOYuglKgpqquhox2icySdI
         7Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7k3Iq0WdPKvMtclmO+miPSypiVYJLITa1Qn3fNfnyew=;
        b=RvS+Q31qeHEhpV5wlYnF2lrm+v1Hz4o/wGF741uSpEvETuLrjzRevITBRpKjhlggFJ
         zfWwdNG/ajedbBnyjsSFLu7fQ2Ui5u964eSCf+hj3JkwzNRVWWMDXi8tfLUoVAd4JdC5
         vzLS7wQgtO5MA8HYDsx5EqqAkKehsyIdfpF//i0B1TWHJHGGkq7ao5LCYRNm60jrpLtC
         WKSCAAcqK8k35Nl6XLyEjt7WTq26/WeDC+Afgyl49qVPuGGFJuNZLrae0+HEN+U3MALv
         Ts0VoLyJo+CRpwj1nNBg3xTPx5tP3RXLbHjfu8XJ/9kZgP5kKVErxe52nEyqhvKJMNzD
         kAHw==
X-Gm-Message-State: AOAM530jaxGxIkH8j2pIjspJh+GZg+uVMc7rCeONHD1S8jKRKj8N72NE
        iCYwqvRE5DvF2e+IdP/+LP6YiZ6r41OFt+1NtKbt0A==
X-Google-Smtp-Source: ABdhPJx6JVhtt2tsGa5V+fifJPM7qghyn0NDTgPijg+ypM/h8ZUzomF9gpsVBWkUl1wOKSAIcb1pk+/xRnK2WOELm2s=
X-Received: by 2002:a17:90b:807:: with SMTP id bk7mr8176229pjb.166.1601906659307;
 Mon, 05 Oct 2020 07:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000810a4405b0ece316@google.com>
In-Reply-To: <000000000000810a4405b0ece316@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 5 Oct 2020 16:04:08 +0200
Message-ID: <CAAeHK+xWQp87S=bF2RfUjcudGaLVjk3yKLL-bxRzVM=YNRtzRA@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in event_handler
To:     Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:59 PM syzbot
<syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d3d45f82 Merge tag 'pinctrl-v5.9-2' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15781d8f900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
> dashboard link: https://syzkaller.appspot.com/bug?extid=bf1a360e305ee719e364
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cbaa7d900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1364f367900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com
>
> vhci_hcd: stop threads
> vhci_hcd: release socket
> vhci_hcd: disconnect device
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
> BUG: KASAN: null-ptr-deref in refcount_add include/linux/refcount.h:201 [inline]
> BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:241 [inline]
> BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:104 [inline]
> BUG: KASAN: null-ptr-deref in kthread_stop+0x90/0x7e0 kernel/kthread.c:591
> Write of size 4 at addr 000000000000001c by task kworker/u4:5/2519
>
> CPU: 1 PID: 2519 Comm: kworker/u4:5 Not tainted 5.9.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usbip_event event_handler
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fd lib/dump_stack.c:118
>  __kasan_report mm/kasan/report.c:517 [inline]
>  kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
>  check_memory_region_inline mm/kasan/generic.c:186 [inline]
>  check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>  instrument_atomic_write include/linux/instrumented.h:71 [inline]
>  atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
>  refcount_add include/linux/refcount.h:201 [inline]
>  refcount_inc include/linux/refcount.h:241 [inline]
>  get_task_struct include/linux/sched/task.h:104 [inline]
>  kthread_stop+0x90/0x7e0 kernel/kthread.c:591
>  vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
>  event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
>  process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 2519 Comm: kworker/u4:5 Tainted: G    B             5.9.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usbip_event event_handler
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fd lib/dump_stack.c:118
>  panic+0x382/0x7fb kernel/panic.c:231
>  end_report+0x4d/0x53 mm/kasan/report.c:104
>  __kasan_report mm/kasan/report.c:520 [inline]
>  kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
>  check_memory_region_inline mm/kasan/generic.c:186 [inline]
>  check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>  instrument_atomic_write include/linux/instrumented.h:71 [inline]
>  atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
>  refcount_add include/linux/refcount.h:201 [inline]
>  refcount_inc include/linux/refcount.h:241 [inline]
>  get_task_struct include/linux/sched/task.h:104 [inline]
>  kthread_stop+0x90/0x7e0 kernel/kthread.c:591
>  vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
>  event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
>  process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

Hi Valentina and Shuah,

There appears to be a race condition in the USB/IP vhci_hcd shutdown
procedure. It happens quite often during fuzzing with syzkaller, and
prevents us from going deeper into the USB/IP code.

Could you advise us what would be the best fix for this?

Thanks in advance!
