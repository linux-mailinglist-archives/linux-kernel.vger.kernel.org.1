Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062DD26AD31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgIOTLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:11:41 -0400
Received: from foss.arm.com ([217.140.110.172]:42260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgIOTFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:05:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6369A12FC;
        Tue, 15 Sep 2020 12:05:07 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2C53F718;
        Tue, 15 Sep 2020 12:05:06 -0700 (PDT)
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
In-reply-to: <20200914100340.17608-1-vincent.guittot@linaro.org>
Date:   Tue, 15 Sep 2020 20:05:03 +0100
Message-ID: <jhjeen26eu8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,

On 14/09/20 11:03, Vincent Guittot wrote:
> When the system doesn't have enough cycles for all tasks, the scheduler
> must ensure a fair split of those CPUs cycles between CFS tasks. The
> fairness of some use cases can't be solved with a static distribution of
> the tasks on the system and requires a periodic rebalancing of the system
> but this dynamic behavior is not always optimal and the fair distribution
> of the CPU's time is not always ensured.
>
> The patchset improves the fairness by decreasing  the constraint for
> selecting migratable tasks with the number of failed load balance. This
> change enables then to decrease the imbalance threshold because 1st LB
> will try to migrate tasks that fully match the imbalance.
>
> Some tests results:
>
> - small 2 x 4 cores arm64 system
>
> hackbench -l (256000/#grp) -g #grp
>
> grp    tip/sched/core         +patchset             improvement
> 1      1.420(+/- 11.72 %)     1.382(+/-10.50 %)     2.72 %
> 4      1.295(+/-  2.72 %)     1.218(+/- 2.97 %)     0.76 %
> 8      1.220(+/-  2.17 %)     1.218(+/- 1.60 %)     0.17 %
> 16     1.258(+/-  1.88 %)     1.250(+/- 1,78 %)     0.58 %
>
>
> fairness tests: run always running rt-app threads
> monitor the ratio between min/max work done by threads
>
>                   v5.9-rc1             w/ patchset
> 9 threads  avg     78.3% (+/- 6.60%)   91.20% (+/- 2.44%)
>            worst   68.6%               85.67%
>
> 11 threads avg     65.91% (+/- 8.26%)  91.34% (+/- 1.87%)
>            worst   53.52%              87.26%
>
> - large 2 nodes x 28 cores x 4 threads arm64 system
>
> The hackbench tests that I usually run as well as the sp.C.x and lu.C.x
> tests with 224 threads have not shown any difference with a mix of less
> than 0.5% of improvements or regressions.
>

Few nitpicks from my end, but no major objections - this looks mostly
sane to me.

> Vincent Guittot (4):
>   sched/fair: relax constraint on task's load during load balance
>   sched/fair: reduce minimal imbalance threshold
>   sched/fair: minimize concurrent LBs between domain level
>   sched/fair: reduce busy load balance interval
>
>  kernel/sched/fair.c     | 7 +++++--
>  kernel/sched/topology.c | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
