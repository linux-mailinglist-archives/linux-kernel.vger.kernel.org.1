Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3E27894B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgIYNRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbgIYNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:17:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601039872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKGs/06q4FAXYVO+5AxisRtPOkcoFhGrnFnx6UXBozM=;
        b=CU053gs4MeBVhr0E09V5kFqfaqhvraLAIfexkPIBd1ep7+z7IxfjfFS1MkIlF8BmJSDZlw
        7Yyw0O/Z5WvUTunPZ66ZDkM2wxTmhQR3HjTqZKb2eKmTuvmagxtM34EVf5fzBzM5FkanyI
        Y4K+xj18Y8ArNLIvbzfUhNano3wCin0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-NhMQBJsUMr6lTCRUEfPPmA-1; Fri, 25 Sep 2020 09:17:48 -0400
X-MC-Unique: NhMQBJsUMr6lTCRUEfPPmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A8B610066FC;
        Fri, 25 Sep 2020 13:17:46 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-24.phx2.redhat.com [10.3.113.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D43373667;
        Fri, 25 Sep 2020 13:17:42 +0000 (UTC)
Date:   Fri, 25 Sep 2020 09:17:40 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove the force parameter of
 update_tg_load_avg()
Message-ID: <20200925131740.GB36943@lorien.usersys.redhat.com>
References: <20200924014755.36253-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924014755.36253-1-tian.xianting@h3c.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:47:55AM +0800 Xianting Tian wrote:
> In the file fair.c, sometims update_tg_load_avg(cfs_rq, 0) is used,
> sometimes update_tg_load_avg(cfs_rq, false) is used.
> update_tg_load_avg() has the parameter force, but in current code,
> it never set 1 or true to it, so remove the force parameter.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  kernel/sched/fair.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a0536..7056fa97f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -831,7 +831,7 @@ void init_entity_runnable_average(struct sched_entity *se)
>  void post_init_entity_util_avg(struct task_struct *p)
>  {
>  }
> -static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
> +static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>  }
>  #endif /* CONFIG_SMP */
> @@ -3288,7 +3288,6 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>  /**
>   * update_tg_load_avg - update the tg's load avg
>   * @cfs_rq: the cfs_rq whose avg changed
> - * @force: update regardless of how small the difference
>   *
>   * This function 'ensures': tg->load_avg := \Sum tg->cfs_rq[]->avg.load.
>   * However, because tg->load_avg is a global value there are performance
> @@ -3300,7 +3299,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>   *
>   * Updating tg's load_avg is necessary before update_cfs_share().
>   */
> -static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
> +static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>  	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
>  
> @@ -3310,7 +3309,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
>  	if (cfs_rq->tg == &root_task_group)
>  		return;
>  
> -	if (force || abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> +	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
>  		atomic_long_add(delta, &cfs_rq->tg->load_avg);
>  		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
>  	}
> @@ -3612,7 +3611,7 @@ static inline bool skip_blocked_update(struct sched_entity *se)
>  
>  #else /* CONFIG_FAIR_GROUP_SCHED */
>  
> -static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
> +static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
>  
>  static inline int propagate_entity_load_avg(struct sched_entity *se)
>  {
> @@ -3800,13 +3799,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		 * IOW we're enqueueing a task on a new CPU.
>  		 */
>  		attach_entity_load_avg(cfs_rq, se);
> -		update_tg_load_avg(cfs_rq, 0);
> +		update_tg_load_avg(cfs_rq);
>  
>  	} else if (decayed) {
>  		cfs_rq_util_change(cfs_rq, 0);
>  
>  		if (flags & UPDATE_TG)
> -			update_tg_load_avg(cfs_rq, 0);
> +			update_tg_load_avg(cfs_rq);
>  	}
>  }
>  
> @@ -7887,7 +7886,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
>  		struct sched_entity *se;
>  
>  		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> -			update_tg_load_avg(cfs_rq, 0);
> +			update_tg_load_avg(cfs_rq);
>  
>  			if (cfs_rq == &rq->cfs)
>  				decayed = true;
> @@ -10786,7 +10785,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>  	/* Catch up with the cfs_rq and remove our load when we leave */
>  	update_load_avg(cfs_rq, se, 0);
>  	detach_entity_load_avg(cfs_rq, se);
> -	update_tg_load_avg(cfs_rq, false);
> +	update_tg_load_avg(cfs_rq);
>  	propagate_entity_cfs_rq(se);
>  }
>  
> @@ -10805,7 +10804,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>  	/* Synchronize entity with its cfs_rq */
>  	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>  	attach_entity_load_avg(cfs_rq, se);
> -	update_tg_load_avg(cfs_rq, false);
> +	update_tg_load_avg(cfs_rq);
>  	propagate_entity_cfs_rq(se);
>  }
>  
> -- 
> 2.17.1
> 

LGTM,

Reviewed-by: Phil Auld <pauld@redhat.com>
-- 

