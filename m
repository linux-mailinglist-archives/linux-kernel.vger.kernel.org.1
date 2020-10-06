Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8730284CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFNot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFNot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:44:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5936920760;
        Tue,  6 Oct 2020 13:44:47 +0000 (UTC)
Date:   Tue, 6 Oct 2020 09:44:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl
 balancing
Message-ID: <20201006094445.09c8b3b9@gandalf.local.home>
In-Reply-To: <20201006075939.GL2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
        <20201005150922.458081448@infradead.org>
        <20201006075939.GL2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 09:59:39 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 05, 2020 at 04:57:32PM +0200, Peter Zijlstra wrote:
> > +static inline struct task_struct *get_push_task(struct rq *rq)
> > +{
> > +	struct task_struct *p = rq->curr;
> > +
> > +	lockdep_assert_held(&rq->lock);
> > +
> > +	if (rq->push_busy)
> > +		return NULL;
> > +
> > +	if (p->nr_cpus_allowed == 1)
> > +		return NULL;  
> 
> This; that means what when we're stuck below a per-cpu thread, we're
> toast. There's just nothing much you can do... :/

Well, hopefully, per CPU threads don't run for long periods of time. I'm
working with folks having issues of running non stop RT threads that every
so often go into the kernel kicking off per CPU kernel threads that now get
starved when the RT tasks go back to user space, causing the rest of the
system to hang.

As I've always said. When dealing with real-time systems, you need to be
careful about how you organize your tasks. Ideally, any RT task that is
pinned to a CPU shouldn't be sharing that CPU with anything else that may
be critical.

-- Steve


> 
> > +
> > +	rq->push_busy = true;
> > +	return get_task_struct(p);
> > +}  

