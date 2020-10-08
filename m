Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B525228745A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgJHMhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:37:48 -0400
Received: from m12-18.163.com ([220.181.12.18]:53810 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbgJHMhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ATb6q
        WOfEKLFdKGw4EMPraAGyHQzt5jzPCpiih1DgBg=; b=gxnbotfAQSEMd/ieajH4H
        PFKkfezRW5aIlIuA4hgFkJYDQsxW8f2Xb0IwYwx/u8S11Cg++TzF488RmdZ2fioM
        dhjC3XoG8V+v9oflV5uPClP9sBFBBPQzzQj4dqXyeqgxzOtLv2eAY/Y9w/6e6BXs
        betR0Ggb4YxFSbgWN7uoRs=
Received: from localhost (unknown [101.228.30.83])
        by smtp14 (Coremail) with SMTP id EsCowABXQL72B39fLfDSSA--.59064S2;
        Thu, 08 Oct 2020 20:37:10 +0800 (CST)
Date:   Thu, 8 Oct 2020 20:37:10 +0800
From:   Hui Su <sh_def@163.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, juri.lelli@redhat.com
Subject: Re: [PATCH] sched,fair: use list_for_each_entry() in
 print_cfs_stats()
Message-ID: <20201008123710.GB7424@rlk>
References: <20200925191019.GA174025@rlk>
 <7afdceb2-b727-4f89-75e3-e08bf06d78d9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7afdceb2-b727-4f89-75e3-e08bf06d78d9@arm.com>
X-CM-TRANSID: EsCowABXQL72B39fLfDSSA--.59064S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4xKF48urW7uFyfXF1kKrg_yoW5Jw4kpr
        Z0yay7Kr4vgw15ua45CrZ5uFy3Xry7G3y7XF4Uta40kw1UG3s0qFn7tw13uFyYvrZ5G34r
        tr4qvryakF1j9r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyuWJUUUUU=
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJha3X1v2efbulAAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:56:42AM +0200, Dietmar Eggemann wrote:
> On 25/09/2020 21:10, Hui Su wrote:
> > Macro for_each_leaf_cfs_rq_safe() use list_for_each_entry_safe(),
> > which can against removal of list entry, but we only
> > print the cfs_rq data and won't remove the list entry in
> > print_cfs_stats().
> > 
> > Thus, add macro for_each_leaf_cfs_rq() based on
> > list_for_each_entry(), and use for_each_leaf_cfs_rq() in
> > print_cfs_stats().
> > 
> > Signed-off-by: Hui Su <sh_def@163.com>
> > ---
> >  kernel/sched/fair.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1a68a0536add..d40dfb4349b0 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -391,11 +391,16 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> >  	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
> >  }
> >  
> > -/* Iterate thr' all leaf cfs_rq's on a runqueue */
> > +/* Iterate thr' all leaf cfs_rq's on a runqueue safely */
> >  #define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
> >  	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
> >  				 leaf_cfs_rq_list)
> >  
> > +/* Iterate thr' all leaf cfs_rq's on a runqueue */
> > +#define for_each_leaf_cfs_rq(rq, cfs_rq)			\
> > +	list_for_each_entry(cfs_rq, &rq->leaf_cfs_rq_list,	\
> > +				 leaf_cfs_rq_list)
> > +
> >  /* Do the two (enqueued) entities belong to the same group ? */
> >  static inline struct cfs_rq *
> >  is_same_group(struct sched_entity *se, struct sched_entity *pse)
> > @@ -11185,10 +11190,10 @@ const struct sched_class fair_sched_class
> >  #ifdef CONFIG_SCHED_DEBUG
> >  void print_cfs_stats(struct seq_file *m, int cpu)
> >  {
> > -	struct cfs_rq *cfs_rq, *pos;
> > +	struct cfs_rq *cfs_rq;
> >  
> >  	rcu_read_lock();
> > -	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
> > +	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
> >  		print_cfs_rq(m, cpu, cfs_rq);
> >  	rcu_read_unlock();
> >  }
> 
> IMHO, for_each_leaf_cfs_rq_safe() was introduced in commit a9e7f6544b9c
> ("sched/fair: Fix O(nr_cgroups) in load balance path") and reintroduced
> again by commit 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load
> balancing path") to prevent races between tasks running
> print_cfs_stats() and today's  __update_blocked_fair() ->
> list_del_leaf_cfs_rq(cfs_rq).
> 
> Your patch doesn't compile w/ !CONFIG_FAIR_GROUP_SCHED.

Thanks for your explanation, please ignore this change.

