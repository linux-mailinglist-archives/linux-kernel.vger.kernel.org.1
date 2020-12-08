Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9182D297E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgLHLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:03:38 -0500
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:40695 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728764AbgLHLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:03:38 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 9DD8D1942
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 11:02:46 +0000 (GMT)
Received: (qmail 24492 invoked from network); 8 Dec 2020 11:02:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Dec 2020 11:02:46 -0000
Date:   Tue, 8 Dec 2020 11:02:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] sched/fair: Do not replace recent_used_cpu with the
 new target
Message-ID: <20201208110244.GH3371@techsingularity.net>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-3-mgorman@techsingularity.net>
 <842ef1db-49d1-7d05-997b-1562383cdd28@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <842ef1db-49d1-7d05-997b-1562383cdd28@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:57:29AM +0100, Dietmar Eggemann wrote:
> On 07/12/2020 10:15, Mel Gorman wrote:
> > After select_idle_sibling, p->recent_used_cpu is set to the
> > new target. However on the next wakeup, prev will be the same as
> 
> I'm confused here. Isn't current->recent_used_cpu set to 'cpu =
> smp_processor_id()' after sis()? Looking at v5.10-rc6.

If you are referring to this;

               if (want_affine)
                       current->recent_used_cpu = cpu;

then it gets removed by the path. That replaces recent_used_cpu with the
wakers CPU which still works but the hit rate is lower.

> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 23934dbac635..01b38fc17bca 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6274,6 +6274,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  
> >  	/* Check a recently used CPU as a potential idle candidate: */
> >  	recent_used_cpu = p->recent_used_cpu;
> > +	p->recent_used_cpu = prev;
> >  	if (recent_used_cpu != prev &&
> >  	    recent_used_cpu != target &&
> >  	    cpus_share_cache(recent_used_cpu, target) &&
> 
> p->recent_used_cpu is already set to prev in this if condition.
> 

That can be removed as redundant, I'll fix it.

-- 
Mel Gorman
SUSE Labs
