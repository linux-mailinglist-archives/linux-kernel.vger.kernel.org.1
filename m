Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2058E26F826
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRI26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:28:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0106C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DZmGlO+RbJQsQu3+LJgWKifaLNWef/p/ielujG+rOJI=; b=bFKJwebFcMyDv0k+pEwTJGRQDh
        AFbiuHvv43PtNXZRXrdoC1vDCGy+yRJgANIZDmpObmmu/E6L/Q4St4I6Qxm0/HMV++9mFMDWhCMuA
        HnliEquXO1hb7I8GRo53zY/uURFmvAzFQq9EO7jwvVY+4QecUde1eCCd9Qqmu1DzZBWtuZgBiDX89
        Bpsv3cV76sfNgf/Ps9jO6ouizcb1m4ivJRKFTAKgQV4VmjbDmbi8BPAUVNxuL6a0SkyVq4xT2/B7V
        70SYfei1R+xGEU4EcAuhznbGHgNvRPghILBXSjiNzbuXrbd7jzEbQoH54I6YljiifyGnWWDfeqnaC
        5Ntxmulg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJBl7-0007Uf-Sk; Fri, 18 Sep 2020 08:28:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB8D9303A02;
        Fri, 18 Sep 2020 10:28:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85A1C2C8469ED; Fri, 18 Sep 2020 10:28:43 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:28:43 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20200918082843.GM1362448@hirez.programming.kicks-ass.net>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
 <87bli3y3gs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bli3y3gs.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 09:00:03AM +0200, Thomas Gleixner wrote:

> >> +void migrate_disable(void)
> >> +{
> >> +	unsigned long flags;
> >> +
> >> +	if (!current->migration_ctrl.disable_cnt) {
> >> +		raw_spin_lock_irqsave(&current->pi_lock, flags);
> >> +		current->migration_ctrl.disable_cnt++;
> >> +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);
> >> +	} else {
> >> +		current->migration_ctrl.disable_cnt++;
> >> +	}
> >> +}
> >
> > That pi_lock seems unfortunate, and it isn't obvious what the point of
> > it is.
> 
> Indeed. That obviously lacks a big fat comment.
> 
> current->migration_ctrl.disable_cnt++ is obviously a RMW operation. So
> you end up with the following:
> 
> CPU0                                            CPU1
> migrate_disable()
>    R = current->migration_ctrl.disable_cnt;
>                                                 set_cpus_allowed_ptr()
>                                                   task_rq_lock();
>                                                   if
>                                                   (!p->migration_ctrl.disable_cnt) {
>    current->migration_ctrl.disable_cnt = R + 1;
>    							stop_one_cpu();
> ---> stopper_thread()
>         BUG_ON(task->migration_ctrl.disable_cnt);
> 
> I tried to back out from that instead of BUG(), but that ended up being
> even more of a hacky trainwreck than just biting the bullet and taking
> pi_lock.

You don't need the load-store for that I think, pure timing will do.
Blergh, lemme prepare more wake-up juice and think about that.

