Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B1E2B04DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgKLMRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:17:31 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E157DC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:17:30 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v144so8024041lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNUlpQunA3+8lpdXHUOH+JYlsunfRD+1uj7ARWKY0dE=;
        b=n0W4VF2c796n+cwQh1D1PjKNqcuPmrIC3yuhlizCD4yJYyKA9+ZKdC8rr3FJIUhT9X
         cqIRykmWGqZJ2QHi1ZxFrYdvHP/sEUVKwuBiZ4QRQaP98/7kB/Oj3ZRYGVUBgP6R4rZs
         WLPxhvvalUSsOCsRBlRhdwc+OtzHLYCqPY5jFtzyRFqnHNz78ovNKlTBZbULBEXzYN0V
         tD8rmPQxjVjjfEqGDCAzFu+QBV7ymwzJtaw9HMS10F0S2Az3FM9mNg37Z/TXxNwPyyA4
         rWjdSpCWkdqruuUqsd59Eww3Om+asfvphKiS7E1NpznAuWPPzbKZMvL3ypyGVAfMUxys
         XWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNUlpQunA3+8lpdXHUOH+JYlsunfRD+1uj7ARWKY0dE=;
        b=uAGQSAFinufNYxNga4u2aSznT8ow6T3s9TM8hr7Eyth5OfLOJ3o/dfV3/QUEFJcQeO
         HoG3OefaJ9fZc0tkr5HTmNnafF1EilCpoM4/kXFWg/0/krSd/q6HxS+DugGxFcLnJ+1L
         X+b0WxmzEGefTWqbcdr8wi5J1XvrG9XTXGranKRE4w2j69SiMA3eBNUaOrWGs5T2nt3H
         g9xTFhpUf9yYGkXyOvc+8USRBx0jejFK7mSduHx71rDdikKAPTOaPyE7S8UORzmKYQ33
         juuzyPDxelq4L3CHN6CdWpCHiG38qV5SKWTJN1oe802HipYV1NGXcE/AdCfs38765RHn
         +S9w==
X-Gm-Message-State: AOAM532CC/1qhh7llEJRXWvCzkWg9AuItbedTyIeURvSFJD2uAIptrb7
        p9OfUZrpIQFweimt7ixgRUM0Vlr85hgbljQLKfua9w==
X-Google-Smtp-Source: ABdhPJxNIwGcK9c6aEjMHQZsZTgtsjkiI9E/PGHD4mRkIycpqEykkgyZpLyIfUYSUI2mgyUKvOxopI9u0jGBobTKeMA=
X-Received: by 2002:a19:cc91:: with SMTP id c139mr4626589lfg.31.1605183449335;
 Thu, 12 Nov 2020 04:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20201112111201.2081902-1-qperret@google.com>
In-Reply-To: <20201112111201.2081902-1-qperret@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 12 Nov 2020 13:17:18 +0100
Message-ID: <CAKfTPtB0tYwVKdV47fL_zZ_AqTcfk9ZXg3i7RCTJZ-hczjvMSw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix overutilized update in enqueue_task_fair()
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Rick Yiu <rickyiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 at 12:12, Quentin Perret <qperret@google.com> wrote:
>
> enqueue_task_fair() attempts to skip the overutilized update for new
> tasks as their util_avg is not accurate yet. However, the flag we check
> to do so is overwritten earlier on in the function, which makes the
> condition pretty much a nop.
>
> Fix this by saving the flag early on.
>
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point
> indicator")
> Reported-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e38378c..f3ee60b92718 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5477,6 +5477,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         struct cfs_rq *cfs_rq;
>         struct sched_entity *se = &p->se;
>         int idle_h_nr_running = task_has_idle_policy(p);
> +       int task_new = !(flags & ENQUEUE_WAKEUP);
>
>         /*
>          * The code below (indirectly) updates schedutil which looks at
> @@ -5549,7 +5550,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>          * into account, but that is not straightforward to implement,
>          * and the following generally works well enough in practice.
>          */
> -       if (flags & ENQUEUE_WAKEUP)
> +       if (!task_new)
>                 update_overutilized_status(rq);
>
>  enqueue_throttle:
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
