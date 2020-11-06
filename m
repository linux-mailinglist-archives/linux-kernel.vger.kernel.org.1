Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF342A9804
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgKFPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:02:53 -0500
Received: from m12-12.163.com ([220.181.12.12]:49583 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgKFPCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Wb/h3
        BkhDXtHxQwGiLnU9PYyWzHSeCJp4JZdvPWa4Qs=; b=LxoGur1eK0erFAxYPdPgF
        a2bWPwEUvdv0GIz1TsEsypKvyDRQHa8p93KCl6EBYQM9hSLFf05HhImfflS+XNp6
        9+aVzSLOd8hvOuADT+rD/HtqGHOjKlar5dSqZa91qWkFriCni8U/fcKWEnodPGgu
        jKGMbw/6U5n7Cm9wYVveRg=
Received: from localhost (unknown [110.251.190.92])
        by smtp8 (Coremail) with SMTP id DMCowACX8feVZKVfrt9sAA--.18912S2;
        Fri, 06 Nov 2020 22:58:29 +0800 (CST)
Date:   Fri, 6 Nov 2020 22:58:35 +0800
From:   Tao Zhou <t1zhou@163.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, xuewyan@foxmail.com, t1zhou@163.com
Subject: Re: [PATCH v3] sched: revise the initial value of the util_avg.
Message-ID: <20201106145835.GA25870@geo.homenetwork>
References: <1604632923-4243-1-git-send-email-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604632923-4243-1-git-send-email-xuewen.yan@unisoc.com>
X-CM-TRANSID: DMCowACX8feVZKVfrt9sAA--.18912S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWUJrykAr1xXw48ArWUArb_yoWrWrWkpr
        43WFW7Jw4DKw17Way8Zr48uFyUtwn8t34agF18AryfAFyrCryjqrnYqa93Z342vrWUK34x
        Ar4F9342gFyjgr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfOzxUUUUU=
X-Originating-IP: [110.251.190.92]
X-CM-SenderInfo: vwr2x0rx6rljoofrz/1tbiXRbUllWBkz9gdQAAsk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 11:22:03AM +0800, Xuewen Yan wrote:

> According to the original code logic:
> 		cfs_rq->avg.util_avg
> sa->util_avg  = -------------------- * se->load.weight
> 		cfs_rq->avg.load_avg
> but for fair_sched_class in 64bits platform:
> se->load.weight = 1024 * sched_prio_to_weight[prio];
> 	cfs_rq->avg.util_avg
> so the  -------------------- must be extremely small, the
> 	cfs_rq->avg.load_avg
> judgment condition "sa->util_avg < cap" could be established.
> It's not fair for those tasks who has smaller nice value.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> changes since V2:
> 
> *kernel/sched/fair.c | 6 +++++-
> * 1 file changed, 5 insertions(+), 1 deletion(-)
> *
> *diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> *index 290f9e3..079760b 100644
> *--- a/kernel/sched/fair.c
> *+++ b/kernel/sched/fair.c
> *@@ -794,7 +794,11 @@ void post_init_entity_util_avg(struct task_struct *p)
> *
> *        if (cap > 0) {
> *                if (cfs_rq->avg.util_avg != 0) {
> *-                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> *+                       if (p->sched_class == &fair_sched_class)
> *+                               sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
> *+                       else
> *+                               sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> *+
> *                        sa->util_avg /= (cfs_rq->avg.load_avg + 1);
> *
> *                        if (sa->util_avg > cap)
> *
> ---
> comment from Vincent Guittot <vincent.guittot@linaro.org>:
> >
> > According to the original code logic:
> >                 cfs_rq->avg.util_avg
> > sa->util_avg  = -------------------- * se->load.weight
> >                 cfs_rq->avg.load_avg
> 
> this should have been scale_load_down(se->load.weight) from the beginning
> 
> > but for fair_sched_class:
> > se->load.weight = 1024 * sched_prio_to_weight[prio];
> 
> This is only true for 64bits platform otherwise scale_load and
> scale_load_down are nop
> 
> >         cfs_rq->avg.util_avg
> > so the  -------------------- must be extremely small, the
> >         cfs_rq->avg.load_avg
> > judgment condition "sa->util_avg < cap" could be established.
> > It's not fair for those tasks who has smaller nice value.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 290f9e3..079760b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -794,7 +794,11 @@ void post_init_entity_util_avg(struct task_struct *p)
> >
> >         if (cap > 0) {
> >                 if (cfs_rq->avg.util_avg != 0) {
> 
> We should now use cpu_util() instead of cfs_rq->avg.util_avg which
> takes into account other classes
> 
> > -                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> > +                       if (p->sched_class == &fair_sched_class)
> > +                               sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
> > +                       else
> > +                               sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> 
> Why this else keeps using se->load.weight ?
> 
> Either we uses sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
> for all classes
> 
> Or we want a different init value for other classes. But in this case
> se->load.weight is meaningless and we should simply set them to 0
> although we could probably compute a value based on bandwidth for
> deadline class.
> 
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e3..c6186cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -794,7 +794,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>  
>  	if (cap > 0) {
>  		if (cfs_rq->avg.util_avg != 0) {
> -			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> +			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);

Please refer to this MessageID: 20161208012722.GA4128@geo in lkml web site
if you want. Just a notice and no matter here. My head do not work now.
I can't remember more things that time..

>  			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
>  
>  			if (sa->util_avg > cap)
> -- 
> 1.9.1
> 

