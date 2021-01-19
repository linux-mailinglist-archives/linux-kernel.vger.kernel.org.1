Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05722FB8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405698AbhASNmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394234AbhASNfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:35:55 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4ACC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:35:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id m10so21924933lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVI4VFAi/KNUvYPZejE0M1noebhuVU3D3T9Afh85Z1U=;
        b=AroODpIuIyQ60AuOkP48N/jvDoshWQYwCW/WoNKtw7AH8CU+YWtsRS52CixOgW5AZr
         yvqk985ltazv8QX7tjib5EcZswsA6OTtwMMH5ocTuyzhG5c6Bx5krdkBMSiV78Uy06k0
         NZW/sSq0gcJzSpG5Wrv0+7UpuXp5CcPY+BNwYFpK80tCJrQ9T4iBnRjPM/GtqVM7knjD
         iG3kgQjmrOEP/yfz3H7w0hQPG7cSR1zy+SYjM2Kpi9tAXp2nXEtiiVPrkugkOa2QqcTM
         wvn7Rp93OnT0VnOxJnCC8jD3LMjJkD6moBPIlo4itWS1G5edLmzkzTTrNdnyqJKj60Mj
         gI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVI4VFAi/KNUvYPZejE0M1noebhuVU3D3T9Afh85Z1U=;
        b=FyBmleDa/Ho42tiOS2IMoYAOi37yvx5GafH803JZKqkbtz+ppMdVEf3tyrk3xtG90y
         W4UKUhPUMmOAPC8KsAKSqtqO7L7XpWmIGpsgxo6fGAfwtcHMHrxTpOhJ24xiGmET0wti
         coSN5DltWCoSdmjFU/T4vP5dvfqWFo18OC5ZZOVNu9lrrNzYvgCgQWAM1rEM14GdUCOB
         77OzQTK4e0xjyyUwJdluMd/XhCqzzE5Ld634/nzAIW+6QsK/ftzU8j6C/GqmSe91koGx
         mh0MihLTzHy8VXdhce26HYUls/bCE0EjVuF3Ef+2kmgSbHJNdSM8SCgbRVfbOhm6H+ee
         VNOQ==
X-Gm-Message-State: AOAM531R55setxkoTWpCWel3A7Vrhz78cOeIVkLOBYWE0V5xldPhZIKA
        lotr+kHJzHedHlAowVMwjBWVAS+fuYAm2Z3VdjLdGg==
X-Google-Smtp-Source: ABdhPJwSHc1GYwmGeUT69urHBYrNOixpLFtjemakraSTMnMbEFPxTMPSFl2AmtNVc6lGdR8leiKkxqsThbm06390I0c=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr1909981ljm.445.1611063306390;
 Tue, 19 Jan 2021 05:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20210119120755.2425264-1-qais.yousef@arm.com>
In-Reply-To: <20210119120755.2425264-1-qais.yousef@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jan 2021 14:34:55 +0100
Message-ID: <CAKfTPtD+wU9-UitvnBmZFeAgXbsDO+qcsv-hYr0xxuewB_Kp+A@mail.gmail.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is pinned
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 13:08, Qais Yousef <qais.yousef@arm.com> wrote:
>
> If the task is pinned to a cpu, setting the misfit status means that
> we'll unnecessarily continuously attempt to migrate the task but fail.
>
> This continuous failure will cause the balance_interval to increase to
> a high value, and eventually cause unnecessary significant delays in
> balancing the system when real imbalance happens.
>
> Caught while testing uclamp where rt-app calibration loop was pinned to
> cpu 0, shortly after which we spawn another task with high util_clamp
> value. The task was failing to migrate after over 40ms of runtime due to
> balance_interval unnecessary expanded to a very high value from the
> calibration loop.
>
> Not done here, but it could be useful to extend the check for pinning to
> verify that the affinity of the task has a cpu that fits. We could end
> up in a similar situation otherwise.
>
> Fixes: 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 197a51473e0c..9379a481dd8c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4060,7 +4060,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>         if (!static_branch_unlikely(&sched_asym_cpucapacity))
>                 return;
>
> -       if (!p) {
> +       if (!p || p->nr_cpus_allowed == 1) {

Side question: What happens if there is 2 misfit tasks and the current
one is pinned but not the other waiting one

>                 rq->misfit_task_load = 0;
>                 return;
>         }
> --
> 2.25.1
>
