Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1A26F80A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIRIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:22:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24376C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+nEbGZiGxKWrC4UKDrpypXmTMi/0BYCVQEm5cXdl7Ew=; b=VtAcJLNpZWqZfkEyBIBiNV8Lxn
        37hOc7x6VZxi9QBMRR3ANjLYxSM2arI6H+sEpMBki4Wb8QT3aOtO4+E8+wP0Ugm8goMwYwPMExqA0
        dt2IFLLF/we5wVcZzDC6JwlVyiMSP0haQXiXxs/hjiGeTe77b53SSJysP7cDwr6IDlfP9+6HdcOKn
        2BkTCbVpgtjJk+XOiTph7kf6bw3Ey6FnYjmsL9pKOM5KcUkBkTNeSNN3a8fDrdy6Ypu3YfwJ5DvF4
        N5oDcNhn8fpfyOg3NrlfFcNnl78RnZLdjA9gs+uOZ5JUW8PutedN76D8XQpgJ696UGowo70bchBNC
        KTVpqvWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJBf9-0008Jv-Cm; Fri, 18 Sep 2020 08:22:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56F0F304B92;
        Fri, 18 Sep 2020 10:22:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4482F2C8469EB; Fri, 18 Sep 2020 10:22:32 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:22:32 +0200
From:   peterz@infradead.org
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200918082232.GL1362448@hirez.programming.kicks-ass.net>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
 <20200917143850.25akkvr32ojtwohy@linutronix.de>
 <20200917144937.GI1362448@hirez.programming.kicks-ass.net>
 <20200917151341.2ilqamtnc6hperix@linutronix.de>
 <20200917155410.GK1362448@hirez.programming.kicks-ass.net>
 <20200917163001.5ksl5vjwi35ozzsv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917163001.5ksl5vjwi35ozzsv@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 06:30:01PM +0200, Sebastian Siewior wrote:
> On 2020-09-17 17:54:10 [+0200], peterz@infradead.org wrote:
> > I'm not sure what the problem with FPU was, I was throwing alternatives
> > at tglx to see what would stick, in part to (re)discover the design
> > constraints of this thing.
> 
> was this recent or distant in the time line?

The past few weeks :-) Thomas and me have been bickering about this
stuff on IRC on and off.

> > One reason for not allowing migrate_disable() to sleep was: FPU code.
> > 
> > Could it be it does something like:
> > 
> > 	preempt_disable();
> > 	spin_lock();
> > 
> > 	spin_unlock();
> > 	preempt_enable();
> > 
> > Where we'll never get preempted while migrate_disable()'d and thus never
> > trigger any of the sleep paths?
> 
> I try to get rid of something like that. This doesn't work either way
> because the spin_lock() may block which it can't with disabled
> preemption.

Yeah, that obviously should have been migrate_disable/enable instead of
spin_lock/unlock :/

> Ah. We used to have migrate_disable() in pagefault_disable(). The x86
> FPU code does
> 	preempt_disable();
> 	…
> 	pagefault_disable();
> 
> but that migrate_disable() was moved from pagefault_disable() to
> kmap_atomic(). We shouldn't have
> 	preempt_disable(); || local_irq_disable();
> 	kmap_atomic();
> 
> on RT. I've been running around removing those. See
>    a10dcebacdb0c ("fs/ntfs/aops.c: don't disable interrupts during kmap_atomic()")
>    ce1e518190ea7 ("ide: don't disable interrupts during kmap_atomic()")
>    f3a1075e5fc34 ("block: don't disable interrupts during kmap_atomic()")

Hmm, okay.
