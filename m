Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6048F2B9FED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgKTBpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgKTBpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:45:45 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:45:45 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y9so7218443ilb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfZ1WpxjqG2Zedb64ss+FUrg+7eCMM8D6VEgB1bMXu4=;
        b=A5woYAG8w+ggyl6iBWGMNxqLlbS6NYyOtRrzcLKUSHNuptfTMpI3XiczcNyTArl8HA
         xfU3MgboGDbhgVfu9zhC/gVAizJHzXNTiEFIEcV7dBPKB9+hUBrk9hiqqexUzgCqRVk2
         eQAXAtB3sDkyNq8vlHgj/uJIxOkoowg3v2dNtYJ2A30VWngcZDQx7YVbMhVQVuVCUZ0m
         vBA0bcxGkAPouQcqIkg4KFyMgiMAIQvPf1y53NsTLAHZa0V6wpb5NK8Sx6OCPuNvkr9D
         fRwJ3SIyQrfIkfHfH5ZKJgElhpsi/FewYC9UmhMTUc4UNWbtAjrs9UJ175lLF/DgXw5j
         dNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfZ1WpxjqG2Zedb64ss+FUrg+7eCMM8D6VEgB1bMXu4=;
        b=LtDN8UOQXuu+cAQSAghM7QL9487UOGOQkhlSM46VjHLf1sBHPYvoUYSO2Fes19T9jw
         49v4u+h3heA+So7SXurAuK9t3xmJG29vK4FZMQsTjjUMcxhGgnH5rtW8UFmCzuxRUKbI
         c3uWHLn63HFoi1GDeY5MzKlCsuLMzwlqAvwjzKnilLiA/1PNReleO5yC9fiZqp/Ww1U7
         mOZQ+kXNC5a+iPwCe3LnHc11mWoLd0KVIcd/oKbBA0GbekTKf9jgZA1lizBczyBTIsPZ
         ZIpnOEpR3umc43qVE6hRhn2NyxuMQOg32ToJjh92Z4xZ/WNnn5MwbUVze5q8bgkg9aNL
         esog==
X-Gm-Message-State: AOAM533DpmAc0aN34L7CZIlUK8Ah9QuWvZ33VgGuwHCkUrehGJKzGYrR
        kujt+v6tIgGVpLNh+qH8dMFoymi40+IT0S4aUrQ=
X-Google-Smtp-Source: ABdhPJwAO0h4RwB/6zHD3FOHSNO/+6cVLfaNlAV/BTR6sEAXwyxYACLT/8XY2/B2UUrfnhZVZn6RjR89uiCaLY3UF04=
X-Received: by 2002:a92:cf45:: with SMTP id c5mr24981280ilr.52.1605836745127;
 Thu, 19 Nov 2020 17:45:45 -0800 (PST)
MIME-Version: 1.0
References: <3837a2ee-f3d5-2732-7d15-7e9616319f05@huawei.com>
In-Reply-To: <3837a2ee-f3d5-2732-7d15-7e9616319f05@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 20 Nov 2020 09:45:34 +0800
Message-ID: <CAJhGHyBBFebdb4=G35KaHWYCs+ASox+br7o-=nabXEm9Y1bqJA@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: Kick a worker based on the actual
 activation of delayed works
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 2:21 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
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
> So it is unnecessary to kick a kworker for percpu's wq when invoking
> alloc_workqueue(). this patch only kick a worker based on the actual
> activation of delayed works.
>
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> ---
>  kernel/workqueue.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c41c3c17b86a..b3c9d6ef7c69 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3725,17 +3725,25 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>          * is updated and visible.
>          */
>         if (!freezable || !workqueue_freezing) {
> +               bool kick = false;
> +
>                 pwq->max_active = wq->saved_max_active;
>
>                 while (!list_empty(&pwq->delayed_works) &&
> -                      pwq->nr_active < pwq->max_active)
> +                      pwq->nr_active < pwq->max_active) {
>                         pwq_activate_first_delayed(pwq);
> +                       kick = true;
> +               }
>
>                 /*
>                  * Need to kick a worker after thawed or an unbound wq's
> -                * max_active is bumped.  It's a slow path.  Do it always.
> +                * max_active is bumped. But in realtime scenario, kick a
> +                * worker always will have interference on the isolated
> +                * cpu cores. So do it only based on the actual activation
> +                * of delayed works.
>                  */
> -               wake_up_worker(pwq->pool);
> +               if (kick)
> +                       wake_up_worker(pwq->pool);
>         } else {
>                 pwq->max_active = 0;
>         }
> --
> 2.18.4
