Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55E294C92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440216AbgJUM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440121AbgJUM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:27:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378CC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:27:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so2467457ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8W1xkxnlDX18g4L0K2q4D2rLOlGLmCusShXO/rfv2/8=;
        b=zdsmtVKJeSM2j/VCrTg7lUsk9hlTIq6dUyYlBaxiOeDOKN++weuTZPqQURXi5X8rzJ
         4IHq/645fWHJpJBFrMXWSUovHXpmvNm5tmqiXkZGMXIWbe9tFy79V+grYFiMAKzGfJsC
         DJVzvHyPYMiYvAcq8Gp7yO8DD7Pqp1X2+umRmzpTlhbIvAln2xVbJrUidVCy3jlBcIRp
         lzOwlQqV6b3iaebrI5Z55jrRZF6r6UbVuAOCuGWd4vL7vQYxkNgmJyGzp/ghv7cHKLEK
         1mXHf7PtOv/7+Cg2QmEkeSvWGFtOZgTkqPYqhB96BnU5P6LQOfFOu8glgxULXyr+s8bv
         5HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8W1xkxnlDX18g4L0K2q4D2rLOlGLmCusShXO/rfv2/8=;
        b=Abeph12tnz/1EUtrXZ79JuQwuYsR4sHIfS09xRSsVePoQj+h9u66+ZNxuii1JTdcW/
         +FE5tz9bNkcjBHLvsnbTtYh7ZmznlNqvV3uI4t/JFWayR8TYEqLCzDVKOCTjSIR0zXQH
         Yo3SlaBVs1RXXsGCoCfHjX/UoWnBMYgWzVFdumAUmETRHfCySxjawLVdutfIekwjD5Qk
         vLJpASXjffKxR3zBY7rNOPHKspJU39zlgDqbgTm0FhRKV2t7M0zVqe6hJf2n5NCHSy3I
         1uIpsPmsCTxiv4ai3c+9yEcqSqlvCbBKlfkal8EptBOBrDw/svO2EAE/zYVdV/eC7FWZ
         7j9A==
X-Gm-Message-State: AOAM5306k3G+QYFWmmQnlG+uhuGWcDaTcfFzEJvvjrwzAEk0mnxyu0He
        bAECtNY+77PuUe6h9lfIfqq3IBXi511rO852JsyGVA==
X-Google-Smtp-Source: ABdhPJz8tdlE0yL37bi8aSVHR4SVgNiinnmaoK6wpnSI2lSv/I6WLb7ZgeU1BSMMMxxqrfeErKIEAtGMvYQTly/gkqs=
X-Received: by 2002:a2e:8787:: with SMTP id n7mr1357319lji.111.1603283266338;
 Wed, 21 Oct 2020 05:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <CAKfTPtB41JopBq0CZVvo16N1u+2Smmc1TamJXkbTVj-pRJeHzA@mail.gmail.com>
In-Reply-To: <CAKfTPtB41JopBq0CZVvo16N1u+2Smmc1TamJXkbTVj-pRJeHzA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Oct 2020 14:27:34 +0200
Message-ID: <CAKfTPtBhLLSjqAAbN7jO0vDi6Tr8J4CnoggM2DuBU98i9oCmpA@mail.gmail.com>
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

On Wed, 21 Oct 2020 at 09:29, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Julia,
>
> On Tue, 20 Oct 2020 at 19:21, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > On a thread wakeup, the change [1] from runnable load average to load
> > average for comparing candidate cores means that recent short-running
> > daemons on the core where a thread ran previously can be considered to
> > have a higher load than the core performing the wakeup, even when the
> > core where the thread ran previously is currently idle.  This can
> > cause a thread to migrate, taking the place of some other thread that
> > is about to wake up, and so on.  To avoid unnecessary migrations,
> > extend wake_affine_idle to check whether the core where the thread
> > previously ran is currently idle, and if so return that core as the
> > target.
> >
> > [1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
> > load in wakeup path")
> >
> > This particularly has an impact when using passive (intel_cpufreq)
> > power management, where kworkers run every 0.004 seconds on all cores,
> > increasing the likelihood that an idle core will be considered to have
> > a load.
> >
> > The following numbers were obtained with the benchmarking tool
> > hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
> > benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
> > tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
> > 2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
> > management were used.  Times are in seconds.  All experiments use all
> > 160 hardware threads.
> >
> >         v5.9/active             v5.9+patch/active
> > bt.C.c  24.725724+-0.962340     23.349608+-1.607214
> > lu.C.x  29.105952+-4.804203     25.249052+-5.561617
> > sp.C.x  31.220696+-1.831335     30.227760+-2.429792
> > ua.C.x  26.606118+-1.767384     25.778367+-1.263850
> >
> >         v5.9/passive            v5.9+patch/passive
> > bt.C.c  25.330360+-1.028316     23.544036+-1.020189
> > lu.C.x  35.872659+-4.872090     23.719295+-3.883848
> > sp.C.x  32.141310+-2.289541     29.125363+-0.872300
> > ua.C.x  29.024597+-1.667049     25.728888+-1.539772
> >
> > On the smaller data sets (A and B) and on the other NAS benchmarks
> > there is no impact on performance.
> >

A fix tag is missing
Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in
wakeup path")

> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
>
> >
> > ---
> >  kernel/sched/fair.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index aa4c6227cd6d..9b23dad883ee 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5804,6 +5804,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >         if (sync && cpu_rq(this_cpu)->nr_running == 1)
> >                 return this_cpu;
> >
> > +       if (available_idle_cpu(prev_cpu))
> > +               return prev_cpu;
> > +
> >         return nr_cpumask_bits;
> >  }
> >
> >
