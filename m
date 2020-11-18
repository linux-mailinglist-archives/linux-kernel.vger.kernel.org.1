Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639062B753D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgKREHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKREHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:07:02 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7BC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:07:02 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y18so698188ilp.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdmOFp1nhxoi4yA/PTvEMp1MgWPBkdEIKAf0qsQNkZE=;
        b=H/wMY7/06X1o/hHCckWJdJY3/44Sv4HB1eiqv/f2chmop8gNUMcy81Vyj9i9iLFKna
         UMYz/Ox1zGCFdujjNVBlLo5+1/RK8aKsM7lNmqDDDANBO68uhBEgLMDTH6YN/yMcxQ+s
         Tyjt+SlGhYjWjFIX7xz4gngslw8/eTNkCB26l33ZpVe7nA8VPKzOV6Jw4VBokaM6xbgK
         ugwo33DKgjiJTvdnYWNkTZ+LBoVJ5rHOOzi0q57Bkmcu05jKYs5CBr1vK6iIBX3I1u6+
         z+o2Of9wDKo1jGMaMY3no03rMiPZwz1zBR5NfPZ8xo9GVMWbg+OXXDzKVnEETFG7UePy
         MQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdmOFp1nhxoi4yA/PTvEMp1MgWPBkdEIKAf0qsQNkZE=;
        b=RfWHBPojSbNGX8meJZ4Hm4Bybp69tNI9sEAzWSVIOOjd1zDf1dIXyVjPXmq3n5plTS
         KtXrAp9Wy9NPlDY29zLsxTpLsF1sMSigv1bD/cP6xC9/G+hq8Qyd13lGkIje5ci/D/uq
         PNrrOlKeW5gUrVPsvbnAg5hG7BmZCJFYnbez42g+L+8WmYmKYT4HQBWe87gwztiXOTjK
         qIBsis8RstTWsua7SmDD7FeUZQnwkjv7kom5qWj1FOh9bfzg2ODvB10pzH0vlydJNKc0
         5ArEGnOsrPFcHWF1R6DahXOv46lNFHzhUvPNQMYAfgDmaDwZeeG6gGwPFosnmfB4CEKT
         FcaQ==
X-Gm-Message-State: AOAM531sN4WubAeA9GnIY18i50X38gRqDPzvLDXAozyIet/m4HZgrPB+
        YyT9W5nFZtmERA4Qh2JPtjzRNov+/mW7OTXtE7k=
X-Google-Smtp-Source: ABdhPJz+OS/HVhk8oaZsdL0yRZVD1foNdV/VW72fxIzTDAOKuaJ1grMtAlVpqrD0IoKCtgY40YMiAb28rOWEgWDj6BA=
X-Received: by 2002:a05:6e02:1391:: with SMTP id d17mr9731734ilo.308.1605672421993;
 Tue, 17 Nov 2020 20:07:01 -0800 (PST)
MIME-Version: 1.0
References: <aaa87d62-b89d-e241-1a6e-01176694616f@huawei.com>
In-Reply-To: <aaa87d62-b89d-e241-1a6e-01176694616f@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 18 Nov 2020 12:06:50 +0800
Message-ID: <CAJhGHyBCs17Q=iQBfTJ-4Ls7egpa_70aEx0Ym_-oCt2vXKkSOg@mail.gmail.com>
Subject: Re: workqueue: Only kick a worker after thawed or for an unbound workqueue
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 3:33 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
> In realtime scenario, We do not want to have interference on the
> isolated cpu cores. but when invoking alloc_workqueue() for percpu wq
> on the housekeeping cpu, it kick a kworker on the isolated cpu.
>
>   alloc_workqueue
>     pwq_adjust_max_active
>       wake_up_worker
>
> The comment in pwq_adjust_max_active() said:
>   "Need to kick a worker after thawed or an unbound wq's
>    max_active is bumped"
>
> So it is unnecessary to kick a kworker for percpu wq's when
> alloc_workqueue. this patch only kick a worker after thawed or for an
> unbound workqueue.
>
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  kernel/workqueue.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c41c3c17b86a..80f7bbd4889f 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3696,14 +3696,16 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
>  }
>
>  /**
> - * pwq_adjust_max_active - update a pwq's max_active to the current setting
> + * pwq_adjust_max_active_and_kick - update a pwq's max_active to the current setting
>   * @pwq: target pool_workqueue
> + * @force_kick: force to kick a worker
>   *
>   * If @pwq isn't freezing, set @pwq->max_active to the associated
>   * workqueue's saved_max_active and activate delayed work items
>   * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
>   */
> -static void pwq_adjust_max_active(struct pool_workqueue *pwq)
> +static void pwq_adjust_max_active_and_kick(struct pool_workqueue *pwq,
> +                                       bool force_kick)
>  {
>         struct workqueue_struct *wq = pwq->wq;
>         bool freezable = wq->flags & WQ_FREEZABLE;
> @@ -3733,9 +3735,10 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>
>                 /*
>                  * Need to kick a worker after thawed or an unbound wq's
> -                * max_active is bumped.  It's a slow path.  Do it always.
> +                * max_active is bumped.


Hello

Thanks for reporting the problem.

But I don't like to add an argument. The waking up is called
always just because it was considered no harm and it is slow
path. But it can still be possible to detect if the waking up
is really needed based on the actual activation of delayed works.

The previous lines are:

                while (!list_empty(&pwq->delayed_works) &&
                       pwq->nr_active < pwq->max_active)
                        pwq_activate_first_delayed(pwq);

And you can record the old pwq->nr_active before these lines:

                int old_nr_active = pwq->nr_active;

                while (!list_empty(&pwq->delayed_works) &&
                       pwq->nr_active < pwq->max_active)
                        pwq_activate_first_delayed(pwq);

                /* please add more comments here, see 951a078a5 */
                if (old_nr_active < pwq->nr_active) {
                        if (!old_nr_active || (wq->flags & WQ_UNBOUND))
                                wake_up_worker(pwq->pool);
                }


Thanks for your work.
Lai.

>                  */
> -               wake_up_worker(pwq->pool);
> +               if (force_kick || (wq->flags & WQ_UNBOUND))
> +                       wake_up_worker(pwq->pool);
>         } else {
>                 pwq->max_active = 0;
>         }
> @@ -3743,6 +3746,11 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>         raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
>  }
>
> +static void pwq_adjust_max_active(struct pool_workqueue *pwq)
> +{
> +       pwq_adjust_max_active_and_kick(pwq, false);
> +}
> +
>  /* initialize newly alloced @pwq which is associated with @wq and @pool */
>  static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
>                      struct worker_pool *pool)
> @@ -5252,7 +5260,7 @@ void thaw_workqueues(void)
>         list_for_each_entry(wq, &workqueues, list) {
>                 mutex_lock(&wq->mutex);
>                 for_each_pwq(pwq, wq)
> -                       pwq_adjust_max_active(pwq);
> +                       pwq_adjust_max_active_and_kick(pwq, true);
>                 mutex_unlock(&wq->mutex);
>         }
>
> --
> 2.18.4
