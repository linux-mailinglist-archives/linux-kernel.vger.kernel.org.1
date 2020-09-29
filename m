Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8949327D071
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgI2ODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbgI2ODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:03:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF07C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:03:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j2so5540884wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HLBENmVRb53NJihmiqBEmiPhN41gADm14oL/ZJQg2vw=;
        b=TPpZtDJhmCP8JUw6PONOs6BYAu0lHWVNn4tdMhYkKHCIyf4Q0XodFu23yB3YRqW//A
         SYFXbgP2QqdfS6nUz+Nko4fD8d5XYIJ4Zc5WSL7yjsp4MZ6/H3wrZMBD6YvGW5a2mmOv
         3VuJqAMeSUL4zZTWO1/m4h/oCknevZ8L9g/yOm2cq9Tou8QwC+/pLBPC016RDgCxDm6v
         lHxoE7ynp1TJfOZqiVoLyQAQCZlNd4oC4UKnV5uEU0GULYfyQqBHGr64I1lOoqjUpf5k
         5xRXKs6ln7daNnyIfe3eekMBGIlScTLByi+EvwyJTpQ0GNYHw6mVtBgF4fsLWwhs2W96
         6Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HLBENmVRb53NJihmiqBEmiPhN41gADm14oL/ZJQg2vw=;
        b=PZvU9aOQcromvPhYEk3QLcClrxgVDNzh21Lxm3A3AjRRNp9YKdOdsIaYWEq3TyxuYX
         Jfj5NkTlQ3cW1uyGMijXA1H/a0hxtZxNNtp/qcAW9ProwL/skERLzQrpTrb+haNpSVQK
         9Pp5HjB8b8qz3mxt9Es/qroq0tB0o5iYj0dFCK/cgpBWsdmhpTAKnMZOVTLGNGI6/Syr
         0X3qr+K3Xu8wkXFBy8Wi6SM6Et5RHUoi1hR7UgZYjBuUP2Q0BE8ij/YT5Anv+ehHJj6v
         KZ8uu414Vg1effAbdx3Lxh4dWYHPX5DxfqhFyOvs64yp6WEp7tZhqBMyfP3MKZb9/EZh
         Ij3A==
X-Gm-Message-State: AOAM530MZ2HttEV8wbSRR8kGrIB4cd+8HhUyGb93rrFBb+VItJ8uqqNa
        GlFmYJZ58xU9ZExFJsuRzQOHy5hCRGSk2FPowUc=
X-Google-Smtp-Source: ABdhPJwAKg/5O/vIt47izvW2n4baajpLrN3ACXitepOoD8qTJU5sYxUpj4qdqVd+w8ujw3Ih6TP9RxAdpD7OhyKoKqQ=
X-Received: by 2002:adf:e385:: with SMTP id e5mr4469288wrm.129.1601388216060;
 Tue, 29 Sep 2020 07:03:36 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Grimaldi <grimaldi.ivan@gmail.com>
Date:   Tue, 29 Sep 2020 16:03:22 +0200
Message-ID: <CAO1575XC8qZjpdx1ezXP-wp0xegOag5q-ip9YAM5e0WF_w6Y6g@mail.gmail.com>
Subject: kernel 4.4.192 spinlock already unlocked
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ivan Grimaldi <grimaldi.ivan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  during normal usage, system locked up, and the following messages
appeared on the screen. where you can see from the log, the spinlock
owner and CPU are -1. After this BUG the system restarts by WatchDog.

Our CPU is arm Cortex A9 iMX6DL, with both cores active. Have you some
idea, what the root cause of this BUG?

BUG: spinlock already unlocked on CPU#0, WQ#2(System)/830
 lock: 0xbf1f7f04, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
CPU: 0 PID: 830 Comm: WQ#2(System) Tainted: G           O    4.4.192+prod #1
Hardware name: TESTBOARD (Device Tree)
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:00000000 r6:60030013 r5:00000000 r4:80a28da8
[<800157ac>] (show_stack) from [<8030ac20>] (dump_stack+0xdc/0x110)
[<8030ab44>] (dump_stack) from [<80087c3c>] (spin_dump+0x90/0xdc)
 r9:bf1f7f00 r8:bdb07e40 r7:bdb07e5c r6:bdb07e04 r5:ffffffff r4:bf1f7f04
[<80087bac>] (spin_dump) from [<80088004>] (do_raw_spin_unlock+0xc4/0x130)
 r5:74f00010 r4:bf1f7f04
[<80087f40>] (do_raw_spin_unlock) from [<8060d808>] (_raw_spin_unlock+0x30/0x34)
 r5:74f00010 r4:bf1f7f04
[<8060d7d8>] (_raw_spin_unlock) from [<800b74f8>] (futex_wait_setup+0x148/0x1a8)
 r5:74f00010 r4:bf1f7f00
[<800b73b0>] (futex_wait_setup) from [<800b77b0>] (futex_wait+0xf0/0x228)
 r10:74f00010 r9:74f00010 r8:00000002 r7:00000000 r6:bdb06000 r5:00000000
 r4:00000000
[<800b76c0>] (futex_wait) from [<800b94e8>] (do_futex+0x104/0xca0)
 r10:74f00010 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000000 r5:00000002
 r4:00000000
[<800b93e4>] (do_futex) from [<800ba10c>] (SyS_futex+0x88/0x188)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000080 r5:00000000
 r4:00000000
[<800ba084>] (SyS_futex) from [<80010940>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:000000f0 r6:769ccd1a r5:000000dc
 r4:74f00010
BUG: spinlock lockup suspected on CPU#0, WQ#2(System)/830
 lock: 0xbf1f7f04, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
CPU: 0 PID: 830 Comm: WQ#2(System) Tainted: G           O    4.4.192+prod #1
Hardware name: TESTBOARD (Device Tree)
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:00000000 r6:60030013 r5:00000000 r4:80a28da8
[<800157ac>] (show_stack) from [<8030ac20>] (dump_stack+0xdc/0x110)
[<8030ab44>] (dump_stack) from [<80087c3c>] (spin_dump+0x90/0xdc)
 r9:00000000 r8:002dc6c0 r7:00000000 r6:002dc6c0 r5:ffffffff r4:bf1f7f04
[<80087bac>] (spin_dump) from [<80087ddc>] (do_raw_spin_lock+0xfc/0x1f8)
 r5:00000001 r4:bf1f7f04
[<80087ce0>] (do_raw_spin_lock) from [<8060d3fc>] (_raw_spin_lock+0x6c/0x80)
 r10:bf1f7f00 r9:bdb06000 r8:bf1f7f04 r7:00000001 r6:bf1f7f04 r5:800b75e8
 r4:bf1f7f14 r3:00000000
[<8060d390>] (_raw_spin_lock) from [<800b75e8>] (futex_wake+0x90/0x168)
 r6:ffffffff r5:00000000 r4:bdb07e64
[<800b7558>] (futex_wake) from [<800b950c>] (do_futex+0x128/0xca0)
 r10:74f00010 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000000 r5:00000001
 r4:00000001
[<800b93e4>] (do_futex) from [<800ba10c>] (SyS_futex+0x88/0x188)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000081 r5:00000000
 r4:00000001
[<800ba084>] (SyS_futex) from [<80010940>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:000000f0 r6:769ccd1a r5:000000dc
 r4:74f00010
Sending NMI to all CPUs:
NMI backtrace for cpu 0
CPU: 0 PID: 830 Comm: WQ#2(System) Tainted: G           O    4.4.192+prod #1
Hardware name: TESTBOARD (Device Tree)
task: bc380000 ti: bdb06000 task.ti: bdb06000
PC is at _raw_spin_unlock_irqrestore+0x44/0x54
LR is at trace_hardirqs_on+0x14/0x18
pc : [<8060d894>]    lr : [<8007f158>]    psr: 60030013
sp : bdb07d28  ip : bdb07d18  fp : bdb07d3c
r10: 809d6704  r9 : 60030013  r8 : 0000000f
r7 : 809d72d0  r6 : 00000002  r5 : 80a291e0  r4 : 60030013
r3 : 00000000  r2 : 00000000  r1 : bc380000  r0 : 8060d890
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4d1b404a  DAC: 00000051
CPU: 0 PID: 830 Comm: WQ#2(System) Tainted: G           O    4.4.192+prod #1
Hardware name: TESTBOARD (Device Tree)
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:00000000 r6:60030193 r5:00000000 r4:80a28da8
[<800157ac>] (show_stack) from [<8030ac20>] (dump_stack+0xdc/0x110)
[<8030ab44>] (dump_stack) from [<80011564>] (show_regs+0x1c/0x20)
 r9:f4000100 r8:00000000 r7:8008cde4 r6:809ce380 r5:bdb07cd8 r4:00000000
[<80011548>] (show_regs) from [<8030ed30>] (nmi_cpu_backtrace+0x8c/0xd0)
[<8030eca4>] (nmi_cpu_backtrace) from [<80018234>] (handle_IPI+0xd4/0x2e8)
 r7:00000000 r6:809d05b8 r5:bdb07cd8 r4:0000000f
[<80018160>] (handle_IPI) from [<80009560>] (gic_handle_irq+0xa8/0xc4)
 r10:809d7300 r9:f4000100 r8:80a291e0 r7:bdb07cd8 r6:000003ff r5:000003eb
 r4:f400010c r3:00000000
[<800094b8>] (gic_handle_irq) from [<8060e3b8>] (__irq_svc+0x58/0x78)
Exception stack(0xbdb07cd8 to 0xbdb07d20)
7cc0:                                                       8060d890 bc380000
7ce0: 00000000 00000000 60030013 80a291e0 00000002 809d72d0 0000000f 60030013
7d00: 809d6704 bdb07d3c bdb07d18 bdb07d28 8007f158 8060d894 60030013 ffffffff
 r10:809d6704 r9:60030013 r8:0000000f r7:bdb07d0c r6:ffffffff r5:60030013
 r4:8060d894
[<8060d850>] (_raw_spin_unlock_irqrestore) from [<80337e60>]
(gic_raise_softirq+0x88/0x98)
 r5:809d7300 r4:0003000f
[<80337dd8>] (gic_raise_softirq) from [<80017854>] (smp_cross_call+0x7c/0x114)
 r10:00001000 r9:809d7184 r8:0000000f r7:80a506c8 r6:806139a4 r5:809d72d0
 r4:809d72d0 r3:80337dd8
[<800177d8>] (smp_cross_call) from [<80017950>] (raise_nmi+0x64/0x74)
 r9:809d7184 r8:809d6704 r7:00000002 r6:809d72d0 r5:809d05c0 r4:809d72d0
[<800178ec>] (raise_nmi) from [<8030f000>]
(nmi_trigger_all_cpu_backtrace+0x238/0x280)
 r5:809d05c0 r4:809d72d0
[<8030edc8>] (nmi_trigger_all_cpu_backtrace) from [<8001862c>]
(arch_trigger_all_cpu_backtrace+0x1c/0x24)
 r10:80a28d90 r9:00000000 r8:002dc6c0 r7:00000000 r6:002dc6c0 r5:00000001
 r4:bf1f7f04
[<80018610>] (arch_trigger_all_cpu_backtrace) from [<80087de8>]
(do_raw_spin_lock+0x108/0x1f8)
[<80087ce0>] (do_raw_spin_lock) from [<8060d3fc>] (_raw_spin_lock+0x6c/0x80)
 r10:bf1f7f00 r9:bdb06000 r8:bf1f7f04 r7:00000001 r6:bf1f7f04 r5:800b75e8
 r4:bf1f7f14 r3:00000000
[<8060d390>] (_raw_spin_lock) from [<800b75e8>] (futex_wake+0x90/0x168)
 r6:ffffffff r5:00000000 r4:bdb07e64
[<800b7558>] (futex_wake) from [<800b950c>] (do_futex+0x128/0xca0)
 r10:74f00010 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000000 r5:00000001
 r4:00000001
[<800b93e4>] (do_futex) from [<800ba10c>] (SyS_futex+0x88/0x188)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000081 r5:00000000
 r4:00000001
[<800ba084>] (SyS_futex) from [<80010940>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:000000f0 r6:769ccd1a r5:000000dc
 r4:74f00010
NMI backtrace for cpu 1
CPU: 1 PID: 715 Comm: syslogd Tainted: G           O    4.4.192+prod #1
Hardware name: TESTBOARD (Device Tree)
task: bd889f80 ti: bd810000 task.ti: bd810000
PC is at 0x13f18
LR is at 0x4c8e8
pc : [<00013f18>]    lr : [<0004c8e8>]    psr: 600f0010
sp : 7ea97bc8  ip : 00000000  fp : 00903008
r10: 0090308c  r9 : 00000028  r8 : 000aeab4
r7 : 00000028  r6 : 000aeaa8  r5 : 00903064  r4 : 00903164
r3 : 00000000  r2 : 000000ff  r1 : 00903164  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
Control: 10c5387d  Table: 4db9004a  DAC: 00000055
CPU: 1 PID: 715 Comm: syslogd Tainted: G           O    4.4.192+prod #1
Hardware name: TESTBOARD (Device Tree)
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:00000000 r6:200f0193 r5:00000000 r4:80a28da8
[<800157ac>] (show_stack) from [<8030ac20>] (dump_stack+0xdc/0x110)
[<8030ab44>] (dump_stack) from [<80011564>] (show_regs+0x1c/0x20)
 r9:f4000100 r8:00000000 r7:8008cde4 r6:809ce380 r5:bd811fb0 r4:00000001
[<80011548>] (show_regs) from [<8030ed30>] (nmi_cpu_backtrace+0x8c/0xd0)
[<8030eca4>] (nmi_cpu_backtrace) from [<80018234>] (handle_IPI+0xd4/0x2e8)
 r7:00000001 r6:809d05b8 r5:bd811fb0 r4:0000000f
[<80018160>] (handle_IPI) from [<80009560>] (gic_handle_irq+0xa8/0xc4)
 r10:809d7300 r9:f4000100 r8:80a291e0 r7:bd811fb0 r6:000003ff r5:000003eb
 r4:f400010c r3:00000000
[<800094b8>] (gic_handle_irq) from [<8060e738>] (__irq_usr+0x58/0x80)
Exception stack(0xbd811fb0 to 0xbd811ff8)
1fa0:                                     00000000 00903164 000000ff 00000000
1fc0: 00903164 00903064 000aeaa8 00000028 000aeab4 00000028 0090308c 00903008
1fe0: 00000000 7ea97bc8 0004c8e8 00013f18 600f0010 ffffffff
 r10:0090308c r9:00000028 r8:10c5387d r7:10c5387d r6:ffffffff r5:600f0010
 r4:00013f18
INFO: rcu_sched self-detected stall on CPU
    0-...: (2589 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=2599
INFO: rcu_sched detected stalls on CPUs/tasks:
    0-...: (2589 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=2599
    (detected by 1, t=2602 jiffies, g=227151, c=227150, q=10076)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
Backtrace aborted due to bad frame pointer <bdb07f6c>
     (t=2605 jiffies g=227151 c=227150 q=10077)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:809e7480 r6:00000315 r5:bc380000 r4:00000ea8
[<800157ac>] (show_stack) from [<8005e188>] (sched_show_task+0x144/0x258)
[<8005e044>] (sched_show_task) from [<80060b4c>] (dump_cpu_task+0x3c/0x4c)
 r7:809e7480 r6:80030193 r5:809e7480 r4:00000000
[<80060b10>] (dump_cpu_task) from [<80098cf4>] (rcu_dump_cpu_stacks+0x94/0xd8)
 r5:809e7480 r4:00000000
[<80098c60>] (rcu_dump_cpu_stacks) from [<8009d514>]
(rcu_check_callbacks+0x5f8/0x910)
 r9:bf6584c0 r8:809e7480 r7:809d66c4 r6:3ec86000 r5:809d663c r4:809d24c0
[<8009cf1c>] (rcu_check_callbacks) from [<800a1e64>]
(update_process_times+0x48/0x74)
 r10:800b5654 r9:809d6640 r8:bf654c40 r7:00000410 r6:00000000 r5:bc380000
 r4:ffffe000
[<800a1e1c>] (update_process_times) from [<800b5650>]
(tick_sched_handle+0x58/0x5c)
 r7:00000410 r6:b7d25ecb r5:bdb07db0 r4:bf654eb8
[<800b55f8>] (tick_sched_handle) from [<800b56a8>] (tick_sched_timer+0x54/0x9c)
[<800b5654>] (tick_sched_timer) from [<800a30ec>]
(__hrtimer_run_queues+0x158/0x414)
 r7:806139a4 r6:00000000 r5:bdb06000 r4:bf654eb8
[<800a2f94>] (__hrtimer_run_queues) from [<800a3634>]
(hrtimer_interrupt+0xb8/0x200)
 r10:bf654cf8 r9:bf654d18 r8:bf654c90 r7:bf654d38 r6:ffffffff r5:00000003
 r4:bf654c40
[<800a357c>] (hrtimer_interrupt) from [<80019280>] (twd_handler+0x3c/0x50)
 r10:80a2920c r9:80a5077c r8:809d6640 r7:00000010 r6:bf65ac00 r5:bf08b400
 r4:00000001
[<80019244>] (twd_handler) from [<800926dc>]
(handle_percpu_devid_irq+0xd0/0x250)
 r5:bf08b400 r4:bf031f00
[<8009260c>] (handle_percpu_devid_irq) from [<8008daf8>]
(generic_handle_irq+0x30/0x44)
 r10:809d7300 r9:f4000100 r8:bf034000 r7:00000001 r6:00000000 r5:00000010
 r4:809d05b8
[<8008dac8>] (generic_handle_irq) from [<8008de38>]
(__handle_domain_irq+0x60/0xc8)
[<8008ddd8>] (__handle_domain_irq) from [<80009518>] (gic_handle_irq+0x60/0xc4)
 r9:f4000100 r8:80a291e0 r7:bdb07db0 r6:000003ff r5:000003eb r4:f400010c
[<800094b8>] (gic_handle_irq) from [<8060e3b8>] (__irq_svc+0x58/0x78)
Exception stack(0xbdb07db0 to 0xbdb07df8)
7da0:                                     00000000 00000000 00000621 00000622
7dc0: bf1f7f04 00000001 002dc6c0 00000000 002dc6c0 00000000 80a28d90 bdb07e2c
7de0: 00000000 bdb07e00 8030ef8c 80087e10 20030013 ffffffff
 r10:80a28d90 r9:00000000 r8:002dc6c0 r7:bdb07de4 r6:ffffffff r5:20030013
 r4:80087e10
[<80087ce0>] (do_raw_spin_lock) from [<8060d3fc>] (_raw_spin_lock+0x6c/0x80)
 r10:bf1f7f00 r9:bdb06000 r8:bf1f7f04 r7:00000001 r6:bf1f7f04 r5:800b75e8
 r4:bf1f7f14 r3:00000000
[<8060d390>] (_raw_spin_lock) from [<800b75e8>] (futex_wake+0x90/0x168)
 r6:ffffffff r5:00000000 r4:bdb07e64
[<800b7558>] (futex_wake) from [<800b950c>] (do_futex+0x128/0xca0)
 r10:74f00010 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000000 r5:00000001
 r4:00000001
[<800b93e4>] (do_futex) from [<800ba10c>] (SyS_futex+0x88/0x188)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000081 r5:00000000
 r4:00000001
[<800ba084>] (SyS_futex) from [<80010940>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:000000f0 r6:769ccd1a r5:000000dc
 r4:74f00010
INFO: rcu_sched self-detected stall on CPU
    0-...: (10362 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=10363
INFO: rcu_sched detected stalls on CPUs/tasks:
    0-...: (10362 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=10363
    (detected by 1, t=10407 jiffies, g=227151, c=227150, q=34147)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
Backtrace aborted due to bad frame pointer <bdb07f6c>
     (t=10410 jiffies g=227151 c=227150 q=34147)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:809e7480 r6:00000315 r5:bc380000 r4:00000ea8
[<800157ac>] (show_stack) from [<8005e188>] (sched_show_task+0x144/0x258)
[<8005e044>] (sched_show_task) from [<80060b4c>] (dump_cpu_task+0x3c/0x4c)
 r7:809e7480 r6:80030193 r5:809e7480 r4:00000000
[<80060b10>] (dump_cpu_task) from [<80098cf4>] (rcu_dump_cpu_stacks+0x94/0xd8)
 r5:809e7480 r4:00000000
[<80098c60>] (rcu_dump_cpu_stacks) from [<8009d514>]
(rcu_check_callbacks+0x5f8/0x910)
 r9:bf6584c0 r8:809e7480 r7:809d66c4 r6:3ec86000 r5:809d663c r4:809d24c0
[<8009cf1c>] (rcu_check_callbacks) from [<800a1e64>]
(update_process_times+0x48/0x74)
 r10:800b5654 r9:809d6640 r8:bf654c40 r7:00000422 r6:00000000 r5:bc380000
 r4:ffffe000
[<800a1e1c>] (update_process_times) from [<800b5650>]
(tick_sched_handle+0x58/0x5c)
 r7:00000422 r6:e3f6e70d r5:bdb07db0 r4:bf654eb8
[<800b55f8>] (tick_sched_handle) from [<800b56a8>] (tick_sched_timer+0x54/0x9c)
[<800b5654>] (tick_sched_timer) from [<800a30ec>]
(__hrtimer_run_queues+0x158/0x414)
 r7:806139a4 r6:00000000 r5:bdb06000 r4:bf654eb8
[<800a2f94>] (__hrtimer_run_queues) from [<800a3634>]
(hrtimer_interrupt+0xb8/0x200)
 r10:bf654cf8 r9:bf654d18 r8:bf654c90 r7:bf654d38 r6:ffffffff r5:00000003
 r4:bf654c40
[<800a357c>] (hrtimer_interrupt) from [<80019280>] (twd_handler+0x3c/0x50)
 r10:80a2920c r9:80a5077c r8:809d6640 r7:00000010 r6:bf65ac00 r5:bf08b400
 r4:00000001
[<80019244>] (twd_handler) from [<800926dc>]
(handle_percpu_devid_irq+0xd0/0x250)
 r5:bf08b400 r4:bf031f00
[<8009260c>] (handle_percpu_devid_irq) from [<8008daf8>]
(generic_handle_irq+0x30/0x44)
 r10:809d7300 r9:f4000100 r8:bf034000 r7:00000001 r6:00000000 r5:00000010
 r4:809d05b8
[<8008dac8>] (generic_handle_irq) from [<8008de38>]
(__handle_domain_irq+0x60/0xc8)
[<8008ddd8>] (__handle_domain_irq) from [<80009518>] (gic_handle_irq+0x60/0xc4)
 r9:f4000100 r8:80a291e0 r7:bdb07db0 r6:000003ff r5:000003eb r4:f400010c
[<800094b8>] (gic_handle_irq) from [<8060e3b8>] (__irq_svc+0x58/0x78)
Exception stack(0xbdb07db0 to 0xbdb07df8)
7da0:                                     00000000 00000000 00000621 00000622
7dc0: bf1f7f04 00000001 002dc6c0 00000000 002dc6c0 00000000 80a28d90 bdb07e2c
7de0: 00000000 bdb07e00 8030ef8c 80087e10 20030013 ffffffff
 r10:80a28d90 r9:00000000 r8:002dc6c0 r7:bdb07de4 r6:ffffffff r5:20030013
 r4:80087e10
[<80087ce0>] (do_raw_spin_lock) from [<8060d3fc>] (_raw_spin_lock+0x6c/0x80)
 r10:bf1f7f00 r9:bdb06000 r8:bf1f7f04 r7:00000001 r6:bf1f7f04 r5:800b75e8
 r4:bf1f7f14 r3:00000000
[<8060d390>] (_raw_spin_lock) from [<800b75e8>] (futex_wake+0x90/0x168)
 r6:ffffffff r5:00000000 r4:bdb07e64
[<800b7558>] (futex_wake) from [<800b950c>] (do_futex+0x128/0xca0)
 r10:74f00010 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000000 r5:00000001
 r4:00000001
[<800b93e4>] (do_futex) from [<800ba10c>] (SyS_futex+0x88/0x188)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000081 r5:00000000
 r4:00000001
[<800ba084>] (SyS_futex) from [<80010940>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:000000f0 r6:769ccd1a r5:000000dc
 r4:74f00010
INFO: rcu_sched self-detected stall on CPU
    0-...: (18135 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=18133
INFO: rcu_sched detected stalls on CPUs/tasks:
    0-...: (18135 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=18133
    (detected by 1, t=18212 jiffies, g=227151, c=227150, q=34510)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
Backtrace aborted due to bad frame pointer <bdb07f6c>
     (t=18215 jiffies g=227151 c=227150 q=34510)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:809e7480 r6:00000315 r5:bc380000 r4:00000ea8
[<800157ac>] (show_stack) from [<8005e188>] (sched_show_task+0x144/0x258)
[<8005e044>] (sched_show_task) from [<80060b4c>] (dump_cpu_task+0x3c/0x4c)
 r7:809e7480 r6:80030193 r5:809e7480 r4:00000000
[<80060b10>] (dump_cpu_task) from [<80098cf4>] (rcu_dump_cpu_stacks+0x94/0xd8)
 r5:809e7480 r4:00000000
[<80098c60>] (rcu_dump_cpu_stacks) from [<8009d514>]
(rcu_check_callbacks+0x5f8/0x910)
 r9:bf6584c0 r8:809e7480 r7:809d66c4 r6:3ec86000 r5:809d663c r4:809d24c0
[<8009cf1c>] (rcu_check_callbacks) from [<800a1e64>]
(update_process_times+0x48/0x74)
 r10:800b5654 r9:809d6640 r8:bf654c40 r7:00000435 r6:00000000 r5:bc380000
 r4:ffffe000
[<800a1e1c>] (update_process_times) from [<800b5650>]
(tick_sched_handle+0x58/0x5c)
 r7:00000435 r6:101b53f6 r5:bdb07db0 r4:bf654eb8
[<800b55f8>] (tick_sched_handle) from [<800b56a8>] (tick_sched_timer+0x54/0x9c)
[<800b5654>] (tick_sched_timer) from [<800a30ec>]
(__hrtimer_run_queues+0x158/0x414)
 r7:806139a4 r6:00000000 r5:bdb06000 r4:bf654eb8
[<800a2f94>] (__hrtimer_run_queues) from [<800a3634>]
(hrtimer_interrupt+0xb8/0x200)
 r10:bf654cf8 r9:bf654d18 r8:bf654c90 r7:bf654d38 r6:ffffffff r5:00000003
 r4:bf654c40
[<800a357c>] (hrtimer_interrupt) from [<80019280>] (twd_handler+0x3c/0x50)
 r10:80a2920c r9:80a5077c r8:809d6640 r7:00000010 r6:bf65ac00 r5:bf08b400
 r4:00000001
[<80019244>] (twd_handler) from [<800926dc>]
(handle_percpu_devid_irq+0xd0/0x250)
 r5:bf08b400 r4:bf031f00
[<8009260c>] (handle_percpu_devid_irq) from [<8008daf8>]
(generic_handle_irq+0x30/0x44)
 r10:809d7300 r9:f4000100 r8:bf034000 r7:00000001 r6:00000000 r5:00000010
 r4:809d05b8
[<8008dac8>] (generic_handle_irq) from [<8008de38>]
(__handle_domain_irq+0x60/0xc8)
[<8008ddd8>] (__handle_domain_irq) from [<80009518>] (gic_handle_irq+0x60/0xc4)
 r9:f4000100 r8:80a291e0 r7:bdb07db0 r6:000003ff r5:000003eb r4:f400010c
[<800094b8>] (gic_handle_irq) from [<8060e3b8>] (__irq_svc+0x58/0x78)
Exception stack(0xbdb07db0 to 0xbdb07df8)
7da0:                                     00000000 00000000 00000621 00000622
7dc0: bf1f7f04 00000001 002dc6c0 00000000 002dc6c0 00000000 80a28d90 bdb07e2c
7de0: 00000000 bdb07e00 8030ef8c 80087e10 20030013 ffffffff
 r10:80a28d90 r9:00000000 r8:002dc6c0 r7:bdb07de4 r6:ffffffff r5:20030013
 r4:80087e10
[<80087ce0>] (do_raw_spin_lock) from [<8060d3fc>] (_raw_spin_lock+0x6c/0x80)
 r10:bf1f7f00 r9:bdb06000 r8:bf1f7f04 r7:00000001 r6:bf1f7f04 r5:800b75e8
 r4:bf1f7f14 r3:00000000
[<8060d390>] (_raw_spin_lock) from [<800b75e8>] (futex_wake+0x90/0x168)
 r6:ffffffff r5:00000000 r4:bdb07e64
[<800b7558>] (futex_wake) from [<800b950c>] (do_futex+0x128/0xca0)
 r10:74f00010 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000000 r5:00000001
 r4:00000001
[<800b93e4>] (do_futex) from [<800ba10c>] (SyS_futex+0x88/0x188)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000081 r5:00000000
 r4:00000001
[<800ba084>] (SyS_futex) from [<80010940>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:000000f0 r6:769ccd1a r5:000000dc
 r4:74f00010
kworker/dying (1194) used greatest stack depth: 3720 bytes left
INFO: rcu_sched self-detected stall on CPU
    0-...: (25908 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=25895
INFO: rcu_sched detected stalls on CPUs/tasks:
    0-...: (25908 ticks this GP) idle=215/140000000000001/0
softirq=428249/428250 fqs=25895
    (detected by 1, t=26017 jiffies, g=227151, c=227150, q=34899)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
Backtrace aborted due to bad frame pointer <bdb07f6c>
     (t=26020 jiffies g=227151 c=227150 q=34899)
Task dump for CPU 0:
WQ#2(System)    R running   3752   830    789 0x00000002
Backtrace:
[<80015584>] (dump_backtrace) from [<800157cc>] (show_stack+0x20/0x24)
 r7:809e7480 r6:00000315 r5:bc380000 r4:00000ea8
[<800157ac>] (show_stack) from [<8005e188>] (sched_show_task+0x144/0x258)
[<8005e044>] (sched_show_task) from [<80060b4c>] (dump_cpu_task+0x3c/0x4c)
 r7:809e7480 r6:80030193 r5:809e7480 r4:00000000
[<80060b10>] (dump_cpu_task) from [<80098cf4>] (rcu_dump_cpu_stacks+0x94/0xd8)
 r5:809e7480 r4:00000000
[<80098c60>] (rcu_dump_cpu_stacks) from [<8009d514>]
(rcu_check_callbacks+0x5f8/0x910)
 r9:bf6584c0 r8:809e7480 r7:809d66c4 r6:3ec86000 r5:809d663c r4:809d24c0
[<8009cf1c>] (rcu_check_callbacks) from [<800a1e64>]
(update_process_times+0x48/0x74)
 r10:800b5654 r9:809d6640 r8:bf654c40 r7:00000447 r6:00000000 r5:bc380000
 r4:ffffe000
[<800a1e1c>] (update_process_times) from [<800b5650>]
(tick_sched_handle+0x58/0x5c)
 r7:00000447 r6:3c3fd07f r5:bdb07db0 r4:bf654eb8
[<800b55f8>] (tick_sched_handle) from [<800b56a8>] (tick_sched_timer+0x54/0x9c)
[<800b5654>] (tick_sched_timer) from [<800a30ec>]
(__hrtimer_run_queues+0x158/0x414)
 r7:806139a4 r6:00000000 r5:bdb06000 r4:bf654eb8
[<800a2f94>] (__hrtimer_run_queues) from [<800a3634>]
(hrtimer_interrupt+0xb8/0x200)
 r10:bf654cf8 r9:bf654d18 r8:bf654c90 r7:bf654d38 r6:ffffffff r5:00000003
 r4:bf654c40
[<800a357c>] (hrtimer_interrupt) from [<80019280>] (twd_handler+0x3c/0x50)
 r10:80a2920c r9:80a5077c r8:809d6640 r7:00000010 r6:bf65ac00 r5:bf08b400
 r4:00000001
[<80019244>] (twd_handler) from [<800926dc>]
(handle_percpu_devid_irq+0xd0/0x250)
 r5:bf08b400 r4:bf031f00
[<8009260c>] (handle_percpu_devid_irq) from [<8008daf8>]
(generic_handle_irq+0x30/0x44)
 r10:809d7300 r9:f4000100 r8:bf034000 r7:00000001 r6:00000000 r5:00000010
 r4:809d05b8
[<8008dac8>] (generic_handle_irq) from [<8008de38>]
(__handle_domain_irq+0x60/0xc8)
[<8008ddd8>] (__handle_domain_irq) from [<80009518>] (gic_handle_irq+0x60/0xc4)
 r9:f4000100 r8:80a291e0 r7:bdb07db0 r6:000003ff r5:000003eb r4:f400010c
[<800094b8>] (gic_handle_irq) from [<8060e3b8>] (__irq_svc+0x58/0x78)
Exception stack(0xbdb07db0 to 0xbdb07df8)
7da0:                                     00000000 00000000 00000621 00000622
7dc0: bf1f7f04 00000001 002dc6c0 00000000 002dc6c0 00000000 80a28d90 bdb07e2c
7de0: 00000000 bdb07e00 8030ef8c 80087e10 20030013 ffffffff
 r10:80a28d90 r9:00000000 r8:002dc6c0 r7:bdb07de4 r6:ffffffff r5:20030013
 r4:80087e10
[<80087ce0>] (do_raw_spin_lock) from [<8060d3fc>] (_raw_spin_lock+0x6c/0x80)
 r10:bf1f7f00 r9:bdb06000 r8:bf1f7f04 r7:00000001 r6:bf1f7f04 r5:800b75e8
 r4:bf1f7f14 r3:00000000
[<8060d390>] (_raw_spin_lock) from [<800b75e8>] (futex_wake+0x90/0x168)
 r6:ffffffff r5:00000000 r4:bdb07e64
[<800b7558>] (futex_wake) from [<800b950c>] (do_futex+0x128/0xca0)
 r10:74f00010 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000000 r5:00000001
 r4:00000001
[<800b93e4>] (do_futex) from [<800ba10c>] (SyS_futex+0x88/0x188)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:74f00010 r6:00000081 r5:00000000
 r4:00000001
[<800ba084>] (SyS_futex) from [<80010940>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r9:bdb06000 r8:80010b04 r7:000000f0 r6:769ccd1a r5:000000dc
 r4:74f00010


 Thanks and Regards,
 Ivan
