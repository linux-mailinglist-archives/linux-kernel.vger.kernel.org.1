Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA627DB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgI2WUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2WUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:20:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90434C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:20:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id v14so3523994pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW4xJW5sHeuTfJ1ymz8rtT1eSnkcW5Xhk1X9XMmfERo=;
        b=de/zOxsEdM8DBs3rXieB31MWUV9pHZhkw6XkgIek0yc6gyocny6G6O8L5CQ2odbMOT
         zJ6BmPkfmHWCuXbfV7AqnFFj2/ESunYesaOypouEqeQgNZFqYO0V3O/rkLTGt/PkpUI6
         XkjDFAjiPJwazMZ1hdNlkBFYfXfPQJx14GsLBe1072GrTv9KJc2KhzeLggCGnb3glBb0
         5BfeFo7Hgk7TA8Ats7mKsIKRJX0ClT/mm3glfdr+iQI6AFVqLxtOiNHfQvipyZv04rmE
         cTk+ZbmeWgaVKiBa6y1a+tcJzzb46/W3+npi4PEvfeit+zVwhYKhiNRAuYQ7GY6s/2tf
         CHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW4xJW5sHeuTfJ1ymz8rtT1eSnkcW5Xhk1X9XMmfERo=;
        b=RfdB6bg8Mf+r7o8TEcoQOGjVsIXMqTmdM5d9zEiLiNJ00ID9QeKn3WzoW6nXl+PM1q
         NFopstVEf9cPKgiOCkKCjxyQTtiTGTUxKaj+i/c1+3hEIEJ3cYK7Z5ihx0R0zzxK1j0h
         B76X2rpWoutIIkBiB7n4ViiTAros5fcuzm4FQrF830+p3ZMtzqn8hChTh2fLfNBAcDLE
         b5vFIaSZgXwliiv0Me3QtXDxjYHfp29IMUitQ2ufUcmGROOjH91Ip5ljjLvVi8RlTMSX
         GAz6wES/hvcrpVTI9pMPqP7jxqXR0BnUMl3+w4W1+4ILfXk+kqjdpzGqYR75NZDjeZV0
         p3hg==
X-Gm-Message-State: AOAM530VppvqTyha5+05GS8yVCfpJu4BCQF0hduxOuvvIXVFe9tO3W95
        2PuK3XJWoM0/hXUr28tcrYKq3wpVzglFdnF9tLd5lw==
X-Google-Smtp-Source: ABdhPJz3vNH4547wM6Z7s2N3YyauFZZxBY/FXDkx664nW/qhCFetGWHM5mxxnw4E1v6jWzsOUMmKMR/2aurB3YC2cK8=
X-Received: by 2002:a17:90a:9403:: with SMTP id r3mr5916998pjo.52.1601418002739;
 Tue, 29 Sep 2020 15:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601410890.git.zanussi@kernel.org>
In-Reply-To: <cover.1601410890.git.zanussi@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 29 Sep 2020 15:19:25 -0700
Message-ID: <CAJHvVchE91tpR2QtyB3NmiaRoDBgiQ-D7g7NCp0viEQ9H0G76g@mail.gmail.com>
Subject: Re: [PATCH 0/3] tracing: Add dynamic strings for synthetic events
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 1:33 PM Tom Zanussi <zanussi@kernel.org> wrote:
>
> Hi,
>
> This patchset adds support for dynamic strings for synthetic events,
> as requested by Axel Rasmussen.
>
> Actually, the first two patches should be applied in any case - the
> first just changes the current max string length and the second fixes
> a bug I found while testing.
>
> It works fine for my simple test cases, but I still need to do a lot
> more testing, especially of the in-kernel API parts, which don't
> affect Axel's use case.
>
> Anyway, Axel, please try it out and send me your Tested-by: if it
> works for you, and your broken testcase(s) if it doesn't. ;-)

Thanks for working on this!

Capturing a histogram with a histogram trigger on the synthetic
event[1] seems to work as expected for me.

However, I tried creating the synthetic event, and then capturing a
histogram from it using bpftrace [2], and this doesn't seem to work.
It's completely possible I'm just doing something wrong, or the
bpftrace I'm using is buggy (getting it to work with __data_loc fields
at all requires a super bleeding edge bpftrace [3]). bpftrace reports
that it fails to attach to the synthetic event, and I hit some
WARN_ONs [4].

Does it seem possible this issue is related? If not, feel free to
disregard. :) I'll spend some more time digging into this tomorrow.



[1]:
echo 'mmap_lock_latency u64 time; char memcg_path[], bool write' > \
        /sys/kernel/tracing/synthetic_events

echo 'hist:keys=memcg_path,write:ts0=common_timestamp.usecs' > \
        /sys/kernel/tracing/events/mmap_lock/mmap_lock_start_locking/trigger

echo 'hist:keys=memcg_path,write:latency=common_timestamp.usecs-$ts0:onmatch(mmap_lock.mmap_lock_start_locking).mmap_lock_latency($latency,memcg_path,write)'
> \
        /sys/kernel/tracing/events/mmap_lock/mmap_lock_acquire_returned/trigger

echo 'hist:keys=memcg_path,write:values=time' > \
        /sys/kernel/tracing/events/synthetic/mmap_lock_latency/trigger

[2]:
(Same setup of the synthetic event as [1], except adding the histogram
trigger...)

cat <<EOF > /root/bpftypes.h
#include <stdbool.h>
#include <stdint.h>
typedef uint64_t u64;
typedef int64_t s64;
EOF

cat <<EOF > /root/mmap-lock-per-memcg.bpf
tracepoint:synthetic:mmap_lock_latency {
        @latency[args->memcg_path] = hist(args->time);
}
EOF

/home/axelrasmussen/bpftrace/build/src/bpftrace \
        -v \
        -I "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include" \
        --include "/root/bpftypes.h" \
        /root/mmap-lock-per-memcg.bpf

[3]: https://github.com/iovisor/bpftrace/pull/1542

[4]:
[   31.361814] kauditd_printk_skb: 6 callbacks suppressed
[   31.361815] audit: type=1334 audit(1601414765.236:34): prog-id=11 op=LOAD

From `WARN_ON(!tp_func->func)`:

[   31.365310] ------------[ cut here ]------------
[   31.365316] WARNING: CPU: 0 PID: 235 at kernel/tracepoint.c:136
tracepoint_add_func+0x2ad/0x300
[   31.366594] Modules linked in: xhci_pci xhci_hcd virtio_net
net_failover failover virtio_crypto crypto_engine virtio_console
virtio_blk virtio_balloon uhci_hcd ohci_pci ohci_ht
[   31.366603] CPU: 0 PID: 235 Comm: bpftrace Not tainted 5.9.0-smp-DEV #1
[   31.366604] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1 04/01/2014
[   31.366606] RIP: 0010:tracepoint_add_func+0x2ad/0x300
[   31.366607] Code: 17 ff ff ff 4c 89 ff e8 e1 0c 0a 00 e9 22 ff ff
ff 41 ff 57 18 85 c0 4c 8b 04 24 8b 54 24 08 0f 89 9c fd ff ff e9 31
ff ff ff <0f> 0b b8 ea ff ff ff e9 f9 fd5
[   31.366607] RSP: 0018:ffff911554fdbc50 EFLAGS: 00010246
[   31.366608] RAX: 0000000000000000 RBX: ffff9115583c1200 RCX: 0000000000000000
[   31.366609] RDX: 000000000000000a RSI: 0000000000000000 RDI: ffff9115583c1200
[   31.366609] RBP: ffff911554fdbc90 R08: ffff911554fdbca0 R09: ffffcaabffdb5018
[   31.366610] R10: 0000000000000080 R11: 0000000000000080 R12: ffff911558013c90
[   31.366610] R13: 0000000000000000 R14: ffff911554f84d10 R15: ffff9115583c1200
[   31.366611] FS:  00007f9bdf8f0c00(0000) GS:ffff91155fc00000(0000)
knlGS:0000000000000000
[   31.366612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.366614] CR2: 00007f9bdefbc000 CR3: 0000000814fe0006 CR4: 0000000000370ef0
[   31.366615] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   31.366615] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   31.366616] Call Trace:
[   31.366620]  tracepoint_probe_register+0x58/0x90
[   31.366625]  trace_event_reg+0x56/0xa0
[   31.366626]  perf_trace_event_reg.isra.2+0xba/0x130
[   31.366627]  perf_trace_event_init+0x32/0x70
[   31.366628]  perf_trace_init+0x6e/0xa0
[   31.366631]  perf_tp_event_init+0x28/0x40
[   31.366632]  perf_try_init_event+0xe7/0x130
[   31.366633]  perf_event_alloc+0x4ba/0xdc0
[   31.366635]  ? __alloc_fd+0x40/0x160
[   31.366637]  __do_sys_perf_event_open+0x2bb/0xe90
[   31.366638]  __x64_sys_perf_event_open+0x20/0x30
[   31.366641]  do_syscall_64+0x31/0x40
[   31.366644]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   31.366645] RIP: 0033:0x7f9be4886d5d
[   31.366646] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 488
[   31.366646] RSP: 002b:00007ffdcf6e4d68 EFLAGS: 00000246 ORIG_RAX:
000000000000012a
[   31.366647] RAX: ffffffffffffffda RBX: 00007ffdcf6e5e6c RCX: 00007f9be4886d5d
[   31.366647] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00007ffdcf6e4d80
[   31.366648] RBP: 00007ffdcf6e4d80 R08: 0000000000000008 R09: 000056095c148578
[   31.366651] R10: 00000000ffffffff R11: 0000000000000246 R12: 000000000000000b
[   31.366652] R13: 00000000ffffffff R14: 00007ffdcf6e5e70 R15: 00007ffdcf6e4e00
[   31.366653] ---[ end trace 25e0e681c1442c93 ]---

From `WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);`:

[   31.367345] ------------[ cut here ]------------
[   31.367347] WARNING: CPU: 0 PID: 235 at kernel/tracepoint.c:243
tracepoint_add_func+0xb2/0x300
[   31.368612] Modules linked in: xhci_pci xhci_hcd virtio_net
net_failover failover virtio_crypto crypto_engine virtio_console
virtio_blk virtio_balloon uhci_hcd ohci_pci ohci_ht
[   31.368615] CPU: 0 PID: 235 Comm: bpftrace Tainted: G        W
   5.9.0-smp-DEV #1
[   31.368615] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1 04/01/2014
[   31.368617] RIP: 0010:tracepoint_add_func+0xb2/0x300
[   31.368617] Code: c6 48 8b 01 48 85 c0 74 28 41 83 fd ff 75 df 3b
51 10 44 0f 4f eb 48 39 c6 75 d8 49 8b 40 08 48 39 41 08 75 ce b8 ef
ff ff ff <0f> 0b e9 25 01 00 00 8d 43 02d
[   31.368618] RSP: 0018:ffff911554fdbc50 EFLAGS: 00010246
[   31.368618] RAX: 00000000ffffffea RBX: ffff9115583c1200 RCX: 0000000000000000
[   31.368619] RDX: 000000000000000a RSI: 0000000000000000 RDI: ffff9115583c1200
[   31.368619] RBP: ffff911554fdbc90 R08: ffff911554fdbca0 R09: ffffcaabffdb5018
[   31.368620] R10: 0000000000000080 R11: 0000000000000080 R12: ffff911558013c90
[   31.368620] R13: 0000000000000000 R14: ffff911554f84d10 R15: ffff9115583c1200
[   31.368621] FS:  00007f9bdf8f0c00(0000) GS:ffff91155fc00000(0000)
knlGS:0000000000000000
[   31.368621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.368623] CR2: 00007f9bdefbc000 CR3: 0000000814fe0006 CR4: 0000000000370ef0
[   31.368624] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   31.368624] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   31.368625] Call Trace:
[   31.368626]  tracepoint_probe_register+0x58/0x90
[   31.368627]  trace_event_reg+0x56/0xa0
[   31.368628]  perf_trace_event_reg.isra.2+0xba/0x130
[   31.368629]  perf_trace_event_init+0x32/0x70
[   31.368630]  perf_trace_init+0x6e/0xa0
[   31.368631]  perf_tp_event_init+0x28/0x40
[   31.368632]  perf_try_init_event+0xe7/0x130
[   31.368632]  perf_event_alloc+0x4ba/0xdc0
[   31.368634]  ? __alloc_fd+0x40/0x160
[   31.368635]  __do_sys_perf_event_open+0x2bb/0xe90
[   31.368636]  __x64_sys_perf_event_open+0x20/0x30
[   31.368637]  do_syscall_64+0x31/0x40
[   31.368638]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   31.368639] RIP: 0033:0x7f9be4886d5d
[   31.368639] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 488
[   31.368640] RSP: 002b:00007ffdcf6e4d68 EFLAGS: 00000246 ORIG_RAX:
000000000000012a
[   31.368640] RAX: ffffffffffffffda RBX: 00007ffdcf6e5e6c RCX: 00007f9be4886d5d
[   31.368641] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00007ffdcf6e4d80
[   31.368641] RBP: 00007ffdcf6e4d80 R08: 0000000000000008 R09: 000056095c148578
[   31.368642] R10: 00000000ffffffff R11: 0000000000000246 R12: 000000000000000b
[   31.368642] R13: 00000000ffffffff R14: 00007ffdcf6e5e70 R15: 00007ffdcf6e4e00
[   31.368643] ---[ end trace 25e0e681c1442c94 ]---
[   31.377271] audit: type=1334 audit(1601414765.252:35): prog-id=11 op=UNLOAD

>
> Thanks,
>
> Tom
>
> The following changes since commit 106c076d23cca67c959a6fd1ccadb5b3ef01ddc9:
>
>   mmap_lock: add tracepoints around lock acquisition (2020-09-23 08:48:08 -0500)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-dynstring-v0
>
> Tom Zanussi (3):
>   tracing: Change STR_VAR_MAX_LEN
>   tracing: Fix parse_synth_field() error handling
>   tracing: Add support for dynamic strings to synthetic events
>
>  Documentation/trace/events.rst    |  15 ++-
>  Documentation/trace/histogram.rst |  18 ++++
>  kernel/trace/trace_events_hist.c  |   9 ++
>  kernel/trace/trace_events_synth.c | 163 ++++++++++++++++++++++++++----
>  kernel/trace/trace_synth.h        |   6 +-
>  5 files changed, 186 insertions(+), 25 deletions(-)
>
> --
> 2.17.1
>
