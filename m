Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220792FB869
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393093AbhASMce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:32:34 -0500
Received: from foss.arm.com ([217.140.110.172]:54870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404319AbhASMZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:25:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31A2A1396;
        Tue, 19 Jan 2021 04:24:44 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322033F719;
        Tue, 19 Jan 2021 04:24:43 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is pinned
In-Reply-To: <20210119120755.2425264-1-qais.yousef@arm.com>
References: <20210119120755.2425264-1-qais.yousef@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 19 Jan 2021 12:24:38 +0000
Message-ID: <jhjpn213yih.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nit: Topic should probably be sched/fair - not many other than us
loonies talk about EAS, and misfit stuff doesn't require an energy
model, only CPU capacity asymmetry.

On 19/01/21 12:07, Qais Yousef wrote:
> If the task is pinned to a cpu, setting the misfit status means that
> we'll unnecessarily continuously attempt to migrate the task but fail.
>
> This continuous failure will cause the balance_interval to increase to
> a high value, and eventually cause unnecessary significant delays in
> balancing the system when real imbalance happens.
>
> Caught while testing uclamp where rt-app calibration loop was pinned to
> cpu 0, shortly after which we spawn another task with high util_clamp
> value. The task was failing to migrate after over 40ms of runtime due to
> balance_interval unnecessary expanded to a very high value from the
> calibration loop.
>
> Not done here, but it could be useful to extend the check for pinning to
> verify that the affinity of the task has a cpu that fits. We could end
> up in a similar situation otherwise.
>
> Fixes: 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Acked-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks!

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 197a51473e0c..9379a481dd8c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4060,7 +4060,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>       if (!static_branch_unlikely(&sched_asym_cpucapacity))
>               return;
>
> -	if (!p) {
> +	if (!p || p->nr_cpus_allowed == 1) {
>               rq->misfit_task_load = 0;
>               return;
>       }
> --
> 2.25.1
