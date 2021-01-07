Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6862ECEB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbhAGL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:27:37 -0500
Received: from foss.arm.com ([217.140.110.172]:58372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAGL1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:27:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC92CED1;
        Thu,  7 Jan 2021 03:26:50 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B833F719;
        Thu,  7 Jan 2021 03:26:49 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/3 v2] sched/fair: reduce cases for active balance
In-Reply-To: <20210107103325.30851-4-vincent.guittot@linaro.org>
References: <20210107103325.30851-1-vincent.guittot@linaro.org> <20210107103325.30851-4-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 07 Jan 2021 11:26:47 +0000
Message-ID: <jhjczyhasy0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/21 11:33, Vincent Guittot wrote:
> Active balance is triggered for a number of voluntary cases like misfit
> or pinned tasks cases but also after that a number of load balance
> attempts failed to migrate a task. There is no need to use active load
> balance when the group is overloaded because an overloaded state means
> that there is at least one waiting task. Nevertheless, the waiting task
> is not selected and detached until the threshold becomes higher than its
> load. This threshold increases with the number of failed lb (see the
> condition if ((load >> env->sd->nr_balance_failed) > env->imbalance) in
> detach_tasks()) and the waiting task will end up to be selected after a
> number of attempts.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a3515dea1afc..00ec5b901188 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9499,13 +9499,32 @@ asym_active_balance(struct lb_env *env)
>  }
>
>  static inline bool
> -voluntary_active_balance(struct lb_env *env)
> +imbalanced_active_balance(struct lb_env *env)
> +{
> +	struct sched_domain *sd = env->sd;
> +
> +	/*
> +	 * The imbalanced case includes the case of pinned tasks preventing a fair
> +	 * distribution of the load on the system but also the even distribution of the
> +	 * threads on a system with spare capacity
> +	 */

Do you mean s/imbalanced/migrate_task/? This part here will affect
group_imbalanced, group_asym_packing, and some others.

> +	if ((env->migration_type == migrate_task) &&
> +	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
> +		return 1;
> +
> +	return 0;
> +}
> +
