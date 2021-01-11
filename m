Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2092F1865
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbhAKOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbhAKOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:37:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480CCC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:37:10 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e7so3804558ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sC4E+CANulYGsf3AD5726pEn2yqMCAtzJ1BXr61X6ow=;
        b=yTq/vdrDwIVDayA1cJV6ja9Z6DxF57PjcMQhP8aoNG7m7JauYmbiTp8g+hhhMF+n6s
         EoFW1GHGuZIkgANK85ueJZbGB7wuuJTSxG0FQucn6xMzCdOKsa8icKKTFBSDgny2Ce5g
         99MSDHDJ3L1UErnvIIrnyulpO8iv8Nvm6MtCSK27sTL+7gbH2JUxbdUVIUM8GnQegCzF
         HSkHE0K2wsn8rsXRiuU7A+1b1IX+zWo7QeRmUtu/pS/rf6W8ZHaDFw4OJcPIm3lrTtBt
         2x5yhRqs3HRhWVU3xzX/smr0p7IPz/RC6ybUar+LVsjqnSwDhQ16yEtSbr3jIVEUZ8pm
         5+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sC4E+CANulYGsf3AD5726pEn2yqMCAtzJ1BXr61X6ow=;
        b=fxtyEG8Zp5//Ud58ovqbtHMJMpYrK44DwtKCnE8OZwd0gqYkLZgOQC2DP0+p31Lxdf
         kp5ODXYFgg9eTh+2Hpev1f67/xSa6vR07sNw2OVeIMxJhgiekOk/6YunjNwKNXhOerCo
         p4aPMIueshMpnyXnKPhox52WfVend/yk7a0AyjGcZ3owfROOh2pqolAndaDdt6KrkF9Q
         UOPiob6wyPYLg7kaF6rXFis49s7OyxmV9/qtRXbeiEaYOE96mqVb8bac/Z+cQWntQqMm
         TemEbVJHwHKZ51mBfhXGKKCXatLLpRFHVE5O7wIpds32/PHeLx6Onu4235spm8bYgwy+
         V/lg==
X-Gm-Message-State: AOAM53129F+NaVfrc0ERYChGnqiKgsgmY7JIWt0qPbIdJbRmmg4NKMiK
        wiMagvVvrzkQO8l6uUpWvtsCGn3ZiiFcpJDx4fq15g==
X-Google-Smtp-Source: ABdhPJyEIIcWqss+gfkcUn2BkBjR9rhWvDUPzf1eebrV5sU3OTEGYbY0bmyXWjq7LWjXt5kTVKdXV5Iw5RR0rGIqS00=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr7009856ljn.176.1610375828612;
 Mon, 11 Jan 2021 06:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com> <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net> <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net> <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
 <20210108161405.GE3592@techsingularity.net>
In-Reply-To: <20210108161405.GE3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Jan 2021 15:36:57 +0100
Message-ID: <CAKfTPtAQuX5ZbzOH_LnFbBRWErP9pcnAVMvVE9qQw1LXouwzog@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost accounting
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 17:14, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Jan 08, 2021 at 04:10:51PM +0100, Vincent Guittot wrote:
> > > > Trying to bias the avg_scan_cost with:  loops <<= 2;
> > > > will just make avg_scan_cost lost any kind of meaning because it
> > > > doesn't reflect the avg cost of scanning a rq anymore
> > > >
> > >
> > > Before the series, the avg_scan_cost also did not represent the cost of
> > > scanning a RQ before either. Treating scan failures and successes equally
> >
> > I agree that the previous avg_scan_cost was not representing a RQ
> > because it was the avg cost of scanning the full domain.
>
> It was not even that. As the full domain was not necessarily scanned at
> all, it simply reflected how much time was spent scanning in general. It
> neither represented an rq scan cost (which is variable due to cache
> traffic) nor did it represent a full domain scan.

My point was mainly that the goal was to monitor the avg scan cost for
the domain (whatever the number of rq effectively checked) so the
duration was impacted by a successful scan that returns earlier

>
> > And we were
> > comparing it with the average idle time (weighted by few factors).
> > And this cost was impacted by the fact that the scan can return early
> > because it found a cpu. This has advantage and drawback but at least
> > stays coherent in what we are comparing
> >
>
> Not really because it represented the cost of a scan of some number of
> rqs from 1 to sd->span_weight.
>
> > Peter's patch wants to move on per rq avg scan cost. And what you're
> > proposing is to add a magic heuristic to bias the per rq which at the
> > end makes this value just an opaque metric.
> >
>
> The metric is a heuristic no matter what. The scan cost of a RQ is not
> fixed as it depends on whether cache data needs to be updated or not. Also
> bear in mind that the first round of results and the results that I posted
> showed that Peter's patch has significant corner cases that the patch
> mitigates. You also note that avg_idle is an unusual metric to compare
> against because it has numerous timing artifacts. At least one of them
> is that we are extrapolating the domain idle time from a single rq which
> is a poor proxy measure when a domain is only partially used. There just
> is not a better one available without heavy writes to sd_llc which causes
> its own set of problems.
>
> > If we really want to keep the impact of early return than IMO we
> > should stay on a full domain scan level instead of a per rq.
> >
>
> That also has the same class of side-effects. Once the scan cost of
> a successful scan is strictly accounted for, there are problems. Even
> tracking the success scans is costly as the CPU clock has to be read and
> sd_llc has to be updated.
>
> > Also, there is another problem (that I'm investigating)  which is that
> > this_rq()->avg_idle is stalled when your cpu is busy. Which means that
> > this avg_idle can just be a very old and meaningless value.
>
> Yes, avg_idle in itself is just the average inter-arrival time between
> a CPU going idle and receiving a wakeup partially bound roughly
> by 2*sysctl_sched_migration_cost. If avg_idle is traced for each
> select_idle_cpu(), it's obvious that it takes time to adjust when a
> load starts.
>
> > I think
> > that we should decay it periodically to reflect there is less and less
> > idle time (in fact no more)  on this busy CPU that never goes to idle.
> > If a cpu was idle for a long period but then a long running task
> > starts, the avg_idle will stay stalled to the large value which is
> > becoming less and less relevant.
>
> While I get what you're saying, it does not help extrapolate what the
> idleness of a domain is.

not but it gives a more up to date view of the idleness of the local
cpu which is better than a stalled value

>
> > At the opposite, a cpu with a short running/idle period task will have
> > a lower avg_idle whereas it is more often idle.
> >
> > Another thing that worries me, is that we use the avg_idle of the
> > local cpu, which is obviously not idle otherwise it would have been
> > selected, to decide how much time we should spend on looking for
> > another idle CPU. I'm not sure that's the right metrics to use
> > especially with a possibly stalled value.
> >
>
> A better estimate requires heavy writes to sd_llc. The cost of that will
> likely offset any benefit gained by a superior selection of a scan
> depth.
>
> Treating a successful scan cost and a failed scan cost as being equal has
> too many corner cases. If we do not want to weight the successful scan
> cost, then the compromise is to keep the old behaviour that accounts for

I think that keeping the current way to scane_cost id the best option for now

> scan failures only (avoids an sd_llc write at least) but base it on the
> estimated scan cost for a single rq. The fact that we do not account for
> scan failures should be explicitly commented so we do not forget it
> again in the future.
>
> --
> Mel Gorman
> SUSE Labs
