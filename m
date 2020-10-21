Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F52948E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440973AbgJUHaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440965AbgJUHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:30:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96B0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:29:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r127so1745581lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4/I+nUkpd8aiLL/7Bk57Oeqd7wJz8LYc62JJnA1ZR4=;
        b=xhJXXga76rwDz1EEm8aXKo5AmlQ4at+1BklAz0WL2j9ZvKLfhZbYZ4IhuHrnZZKyqm
         rw8lDoxCDSuMVuitJ+iktm4/ujRyQl1soYKdmw6KFKGeUQF8UsmD023CfQH3gx6VtIuZ
         PAUttnVDId/I+jKBJ4VpIsVl4NbqU6Sez2n3kw4IZIMa4s16m0g1YQFTgD7Nl438GH2C
         HFZih0ZXak9vbwD7eyHk7rR3bznCCIqbqurSY9zFMQPHJEWd2zI7QzG+9IIzktkEVuiv
         HnmH3gJQ3hemAAp9nsaT1rROwSOTj60Uzbn1cXseaSttyYdEYKUCmmp+sYQkpsUrmoBB
         107w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4/I+nUkpd8aiLL/7Bk57Oeqd7wJz8LYc62JJnA1ZR4=;
        b=YpYb+YBa6sMVpC7uaVmQ47cwo/WucfEo450dGgoufRelrV+FzxjaM41S3qZitzPdSM
         +VslRlGGyBJ2qL3/eEwwXNtmPRJs9MEZoVOPPYjnMfY1Z/GJpQiKue6mET0533mWZXoN
         gbtrsH9J78/+5uEAnzL32IMq6BV13r70lTnFbKlLjMVPp3lOJdyGelV7aQBHU2A7JOsL
         NxfimupxK9yWMixZmRZh/mzfNlOy4otW78R2BB4ODwqllvNUg0VPhdEJBO7lUV/uvObf
         ToZ4k5nA3YNIOhAXTlpk//PBkMZ851mXUoGhjHPL5pk/7m62rEf89MnYmQc96l5cjPHl
         X3XA==
X-Gm-Message-State: AOAM532U18SDfwtES7mxBPUCc5MxqXjl6rz6R/TVbI27iJ8c3idBOPLi
        mdGMGkiSy5Sh1iHTta5ZZcq1GYd4qefdHuR8MF6cQg==
X-Google-Smtp-Source: ABdhPJwXWd4wsHdDJkFYzbt6LBUhiADRG/pB6O4X11PD74be3EVcFM2GkICwtNKKHM8AGX6sxX7L3A7c5Y9ETsF8L+M=
X-Received: by 2002:a19:4a88:: with SMTP id x130mr658503lfa.31.1603265398035;
 Wed, 21 Oct 2020 00:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Oct 2020 09:29:46 +0200
Message-ID: <CAKfTPtB41JopBq0CZVvo16N1u+2Smmc1TamJXkbTVj-pRJeHzA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: check for idle core
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Tue, 20 Oct 2020 at 19:21, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> On a thread wakeup, the change [1] from runnable load average to load
> average for comparing candidate cores means that recent short-running
> daemons on the core where a thread ran previously can be considered to
> have a higher load than the core performing the wakeup, even when the
> core where the thread ran previously is currently idle.  This can
> cause a thread to migrate, taking the place of some other thread that
> is about to wake up, and so on.  To avoid unnecessary migrations,
> extend wake_affine_idle to check whether the core where the thread
> previously ran is currently idle, and if so return that core as the
> target.
>
> [1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
> load in wakeup path")
>
> This particularly has an impact when using passive (intel_cpufreq)
> power management, where kworkers run every 0.004 seconds on all cores,
> increasing the likelihood that an idle core will be considered to have
> a load.
>
> The following numbers were obtained with the benchmarking tool
> hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
> benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
> tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
> 2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
> management were used.  Times are in seconds.  All experiments use all
> 160 hardware threads.
>
>         v5.9/active             v5.9+patch/active
> bt.C.c  24.725724+-0.962340     23.349608+-1.607214
> lu.C.x  29.105952+-4.804203     25.249052+-5.561617
> sp.C.x  31.220696+-1.831335     30.227760+-2.429792
> ua.C.x  26.606118+-1.767384     25.778367+-1.263850
>
>         v5.9/passive            v5.9+patch/passive
> bt.C.c  25.330360+-1.028316     23.544036+-1.020189
> lu.C.x  35.872659+-4.872090     23.719295+-3.883848
> sp.C.x  32.141310+-2.289541     29.125363+-0.872300
> ua.C.x  29.024597+-1.667049     25.728888+-1.539772
>
> On the smaller data sets (A and B) and on the other NAS benchmarks
> there is no impact on performance.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>

>
> ---
>  kernel/sched/fair.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa4c6227cd6d..9b23dad883ee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5804,6 +5804,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>         if (sync && cpu_rq(this_cpu)->nr_running == 1)
>                 return this_cpu;
>
> +       if (available_idle_cpu(prev_cpu))
> +               return prev_cpu;
> +
>         return nr_cpumask_bits;
>  }
>
>
