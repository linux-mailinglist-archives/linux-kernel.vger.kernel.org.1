Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32872CB5FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbgLBHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:55:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37678 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgLBHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:55:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B27Vo4j146982;
        Wed, 2 Dec 2020 02:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=evv0OZWkwEnHVG6q4bdHBEiJX/u2QRJYlOWfkqcKV68=;
 b=YPvsTAju5O+WLK5bWLJlR2w8vM9cGo+VcQ2P3lKn2bOprEttHWpyUHknd6M9h8mpMIsT
 3OyvKXzFMApsmpGCxC/XsjV0Tqp3mBLwWu6T+YOULuXDYi+avH2FEMguGemW0sKx0iHx
 zqUTETBZPsIImVLhm/SA1CGHttr11psjMf8L9jZsFiSbLra7y92XpL5LdJpUQ4vGbXWt
 POEwf9PfugpahY15cV2MnMyqFuo9b+1dubWWSR4vp3rdY+A2qNRnIGh72FY/FCP0MBYj
 jKCxdHtxY81VEOquHDGL+Z0bJfAMNCkdFjnaxnLuQ0EtPRe+yvxBOG5EHu2SPaBwNEwC eQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355d9e3882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 02:54:34 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B27q5GL008168;
        Wed, 2 Dec 2020 07:54:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpdar80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 07:54:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B27sTu66750972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 07:54:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C86C5A405B;
        Wed,  2 Dec 2020 07:54:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C0D6A4054;
        Wed,  2 Dec 2020 07:54:29 +0000 (GMT)
Received: from osiris (unknown [9.171.59.193])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 07:54:29 +0000 (GMT)
Date:   Wed, 2 Dec 2020 08:54:27 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202075427.GA5838@osiris>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_01:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=996
 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012020042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > But but but...
> > 
> >   do_idle()			# IRQs on
> >     local_irq_disable();	# IRQs off
> >     defaul_idle_call()	# IRQs off
> 	lockdep_hardirqs_on();	# IRQs off, but lockdep things they're on
> >       arch_cpu_idle()		# IRQs off
> >         enabled_wait()	# IRQs off
> > 	  raw_local_save()	# still off
> > 	  psw_idle()		# very much off
> > 	    ext_int_handler	# get an interrupt ?!?!
> 	      rcu_irq_enter()	# lockdep thinks IRQs are on <- FAIL
> 
> I can't much read s390 assembler, but ext_int_handler() has a
> TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
> with the actual state, but there's some condition before it, what's that
> test and is that right?

After digging a bit into our asm code: no, it is not right, and only
for psw_idle() it is wrong.

What happens with the current code:

- default_idle_call() calls lockdep_hardirqs_on() before calling into
  arch_cpu_idle()

- our arch_cpu_idle() calls psw_idle() which enables irqs. the irq
  handler will call/use the SWITCH_ASYNC macro which clears the
  interrupt enabled bits in the old program status word (_only_ for
  psw_idle)

- this again causes the interrupt handler to _not_ call TRACE_IRQS_OFF
  and therefore lockdep thinks interrupts are enabled within the
  interrupt handler

So I guess my patch which I sent yesterday evening should fix all that
mess - plus an explicit trace_hardirqs_off() call in our udelay
implementation is required now.

I'll send a proper patch later.
