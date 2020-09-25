Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C006727847C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIYJ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A314C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O4BPsI0ywNAvUxqgeLw3VCGMfjCiwlBP2my+mf2Wvug=; b=U68x3N1d4kfWLJAW4yfwlp6PYh
        /jC2zzbq5mmfMLBu0zrs0DujqZqTNv6jZrEDGwwOVuB9VKCqlIpP0q3lnXg8iIgIJfHP9NA2RNtSK
        +cHkessRty0c8PytddTldWWSZi4iEDi211trGTtv3nZNbFgiI54898UYaFDgfksPphhK1q5Sv8tEy
        LZ3bzKv0mlH5Iv9uH3Ny8u9hUYJx/o8au/BEGXmLhE8tf3zXeN9Y+COhNSqsshtl/7LS0aR4XLdAE
        Qt+FXlu/stL3eyIDwFgWSOMJ9xvwv4GwnvKyqMByDEqSjyE0BhDk/eWtAQCiJcV9zK+RCoyRwqCo0
        34+2hvIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLkSf-0002iF-6d; Fri, 25 Sep 2020 09:56:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7B14305C16;
        Fri, 25 Sep 2020 11:56:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CDDA203EB17E; Fri, 25 Sep 2020 11:56:15 +0200 (CEST)
Date:   Fri, 25 Sep 2020 11:56:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 8/9] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
Message-ID: <20200925095615.GA2651@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.830487105@infradead.org>
 <jhj3637lzdm.mognet@arm.com>
 <20200925090528.GV2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925090528.GV2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:05:28AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 08:59:33PM +0100, Valentin Schneider wrote:
> > > @@ -2025,19 +2138,8 @@ static int __set_cpus_allowed_ptr(struct
> > >       if (cpumask_test_cpu(task_cpu(p), new_mask))
> > >               goto out;
> > 
> > I think this needs a cancellation of any potential pending migration
> > requests. Consider a task P0 running on CPU0:
> > 
> >    P0                     P1                               P2
> > 
> >    migrate_disable();
> >    <preempt>
> >                           set_cpus_allowed_ptr(P0, CPU1);
> >                           // waits for completion
> >                                                            set_cpus_allowed_ptr(P0, CPU0);
> >                                                            // Already good, no waiting for completion
> >    <resumes>
> >    migrate_enable();
> >    // task_cpu(p) allowed, no move_task()
> > 
> > AIUI in this scenario P1 would stay forever waiting.
> 

> The other approach is trying to handle that last condition in
> move_task(), but I'm quite sure that's going to be aweful too :/

Something like so perhaps?

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2039,6 +2039,10 @@ static int move_task(struct rq *rq, stru
 	if (WARN_ON_ONCE(!pending))
 		return -EINVAL;
 
+	/* Can the task run on the task's current CPU? If so, we're done */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
+		goto easy;
+
 	arg.done = &pending->done;
 
 	if (flags & SCA_MIGRATE_ENABLE) {
@@ -2063,6 +2067,7 @@ static int move_task(struct rq *rq, stru
 			if (task_on_rq_queued(p))
 				rq = move_queued_task(rq, rf, p, dest_cpu);
 
+easy:
 			p->migration_pending = NULL;
 			complete = true;
 		}
@@ -2151,10 +2156,6 @@ static int __set_cpus_allowed_ptr(struct
 			p->nr_cpus_allowed != 1);
 	}
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask))
-		goto out;
-
 	return move_task(rq, &rf, p, dest_cpu, flags);
 
 out:
