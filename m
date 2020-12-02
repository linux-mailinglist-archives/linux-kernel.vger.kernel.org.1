Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C512CBEA6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgLBNrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:47:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16724 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgLBNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:47:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2DVmLP083465;
        Wed, 2 Dec 2020 08:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CPYBV9GU6OHg3eIE8AyprEnCWEvhvhy00L9x6GkTAEk=;
 b=eCGF4LX5ox5URpf3Clex7PnKp5RNNLfRhlEiBTiQeBHFRTc4Dgkc/LfTOs9bMNj6xEHc
 RDlR94XsCqVhEgckKzayxesOd/uSsfLs74ydio7K9VlMuEH73pcpRy1E1yShFG2LEeHQ
 891Pcdflq5uxwGRBm3sg8xHV+iS7e8x90grqPs0spAXgCkTi5zY/JKBb2CM5CcA80HIf
 ymTrYkpZ3yAqbOc3jhngRadYsIJsy3+cr3tnFsLae4A1sEe4THt/C/AvpyynmTs7LqQX
 2mr6jxHeln0QlevxVthEs4l1q+l7f+Biyr7OXByVplmJo/VzwIIGwU/MxnVpiL7bnKdz cw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3567ypqrf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 08:46:11 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2DgTE6029966;
        Wed, 2 Dec 2020 13:46:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 35693xg53g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 13:46:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2Dk6Dc3473994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 13:46:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62C2E4C05E;
        Wed,  2 Dec 2020 13:46:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 094F94C040;
        Wed,  2 Dec 2020 13:46:06 +0000 (GMT)
Received: from osiris (unknown [9.171.20.32])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 13:46:05 +0000 (GMT)
Date:   Wed, 2 Dec 2020 14:46:04 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202134604.GC6202@osiris>
References: <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
 <20201201185737.GA93208@C02TD0UTHF1T.local>
 <20201201191441.GW3040@hirez.programming.kicks-ass.net>
 <20201201191856.GD8316@osiris>
 <20201202092116.GA3040@hirez.programming.kicks-ass.net>
 <20201202105649.GB6202@osiris>
 <20201202111605.GA63790@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202111605.GA63790@C02TD0UTHF1T.local>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=1 phishscore=0 mlxlogscore=279 bulkscore=0 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:16:05AM +0000, Mark Rutland wrote:
> On Wed, Dec 02, 2020 at 11:56:49AM +0100, Heiko Carstens wrote:
> > From 7bd86fb3eb039a4163281472ca79b9158e726526 Mon Sep 17 00:00:00 2001
> > From: Heiko Carstens <hca@linux.ibm.com>
> > Date: Wed, 2 Dec 2020 11:46:01 +0100
> > Subject: [PATCH] s390: fix irq state tracing
> > 
> > With commit 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs
> > tracing") common code calls arch_cpu_idle() with a lockdep state that
> > tells irqs are on.
> > 
> > This doesn't work very well for s390: psw_idle() will enable interrupts
> > to wait for an interrupt. As soon as an interrupt occurs the interrupt
> > handler will verify if the old context was psw_idle(). If that is the
> > case the interrupt enablement bits in the old program status word will
> > be cleared.
> > 
> > A subsequent test in both the external as well as the io interrupt
> > handler checks if in the old context interrupts were enabled. Due to
> > the above patching of the old program status word it is assumed the
> > old context had interrupts disabled, and therefore a call to
> > TRACE_IRQS_OFF (aka trace_hardirqs_off_caller) is skipped. Which in
> > turn makes lockdep incorrectly "think" that interrupts are enabled
> > within the interrupt handler.
> > 
> > Fix this by unconditionally calling TRACE_IRQS_OFF when entering
> > interrupt handlers. Also call unconditionally TRACE_IRQS_ON when
> > leaving interrupts handlers.
> > 
> > This leaves the special psw_idle() case, which now returns with
> > interrupts disabled, but has an "irqs on" lockdep state. So callers of
> > psw_idle() must adjust the state on their own, if required. This is
> > currently only __udelay_disabled().
> > 
> > Fixes: 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs tracing")
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> FWIW, this makes sense to me from what I had to chase on the arm64 side,
> and this seems happy atop v5.10-rc6 with all the lockdep and RCU debug
> options enabled when booting to userspace under QEMU.
> 
> Thanks,
> Mark.

Thanks a lot for having a look and testing this!
