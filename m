Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356282CA316
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390151AbgLAMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:47:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:58920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgLAMrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:47:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B775ACC2;
        Tue,  1 Dec 2020 12:46:18 +0000 (UTC)
Date:   Tue, 1 Dec 2020 12:46:14 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        qianjun.kernel@gmail.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/6] sched: make schedstats helpers independent of fair
 sched class
Message-ID: <20201201124614.GU3306@suse.de>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
 <20201201115416.26515-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201201115416.26515-5-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 07:54:14PM +0800, Yafang Shao wrote:
> The original prototype of the schedstats helpers are
> 
> update_stats_wait_*(struct cfs_rq *cfs_rq, struct sched_entity *se)
> 
> The cfs_rq in these helpers is used to get the rq_clock, and the se is
> used to get the struct sched_statistics and the struct task_struct. In
> order to make these helpers available by all sched classes, we can pass
> the rq, sched_statistics and task_struct directly.
> 
> Then the new helpers are
> 
> update_stats_wait_*(struct rq *rq, struct task_struct *p,
> 		    struct sched_statistics *stats)
> 
> which are independent of fair sched class.
> 
> To avoid vmlinux growing too large or introducing ovehead when
> !schedstat_enabled(), some new helpers after schedstat_enabled() are also
> introduced, Suggested by Mel. These helpers are in sched/stats.c,
> 
> __update_stats_wait_*(struct rq *rq, struct task_struct *p,
> 		      struct sched_statistics *stats)
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Think it's ok, it's mostly code shuffling. I'd have been happier if
there was evidence showing a before/after comparison of the sched stats
for something simple like "perf bench sched pipe" and a clear statement
of no functional change as well as a comparison of the vmlinux files but
I think it's ok so;

Acked-by: Mel Gorman <mgorman@suse.de>

I didn't look at the rt.c parts

-- 
Mel Gorman
SUSE Labs
