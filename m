Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98380286136
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgJGO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgJGO3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:29:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19959C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 07:29:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s19so1094142plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQYkY/Dv05CiXsnmKprjQxciPozbbKHbrhFsuD2QN5Y=;
        b=NZevZlnDNtoR2u+w8MoD52tv83VAMSIiVguE0q8Mf1in4VjNZ4j9XYqo/wykWeLS1S
         1f+7fTPOgREr4e8Mm4lDt9+DSEJrYR1yF7wrRjg0LCxow7eF3sN6loJr+r4QMbIyFJjQ
         jsyawVJb7gtIJ9jLAvpOdFWaKbUco2MqTl0BMm7K3qikfBhM2P5XjE9IXBuD0Cp3Kn38
         psccadWxoxBX9H+fMFM5d4TMThp3lV+xgixn+1tv/e4u7oNbP/kyHulfaj7B9CJdAWsv
         npdfMWojzHNhoqD+bm26QnfIG3YkuyWbaCk/q6bqEjxPib8/t+rDkrAkt8+TVr7j7L0Y
         cT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQYkY/Dv05CiXsnmKprjQxciPozbbKHbrhFsuD2QN5Y=;
        b=aCA7eJY9NDmjzSgApsE5vMDTPZxg2+mACxCavw+vpkzcSGSTuacuz+8mavza6MM6rJ
         u7odmaNs7iRixWL1H57yGt2Qpw+9qiNscTcuD1nhDk1K7YPrUeRBpMDfOB+lBSjjfAfn
         mIAn5RBZSJjuYjLccbLMD6sYMwREs61DtTDI/1aVzrwvGzNMQoFvVxgDFAwTV9bs91hT
         6+pS9yP67HwdKvXrZ9qfO/nTMRkM28VCysl/v/6qiHvANB/4V+osCJgI4wg6NT7/EoEA
         3yNZ4dERO+tFPBP+TN/67XQG7b3s8xdWloGh40jpJOWr/shby1IHLtKMoER51LjXZhtF
         +PgQ==
X-Gm-Message-State: AOAM531al306J2anjLECsVIRNY1dWw1Vvitpsdw3arjFG9czEQIKF7L8
        iTZKZXG6zJW8e0m1N5viFNUAjz9mj+EYzQOcDOuoZA==
X-Google-Smtp-Source: ABdhPJwcSfmm9bSvpdD/7TrlS9fcP5cAfCm/NwmkCj4eDqQWY75wzfBAg3VWb3y665AI+lLJpxKXkLdT0EjvaU2Z7pc=
X-Received: by 2002:a17:90b:228f:: with SMTP id kx15mr3127008pjb.41.1602080949377;
 Wed, 07 Oct 2020 07:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000810a4405b0ece316@google.com> <CAAeHK+xWQp87S=bF2RfUjcudGaLVjk3yKLL-bxRzVM=YNRtzRA@mail.gmail.com>
 <2947473d-76cd-a663-049a-4d51a97e2a3e@linuxfoundation.org> <4b6c9d53-a4de-8749-e0b1-055dbb42703b@linuxfoundation.org>
In-Reply-To: <4b6c9d53-a4de-8749-e0b1-055dbb42703b@linuxfoundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Oct 2020 16:28:58 +0200
Message-ID: <CAAeHK+wZGwovnT969F-aq+EzH8-K21GxJ7YJ0S0Ynd4GM_B4kA@mail.gmail.com>
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

On Wed, Oct 7, 2020 at 3:56 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/5/20 2:44 PM, Shuah Khan wrote:
> > On 10/5/20 8:04 AM, Andrey Konovalov wrote:
> >> On Mon, Oct 5, 2020 at 3:59 PM syzbot
> >> <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    d3d45f82 Merge tag 'pinctrl-v5.9-2' of
> >>> git://git.kernel.or..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=15781d8f900000
> >>> kernel config:
> >>> https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
> >>> dashboard link:
> >>> https://syzkaller.appspot.com/bug?extid=bf1a360e305ee719e364
> >>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>> syz repro:
> >>> https://syzkaller.appspot.com/x/repro.syz?x=16cbaa7d900000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1364f367900000
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the
> >>> commit:
> >>> Reported-by: syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com
> >>>
> >>> vhci_hcd: stop threads
> >>> vhci_hcd: release socket
> >>> vhci_hcd: disconnect device
> >>> ==================================================================
> >>> BUG: KASAN: null-ptr-deref in instrument_atomic_write
> >>> include/linux/instrumented.h:71 [inline]
> >>> BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed
> >>> include/asm-generic/atomic-instrumented.h:142 [inline]
> >>> BUG: KASAN: null-ptr-deref in refcount_add
> >>> include/linux/refcount.h:201 [inline]
> >>> BUG: KASAN: null-ptr-deref in refcount_inc
> >>> include/linux/refcount.h:241 [inline]
> >>> BUG: KASAN: null-ptr-deref in get_task_struct
> >>> include/linux/sched/task.h:104 [inline]
> >>> BUG: KASAN: null-ptr-deref in kthread_stop+0x90/0x7e0
> >>> kernel/kthread.c:591
> >>> Write of size 4 at addr 000000000000001c by task kworker/u4:5/2519
> >>>
> >>> CPU: 1 PID: 2519 Comm: kworker/u4:5 Not tainted 5.9.0-rc7-syzkaller #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine,
> >>> BIOS Google 01/01/2011
> >>> Workqueue: usbip_event event_handler
> >>> Call Trace:
> >>>   __dump_stack lib/dump_stack.c:77 [inline]
> >>>   dump_stack+0x198/0x1fd lib/dump_stack.c:118
> >>>   __kasan_report mm/kasan/report.c:517 [inline]
> >>>   kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
> >>>   check_memory_region_inline mm/kasan/generic.c:186 [inline]
> >>>   check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
> >>>   instrument_atomic_write include/linux/instrumented.h:71 [inline]
> >>>   atomic_fetch_add_relaxed
> >>> include/asm-generic/atomic-instrumented.h:142 [inline]
> >>>   refcount_add include/linux/refcount.h:201 [inline]
> >>>   refcount_inc include/linux/refcount.h:241 [inline]
> >>>   get_task_struct include/linux/sched/task.h:104 [inline]
> >>>   kthread_stop+0x90/0x7e0 kernel/kthread.c:591
> >>>   vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
> >>>   event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
> >>>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
> >>>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
> >>>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
> >>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >>> ==================================================================
> >>> Kernel panic - not syncing: panic_on_warn set ...
> >>> CPU: 1 PID: 2519 Comm: kworker/u4:5 Tainted: G    B
> >>> 5.9.0-rc7-syzkaller #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine,
> >>> BIOS Google 01/01/2011
> >>> Workqueue: usbip_event event_handler
> >>> Call Trace:
> >>>   __dump_stack lib/dump_stack.c:77 [inline]
> >>>   dump_stack+0x198/0x1fd lib/dump_stack.c:118
> >>>   panic+0x382/0x7fb kernel/panic.c:231
> >>>   end_report+0x4d/0x53 mm/kasan/report.c:104
> >>>   __kasan_report mm/kasan/report.c:520 [inline]
> >>>   kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
> >>>   check_memory_region_inline mm/kasan/generic.c:186 [inline]
> >>>   check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
> >>>   instrument_atomic_write include/linux/instrumented.h:71 [inline]
> >>>   atomic_fetch_add_relaxed
> >>> include/asm-generic/atomic-instrumented.h:142 [inline]
> >>>   refcount_add include/linux/refcount.h:201 [inline]
> >>>   refcount_inc include/linux/refcount.h:241 [inline]
> >>>   get_task_struct include/linux/sched/task.h:104 [inline]
> >>>   kthread_stop+0x90/0x7e0 kernel/kthread.c:591
> >>>   vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
> >>>   event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
> >>>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
> >>>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
> >>>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
> >>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >>> Kernel Offset: disabled
> >>> Rebooting in 86400 seconds..
> >>
> >> Hi Valentina and Shuah,
> >>
> >> There appears to be a race condition in the USB/IP vhci_hcd shutdown
> >> procedure. It happens quite often during fuzzing with syzkaller, and
> >> prevents us from going deeper into the USB/IP code.
> >>
> >> Could you advise us what would be the best fix for this?
> >>
> >
> > Hi Andrey,
> >
> > Reading the comments for this routine, looks like there is an assumption
> > that context begins cleanup and race conditions aren't considered.
> >
> > The right fix is holding vhci->lock and vdev->priv_lock to protect
> > critical sections in this routine. I will send a patch for this.
> >
>
> Hi Andrey,
>
> I have been unable to reproduce the problem with the reproducer
> so far. You mentioned it happens quite often.
>
> - matched config with yours
> - load vhci_hcd module and run the reproducer

Hm, if you matched the config, then the module should be built-in?

>
> I do see the messages during shutdown - stop threads etc.
>
> What am I missing?

This appears to be a race that requires precise timings. I failed to
reproduce it with the C reproducer, but I managed to reproduce it with
the syzkaller repro program:

https://syzkaller.appspot.com/x/repro.syz?x=16cbaa7d900000

To do that you need to build syzkaller, and copy ./bin/syz-execprog
and ./bin/syz-executor into your testing environment, and then do:

./syz-execprog -sandbox=none -repeat=0 -procs=6 ./repro.prog

Thanks!
