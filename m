Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8457B2BAB26
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKTNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgKTNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:32:27 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A232CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:32:26 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so13437369lfj.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUwWCinPU/rcnyTODhKDPV2jIh5tG5a9WWqSzvSC+LE=;
        b=DODEhSOYxR0VIostkIvx9gvBPqeuODaAMtL6vHtXUPypI6Hooq7dZ1PP3a5TFqhlAT
         tDmQ2E8cf7ew2PhUEBJls3dQr78ozPJVwH4JKIXiX+UPQR3DKzkLw/p1UA+c8jsNpVfM
         vZZms18aOqYHP0jq8VNNKPxi0ZUHR4wpkAuyxPz/SNFxc7Sp2B37RZx0Jg8aFGJN6haV
         +aInPMzb2VXh2wFdzD8habbzqGHH58bDq6RQk6IL/OZW+Q3Kf85B45DxFuz1DrhRZ9Ye
         CA338RNw/yAkb5MtBOtnFhBoUu3nbo+GFg+pffJVo4mOAlsbPrMvGDqM2V8swDrve0mg
         02cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUwWCinPU/rcnyTODhKDPV2jIh5tG5a9WWqSzvSC+LE=;
        b=ED/OR1fJnYVQRFno80l70oDtPC2AsIfJXNQVzW6eEO/lJqV5d3brMgevOQyYrodZtD
         mPkCv+g4r5GyR67oS/hpyyun1LsLqAW246ju24jGG6BiDnuG6XXWSHTOaMZamH2vxHjv
         5y3e7CUmNG3oZ89ujba/elfE7ACmXFCWoclSN+3PLxz10Ah9cUqXQjpjb3DKfuvoAX3u
         +aexQDzadM4jnAQrCz8oKBx2E+Cld/k8U10ZeXk/VjxeMWc2t+BI+z0ymfTvsM483DIf
         wRw09PUpBaEzfZufCiWZN3gyYJIM/HmTb02ZWB3NFKeXm3AUpDjkNnl+6dCwFQ2GTtY4
         EfNQ==
X-Gm-Message-State: AOAM533ZGddeRFshDCWXxEvuNE3Nog8uMgk8ultrdpvAszHl6vHsK4jP
        mHT3jWb2jmYwGzCYdWqoS27NPAbc9H7boFtMPVbB/g==
X-Google-Smtp-Source: ABdhPJw+ZaoL+9LcJWAol8nf2wslsR3GB0NnzaDG5wrSlK/3TuMj5bc5CZPiPQBtsG1v9qdqHEB0pwo1KKVNp6i7bEo=
X-Received: by 2002:a19:6a07:: with SMTP id u7mr8636932lfu.252.1605879145033;
 Fri, 20 Nov 2020 05:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20201120090630.3286-1-mgorman@techsingularity.net> <20201120090630.3286-2-mgorman@techsingularity.net>
In-Reply-To: <20201120090630.3286-2-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Nov 2020 14:32:14 +0100
Message-ID: <CAKfTPtDDBHEKg1n0qWp-sVeNK9RuY+2V8evYGMzsXekTTLVeGw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/numa: Rename nr_running and break out the magic number
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 10:06, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> This is simply a preparation patch to make the following patches easier
> to read. No functional change.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6d78b68847f9..5fbed29e4001 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1550,7 +1550,7 @@ struct task_numa_env {
>  static unsigned long cpu_load(struct rq *rq);
>  static unsigned long cpu_runnable(struct rq *rq);
>  static unsigned long cpu_util(int cpu);
> -static inline long adjust_numa_imbalance(int imbalance, int nr_running);
> +static inline long adjust_numa_imbalance(int imbalance, int dst_running);
>
>  static inline enum
>  numa_type numa_classify(unsigned int imbalance_pct,
> @@ -8991,7 +8991,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>         }
>  }
>
> -static inline long adjust_numa_imbalance(int imbalance, int nr_running)
> +#define NUMA_IMBALANCE_MIN 2
> +
> +static inline long adjust_numa_imbalance(int imbalance, int dst_running)
>  {
>         unsigned int imbalance_min;
>
> @@ -8999,8 +9001,8 @@ static inline long adjust_numa_imbalance(int imbalance, int nr_running)
>          * Allow a small imbalance based on a simple pair of communicating
>          * tasks that remain local when the source domain is almost idle.
>          */
> -       imbalance_min = 2;
> -       if (nr_running <= imbalance_min)
> +       imbalance_min = NUMA_IMBALANCE_MIN;
> +       if (dst_running <= imbalance_min)
>                 return 0;
>
>         return imbalance;
> --
> 2.26.2
>
