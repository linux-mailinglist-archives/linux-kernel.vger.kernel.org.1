Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69089240D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 20:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgHJSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 14:33:28 -0400
Received: from foss.arm.com ([217.140.110.172]:58680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgHJSd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:33:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB6F21063;
        Mon, 10 Aug 2020 11:33:27 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3C33F6CF;
        Mon, 10 Aug 2020 11:33:26 -0700 (PDT)
References: <20200810010009.92758-1-arch0.zheng@gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove the duplicate check from group_has_capacity()
In-reply-to: <20200810010009.92758-1-arch0.zheng@gmail.com>
Date:   Mon, 10 Aug 2020 19:33:20 +0100
Message-ID: <jhjwo26gxlb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/08/20 02:00, Qi Zheng wrote:
> 1. The group_has_capacity() function is only called in
>    group_classify().
> 2. The following inequality has already been checked in
>    group_is_overloaded() which was also called in
>    group_classify().
>
>       (sgs->group_capacity * imbalance_pct) <
>                         (sgs->group_runnable * 100)
>

Consider group_is_overloaded() returns false because of the first
condition:

        if (sgs->sum_nr_running <= sgs->group_weight)
                return false;

then group_has_capacity() would be the first place where the group_runnable
vs group_capacity comparison would be done.

Now in that specific case we'll actually only check it if

  sgs->sum_nr_running == sgs->group_weight

and the only case where the runnable vs capacity check can fail here is if
there's significant capacity pressure going on. TBH this capacity pressure
could be happening even when there are fewer tasks than CPUs, so I'm not
sure how intentional that corner case is.


For the

    sgs->sum_nr_running > sgs->group_weight

case I agree with your patch, there just is that oddity at the == case.

> So just remove the duplicate check from group_has_capacity().
>
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>  kernel/sched/fair.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2ba8f230feb9..a41903fb327a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8234,10 +8234,6 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>       if (sgs->sum_nr_running < sgs->group_weight)
>               return true;
>
> -	if ((sgs->group_capacity * imbalance_pct) <
> -			(sgs->group_runnable * 100))
> -		return false;
> -
>       if ((sgs->group_capacity * 100) >
>                       (sgs->group_util * imbalance_pct))
>               return true;
