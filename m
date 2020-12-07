Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196A52D1466
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgLGPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLGPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:06:43 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA32C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:06:03 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y22so470092ljn.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWae73H+3s3blnSnVqUJJlDoPyT8hFMgQJ2+7vq3as4=;
        b=mOQ5X9eh6BIEq28BKrVdrz8GGshT2deUgE9Yb3Stfx1n3TT+G1XzhQvOugV4DbKkH4
         Zgnz8jW9endVfYFhGBVGroksa4zNHC1PKQfs9yJ897gPq44FR3cMtFgtpxSq5eN2+m3a
         bNBUoOARFUhmlYZMX4Ii25mWkkzT4Ytj9wWcFm9mZOGbKRoZmBEJQ5HXj2TPHQDxAOHt
         TCobHTbHQp1ju5ec+xg8wK0EgEWdCUqGuvcDiTFY7m42Ff1Ys03gA+hUaHmXgEYK2F2t
         AlEkRGXQHxk1gGz3c3x+eYnZ/ck15IUb0Z/JS5XeIl8qh/L0Hakj5B2rj531bHfia0dv
         IFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWae73H+3s3blnSnVqUJJlDoPyT8hFMgQJ2+7vq3as4=;
        b=IulgdT81oyN8Syiqk25TfhhDaJq3xfpNZEhm3ojzvaXFeMavdP2xfln3ZzQJrHCox9
         pRiPYmsUIRiIYBEAjIBWCjz/c+MNFH5el1192dtR5tJUwYP01gtSEXEmxfeyfNcKVLGK
         WrdQbOM70Cw1B/DiMRc6DfvVL7OkszPINtEp7Unapd9t+A4d16ZwMjNQb6qzxOy3qnwF
         +B08jBFm+P8pIpxuqUkuqWwGbnuazc4VFOUr5NE4OyRQy2xs4oEz5YLJbvKRmaFcRrop
         5HByz8ILwnw0lyIvYkZQGJ4yInrqCKlREMuHXAMceHUm7TnNj3UuGte4mmd85/MQZdwR
         ySJA==
X-Gm-Message-State: AOAM5338Yxi7UAOEJJXQnibrIfsQFaWHibz/e6/9Q3GPoKTbsM9R8059
        qaOE/6H17I4iBNbLbePvtP9YGQEvfzcg+FBf5l3uTQ==
X-Google-Smtp-Source: ABdhPJzmONItqGLff4dtj88hxzDvEJi77BvE0p14AGPiFkUXiatJQeg+G7Fnlv4K4rRydm1FSwcp6a7a+P0DsxOPpBI=
X-Received: by 2002:a2e:918a:: with SMTP id f10mr8427358ljg.156.1607353561759;
 Mon, 07 Dec 2020 07:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20201207091516.24683-1-mgorman@techsingularity.net> <20201207091516.24683-2-mgorman@techsingularity.net>
In-Reply-To: <20201207091516.24683-2-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Dec 2020 16:05:50 +0100
Message-ID: <CAKfTPtB8jOsFF9+cYVzRRLk+VskJBB_ZVNYdYC0P68Zow4k9bg@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 10:15, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> SIS_AVG_CPU was introduced as a means of avoiding a search when the
> average search cost indicated that the search would likely fail. It
> was a blunt instrument and disabled by 4c77b18cf8b7 ("sched/fair: Make
> select_idle_cpu() more aggressive") and later replaced with a proportional
> search depth by 1ad3aaf3fcd2 ("sched/core: Implement new approach to
> scale select_idle_cpu()").
>
> While there are corner cases where SIS_AVG_CPU is better, it has now been
> disabled for almost three years. As the intent of SIS_PROP is to reduce
> the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
> on SIS_PROP as a throttling mechanism.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Let see if someone complains but looks reasonable

> ---
>  kernel/sched/fair.c     | 3 ---
>  kernel/sched/features.h | 1 -
>  2 files changed, 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 98075f9ea9a8..23934dbac635 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6161,9 +6161,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         avg_idle = this_rq()->avg_idle / 512;
>         avg_cost = this_sd->avg_scan_cost + 1;
>
> -       if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
> -               return -1;
> -
>         if (sched_feat(SIS_PROP)) {
>                 u64 span_avg = sd->span_weight * avg_idle;
>                 if (span_avg > 4*avg_cost)
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 68d369cba9e4..e875eabb6600 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -54,7 +54,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
>  /*
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
>   */
> -SCHED_FEAT(SIS_AVG_CPU, false)
>  SCHED_FEAT(SIS_PROP, true)
>
>  /*
> --
> 2.26.2
>
