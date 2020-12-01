Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534C2C98AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgLAHtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:49:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728658AbgLAHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:49:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B17XeJx059555;
        Tue, 1 Dec 2020 02:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=SO8tTOmYv6J0PO62B8vyvOsopLeTTbDArLccCIDjrjA=;
 b=H12Pbj8w2I/IO+MEX6xlPNjKBkKiCDvVYjaLOfbr62hfSum74vvvsrcCb0J4NVJHGbSi
 jRbTv5AaubTJUaUJmxaP6jFCwlNn9DFkbZGQI9/EEY+DSv4/xx1rn8fMs594vwnamfoZ
 Xg3t9+fjyzldpFZkpc6JY2muksx4ofy55D2ovJx3pvEHEQYBvxb00Z1QnztzqsiYE74+
 HKnXEjD/e63VZoagUUj+TyMrRGDV4pnV2assrM5wBrcFtEf1C1Jvc5RwwNX4zwLgVnyF
 84NnwPm/EgOQOzNHrrw+NlXcxOVKiLuZNHrxB+TkXPe6tCmTwlrWkuAK/K3LWTEfL2oq yw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355f26md6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 02:48:59 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B17lKLb017268;
        Tue, 1 Dec 2020 07:48:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 353e689fw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 07:48:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B17mtQ07995996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 07:48:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D715AE045;
        Tue,  1 Dec 2020 07:48:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3258AE055;
        Tue,  1 Dec 2020 07:48:54 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 07:48:54 +0000 (GMT)
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
        <yt9dh7p78d8l.fsf@linux.ibm.com> <yt9dpn3v3u1m.fsf@linux.ibm.com>
        <20201130125211.GN2414@hirez.programming.kicks-ass.net>
        <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Dec 2020 08:48:54 +0100
In-Reply-To: <20201130130315.GJ3092@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 30 Nov 2020 14:03:15 +0100")
Message-ID: <yt9dr1oaq849.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_01:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=488 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Nov 30, 2020 at 01:52:11PM +0100, Peter Zijlstra wrote:
>> On Mon, Nov 30, 2020 at 01:31:33PM +0100, Sven Schnelle wrote:
>> > [    0.670280] ------------[ cut here ]------------ 
>> > [    0.670288] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:1054 rcu_irq_enter+0x7e/0xa8 
>> > [    0.670293] Modules linked in: 
>> > [    0.670299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.10.0-rc6 #2263 
>> > [    0.670304] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0) 
>> > [    0.670309] Krnl PSW : 0404d00180000000 0000000000d8a8da (rcu_irq_enter+0x82/0xa8) 
>> > [    0.670318]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3 
>> > [    0.670325] Krnl GPRS: 0000000000000000 0000000080000002 0000000000000001 000000000101fcee 
>> > [    0.670331]            0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> > [    0.670337]            000003e00029ff48 0000000000000000 00000000017212d8 0000000000000001 
>> > [    0.670343]            0000000005ba0100 00000000000324bb 000003e00029fe40 000003e00029fe10
>> >  
>> > [    0.670358] Krnl Code: 0000000000d8a8ca: ec180013017e        cij     %r1,1,8,0000000000d8a8f0 
>> > [    0.670358]            0000000000d8a8d0: ecb80005007e        cij     %r11,0,8,0000000000d8a8da 
>> > [    0.670358]           #0000000000d8a8d6: af000000            mc      0,0 
>> > [    0.670358]           >0000000000d8a8da: ebbff0a00004        lmg     %r11,%r15,160(%r15) 
>> > [    0.670358]            0000000000d8a8e0: c0f4ffffff68        brcl    15,0000000000d8a7b0 
>> > [    0.670358]            0000000000d8a8e6: c0e5000038c1        brasl   %r14,0000000000d91a68 
>> > [    0.670358]            0000000000d8a8ec: a7f4ffdc            brc     15,0000000000d8a8a4 
>> > [    0.670358]            0000000000d8a8f0: c0e5000038bc        brasl   %r14,0000000000d91a68 
>> > [    0.670392] Call Trace: 
>> > [    0.670396]  [<0000000000d8a8da>] rcu_irq_enter+0x82/0xa8  
>> > [    0.670401]  [<0000000000157f9a>] irq_enter+0x22/0x30  
>> > [    0.670404]  [<000000000010e51c>] do_IRQ+0x64/0xd0  
>> > [    0.670408]  [<0000000000d9a65a>] ext_int_handler+0x18e/0x194  
>> > [    0.670412]  [<0000000000d9a6a0>] psw_idle+0x40/0x48  
>> > [    0.670416] ([<0000000000104202>] enabled_wait+0x22/0xf0) 
>> > [    0.670419]  [<00000000001046e2>] arch_cpu_idle+0x22/0x38  
>> > [    0.670423]  [<0000000000d986cc>] default_idle_call+0x74/0xd8  
>> > [    0.670427]  [<000000000019a94a>] do_idle+0xf2/0x1b0  
>> > [    0.670431]  [<000000000019ac7e>] cpu_startup_entry+0x36/0x40  
>> > [    0.670435]  [<0000000000118b9a>] smp_start_secondary+0x82/0x88  
>> 
>> But but but...
>> 
>>   do_idle()			# IRQs on
>>     local_irq_disable();	# IRQs off
>>     defaul_idle_call()	# IRQs off
> 	lockdep_hardirqs_on();	# IRQs off, but lockdep things they're on
>>       arch_cpu_idle()		# IRQs off
>>         enabled_wait()	# IRQs off
>> 	  raw_local_save()	# still off
>> 	  psw_idle()		# very much off
>> 	    ext_int_handler	# get an interrupt ?!?!
> 	      rcu_irq_enter()	# lockdep thinks IRQs are on <- FAIL
>
>
> I can't much read s390 assembler, but ext_int_handler() has a
> TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
> with the actual state, but there's some condition before it, what's that
> test and is that right?

That test was introduced to only track changes in IRQ state because of
recursion problems in lockdep. This now seems to no longer work. We
propably could remove that as lockdep now can handle recursion much
better with all the recent changes, but given that we're already at
-rc6, i don't want to touch entry.S code because of a debugging feature.

