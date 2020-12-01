Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7D2CABA1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392307AbgLATT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:19:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42098 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgLATT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:19:56 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1J1xoj020501;
        Tue, 1 Dec 2020 14:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vR8f4N8aSC3rIgwt8GiCK2TXrghQrQLFEJ1afDBvcCk=;
 b=CyiXZ6IFclm8buVjB2njtJcADLx96MBe3XYYMr9U4WhTsUkDm0Os6ctrEEwrWFAQmvYH
 tfMm79cOuFxZUPOJiUqR+z8uZbgMfLFCHyAfFwOOFxjUEePmmnW88k3fX0OoaY9RKJ+p
 RPpfSXG6KqjrknwOhVBTSKNL5yweradk8+HtY0zq31VJa6bi4903nIlpUzhj7LGxWBf9
 ODaSoTgTI0riUS32aaI8cFTNSPmgBkWd1fCiU+nFEe9wKP3ytQ34l224VldEsgTmco+0
 q4H3EhELJeza+96Is9/Cv9jjUnluq1RA7LSIM6xV6hrB6oyX91ulIG3S7Hh741Yh2x8H dQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355k18r482-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:19:02 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1JGplv021325;
        Tue, 1 Dec 2020 19:19:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 353e68bf5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 19:19:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1JIwgb65601900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 19:18:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F7DDAE053;
        Tue,  1 Dec 2020 19:18:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA721AE045;
        Tue,  1 Dec 2020 19:18:57 +0000 (GMT)
Received: from osiris (unknown [9.171.87.179])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 19:18:57 +0000 (GMT)
Date:   Tue, 1 Dec 2020 20:18:56 +0100
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
Message-ID: <20201201191856.GD8316@osiris>
References: <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
 <20201201185737.GA93208@C02TD0UTHF1T.local>
 <20201201191441.GW3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201191441.GW3040@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_07:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=1 bulkscore=0 mlxlogscore=714 clxscore=1011 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:14:41PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 06:57:37PM +0000, Mark Rutland wrote:
> > On Tue, Dec 01, 2020 at 07:15:06PM +0100, Peter Zijlstra wrote:
> > > On Tue, Dec 01, 2020 at 03:55:19PM +0100, Peter Zijlstra wrote:
> > > > On Tue, Dec 01, 2020 at 06:46:44AM -0800, Paul E. McKenney wrote:
> > > > 
> > > > > > So after having talked to Sven a bit, the thing that is happening, is
> > > > > > that this is the one place where we take interrupts with RCU being
> > > > > > disabled. Normally RCU is watching and all is well, except during idle.
> > > > > 
> > > > > Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
> > > > > Or did this fall victim to recent optimizations?
> > > > 
> > > > It does, but the problem is that s390 is still using
> > > 
> > > I might've been too quick there, I can't actually seem to find where
> > > s390 does rcu_irq_enter()/exit().
> > > 
> > > Also, I'm thinking the below might just about solve the current problem.
> > > The next problem would then be it calling TRACE_IRQS_ON after it did
> > > rcu_irq_exit()... :/
> > 
> > I gave this patch a go under QEMU TCG atop v5.10-rc6 s390 defconfig with
> > PROVE_LOCKING and DEBUG_ATOMIC_SLEEP. It significantly reduces the
> > number of lockdep splats, but IIUC we need to handle the io_int_handler
> > path in addition to the ext_int_handler path, and there's a remaining
> > lockdep splat (below).
> 
> I'm amazed it didn't actually make things worse, given how I failed to
> spot do_IRQ() was arch code etc..
> 
> > If this ends up looking like we'll need more point-fixes, I wonder if we
> > should conditionalise the new behaviour of the core idle code under a
> > new CONFIG symbol for now, and opt-in x86 and arm64, then transition the
> > rest once they've had a chance to test. They'll still be broken in the
> > mean time, but no more so than they previously were.
> 
> We can do that I suppose... :/

Well, the following small patch works for me (plus an additional call to
trace_hardirqs_on() in our udelay implementation - but that's probably
independent).
Is there a reason why this should be considered broken?

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
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 2b85096964f8..5bd8c1044d09 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -123,7 +123,6 @@ void arch_cpu_idle_enter(void)
 void arch_cpu_idle(void)
 {
 	enabled_wait();
-	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_exit(void)
