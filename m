Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4032CBCFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgLBM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgLBM2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:28:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E4C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7WH0kv+LfkLHJaqQQ0H5sk5+tTeHFM9URpx9/ubjxw0=; b=VYThr8uZf2g1Oa5NTsmPaFI/Xn
        uVr8TBCXbAJVe2ecnyv2ABHQvHAYLOFYKzG2/f5IfDhQWzWxatJMtD0MkLX8qgKikKZE5xVELqKQt
        AlIiyrhJDDAHImqWyq/Md3mLT8RdGKZlD/Q0eOMtYGYsFft0BjtDEmjP0QHldp0v1kHBQ9LqgbiuX
        KMI3VIg1xCwW5NO7683KkfP2gMeKddlt2XXLHgqemrpqkkYRji5/wulQbdw9/kch/PJVKOXEZ0Z5i
        LBakgEMfgRZtacQdP7dswNGLpV8cagVbW0vIRB/kI1IIjL7+sgDan37Pv9VvbQudYnIAZQjDLYZ8Y
        zPp/Gf4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkREO-00052S-H9; Wed, 02 Dec 2020 12:27:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A07A0305815;
        Wed,  2 Dec 2020 13:27:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 893EE2143477A; Wed,  2 Dec 2020 13:27:34 +0100 (CET)
Date:   Wed, 2 Dec 2020 13:27:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202122734.GH3021@hirez.programming.kicks-ass.net>
References: <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
 <20201201185737.GA93208@C02TD0UTHF1T.local>
 <20201201191441.GW3040@hirez.programming.kicks-ass.net>
 <20201201191856.GD8316@osiris>
 <20201202092116.GA3040@hirez.programming.kicks-ass.net>
 <20201202105649.GB6202@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202105649.GB6202@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:56:49AM +0100, Heiko Carstens wrote:
> From 7bd86fb3eb039a4163281472ca79b9158e726526 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Wed, 2 Dec 2020 11:46:01 +0100
> Subject: [PATCH] s390: fix irq state tracing
> 
> With commit 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs
> tracing") common code calls arch_cpu_idle() with a lockdep state that
> tells irqs are on.
> 
> This doesn't work very well for s390: psw_idle() will enable interrupts
> to wait for an interrupt. As soon as an interrupt occurs the interrupt
> handler will verify if the old context was psw_idle(). If that is the
> case the interrupt enablement bits in the old program status word will
> be cleared.
> 
> A subsequent test in both the external as well as the io interrupt
> handler checks if in the old context interrupts were enabled. Due to
> the above patching of the old program status word it is assumed the
> old context had interrupts disabled, and therefore a call to
> TRACE_IRQS_OFF (aka trace_hardirqs_off_caller) is skipped. Which in
> turn makes lockdep incorrectly "think" that interrupts are enabled
> within the interrupt handler.
> 
> Fix this by unconditionally calling TRACE_IRQS_OFF when entering
> interrupt handlers. Also call unconditionally TRACE_IRQS_ON when
> leaving interrupts handlers.
> 
> This leaves the special psw_idle() case, which now returns with
> interrupts disabled, but has an "irqs on" lockdep state. So callers of
> psw_idle() must adjust the state on their own, if required. This is
> currently only __udelay_disabled().
> 
> Fixes: 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs tracing")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thanks for sorting this Heiko!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
