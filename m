Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E685B3009C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbhAVR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbhAVQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:57:33 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1FC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:56:35 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f11so7260579ljm.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QK1ChcvAHB0T0asTEwpLYFzpCGgmXtBARlGdorNQLgE=;
        b=OuAZ5aDqJcLMQZ4WTg+2YOrJZOIL/zVNclbUAak+LqLaeuzxqHYE+c8TYxdyLHlf2G
         kFNwzUBGSh4Vx6h9QLoFJpDiQcNanCu/g/lA3fiqpzmBxU3gqGois1GW4+nxkO3hwNLO
         LSWwAsHeOCYVHUim8ikliZxSbdeZG65wBXg9h0ftQmalANONAa9FmMQmyzosjRllDR8X
         MwxLO+5yrfEvX6nYa0HA7gbReTRJkbio//u9yXCzpDhu+uXQvxTPf2qZWlwmm+QO+rhs
         2m6c1d4LvaAJafn1OFlUR76Dy2KBS/kjeZLUZyb+m2r5uLlX5SGi7eAe13d13TlO/p/W
         nRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QK1ChcvAHB0T0asTEwpLYFzpCGgmXtBARlGdorNQLgE=;
        b=bv9jTp5cLi/y99i2FqSRU4mnAByRDkTAkUW2rmLVBt9sDPUGC4kRiTfACChbrIj7fz
         vUzBVFNSjUAmKndOEqLA+5K+xFRPa43AwlHbY7JnLlL2WcyIzAeTvJtQW4hghoWhB/6E
         4nryH09bRTPy/rhSQwynzePT74Qb1tcoscYn6yXYIYbqzhPZShXNtM1SGZu21CwcraOH
         KUgd/Md38jIORs+p/xfyIG+z9aXNcg+ZPej09q8mXFyHUFsSWzRo97eJ2xiL4dK87T45
         Ts6Ub9707Y8r20ZerXbC3z1f9grGeYGp2Upm4FUgrcrZOJXwyVAw5Bul0VpJoy4MHxv1
         aoFw==
X-Gm-Message-State: AOAM531o6c5K5HyF5WGnOkFU4FyqqecBUOc5zp/17J0GCSMzZLUoipxl
        53M1tUorfR1kPNNMQ8R0Vlsxqk5HxUjPh2ujzi9jWg==
X-Google-Smtp-Source: ABdhPJxL3vOV7xQgYvsGuCYZyyfnF52c1R6aTDL6C8A8KMWU1vexIbRXkQhOsE2MOrlvKberXPpOlx6wt9j8u4XwhQo=
X-Received: by 2002:a2e:5408:: with SMTP id i8mr1495165ljb.221.1611334593713;
 Fri, 22 Jan 2021 08:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
In-Reply-To: <20210122154600.1722680-1-joel@joelfernandes.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jan 2021 17:56:22 +0100
Message-ID: <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> On an octacore ARM64 device running ChromeOS Linux kernel v5.4, I found
> that there are a lot of calls to update_blocked_averages(). This causes
> the schedule loop to slow down to taking upto 500 micro seconds at
> times (due to newidle load balance). I have also seen this manifest in
> the periodic balancer.
>
> Closer look shows that the problem is caused by the following
> ingredients:
> 1. If the system has a lot of inactive CGroups (thanks Dietmar for
> suggesting to inspect /proc/sched_debug for this), this can make
> __update_blocked_fair() take a long time.

Inactive cgroups are removed from the list so they should not impact
the duration

>
> 2. The device has a lot of CPUs in a cluster which causes schedutil in a
> shared frequency domain configuration to be slower than usual. (the load

What do you mean exactly by it causes schedutil to be slower than usual ?

> average updates also try to update the frequency in schedutil).
>
> 3. The CPU is running at a low frequency causing the scheduler/schedutil
> code paths to take longer than when running at a high CPU frequency.

Low frequency usually means low utilization so it should happen that much.

>
> The fix is simply rate limit the calls to update_blocked_averages to 20
> times per second. It appears that updating the blocked average less
> often is sufficient. Currently I see about 200 calls per second

Would be good to explain why updating less often is sufficient ?

> sometimes, which seems overkill.
>
> schbench shows a clear improvement with the change:

Have you got more details about your test setup ?
which platform ?
which kernel ?

>
> Without patch:
> ~/schbench -t 2 -m 2 -r 5
> Latency percentiles (usec) runtime 5 (s) (212 total samples)
>         50.0th: 210 (106 samples)
>         75.0th: 619 (53 samples)
>         90.0th: 665 (32 samples)
>         95.0th: 703 (11 samples)
>         *99.0th: 12656 (8 samples)
>         99.5th: 12784 (1 samples)
>         99.9th: 13424 (1 samples)
>         min=15, max=13424
>
> With patch:
> ~/schbench -t 2 -m 2 -r 5
> Latency percentiles (usec) runtime 5 (s) (214 total samples)
>         50.0th: 188 (108 samples)
>         75.0th: 238 (53 samples)
>         90.0th: 623 (32 samples)
>         95.0th: 657 (12 samples)
>         *99.0th: 717 (7 samples)
>         99.5th: 725 (2 samples)
>         99.9th: 725 (0 samples)
>
> Cc: Paul McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Suggested-by: Dietmar Eggeman <dietmar.eggemann@arm.com>
> Co-developed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..fe2dc0024db5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8381,7 +8381,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
>         if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
>                 return false;
>
> -       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> +       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick + (HZ/20)))

This condition is there to make sure to update blocked load at most
once a tick in order to filter newly idle case otherwise the rate
limit is already done by load balance interval
This hard coded (HZ/20) looks really like an ugly hack

>                 return true;
>
>         update_blocked_averages(cpu);
> --
> 2.30.0.280.ga3ce27912f-goog
>
