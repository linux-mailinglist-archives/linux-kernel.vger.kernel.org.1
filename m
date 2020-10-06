Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72514284CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJFNtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:49:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H+rKA1C/hAizwisiqc1O7WqpHp3LalDuVAXZgHje7So=; b=BJyFKR4hUN3ADfAVMa9/LnFQWA
        dxvsz67JiD6I+emAEdYoDAbsCvI8uAwpphEMnRT0gzb/5i6hO04UOI2igBwUroI2DzFdB1wz8IGeU
        2A2YdEXr3XVseO/fDAVwTuyJ7UCHXicK2+zGwjmYXV3q2nNdA01Tee5VlFnkOP/pZ/AdtXxVZBlje
        jgDKaaoQ94NzgUXPMWuwMx9OHNPdAZSg2aaWohQfGY1FGhpkAAViBl2HTW3/tgmX3q5jP3AU0o+EG
        yN9zEZrjrT7t/KzeO3FK9VutyzpkJbFxAl70YzaAlpYWEAODEfUJ+q1Eg9LuIG+GReqgb65F8fcSL
        n5plppaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPnKn-0001sq-9H; Tue, 06 Oct 2020 13:48:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B0473006D0;
        Tue,  6 Oct 2020 15:48:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07F83203C8BE2; Tue,  6 Oct 2020 15:48:50 +0200 (CEST)
Date:   Tue, 6 Oct 2020 15:48:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201006134850.GV2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <jhjv9fnmwhg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjv9fnmwhg.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:20:43PM +0100, Valentin Schneider wrote:
> 
> On 05/10/20 15:57, Peter Zijlstra wrote:
> > In order to minimize the interference of migrate_disable() on lower
> > priority tasks, which can be deprived of runtime due to being stuck
> > below a higher priority task. Teach the RT/DL balancers to push away
> > these higher priority tasks when a lower priority task gets selected
> > to run on a freshly demoted CPU (pull).
> >
> > This adds migration interference to the higher priority task, but
> > restores bandwidth to system that would otherwise be irrevocably lost.
> > Without this it would be possible to have all tasks on the system
> > stuck on a single CPU, each task preempted in a migrate_disable()
> > section with a single high priority task running.
> >
> > This way we can still approximate running the M highest priority tasks
> > on the system.
> >
> 
> Ah, so IIUC that's the important bit that makes it we can't just say go
> through the pushable_tasks list and skip migrate_disable() tasks.
> 
> Once the highest-prio task exits its migrate_disable() region, your patch
> pushes it away. If we ended up with a single busy CPU, it'll spread the
> tasks around one migrate_enable() at a time.
> 
> That time where the top task is migrate_disable() is still a crappy time,
> and as you pointed out earlier today if it is a genuine pcpu task then the
> whole thing is -EBORKED...
> 
> An alternative I could see would be to prevent those piles from forming
> altogether, say by issuing a similar push_cpu_stop() on migrate_disable()
> if the next pushable task is already migrate_disable(); but that's a
> proactive approach whereas yours is reactive, so I'm pretty sure that's
> bound to perform worse.

I think it is always possible to form pileups. Just start enough tasks
such that newer, higher priority, tasks have to preempt existing tasks.

Also, we might not be able to place the task elsewhere, suppose we have
all our M CPUs filled with an RT task, then when the lowest priority
task has migrate_disable(), wake the highest priority task.

Per the SMP invariant, this new highest priority task must preempt the
lowest priority task currently running, otherwise we would not be
running the M highest prio tasks.

That's not to say it might not still be beneficial from trying to avoid
them, but we must assume a pilup will occur, therefore my focus was on
dealing with them as best we can first.
