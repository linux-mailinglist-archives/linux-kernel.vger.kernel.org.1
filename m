Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFC201969
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392314AbgFSRZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 13:25:30 -0400
Received: from foss.arm.com ([217.140.110.172]:49546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbgFSRZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:25:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26B9DD6E;
        Fri, 19 Jun 2020 10:25:29 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78B443F71F;
        Fri, 19 Jun 2020 10:25:27 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:25:25 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619172524.y66a4hz6g6hr3thr@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-3-qais.yousef@arm.com>
 <jhjwo43cpfl.mognet@arm.com>
 <20200619125148.y4cq3hwllgozbutq@e107158-lin.cambridge.arm.com>
 <jhjsgerchmn.mognet@arm.com>
 <20200619141348.5o5iqomwe6lofgiu@e107158-lin.cambridge.arm.com>
 <jhjr1ubccg2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjr1ubccg2.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 16:17, Valentin Schneider wrote:

[...]

> > But here this is
> > just extra churn.
> >
> > If an imbalance has happend this means either:
> >
> >       1. enqueue/dequeue_task() is imablanced itself
> >       2. uclamp_update_active() calls dec without inc.
> >
> > If 1 happened we have more reasons to be worried about. For 2 the function
> > takes task_rq_lock() and does dec/inc in obvious way.
> >
> 
> True. I won't argue over the feasibility of the scenarios we are currently
> aware of, my point was that if they do happen, it's nice to have debug
> helps in the right places as the final breakage can happen much further
> downstream.
> 
> FWIW I don't like the diff I suggested at all, but if we can come up with a
> cleverer scheme I think we should do it, as per the above.

There's the fact as well that this whole thing is to deal with potentially
avoid doing anything that is stricly not necessary in the fast path.

keep in mind that my patch of introducing the sysctl is not accepted yet
because it introduces such thing, but in that case it's not a debug only
feature. CONFIG_SCHED_DEBUG do get enabled by distros because it exports a lot
of useful info.

--
Qais Yousef
