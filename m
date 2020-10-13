Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8028D17A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgJMPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbgJMPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:48:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B918C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xhCu2Ozg6blWdN5A3IUY2LNairqYOuZhuhiSypVRxLE=; b=NxTroRAyDyZHBBWFnA6D3tH+md
        RjgxrR3yYs6sJE1ZI++E731oS3cDu5DiLFpr42ocUQp8xAP2nQwFPl3qt52Mczni5ICE/fkBKnZWw
        V3pvbugoqNFw2jhxJAgRnsfkHntt7aXOD5i8alchVgCZvUV111GNrqWMNGUNiGCq2EUySHJH92ysI
        wCK98Ap2oQZRbcJOG7csn4Xax75PfEvmJ5Z8VT3xSVYCXxMD5zZ00ubF+DPCL8U/KOlmX1S6rFkgr
        yalXp4NKCjrxtVJ8lVRrZEjGk6NKiJixkhQDcVnI5KZY0LDaQSJNi7YgNtbjrqMsEr2A5HpO8MemB
        75JETnCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSMWx-0002TF-0A; Tue, 13 Oct 2020 15:48:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A49C13060AE;
        Tue, 13 Oct 2020 17:48:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 926362C30ED79; Tue, 13 Oct 2020 17:48:00 +0200 (CEST)
Date:   Tue, 13 Oct 2020 17:48:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Replace rq_of_dl_rq(dl_rq_of_se(dl_se))
 with ... ...task_rq(dl_task_of(dl_se))
Message-ID: <20201013154800.GV2611@hirez.programming.kicks-ass.net>
References: <20201013143140.237750-1-arch0.zheng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013143140.237750-1-arch0.zheng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:31:40PM +0800, Qi Zheng wrote:
> The rq is already obtained in the dl_rq_of_se() function:
> 	struct task_struct *p = dl_task_of(dl_se);
>         struct rq *rq = task_rq(p);
> So there is no need to do extra conversion.
> 
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>  kernel/sched/deadline.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6d93f4518734..f64e577f6aba 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1152,7 +1152,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
>  static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
>  {
>  	struct task_struct *p = dl_task_of(dl_se);
> -	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
> +	struct rq *rq = task_rq(p);
>  
>  	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
>  	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
> @@ -1498,7 +1498,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
>  		replenish_dl_entity(dl_se, pi_se);
>  	} else if ((flags & ENQUEUE_RESTORE) &&
>  		  dl_time_before(dl_se->deadline,
> -				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
> +				 rq_clock(task_rq(dl_task_of(dl_se))))) {
>  		setup_new_dl_entity(dl_se);
>  	}

Consider where we're going:

  https://lkml.kernel.org/r/20200807095051.385985-1-juri.lelli@redhat.com

then a dl_entity is no longer immediately a task and the above is no
longer true.
