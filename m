Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6A2CBB29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbgLBK5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:57:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24796 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgLBK5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:57:49 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2Acr5d026968;
        Wed, 2 Dec 2020 05:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3y+VXPOcnH223ELInLCnkNXgTjVMdpgwE+j1/lgr8eE=;
 b=VNXC52bmh8+VJdusQd8QFJqU14rI3x/4rd1Lbch2aJsunoE+uexhzgeRapxkCGcWSj9F
 /3NRNa4EAonhRaC9C27bv25mfDDv9VR4nPXkKNMAFc0tHulu1X74KDQiyO+eSDGDLqkZ
 AJIHejw6/Zp30dDbbkqo+LDQBNymkA6nrBlqz22nLClUAWaKc/el+q4smDUUF1uBbhh5
 P78iLjCZoJfL5m+t1lRzZGWkeP5w+STYr75FQqg2gHXHnU3yeqzZ9PUI+Kxu7r0UaewF
 vUArlUzwmXetjnBhAOHgxtnN50ICC2reZQ8Ph0ZXoSvE09puBQUnpt9dve6pFhQWDAEd RQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355y6cybfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:56:56 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2AqTeJ011911;
        Wed, 2 Dec 2020 10:56:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 353e68a59y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 10:56:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2AupC045941178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 10:56:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3159CA4051;
        Wed,  2 Dec 2020 10:56:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C660EA4055;
        Wed,  2 Dec 2020 10:56:50 +0000 (GMT)
Received: from osiris (unknown [9.171.20.32])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 10:56:50 +0000 (GMT)
Date:   Wed, 2 Dec 2020 11:56:49 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202105649.GB6202@osiris>
References: <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
 <20201201185737.GA93208@C02TD0UTHF1T.local>
 <20201201191441.GW3040@hirez.programming.kicks-ass.net>
 <20201201191856.GD8316@osiris>
 <20201202092116.GA3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202092116.GA3040@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_04:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=691
 mlxscore=0 suspectscore=1 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012020062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:21:16AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 08:18:56PM +0100, Heiko Carstens wrote:
> OK, so with a little help from s390/PoO and Sven, the code removed skips
> the TRACE_IRQS_OFF when IRQs were enabled in the old PSW (the previous
> context).
> 
> That sounds entirely the right thing. Irrespective of what the previous
> IRQ state was, the current state is off.
> 
> > diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> > index 2b85096964f8..5bd8c1044d09 100644
> > --- a/arch/s390/kernel/idle.c
> > +++ b/arch/s390/kernel/idle.c
> > @@ -123,7 +123,6 @@ void arch_cpu_idle_enter(void)
> >  void arch_cpu_idle(void)
> >  {
> >  	enabled_wait();
> > -	raw_local_irq_enable();
> >  }
> 
> Currently arch_cpu_idle() is defined as to return with IRQs enabled,
> however, the very first thing we do when we return is
> raw_local_irq_disable(), so this change is harmless.
> 
> It is also the direction I've been arguing for elsewhere in this thread.
> So I'm certainly not complaining.

So I left that raw_local_irq_enable() in to be consistent with other
architectures. enabled_wait() now returns with irqs disabled, but with
a lockdep state that tells irqs are on...  See patch below.
Works and hopefully makes sense ;)

In addition (but not for rc7) I want to get rid of our complex udelay
implementation. I think we don't need that anymore.. so there would be
only the idle code left where we have to play tricks.

From 7bd86fb3eb039a4163281472ca79b9158e726526 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Wed, 2 Dec 2020 11:46:01 +0100
Subject: [PATCH] s390: fix irq state tracing

With commit 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs
tracing") common code calls arch_cpu_idle() with a lockdep state that
tells irqs are on.

This doesn't work very well for s390: psw_idle() will enable interrupts
to wait for an interrupt. As soon as an interrupt occurs the interrupt
handler will verify if the old context was psw_idle(). If that is the
case the interrupt enablement bits in the old program status word will
be cleared.

A subsequent test in both the external as well as the io interrupt
handler checks if in the old context interrupts were enabled. Due to
the above patching of the old program status word it is assumed the
old context had interrupts disabled, and therefore a call to
TRACE_IRQS_OFF (aka trace_hardirqs_off_caller) is skipped. Which in
turn makes lockdep incorrectly "think" that interrupts are enabled
within the interrupt handler.

Fix this by unconditionally calling TRACE_IRQS_OFF when entering
interrupt handlers. Also call unconditionally TRACE_IRQS_ON when
leaving interrupts handlers.

This leaves the special psw_idle() case, which now returns with
interrupts disabled, but has an "irqs on" lockdep state. So callers of
psw_idle() must adjust the state on their own, if required. This is
currently only __udelay_disabled().

Fixes: 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs tracing")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 15 ---------------
 arch/s390/lib/delay.c    |  5 ++---
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 26bb0603c5a1..92beb1444644 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -763,12 +763,7 @@ ENTRY(io_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tmhh	%r8,0x300
-	jz	1f
 	TRACE_IRQS_OFF
-1:
-#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 .Lio_loop:
 	lgr	%r2,%r11		# pass pointer to pt_regs
@@ -791,12 +786,7 @@ ENTRY(io_int_handler)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lio_work
 .Lio_restore:
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tm	__PT_PSW(%r11),3
-	jno	0f
 	TRACE_IRQS_ON
-0:
-#endif
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jno	.Lio_exit_kernel
@@ -976,12 +966,7 @@ ENTRY(ext_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
-#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
-	tmhh	%r8,0x300
-	jz	1f
 	TRACE_IRQS_OFF
-1:
-#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	lghi	%r3,EXT_INTERRUPT
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index daca7bad66de..8c0c68e7770e 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(__delay);
 
 static void __udelay_disabled(unsigned long long usecs)
 {
-	unsigned long cr0, cr0_new, psw_mask, flags;
+	unsigned long cr0, cr0_new, psw_mask;
 	struct s390_idle_data idle;
 	u64 end;
 
@@ -45,9 +45,8 @@ static void __udelay_disabled(unsigned long long usecs)
 	psw_mask = __extract_psw() | PSW_MASK_EXT | PSW_MASK_WAIT;
 	set_clock_comparator(end);
 	set_cpu_flag(CIF_IGNORE_IRQ);
-	local_irq_save(flags);
 	psw_idle(&idle, psw_mask);
-	local_irq_restore(flags);
+	trace_hardirqs_off();
 	clear_cpu_flag(CIF_IGNORE_IRQ);
 	set_clock_comparator(S390_lowcore.clock_comparator);
 	__ctl_load(cr0, 0, 0);
-- 
2.17.1

