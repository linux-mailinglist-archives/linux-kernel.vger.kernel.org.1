Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A1828B3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbgJLLhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbgJLLhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:37:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zPpLP0+NUwOV83nO78HF3zKSAodWhkOtBFlzeTD80SY=; b=mB7iNleTXBwzo2fgSU/la+h9f+
        F5jbgvZl+wvtzJA2mlrKOBODwSLumwpM9ZPulYMUePvavTBpIKMiZ9kpb4lY3sS/LhqTO04SsysCZ
        VAu9uRGF/TyaFzkPfNhNCVJTodAseQbpduzLwdH7xWCFwi7OYE/6K6RXfIx5IjWdwi76D3FD2Km3x
        MZauwMOazYugadvYverJe0UxUCZzZRLJgbGw4o4zSsATPiHbZThSXfJhIDJ1edFO77dzRMFuQVA8r
        d6CTtDHq1JQI/dvH53UxImyh5OrSCRSPwDJf37sQ/xV5fL3Ri2p72Ra7a3d4eBNX0NkLRycAX2l5c
        AQjBQ7/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRw8Q-0000eq-To; Mon, 12 Oct 2020 11:36:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F586304BAE;
        Mon, 12 Oct 2020 13:36:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 447E420A2950F; Mon, 12 Oct 2020 13:36:57 +0200 (CEST)
Date:   Mon, 12 Oct 2020 13:36:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 10/17] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
Message-ID: <20201012113657.GV2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150921.960169379@infradead.org>
 <CH2PR14MB41833F828B4D3BA5A7B6CE7B9A0B0@CH2PR14MB4183.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR14MB41833F828B4D3BA5A7B6CE7B9A0B0@CH2PR14MB4183.namprd14.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 01:22:00AM +0800, Tao Zhou wrote:
> On Mon, Oct 05, 2020 at 04:57:27PM +0200, Peter Zijlstra wrote:
> > +/*
> > + * This function is wildly self concurrent, consider at least 3 times.
> > + */
> 
> More than that

Probably. I meant to write a coherent comment, but it got very long and
not so very coherent.

It should probably enumerate all the various cases with diagrams like
those in this email:

  https://lkml.kernel.org/r/jhj3637lzdm.mognet@arm.com

So we have:

 - set_affinity() vs migrate_disable()
 - set_affinity() + N*set_affinity() vs migrate_disable()
   (ie. N additional waiters)
 - set_affinity() vs migrate_disable() vs set_affinity()
   (ie. the case from the above email)

And possibly some others.

If you have cycles to spend on writing that comment, that'd be great,
otherwise it'll stay on the todo list for a little while longer.

> > +static int affine_move_task(struct rq *rq, struct rq_flags *rf,
> > +			    struct task_struct *p, int dest_cpu, unsigned int flags)
> > +{
> > +	struct set_affinity_pending my_pending = { }, *pending = NULL;
> > +	struct migration_arg arg = {
> > +		.task = p,
> > +		.dest_cpu = dest_cpu,
> > +	};
> > +	bool complete = false;
> > +
> > +	/* Can the task run on the task's current CPU? If so, we're done */
> > +	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> > +		pending = p->migration_pending;
> > +		if (pending) {
> > +			p->migration_pending = NULL;
> > +			complete = true;
> > +		}
> > +		task_rq_unlock(rq, p, rf);
> > +
> > +		if (complete)
> > +			goto do_complete;
> > +
> > +		return 0;
> > +	}
> > +
> > +	if (!(flags & SCA_MIGRATE_ENABLE)) {
> > +		/* serialized by p->pi_lock */
> > +		if (!p->migration_pending) {
> > +			refcount_set(&my_pending.refs, 1);
> > +			init_completion(&my_pending.done);
> > +			p->migration_pending = &my_pending;
> > +		} else {
> > +			pending = p->migration_pending;
> 
> The above load can be omited, no ?
> 
> > +			refcount_inc(&pending->refs);

That would put ^ in trouble...

> > +		}
> > +	}
> > +	pending = p->migration_pending;
