Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85B22DA2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 22:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgLNVk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 16:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgLNVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:40:27 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:39:47 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id s2so3173822vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnSroKIpTYinItEU9jOZ+vz7IlBWupf/HygDFUj6ksA=;
        b=YZnXxD072W/pSX++iWFSiaRl7GCfzyvVroQEEpiDhCwM3vOlJEroC/fJ3Wuj0Gy0G/
         XjF597jX588ghZUl2w9abD6zMvRuVRh99Xy9Y8MS+wuuU+a4ZhzOEb4pBERKPFqnmqMz
         Oo0DQ+mxOuhMCBjejsiyOCDHdG0rS2itd6IxH29azGp0biD02cQQBwrgouOU6A3UNDrt
         dcVfmxVPpazrA/BL3eOCC8+7wS3RNYNYQewVDbcyp+DLa6a2d/BVK6CzywipzVju/rEq
         AY4O/YkNCMFp+I6Y176xdXgzmtRHie8z1bCFntpxDiBv/Ste4T0E7WOpNrXZVeSPM3mK
         ecoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnSroKIpTYinItEU9jOZ+vz7IlBWupf/HygDFUj6ksA=;
        b=iWol1Ud1ggs58ZgEvJZgfa4/x1ulU0Pv6wme5VJU59ud08tGn66nF8NbJvhDl/Cf7M
         4t6bDiSWObzIGuaNnkXLj77gOQk76H9BCUTT+R4uwzyTTTaebCL2LeEchL/tf+s60es1
         PIVFA9PgKWlJ15Gc39KxZWI1bJF/wGEZkCMV/sKmovEma2CjU73sScgYzBY/r7JxSIVn
         UrKEmGlOBX5VGR/x0zNof1iBOg+GP62zwQLx7eJMWudSqete22ntXiP7JEKWzb5KzwUX
         UQDGQveMWrQSbG7LjwntJRujF9WfZTbVmYFkwiygVDX4ZSeqcy12uZtDyNqhTUuBYrvR
         rssg==
X-Gm-Message-State: AOAM530DEJfM9Lp050SnnarWdv4cb88touR0D30ht8LQl/PhYJjSm7aB
        VLQ+i2O29DXEmts8L3r/oREXXdSh+fY=
X-Google-Smtp-Source: ABdhPJx9KhlnPpThFw7n/xlL+fm6JvcsGehyRg9z5kxO6kER+wQDc/QVmNP/2D5TtqKZQsWRYHd+DA==
X-Received: by 2002:a67:401:: with SMTP id 1mr24748854vse.51.1607981985978;
        Mon, 14 Dec 2020 13:39:45 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id b23sm1064512vso.34.2020.12.14.13.39.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 13:39:45 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id p2so5976230uac.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:39:44 -0800 (PST)
X-Received: by 2002:ab0:324a:: with SMTP id r10mr25502428uan.37.1607981984490;
 Mon, 14 Dec 2020 13:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20201214145834.GI67148@shao2-debian>
In-Reply-To: <20201214145834.GI67148@shao2-debian>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 14 Dec 2020 16:39:07 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfm=7H=fiEVvsTTYu=bmaG_S5nNrvsqSJTCGoQs3wYTzQ@mail.gmail.com>
Message-ID: <CA+FuTSfm=7H=fiEVvsTTYu=bmaG_S5nNrvsqSJTCGoQs3wYTzQ@mail.gmail.com>
Subject: Re: [epoll] fb72873666: WARNING:at_kernel/tracepoint.c:#tracepoint_probe_register_prio
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:59 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: fb728736669f7805bcc0fa1c4d578faf991d62a8 ("epoll: wire up syscall epoll_pwait2")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
>
> in testcase: trinity
> version: trinity-x86_64-af355e9-1_2019-12-03
> with following parameters:
>
>         runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +----------------------------------------------------------------+------------+------------+
> |                                                                | e659ea023d | fb72873666 |
> +----------------------------------------------------------------+------------+------------+
> | boot_successes                                                 | 11         | 0          |
> | boot_failures                                                  | 0          | 12         |
> | WARNING:at_kernel/tracepoint.c:#tracepoint_probe_register_prio | 0          | 10         |
> | RIP:tracepoint_probe_register_prio                             | 0          | 10         |
> | WARNING:at_kernel/locking/lockdep.c:#__lock_acquire            | 0          | 2          |
> | RIP:__lock_acquire                                             | 0          | 2          |
> | BUG:kernel_NULL_pointer_dereference,address                    | 0          | 2          |
> | Oops:#[##]                                                     | 0          | 2          |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt          | 0          | 2          |
> +----------------------------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> [  147.820910] WARNING: CPU: 0 PID: 4088 at kernel/tracepoint.c:136 tracepoint_probe_register_prio+0x451/0x4c0
> [  147.822045] Modules linked in:
> [  147.822415] CPU: 0 PID: 4088 Comm: trinity-main Not tainted 5.10.0-rc7-13210-gfb728736669f #1
> [  147.823462] RIP: 0010:tracepoint_probe_register_prio+0x451/0x4c0
> [  147.824182] Code: ff ff e8 72 e3 0c 00 44 8b 4c 24 08 49 89 c7 e9 fb fd ff ff 41 bf f4 ff ff ff 45 31 e4 48 c7 c5 f4 ff ff ff e9 af fc ff ff 90 <0f> 0b 90 31 c9 31 d2 be 01 00 00 00 48 c7 c7 b8 b0 0c 84 e8 17 c9
> [  147.826276] RSP: 0018:ffff888160cc3d28 EFLAGS: 00010246
> [  147.826938] RAX: 0000000000000001 RBX: ffff888140c2a008 RCX: 0000000000000000
> [  147.827745] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff840cb0e8
> [  147.828556] RBP: ffff888140c2a550 R08: 0000000000000001 R09: 0000000000000000
> [  147.829382] R10: ffff888160cc3d28 R11: 0000000000000001 R12: 0000000000000000
> [  147.830209] R13: ffffffff84f5b6a0 R14: ffffffff8120aea9 R15: 0000000000000000
> [  147.831063] FS:  00007fc0af66a740(0000) GS:ffffffff838b2000(0000) knlGS:0000000000000000
> [  147.831998] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  147.832655] CR2: 00000000027d4058 CR3: 000000016040a000 CR4: 00000000000006b0
> [  147.833481] Call Trace:
> [  147.833817]  ? perf_event_alloc+0x489/0x10c0
> [  147.834330]  ? perf_trace_init+0x251/0x2a0
> [  147.834860]  ? perf_tp_event_init+0x1b/0x40
> [  147.835343]  ? perf_try_init_event+0x47/0x140
> [  147.835861]  ? perf_event_alloc+0x46e/0x10c0
> [  147.836357]  ? sched_clock_cpu+0xa0/0xc0
> [  147.836828]  ? __do_sys_perf_event_open+0x127/0x1120
> [  147.837394]  ? sched_clock+0x2b/0x40
> [  147.837824]  ? sched_clock_cpu+0xa0/0xc0
> [  147.838274]  ? do_syscall_64+0x53/0x100
> [  147.838726]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  147.839365] irq event stamp: 2133343
> [  147.839782] hardirqs last  enabled at (2133351): [<ffffffff8111eec6>] console_unlock+0x486/0x5a0
> [  147.840804] hardirqs last disabled at (2133362): [<ffffffff8111ee10>] console_unlock+0x3d0/0x5a0
> [  147.841808] softirqs last  enabled at (2133120): [<ffffffff82600386>] __do_softirq+0x386/0x47e
> [  147.842823] softirqs last disabled at (2133109): [<ffffffff82400ebf>] asm_call_irq_on_stack+0xf/0x20
> [  147.843952] ---[ end trace a41e09c8b1793541 ]---
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.10.0-rc7-13210-gfb728736669f .config
>         make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> Rong Chen

Thanks for the report. I'm running trinity in qemu on this commit, now.

As the failing test is trinity run without any special arguments, as a
general syscall fuzzer, could this be a mis-attribution?

There is no specific reproduction series of system calls reported that
leads to this WARNING, so I just have to run it for a long time and
hope it triggers. Is it possible that this path that was not exercised
on previous commits, but would exhibit there, too?

e659ea023d..fb72873666 are exactly one patch difference, so if it
consistently passes on the one and fails on the other, it must be new
with this commit. As said, trying to reproduce now.
