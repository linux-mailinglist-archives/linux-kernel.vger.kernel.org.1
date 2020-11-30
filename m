Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D180A2C842C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgK3Mc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:32:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgK3Mc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:32:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUBWeVo195669;
        Mon, 30 Nov 2020 07:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=sbJ7dKGgVTuZeK3rSff6w7OIFG7YqslxMUa1Xf18SVg=;
 b=gPq/45G4mOVvoX4pmKWXnVEloAaMUAdOP0qwQAwYbAeCCkVsgWHOguRl78mFBi4zD0dt
 IwRoZFz4gSffzg/Dl0mdGfXqkVrauISAcNZI5TYOeW7mMRlqQIbvWKpr+1zMd1but2TE
 agSz1r+0003RQcTjhN3lIdeJ27BaApKaVmu/qJzzhfVgR68keTkBfor/a/gyJBeH0lhF
 O0fLFVLuTRHqpDpP8gxpfB1BBb0ipTkaS3+GSP3uULRV1g0V2Cqf/0sV4+6Mh819r/mq
 2/uuCokiljQLDYzJJoGbqHVW1VmW6ShZPbNr6erbbnevKt1gBL+vWMcNTjP9dDjpt1yh PA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 354y9wk49b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 07:31:38 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AUCVaD3011159;
        Mon, 30 Nov 2020 12:31:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 353e6820sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 12:31:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AUCVY2r54854026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 12:31:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 358B25204F;
        Mon, 30 Nov 2020 12:31:34 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id EAAA25204E;
        Mon, 30 Nov 2020 12:31:33 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
References: <160665707945.2808.5384034634184489471.tglx@nanos>
        <160665708065.2808.15317906761841446715.tglx@nanos>
        <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
        <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
        <yt9dh7p78d8l.fsf@linux.ibm.com>
Date:   Mon, 30 Nov 2020 13:31:33 +0100
In-Reply-To: <yt9dh7p78d8l.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Mon, 30 Nov 2020 09:23:22 +0100")
Message-ID: <yt9dpn3v3u1m.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_02:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=778 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sven Schnelle <svens@linux.ibm.com> writes:

> Hi Peter,
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
>> On Sun, Nov 29, 2020 at 11:31:41AM -0800, Linus Torvalds wrote:
>>> On Sun, Nov 29, 2020 at 5:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>> >
>>> > Yet two more places which invoke tracing from RCU disabled regions in the
>>> > idle path. Similar to the entry path the low level idle functions have to
>>> > be non-instrumentable.
>>> 
>>> This really seems less than optimal.
>>> 
>>> In particular, lookie here:
>>> 
>>> > @@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
>>> >
>>> >                 trace_cpu_idle(1, smp_processor_id());
>>> >                 stop_critical_timings();
>>> > +
>>> > +               /*
>>> > +                * arch_cpu_idle() is supposed to enable IRQs, however
>>> > +                * we can't do that because of RCU and tracing.
>>> > +                *
>>> > +                * Trace IRQs enable here, then switch off RCU, and have
>>> > +                * arch_cpu_idle() use raw_local_irq_enable(). Note that
>>> > +                * rcu_idle_enter() relies on lockdep IRQ state, so switch that
>>> > +                * last -- this is very similar to the entry code.
>>> > +                */
>>> > +               trace_hardirqs_on_prepare();
>>> > +               lockdep_hardirqs_on_prepare(_THIS_IP_);
>>> >                 rcu_idle_enter();
>>> > +               lockdep_hardirqs_on(_THIS_IP_);
>>> > +
>>> >                 arch_cpu_idle();
>>> > +
>>> > +               /*
>>> > +                * OK, so IRQs are enabled here, but RCU needs them disabled to
>>> > +                * turn itself back on.. funny thing is that disabling IRQs
>>> > +                * will cause tracing, which needs RCU. Jump through hoops to
>>> > +                * make it 'work'.
>>> > +                */
>>> > +               raw_local_irq_disable();
>>> > +               lockdep_hardirqs_off(_THIS_IP_);
>>> >                 rcu_idle_exit();
>>> > +               lockdep_hardirqs_on(_THIS_IP_);
>>> > +               raw_local_irq_enable();
>>> > +
>>> >                 start_critical_timings();
>>> >                 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>>> >         }
>>> 
>>> And look at what the code generation for the idle exit path is when
>>> lockdep isn't even on.
>>
>> Agreed.
>>
>> The idea was to flip all of arch_cpu_idle() to not enable interrupts.
>>
>> This is suboptimal for things like x86 where arch_cpu_idle() is
>> basically STI;HLT, but x86 isn't likely to actually use this code path
>> anyway, given all the various cpuidle drivers it has.
>>
>> Many of the other archs are now doing things like arm's:
>> wfi();raw_local_irq_enable().
>>
>> Doing that tree-wide interrupt-state flip was something I didn't want to
>> do at this late a stage, the chanse of messing that up is just too high.
>>
>> After that I need to go look at flipping cpuidle, which is even more
>> 'interesting'. cpuidle_enter() has the exact same semantics, and this is
>> the code path that x86 actually uses, and here it's inconsitent at best.
>
> On s390 this introduces the following splat:
> [..]

I sent you the wrong backtrace. This is the correct one:

[    0.667491] smp: Bringing up secondary CPUs ... 
[    0.670262] random: get_random_bytes called from __warn+0x12a/0x160 with crng_init=1 
[    0.670280] ------------[ cut here ]------------ 
[    0.670288] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:1054 rcu_irq_enter+0x7e/0xa8 
[    0.670293] Modules linked in: 
[    0.670299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.10.0-rc6 #2263 
[    0.670304] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0) 
[    0.670309] Krnl PSW : 0404d00180000000 0000000000d8a8da (rcu_irq_enter+0x82/0xa8) 
[    0.670318]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3 
[    0.670325] Krnl GPRS: 0000000000000000 0000000080000002 0000000000000001 000000000101fcee 
[    0.670331]            0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    0.670337]            000003e00029ff48 0000000000000000 00000000017212d8 0000000000000001 
[    0.670343]            0000000005ba0100 00000000000324bb 000003e00029fe40 000003e00029fe10
 
[    0.670358] Krnl Code: 0000000000d8a8ca: ec180013017e        cij     %r1,1,8,0000000000d8a8f0 
[    0.670358]            0000000000d8a8d0: ecb80005007e        cij     %r11,0,8,0000000000d8a8da 
[    0.670358]           #0000000000d8a8d6: af000000            mc      0,0 
[    0.670358]           >0000000000d8a8da: ebbff0a00004        lmg     %r11,%r15,160(%r15) 
[    0.670358]            0000000000d8a8e0: c0f4ffffff68        brcl    15,0000000000d8a7b0 
[    0.670358]            0000000000d8a8e6: c0e5000038c1        brasl   %r14,0000000000d91a68 
[    0.670358]            0000000000d8a8ec: a7f4ffdc            brc     15,0000000000d8a8a4 
[    0.670358]            0000000000d8a8f0: c0e5000038bc        brasl   %r14,0000000000d91a68 
[    0.670392] Call Trace: 
[    0.670396]  [<0000000000d8a8da>] rcu_irq_enter+0x82/0xa8  
[    0.670401]  [<0000000000157f9a>] irq_enter+0x22/0x30  
[    0.670404]  [<000000000010e51c>] do_IRQ+0x64/0xd0  
[    0.670408]  [<0000000000d9a65a>] ext_int_handler+0x18e/0x194  
[    0.670412]  [<0000000000d9a6a0>] psw_idle+0x40/0x48  
[    0.670416] ([<0000000000104202>] enabled_wait+0x22/0xf0) 
[    0.670419]  [<00000000001046e2>] arch_cpu_idle+0x22/0x38  
[    0.670423]  [<0000000000d986cc>] default_idle_call+0x74/0xd8  
[    0.670427]  [<000000000019a94a>] do_idle+0xf2/0x1b0  
[    0.670431]  [<000000000019ac7e>] cpu_startup_entry+0x36/0x40  
[    0.670435]  [<0000000000118b9a>] smp_start_secondary+0x82/0x88  
[    0.670438] INFO: lockdep is turned off. 
[    0.670441] Last Breaking-Event-Address: 
[    0.670444]  [<0000000000157f94>] irq_enter+0x1c/0x30 
[    0.670447] irq event stamp: 19 
[    0.670451] hardirqs last  enabled at (19): [<0000000000d98688>] default_idle_call+0x30/0xd8 
[    0.670455] hardirqs last disabled at (18): [<000000000019a9c2>] do_idle+0x16a/0x1b0 
[    0.670459] softirqs last  enabled at (0): [<000000000014c3be>] copy_process+0x48e/0x14c0 
[    0.670463] softirqs last disabled at (0): [<0000000000000000>] 0x0 
[    0.670466] ---[ end trace cba3783aedff6f79 ]--- 
[    0.670685] smp: Brought up 1 node, 2 CPUs 
[    0.676300]  
[    0.676301] ============================= 
[    0.676302] WARNING: suspicious RCU usage 
[    0.676303] 5.10.0-rc6 #2263 Not tainted 
[    0.676303] ----------------------------- 
[    0.676304] include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage! 
[    0.676305]  
[    0.676306] other info that might help us debug this: 
[    0.676306]  
[    0.676307]  
[    0.676307] rcu_scheduler_active = 1, debug_locks = 1 
[    0.676308] RCU used illegally from extended quiescent state! 
[    0.676309] no locks held by swapper/1/0. 
[    0.676309]  
[    0.676310] stack backtrace: 
[    0.676310] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.0-rc6 #2263 
[    0.676311] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0) 
[    0.676312] Call Trace: 
[    0.676312]  [<0000000000d726f8>] show_stack+0x90/0xf8  
[    0.676313]  [<0000000000d855f2>] dump_stack+0xa2/0xd8  
[    0.676314]  [<00000000001d216e>] trace_lock_acquire+0x1ce/0x1d8  
[    0.676314]  [<00000000001d7c44>] lock_acquire+0x44/0x88  
[    0.676315]  [<0000000000d98788>] _raw_spin_lock+0x58/0xa8 
 
[    0.676316]  [<00000000001e4e94>] vprintk_emit+0x74/0x1a8  
[    0.676316]  [<00000000001e4ffe>] vprintk_default+0x36/0x48  
[    0.676317]  [<0000000000d76526>] printk+0x46/0x58  
[    0.676318]  [<00000000009ae188>] report_bug+0x110/0x130  
[    0.676318]  [<000000000010215c>] monitor_event_exception+0x44/0xc0  
[    0.676319]  [<0000000000d9a10e>] pgm_check_handler+0x1da/0x238  
[    0.676320]  [<0000000000d8a8da>] rcu_irq_enter+0x82/0xa8  
[    0.676321] ------------[ cut here ]------------ 
[    0.676321] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled()) 
[    0.676322] WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:5281 check_flags.part.0+0x1cc/0x208 
[    0.676323] Modules linked in: 
[    0.676324] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.0-rc6 #2263 
[    0.676325] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0) 
[    0.676325] Krnl PSW : 0404c00180000000 00000000001d79d0 (check_flags.part.0+0x1d0/0x208) 
[    0.676327]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3 
[    0.676329] Krnl GPRS: 00000000ffffffe5 000000000116dbd4 000000000000002f 0000000000fe8c00 
[    0.676330]            0000000000000000 00000000009ad0e8 0000000000000000 0000000000000000 
[    0.676330]            00000000012d7f20 0000000000000000 040003e000000001 000000000257f310 
[    0.676331]            0000000005ba0100 00000000011725b0 00000000001d79cc 000003e00029f638 
[    0.676332] Krnl Code: 00000000001d79c0: c02000708989        larl    %r2,0000000000fe8cd2 
[    0.676333]            00000000001d79c6: c0e5005cde09        brasl   %r14,0000000000d735d8 
[    0.676334]           #00000000001d79cc: af000000            mc      0,0 
[    0.676335]           >00000000001d79d0: c0200070d844        larl    %r2,0000000000ff2a58 
[    0.676337]            00000000001d79d6: c0e5005cf585        brasl   %r14,0000000000d764e0 
[    0.676338]            00000000001d79dc: a7f4ff3f            brc     15,00000000001d785a 
[    0.676339]            00000000001d79e0: c0e5005dd044        brasl   %r14,0000000000d91a68 
[    0.676340]            00000000001d79e6: a7f4ff6f            brc     15,00000000001d78c4 
[    0.676341] Call Trace: 
[    0.676342]  [<00000000001d79d0>] check_flags.part.0+0x1d0/0x208  
[    0.676343] ([<00000000001d79cc>] check_flags.part.0+0x1cc/0x208) 
[    0.676344]  [<00000000001d7a9e>] lock_acquire.part.0+0x96/0x1f8  
[    0.676344]  [<00000000001d7c7c>] lock_acquire+0x7c/0x88  
[    0.676345]  [<000000000027bce4>] __is_insn_slot_addr+0x5c/0x150  
[    0.676346]  [<000000000017dbf2>] kernel_text_address+0x11a/0x130  
[    0.676346]  [<000000000017dc2e>] __kernel_text_address+0x26/0x70  
[    0.676347]  [<000000000011843c>] unwind_next_frame+0x104/0x1c0  
[    0.676348]  [<0000000000d72738>] show_stack+0xd0/0xf8  
[    0.676348]  [<0000000000d855f2>] dump_stack+0xa2/0xd8  
[    0.676349]  [<00000000001d216e>] trace_lock_acquire+0x1ce/0x1d8  
[    0.676350]  [<00000000001d7c44>] lock_acquire+0x44/0x88  
[    0.676350]  [<0000000000d98788>] _raw_spin_lock+0x58/0xa8  
[    0.676351]  [<00000000001e4e94>] vprintk_emit+0x74/0x1a8  
[    0.676352]  [<00000000001e4ffe>] vprintk_default+0x36/0x48  
[    0.676352]  [<0000000000d76526>] printk+0x46/0x58  
[    0.676353]  [<00000000009ae188>] report_bug+0x110/0x130  
[    0.676354]  [<000000000010215c>] monitor_event_exception+0x44/0xc0  
[    0.676354]  [<0000000000d9a10e>] pgm_check_handler+0x1da/0x238  
[    0.676355]  [<0000000000d8a8da>] rcu_irq_enter+0x82/0xa8  
[    0.676356]  [<0000000000157f9a>] irq_enter+0x22/0x30  
[    0.676356]  [<000000000010e51c>] do_IRQ+0x64/0xd0  
[    0.676357]  [<0000000000d9a65a>] ext_int_handler+0x18e/0x194  
[    0.676358]  [<0000000000d9a6a0>] psw_idle+0x40/0x48  
[    0.676358] ([<0000000000104202>] enabled_wait+0x22/0xf0) 
[    0.676359]  [<00000000001046e2>] arch_cpu_idle+0x22/0x38  
[    0.676360]  [<0000000000d986cc>] default_idle_call+0x74/0xd8  
[    0.676360]  [<000000000019a94a>] do_idle+0xf2/0x1b0  
[    0.676361]  [<000000000019ac7e>] cpu_startup_entry+0x36/0x40  
[    0.676362]  [<0000000000118b9a>] smp_start_secondary+0x82/0x88  
[    0.676362] INFO: lockdep is turned off. 
[    0.676363] Last Breaking-Event-Address: 
[    0.676364]  [<0000000000d9c4d0>] __s390_indirect_jump_r14+0x0/0xc 
[    0.676364] irq event stamp: 19 
[    0.676365] hardirqs last  enabled at (19): [<0000000000d98688>] default_idle_call+0x30/0xd8 
[    0.676366] hardirqs last disabled at (18): [<000000000019a9c2>] do_idle+0x16a/0x1b0 
[    0.676367] softirqs last  enabled at (0): [<000000000014c3be>] copy_process+0x48e/0x14c0 
[    0.676367] softirqs last disabled at (0): [<0000000000000000>] 0x0 
[    0.676368] ---[ end trace cba3783aedff6f78 ]--- 
[    0.676369] possible reason: unannotated irqs-off. 
[    0.676369] irq event stamp: 19 
[    0.676370] hardirqs last  enabled at (19): [<0000000000d98688>] default_idle_call+0x30/0xd8 
[    0.676371] hardirqs last disabled at (18): [<000000000019a9c2>] do_idle+0x16a/0x1b0 
[    0.676372] softirqs last  enabled at (0): [<000000000014c3be>] copy_process+0x48e/0x14c0 
[    0.676372] softirqs last disabled at (0): [<0000000000000000>] 0x0 
[    0.676373]  [<0000000000157f9a>] irq_enter+0x22/0x30  
[    0.676374]  [<000000000010e51c>] do_IRQ+0x64/0xd0  
[    0.676374]  [<0000000000d9a65a>] ext_int_handler+0x18e/0x194  
[    0.676375]  [<0000000000d9a6a0>] psw_idle+0x40/0x48  
[    0.676376] ([<0000000000104202>] enabled_wait+0x22/0xf0) 
[    0.676376]  [<00000000001046e2>] arch_cpu_idle+0x22/0x38  
[    0.676377]  [<0000000000d986cc>] default_idle_call+0x74/0xd8  
[    0.676378]  [<000000000019a94a>] do_idle+0xf2/0x1b0  
[    0.676378]  [<000000000019ac7e>] cpu_startup_entry+0x36/0x40  
[    0.676379]  [<0000000000118b9a>] smp_start_secondary+0x82/0x88  
[    0.676379] INFO: lockdep is turned off. 
