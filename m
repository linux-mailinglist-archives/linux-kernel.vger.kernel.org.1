Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F82DE4F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgLROhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgLROhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:37:14 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843EC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pJ3nANek39x6hzX8wtL0F6s3DjEZJFtQAucDRnn+S1U=; b=0WopPkPDVtBzmNUuWrNVQstsVS
        KOCqQ4gDLUFQL5nkcNpOInd+S01ZptqZNjNKYp4tUDSR/SMjeAR3JdG/KBDhdaZ1dZLinqi/SPpYo
        nL5rOSYGeaFCYcPfrS7yamPSccc9VeIh4JogeOzsYK4MclhGrRiVyGHshdeMJJv8DAPqUDzvv/u+q
        6povzaBtXw+P8tigFCh6ZMmSRuz+SSh7uQSX/jYaCqPed5UW2UbleVy8vc7kDSOSaJUXEEXl2h00+
        JMsiFpsO5Xq0y0PQpRJGrJiAVoHci2Ro9GrhGiIGB/g//6glUWjOiM4QVKJJT841TNJG/jFWNdzXq
        4LMkwJZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqGrJ-00049b-Iu; Fri, 18 Dec 2020 14:35:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77A5D305C11;
        Fri, 18 Dec 2020 15:35:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D78F200926C1; Fri, 18 Dec 2020 15:35:49 +0100 (CET)
Date:   Fri, 18 Dec 2020 15:35:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Xuewen Yan <Xuewen.Yan@unisoc.com>
Subject: Re: [PATCH v3] sched/fair: Avoid stale CPU util_est value for
 schedutil in task dequeue
Message-ID: <20201218143549.GH3021@hirez.programming.kicks-ass.net>
References: <1608283672-18240-1-git-send-email-xuewen.yan94@gmail.com>
 <CAKfTPtC9bfoMeYhhmjQoZyPRYvWLa=4L4qFC_B4vWUMRh8nz4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC9bfoMeYhhmjQoZyPRYvWLa=4L4qFC_B4vWUMRh8nz4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 02:12:50PM +0100, Vincent Guittot wrote:
> On Fri, 18 Dec 2020 at 10:28, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > From: Xuewen Yan <xuewen.yan@unisoc.com>
> >
> > CPU (root cfs_rq) estimated utilization (util_est) is currently used in
> > dequeue_task_fair() to drive frequency selection before it is updated.
> >
> > with:
> >
> > CPU_util        : rq->cfs.avg.util_avg
> > CPU_util_est    : rq->cfs.avg.util_est
> > CPU_utilization : max(CPU_util, CPU_util_est)
> > task_util       : p->se.avg.util_avg
> > task_util_est   : p->se.avg.util_est
> >
> > dequeue_task_fair():
> >
> >     /* (1) CPU_util and task_util update + inform schedutil about
> >            CPU_utilization changes */
> >     for_each_sched_entity() /* 2 loops */
> >         (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change()
> >          -> cpufreq_update_util() ->...-> sugov_update_[shared\|single]
> >          -> sugov_get_util() -> cpu_util_cfs()
> >
> >     /* (2) CPU_util_est and task_util_est update */
> >     util_est_dequeue()
> >
> > cpu_util_cfs() uses CPU_utilization which could lead to a false (too
> > high) utilization value for schedutil in task ramp-down or ramp-up
> > scenarios during task dequeue.
> >
> > To mitigate the issue split the util_est update (2) into:
> >
> >  (A) CPU_util_est update in util_est_dequeue()
> >  (B) task_util_est update in util_est_update()
> >
> > Place (A) before (1) and keep (B) where (2) is. The latter is necessary
> > since (B) relies on task_util update in (1).
> >
> 
> maybe add a
> Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
> 
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
