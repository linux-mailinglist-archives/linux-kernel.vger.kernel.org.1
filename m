Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C097227C1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgI2J4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:56:45 -0400
Received: from foss.arm.com ([217.140.110.172]:38940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgI2J4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:56:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEB8E31B;
        Tue, 29 Sep 2020 02:56:44 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57AB63F6CF;
        Tue, 29 Sep 2020 02:56:43 -0700 (PDT)
Subject: Re: [PATCH] sched,fair: use list_for_each_entry() in
 print_cfs_stats()
To:     Hui Su <sh_def@163.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <20200925191019.GA174025@rlk>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7afdceb2-b727-4f89-75e3-e08bf06d78d9@arm.com>
Date:   Tue, 29 Sep 2020 11:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925191019.GA174025@rlk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 21:10, Hui Su wrote:
> Macro for_each_leaf_cfs_rq_safe() use list_for_each_entry_safe(),
> which can against removal of list entry, but we only
> print the cfs_rq data and won't remove the list entry in
> print_cfs_stats().
> 
> Thus, add macro for_each_leaf_cfs_rq() based on
> list_for_each_entry(), and use for_each_leaf_cfs_rq() in
> print_cfs_stats().
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/sched/fair.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a0536add..d40dfb4349b0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -391,11 +391,16 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
>  	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
>  }
>  
> -/* Iterate thr' all leaf cfs_rq's on a runqueue */
> +/* Iterate thr' all leaf cfs_rq's on a runqueue safely */
>  #define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
>  	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
>  				 leaf_cfs_rq_list)
>  
> +/* Iterate thr' all leaf cfs_rq's on a runqueue */
> +#define for_each_leaf_cfs_rq(rq, cfs_rq)			\
> +	list_for_each_entry(cfs_rq, &rq->leaf_cfs_rq_list,	\
> +				 leaf_cfs_rq_list)
> +
>  /* Do the two (enqueued) entities belong to the same group ? */
>  static inline struct cfs_rq *
>  is_same_group(struct sched_entity *se, struct sched_entity *pse)
> @@ -11185,10 +11190,10 @@ const struct sched_class fair_sched_class
>  #ifdef CONFIG_SCHED_DEBUG
>  void print_cfs_stats(struct seq_file *m, int cpu)
>  {
> -	struct cfs_rq *cfs_rq, *pos;
> +	struct cfs_rq *cfs_rq;
>  
>  	rcu_read_lock();
> -	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
> +	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
>  		print_cfs_rq(m, cpu, cfs_rq);
>  	rcu_read_unlock();
>  }

IMHO, for_each_leaf_cfs_rq_safe() was introduced in commit a9e7f6544b9c
("sched/fair: Fix O(nr_cgroups) in load balance path") and reintroduced
again by commit 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load
balancing path") to prevent races between tasks running
print_cfs_stats() and today's  __update_blocked_fair() ->
list_del_leaf_cfs_rq(cfs_rq).

Your patch doesn't compile w/ !CONFIG_FAIR_GROUP_SCHED.
