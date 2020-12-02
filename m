Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779112CBB24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgLBK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:56:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727886AbgLBK4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:56:34 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2AWtkh170748;
        Wed, 2 Dec 2020 05:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7zSdoLXJvbmeAQGLsIbojhT9njh96wHklxX2MYZzCWE=;
 b=PhkEL3i2V9Fs9gp6w52ORUlt0JapBanR1LYvMBUMNkpJZNR7rn2yLneBUdqso+dijICb
 n6lK9GRsNeEaew92xNAh50FllBwPXU6nT/1zjJh2N+BA0xSusbEefA6WQb8d3yOEkI9D
 5YkDaQZlKVXY9aV0JDjLoJEfDGgoMfnMh3lV2a/CLOAM9A+hFMzS+ar9WigK1zcY8itx
 8LfgA3asRJqypusr4eMCjqtlbMWEODWpRrd988msUCx/WiRz+PaWijaquhfHXKAt7gno
 T9i5umsve/v8AlSJl91t3V5JbDzvPFoVGScO/l97EUXCVsp12I1e54FcEi8uzS/93cKS 5A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355vcqvp2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:55:44 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2Aq1q9007634;
        Wed, 2 Dec 2020 10:52:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 35693xg0s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 10:52:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2AqU8L63635764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 10:52:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A8314203F;
        Wed,  2 Dec 2020 10:52:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E906942041;
        Wed,  2 Dec 2020 10:52:29 +0000 (GMT)
Received: from osiris (unknown [9.171.20.32])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 10:52:29 +0000 (GMT)
Date:   Wed, 2 Dec 2020 11:52:28 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202105228.GA6202@osiris>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <20201202075427.GA5838@osiris>
 <20201202093805.GB3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202093805.GB3040@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_04:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:38:05AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 02, 2020 at 08:54:27AM +0100, Heiko Carstens wrote:
> > > > But but but...
> > > > 
> > > >   do_idle()			# IRQs on
> > > >     local_irq_disable();	# IRQs off
> > > >     defaul_idle_call()	# IRQs off
> > > 	lockdep_hardirqs_on();	# IRQs off, but lockdep things they're on
> > > >       arch_cpu_idle()		# IRQs off
> > > >         enabled_wait()	# IRQs off
> > > > 	  raw_local_save()	# still off
> > > > 	  psw_idle()		# very much off
> > > > 	    ext_int_handler	# get an interrupt ?!?!
> > > 	      rcu_irq_enter()	# lockdep thinks IRQs are on <- FAIL
> > > 
> > > I can't much read s390 assembler, but ext_int_handler() has a
> > > TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
> > > with the actual state, but there's some condition before it, what's that
> > > test and is that right?
> > 
> > After digging a bit into our asm code: no, it is not right, and only
> > for psw_idle() it is wrong.
> > 
> > What happens with the current code:
> > 
> > - default_idle_call() calls lockdep_hardirqs_on() before calling into
> >   arch_cpu_idle()
> 
> Correct.
> 
> > - our arch_cpu_idle() calls psw_idle() which enables irqs. the irq
> >   handler will call/use the SWITCH_ASYNC macro which clears the
> >   interrupt enabled bits in the old program status word (_only_ for
> >   psw_idle)
> 
> This is the condition at 0: that compares r13 to psw_idle_exit?

Yes, exactly.

> > So I guess my patch which I sent yesterday evening should fix all that
> > mess
> 
> Yes, afaict it does the right thing. Exceptions should call
> TRACE_IRQS_OFF unconditionally, since the hardware will disable
> interrupts upon taking an exception, irrespective of what the previous
> context had.
> 
> On exception return the previous IRQ state is inspected and lockdep is
> changed to match (except for NMIs, which either are ignored by lockdep
> or need a little bit of extra care).

Yes, we do all that, except that it seems odd to test the previous
state for interrupts (not exceptions). Since for interrupts the
previous context obviously must have been enabled for interrupts.

Except if you play tricks with the old PSW, like we do :/
