Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B462D576B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgLJJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgLJJlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:41:21 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA413C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:40:40 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so7289249lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Oz3XyGar5DY4ukK7u0T8qX+eQtGEdqnfVQGtlXZsqY=;
        b=WfDK72ejAYpXCWxqemFXKN9iwDNuhlhFo0QqHiK1ergzlGDkV0X0lPXhG3XgISzdIj
         pwbAquS8uVfh/Y2M6aL+uCzlTqtFd1Xjr8dllKTuk1/AqaOysVPhAmc/owqaAK9TugDd
         59zLlyBKhVjvFxXJCBeSpq2rqz5kIN8Y3WwKmAG4ObHYRoOa/vmBT+nzVBmhR4WD6qBu
         pQqHGHS9cIQRDIets9udVVsjjozaoFb5oFIjekc6DmFhD3wSdL0x7MdI4QxG2D1Lx5yN
         XRN/B2KAgyZklE6/KfGQVvQQ7dJeN91it/MsbTOA7PdeEHtyK5fNo9rmWRlwxR2amz91
         P3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Oz3XyGar5DY4ukK7u0T8qX+eQtGEdqnfVQGtlXZsqY=;
        b=dNiVML3tzcj2UDAyWwEF7oOSH2ukkd5VwlF8sccH8f+LcKjs7XCRnOrB8MXmt2dAZQ
         QmV95WprOdMMz8l0gZ2oxi/iKT6tzmw8CXYSBnJZFFyTkewhUS1DXyXiDlHqn1XnrA9g
         4lvRuVo91kSe908KVrSgUR18w2rZnFvLUOfxJ+j7UHhDEQOtAAhlqkOdXdaN2UE6NeXd
         54BsFZT1UXm5qAXAiYIZsX4IAf6fA6EAKarTnprDq6OCOtiW4/qyKSx0sNXYGu53dOOa
         RQlcwgTX05sflKUZ01DQt8RIB0HbrtlxK5sR5DvxQLhvJcdsyjrbm03Yf5L5jlnLTzO/
         l9Rg==
X-Gm-Message-State: AOAM5327xHu855LuUsK+S0xGj261VDLNGARAesq21cEXiqj1nKISlqfG
        c+Fg84vvTJSwbylGvxC720sONAZIFYi32/S0G22BFw==
X-Google-Smtp-Source: ABdhPJwRIhQY3FmImfOqo+q2eMyZ8PhEijpJbDM22u1LXfUlXG5fPdNviu8pG9ZcmMZPhQo9bFsvhRbuPiwCqiWhF80=
X-Received: by 2002:a19:2d47:: with SMTP id t7mr2442999lft.233.1607593239192;
 Thu, 10 Dec 2020 01:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201208153501.1467-4-mgorman@techsingularity.net> <CAKfTPtD+d2wdPVg1f5YXe-rvHHd6m=nB64v60KNGeh-u3=rMTQ@mail.gmail.com>
In-Reply-To: <CAKfTPtD+d2wdPVg1f5YXe-rvHHd6m=nB64v60KNGeh-u3=rMTQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Dec 2020 10:40:28 +0100
Message-ID: <CAKfTPtCZt7gXZiuYEkNrUdr1PWoMTQRVJd2C36NPaXQkGbNpkQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/fair: Do not replace recent_used_cpu with the
 new target
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 17:14, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Tue, 8 Dec 2020 at 16:35, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > After select_idle_sibling, p->recent_used_cpu is set to the
> > new target. However on the next wakeup, prev will be the same as
> > recent_used_cpu unless the load balancer has moved the task since the last
> > wakeup. It still works, but is less efficient than it can be after all
> > the changes that went in since that reduce unnecessary migrations, load
> > balancer changes etc.  This patch preserves recent_used_cpu for longer.
> >
> > With tbench on a 2-socket CascadeLake machine, 80 logical CPUs, HT enabled
> >
> >                           5.10.0-rc6             5.10.0-rc6
> >                          baseline-v2           altrecent-v2
> > Hmean     1        508.39 (   0.00%)      502.05 *  -1.25%*
> > Hmean     2        986.70 (   0.00%)      983.65 *  -0.31%*
> > Hmean     4       1914.55 (   0.00%)     1920.24 *   0.30%*
> > Hmean     8       3702.37 (   0.00%)     3663.96 *  -1.04%*
> > Hmean     16      6573.11 (   0.00%)     6545.58 *  -0.42%*
> > Hmean     32     10142.57 (   0.00%)    10253.73 *   1.10%*
> > Hmean     64     14348.40 (   0.00%)    12506.31 * -12.84%*
> > Hmean     128    21842.59 (   0.00%)    21967.13 *   0.57%*
> > Hmean     256    20813.75 (   0.00%)    21534.52 *   3.46%*
> > Hmean     320    20684.33 (   0.00%)    21070.14 *   1.87%*
> >
> > The different was marginal except for 64 threads which showed in the
> > baseline that the result was very unstable where as the patch was much
> > more stable. This is somewhat machine specific as on a separate 80-cpu
> > Broadwell machine the same test reported.
> >
> >                           5.10.0-rc6             5.10.0-rc6
> >                          baseline-v2           altrecent-v2
> > Hmean     1        310.36 (   0.00%)      291.81 *  -5.98%*
> > Hmean     2        340.86 (   0.00%)      547.22 *  60.54%*
> > Hmean     4        912.29 (   0.00%)     1063.21 *  16.54%*
> > Hmean     8       2116.40 (   0.00%)     2103.60 *  -0.60%*
> > Hmean     16      4232.90 (   0.00%)     4362.92 *   3.07%*
> > Hmean     32      8442.03 (   0.00%)     8642.10 *   2.37%*
> > Hmean     64     11733.91 (   0.00%)    11473.66 *  -2.22%*
> > Hmean     128    17727.24 (   0.00%)    16784.23 *  -5.32%*
> > Hmean     256    16089.23 (   0.00%)    16110.79 *   0.13%*
> > Hmean     320    15992.60 (   0.00%)    16071.64 *   0.49%*
> >
> > schedstats were not used in this series but from an earlier debugging
> > effort, the schedstats after the test run were as follows;
> >
> > Ops SIS Search               5653107942.00  5726545742.00
> > Ops SIS Domain Search        3365067916.00  3319768543.00
> > Ops SIS Scanned            112173512543.00 99194352541.00
> > Ops SIS Domain Scanned     109885472517.00 96787575342.00
> > Ops SIS Failures             2923185114.00  2950166441.00
> > Ops SIS Recent Used Hit           56547.00   118064916.00
> > Ops SIS Recent Used Miss     1590899250.00   354942791.00
> > Ops SIS Recent Attempts      1590955797.00   473007707.00
> > Ops SIS Search Efficiency             5.04           5.77
> > Ops SIS Domain Search Eff             3.06           3.43
> > Ops SIS Fast Success Rate            40.47          42.03
> > Ops SIS Success Rate                 48.29          48.48
> > Ops SIS Recent Success Rate           0.00          24.96
> >
> > First interesting point is the ridiculous number of times runqueues are
> > enabled -- almost 97 billion times over the course of 40 minutes
> >
> > With the patch, "Recent Used Hit" is over 2000 times more likely to
> > succeed. The failure rate also increases by quite a lot but the cost is
> > marginal even if the "Fast Success Rate" only increases by 2% overall. What
> > cannot be observed from these stats is where the biggest impact as these
> > stats cover low utilisation to over saturation.
> >
> > If graphed over time, the graphs show that the sched domain is only
> > scanned at negligible rates until the machine is fully busy. With
> > low utilisation, the "Fast Success Rate" is almost 100% until the
> > machine is fully busy. For 320 clients, the success rate is close to
> > 0% which is unsurprising.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

This patch is responsible for a performance regression on my thx2 with
hackbench. So although i reviewed it, it should not be applied as the
change in the behavior is far deeper than expected

>
> > ---
> >  kernel/sched/fair.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5c41875aec23..413d895bbbf8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6277,17 +6277,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >
> >         /* Check a recently used CPU as a potential idle candidate: */
> >         recent_used_cpu = p->recent_used_cpu;
> > +       p->recent_used_cpu = prev;
> >         if (recent_used_cpu != prev &&
> >             recent_used_cpu != target &&
> >             cpus_share_cache(recent_used_cpu, target) &&
> >             (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> >             cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> >             asym_fits_capacity(task_util, recent_used_cpu)) {
> > -               /*
> > -                * Replace recent_used_cpu with prev as it is a potential
> > -                * candidate for the next wake:
> > -                */
> > -               p->recent_used_cpu = prev;
> >                 return recent_used_cpu;
> >         }
> >
> > @@ -6768,9 +6764,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >         } else if (wake_flags & WF_TTWU) { /* XXX always ? */
> >                 /* Fast path */
> >                 new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> > -
> > -               if (want_affine)
> > -                       current->recent_used_cpu = cpu;
> >         }
> >         rcu_read_unlock();
> >
> > --
> > 2.26.2
> >
