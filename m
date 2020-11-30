Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67EB2C870F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgK3Orz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgK3Ory (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:47:54 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389B3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:47:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so22121823lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrUIm3t7/zD9+p/JP2SKsOxbaIp5CLKekidIYJeqkDo=;
        b=tfvZlTIXXDAEXLK4Jp/+1iBbqGGqjaKk6ux5tOEMu6Nw2DQvwjftJjZXeSO+rusYxv
         rNJGypII/efIlpMNKRIy7TSJdC2YF/V678s8hg384lryL7fukB5zEBKzqY/6kpWXgUPz
         3UCgdZoyBoN29z2AxCsGc3yrXOlwiUSv+gniNp1sV5G4v3YmJvlbo6nEC7UuDl11003S
         QN5EZcU+wEJ/bJQfep/M+ZvXfmjwy3AcJfSvZt+amvGqeId4p2l7ByzBu515zYxF2rLt
         cPBQbH4L7xNfbffKLXKk7XrVRMTvAgl9IGSksjW/3Q6gxQEUpJSuDjhlkdOMh1Top0DZ
         adIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrUIm3t7/zD9+p/JP2SKsOxbaIp5CLKekidIYJeqkDo=;
        b=PyKY+sgZS1FBjfABalj7EupnBmmsohkRvp12qHqKgqcXYxudambjCMj4jN0/hO8Ls3
         q0di8gksZTpevzRzr/eQvkQel7M/8uH8OoAZL9ry96LhMuC/wBqT/Dm3MXEzeUFvvRnN
         mYTzTka5X5P7okxnZkmWKCSmTaHPkNarKjuudPNv68hwmqVU3AFPN3gHVRY+06ZSeVl4
         jQt62hj6gp5Pi7ManKdy28dznDVImv7Cyl+Kx7UWMaUqawhnFvm3rlV3nA8EBaTNXU9F
         MeMkGGR8oBYAWH8jOcxkSkiKwgU0MCin8ofkBxzxCYX91TJ7cOoDfiklj7gf+be1UQiY
         EIQA==
X-Gm-Message-State: AOAM533wZOxxQopkvwjSmLeugr3cxU/1clHaKa3T2ZmikWcoK6A8TwF9
        8s8DEjaj5lV+4z4Q9aNlJtW/Ij4yv8i2GhHRsqvKQpAXnIU=
X-Google-Smtp-Source: ABdhPJwUtLiwhvc00j+Y1t9bsIKByRLM2AXsh0cy1guS/txtGfeJrXUMc6GX/UeDFX3WI24pchi3Y7wOGXLmDSTuj4I=
X-Received: by 2002:a19:c191:: with SMTP id r139mr9748377lff.258.1606747632680;
 Mon, 30 Nov 2020 06:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20201130144020.GS3371@techsingularity.net>
In-Reply-To: <20201130144020.GS3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Nov 2020 15:47:01 +0100
Message-ID: <CAKfTPtBcZnxR073=eRsWNAGOnA8K4emL0BYEUzbkzZx6qJWmSg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Clear SMT siblings after determining the core
 is not idle
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 at 15:40, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The clearing of SMT siblings from the SIS mask before checking for an idle
> core is a small but unnecessary cost. Defer the clearing of the siblings
> until the scan moves to the next potential target. The cost of this was
> not measured as it is borderline noise but it should be self-evident.

Good point

>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0d54d69ba1a5..d9acd55d309b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6087,10 +6087,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>                                 break;
>                         }
>                 }
> -               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>
>                 if (idle)
>                         return core;
> +
> +               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>         }
>
>         /*
