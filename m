Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166012C7FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgK3IYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:24:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727133AbgK3IYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:24:30 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AU81f1q111367;
        Mon, 30 Nov 2020 03:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=DhSedWucQ47SIbd0pze02xdA5IxffT6FprLToFASYw4=;
 b=NDD46NwzoYCQEkw3EaqWwXIUuyIxHNceUifEMb3gktin+Ku+qNR5+Fngow0XVx+i6zdv
 YgfDCXIwZYOo9jci1tCEVUiwgB5H8QBPYYHhR8KCdat3ZHe+bJwR7+RiKsJDSRIY9YC0
 q+UeS4uj9H2wamend+zM2tiEOYy02H/p+Gp9i3TVCZ5s9S04iFtCrmMCBLeHRX4iJ2xk
 vEeC/uuwn0DyS+NGzrQ4fO/GZD7VbASXxDiPMCUUo1N4X26uijyKeVVwaQ95L8M0ng5A
 4UklOoaupb7GJUsb48nW3QvR5TjE4kNJxLaCZRJC9StLVIzRqkrCz7QeTMSwVPme6AW3 VQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 354v989et2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 03:23:26 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AU88dc7012332;
        Mon, 30 Nov 2020 08:23:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 353e682pm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 08:23:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AU8NM0856164820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 08:23:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B988A405C;
        Mon, 30 Nov 2020 08:23:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F19DA405F;
        Mon, 30 Nov 2020 08:23:22 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Nov 2020 08:23:22 +0000 (GMT)
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
Date:   Mon, 30 Nov 2020 09:23:22 +0100
In-Reply-To: <20201130075651.GJ2414@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 30 Nov 2020 08:56:51 +0100")
Message-ID: <yt9dh7p78d8l.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_02:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=818 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Peter Zijlstra <peterz@infradead.org> writes:

> On Sun, Nov 29, 2020 at 11:31:41AM -0800, Linus Torvalds wrote:
>> On Sun, Nov 29, 2020 at 5:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> > Yet two more places which invoke tracing from RCU disabled regions in the
>> > idle path. Similar to the entry path the low level idle functions have to
>> > be non-instrumentable.
>> 
>> This really seems less than optimal.
>> 
>> In particular, lookie here:
>> 
>> > @@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
>> >
>> >                 trace_cpu_idle(1, smp_processor_id());
>> >                 stop_critical_timings();
>> > +
>> > +               /*
>> > +                * arch_cpu_idle() is supposed to enable IRQs, however
>> > +                * we can't do that because of RCU and tracing.
>> > +                *
>> > +                * Trace IRQs enable here, then switch off RCU, and have
>> > +                * arch_cpu_idle() use raw_local_irq_enable(). Note that
>> > +                * rcu_idle_enter() relies on lockdep IRQ state, so switch that
>> > +                * last -- this is very similar to the entry code.
>> > +                */
>> > +               trace_hardirqs_on_prepare();
>> > +               lockdep_hardirqs_on_prepare(_THIS_IP_);
>> >                 rcu_idle_enter();
>> > +               lockdep_hardirqs_on(_THIS_IP_);
>> > +
>> >                 arch_cpu_idle();
>> > +
>> > +               /*
>> > +                * OK, so IRQs are enabled here, but RCU needs them disabled to
>> > +                * turn itself back on.. funny thing is that disabling IRQs
>> > +                * will cause tracing, which needs RCU. Jump through hoops to
>> > +                * make it 'work'.
>> > +                */
>> > +               raw_local_irq_disable();
>> > +               lockdep_hardirqs_off(_THIS_IP_);
>> >                 rcu_idle_exit();
>> > +               lockdep_hardirqs_on(_THIS_IP_);
>> > +               raw_local_irq_enable();
>> > +
>> >                 start_critical_timings();
>> >                 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>> >         }
>> 
>> And look at what the code generation for the idle exit path is when
>> lockdep isn't even on.
>
> Agreed.
>
> The idea was to flip all of arch_cpu_idle() to not enable interrupts.
>
> This is suboptimal for things like x86 where arch_cpu_idle() is
> basically STI;HLT, but x86 isn't likely to actually use this code path
> anyway, given all the various cpuidle drivers it has.
>
> Many of the other archs are now doing things like arm's:
> wfi();raw_local_irq_enable().
>
> Doing that tree-wide interrupt-state flip was something I didn't want to
> do at this late a stage, the chanse of messing that up is just too high.
>
> After that I need to go look at flipping cpuidle, which is even more
> 'interesting'. cpuidle_enter() has the exact same semantics, and this is
> the code path that x86 actually uses, and here it's inconsitent at best.

On s390 this introduces the following splat:

[    2.962283] Testing tracer wakeup_rt:  
[    3.017102] sched: DL replenish lagged too much 
[    3.061777] PASSED 
[    3.062076] Testing tracer wakeup_dl: PASSED 
[    3.161296] ------------[ cut here ]------------ 
[    3.161301] DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key != current->curr_chain_key) 
[    3.161310] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4155 lockdep_hardirqs_on+0x1ea/0x1f8 
[    3.161316] Modules linked in: 
[    3.161323] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-rc6-07209-g9e30ba6d2d5c #2249 
[    3.161327] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0) 
[    3.161331] Krnl PSW : 0404d00180000000 0000000000d730fe (lockdep_hardirqs_on+0x1ee/0x1f8) 
[    3.161340]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3 
[    3.161347] Krnl GPRS: c0000000ffffbfff 0000000080000001 000000000000004a 00000000001e33b8 
[    3.161352]            0000038000007b88 0000038000007b80 ffffffffffffffff 0000000000000000 
[    3.161357]            0000000000000000 000000000151a610 0000000001361500 0000000000d81d40 
[    3.161362]            0000000000010400 0000000000d88010 0000000000d730fa 0000038000007db8
 
[    3.161461] Krnl Code: 0000000000d730ee: c0200012d9ad        larl    %r2,0000000000fce448 
[    3.161461]            0000000000d730f4: c0e5ffff451a        brasl   %r14,0000000000d5bb28 
[    3.161461]           #0000000000d730fa: af000000            mc      0,0 
[    3.161461]           >0000000000d730fe: a7f4ff70            brc     15,0000000000d72fde 
[    3.161461]            0000000000d73102: 0707                bcr     0,%r7 
[    3.161461]            0000000000d73104: 0707                bcr     0,%r7 
[    3.161461]            0000000000d73106: 0707                bcr     0,%r7 
[    3.161461]            0000000000d73108: c418002884ec        lgrl    %r1,0000000001283ae0 
[    3.161518] Call Trace: 
[    3.161526]  [<0000000000d730fe>] lockdep_hardirqs_on+0x1ee/0x1f8  
[    3.161532] ([<0000000000d730fa>] lockdep_hardirqs_on+0x1ea/0x1f8) 
[    3.161538]  [<0000000000d81da6>] default_idle_call+0x96/0xd8  
[    3.161544]  [<0000000000199dba>] do_idle+0xf2/0x1b0  
[    3.161550]  [<000000000019a0ee>] cpu_startup_entry+0x36/0x40 
 
[    3.161604]  [<000000000141af2e>] arch_call_rest_init+0x76/0x80  
[    3.161645] INFO: lockdep is turned off. 
[    3.161649] Last Breaking-Event-Address: 
[    3.161661]  [<00000000001e436e>] vprintk_emit+0xde/0x1a8 
[    3.161700] irq event stamp: 10315 
[    3.161712] hardirqs last  enabled at (10313): [<00000000001aa3ec>] load_balance+0x2ac/0x9c0 
[    3.161751] hardirqs last disabled at (10314): [<0000000000d853c6>] __do_softirq+0x2de/0x3c8 
[    3.161756] softirqs last  enabled at (10315): [<0000000000d85384>] __do_softirq+0x29c/0x3c8 
[    3.161767] softirqs last disabled at (10308): [<000000000010dd70>] do_softirq_own_stack+0x70/0x80 
[    3.161802] ---[ end trace 4484b2a7468d1380 ]--- 
[    3.161887] Testing tracer function_graph: PASSED 
[    3.353303] prandom32: self test passed (less than 6 bits correlated) 
[    3.353319] prandom: seed boundary self test passed 

Haven't looked into it yet.

Regards
Sven
