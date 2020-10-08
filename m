Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85211287CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgJHTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgJHTsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:48:23 -0400
Received: from localhost (i15-lef02-th2-89-83-218-254.ft.lns.abo.bbox.fr [89.83.218.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DEF3221FD;
        Thu,  8 Oct 2020 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602186502;
        bh=BTeLevHpVqiAww66o52yvDVIXekJ4KK/OnGhnEnqV6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3imO/BGRTzFBACw+eqDWVFQ1/ztowfqY6jbxJrKQWkFj6kqphn2HdfKQ1e/gBqI0
         Ye33Z3je5cCFLGEQQ05VPhCDvz5hISl6NP5l8QwFFfrIAW92aU87n2zsT8hx0Od5ou
         r3tjzQL1cggSNwxH5DnqzTX7AtgUqNDbDNH4II/Q=
Date:   Thu, 8 Oct 2020 21:48:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008194819.GA86389@lothringen>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008145940.GG6026@xz-x1>
 <20201008152844.GB2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008152844.GB2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 05:28:44PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 08, 2020 at 10:59:40AM -0400, Peter Xu wrote:
> > On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> > > +static void tick_nohz_kick_task(struct task_struct *tsk)
> > > +{
> > > +	int cpu = task_cpu(tsk);
> > > +
> > > +	/*
> > > +	 * If the task concurrently migrates to another cpu,
> > > +	 * we guarantee it sees the new tick dependency upon
> > > +	 * schedule.
> > > +	 *
> > > +	 *
> > > +	 * set_task_cpu(p, cpu);
> > > +	 *   STORE p->cpu = @cpu
> > > +	 * __schedule() (switch to task 'p')
> > > +	 *   LOCK rq->lock
> > > +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> > > +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> > > +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> > > +	 */
> > > +
> > > +	preempt_disable();
> > 
> > Pure question: is preempt_disable() required here?  Same question to
> > tick_nohz_full_kick_all().
> 
> I think it serializes against hotplug.

Exactly!

Thanks.
