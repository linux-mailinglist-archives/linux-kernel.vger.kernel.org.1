Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1F2FC44B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbhASW60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404276AbhASOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:20:24 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1669FC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 06:19:43 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 3so1887573ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 06:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRO2/C+6E03QiQmlqueDmdiHt80ctBlBnVBI5jJQXQM=;
        b=bKqRue30HAMdrH+Y1dU68G7qzKrZbMFYaGbQfRPPK5NTBMy/E7SkKtal9LDYZMLgm9
         U1114S3GeaTOr6K1fkGgGf7xM+jhg42XEoBW80Vyky9uSmmRI/gjkTRsb11daaR9PvBU
         XxRa00+lFpcDfSE7LhcVEBi0tEzrP7S1rD9DCdAFCHiSpQrxX6afJ/NXIgod5ajqZS+S
         jEeSIrE2fD3Og3kqkpnfsDtrcJEgP1rUfmHapOedtTOWXqcLT0yKC7fN/wAUvXvDgvDb
         bU017crKzfdqmhpLm0GUhObpYe5347YY2c0kSZ91r2OqUDHXMLWvZ0AM0uRIHnOERZyw
         yGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRO2/C+6E03QiQmlqueDmdiHt80ctBlBnVBI5jJQXQM=;
        b=bf7DHNYBdu4lb5xUJJySUuKwaUVJDRt+1w4rH7K2tHP+2uZhpZoe6n668XTpvWrdUt
         2mNwti7VXFm558jsDEnWuw+vY4gvltjmvmAiuso7kIjInY2iyrtOX6vMPFBjlWL+is7C
         gARqD1iwpLwofvSvEEr3nVwjba0FocpF5En+M5Xd0cb8zpk3i9ksvl9UaoeeVU2NBMHR
         5aVjAR6BVukYx4kGChd8CODm5nFGEgeRAvZhiKXjyEJY7XriO2kl7/8pRRNPgRHFTMMT
         tC8qQBoYICVkAPypgBmW0GEcKX2ADBe39a7to4bUEqWYS7yCL/effDuej7U6hSYJUynr
         Lj9w==
X-Gm-Message-State: AOAM530tYG+ptlc1DSaApXbsuk0Cv8KC/ycijVNlKh3DLuN//NOM9XZi
        4TeOVxLr95d6OQGPncaLTUcUFNPn8HDNHjzjBlYBAA==
X-Google-Smtp-Source: ABdhPJxbznconwC378nL7uGRSOf8BCYdYgGxXoqnB5Q6ptMcvTqCijxfTgwLCh5M6ZCIKUfNIBHWxhECUWFA5dY/CVw=
X-Received: by 2002:a2e:9913:: with SMTP id v19mr1987292lji.209.1611065981528;
 Tue, 19 Jan 2021 06:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20210119120755.2425264-1-qais.yousef@arm.com> <CAKfTPtD+wU9-UitvnBmZFeAgXbsDO+qcsv-hYr0xxuewB_Kp+A@mail.gmail.com>
 <jhjmtx53ucp.mognet@arm.com>
In-Reply-To: <jhjmtx53ucp.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jan 2021 15:19:30 +0100
Message-ID: <CAKfTPtCRPViF7B1iqeNVDi31X2sgOWKDJSGCBSzbj0c_Zb=mzA@mail.gmail.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is pinned
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 14:54, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/01/21 14:34, Vincent Guittot wrote:
> > On Tue, 19 Jan 2021 at 13:08, Qais Yousef <qais.yousef@arm.com> wrote:
> >>
> >> If the task is pinned to a cpu, setting the misfit status means that
> >> we'll unnecessarily continuously attempt to migrate the task but fail.
> >>
> >> This continuous failure will cause the balance_interval to increase to
> >> a high value, and eventually cause unnecessary significant delays in
> >> balancing the system when real imbalance happens.
> >>
> >> Caught while testing uclamp where rt-app calibration loop was pinned to
> >> cpu 0, shortly after which we spawn another task with high util_clamp
> >> value. The task was failing to migrate after over 40ms of runtime due to
> >> balance_interval unnecessary expanded to a very high value from the
> >> calibration loop.
> >>
> >> Not done here, but it could be useful to extend the check for pinning to
> >> verify that the affinity of the task has a cpu that fits. We could end
> >> up in a similar situation otherwise.
> >>
> >> Fixes: 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
> >> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> >> ---
> >>  kernel/sched/fair.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 197a51473e0c..9379a481dd8c 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -4060,7 +4060,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >>         if (!static_branch_unlikely(&sched_asym_cpucapacity))
> >>                 return;
> >>
> >> -       if (!p) {
> >> +       if (!p || p->nr_cpus_allowed == 1) {
> >
> > Side question: What happens if there is 2 misfit tasks and the current
> > one is pinned but not the other waiting one
> >
>
> update_misfit_status() is called either on the current task (at tick) or
> on the task picked by pick_next_task_fair() - i.e. CFS current or
> about-to-be-current.
>
> So if you have 2 CPU hogs enqueued on a single LITTLE, and one of them
> is pinned, the other one will be moved away either via regular load

This doesn't seem reliable because it uses load or nr_running

> balance, or via misfit balance sometime after it's picked as the next
> task to run.
>
> Admittedly that second case suffers from unfortunate timing mostly
> related to the load balance interval. There was an old patch in the
> Android stack that would reduce the balance interval upon detecting a

Shouldn't we keep track of enqueue misfit tasks instead ?

> misfit task to "accelerate" its upmigration; this might need to be
> revisited...
>
> >>                 rq->misfit_task_load = 0;
> >>                 return;
> >>         }
> >> --
> >> 2.25.1
> >>
