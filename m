Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408682FCDF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbhATKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbhATJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:22:42 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47991C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:22:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q8so1574164lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVkwJSjkrFocqXuACAgn/hKL0HXwiGKRnmumdPEpTus=;
        b=L5V++/jmonpcsTuSDXM6ABiAc5UM/YB7NcblTg1yFzV0Ua+vm1rc8gcxqW4KEUCfK7
         ardDFvDAAdhV14KzULEiPWWFL1fOq+sxXTjFvK3GRgg9NytEGEDpfqL3HKDJIQpuY2hc
         TlJUDG9ntHbwVlsntLdk21Ka+0bh+AMlIwtX9WNMcgLw645mLMVObNexqehuSMqD29+D
         guNgSpiTCERKLe1rBxkvQklK+1583iJ74yn2IMN9Hvz812hQl/VMuVj1U5gXUmvzMXdJ
         tpsykosB9z7MIP+Fy5R1HhXL5fRNXjEXnjRYdeM8VXzCWGEY1JGYb61WjYvyEms44d7A
         TmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVkwJSjkrFocqXuACAgn/hKL0HXwiGKRnmumdPEpTus=;
        b=DsP50gGRuQkbnv7RB13ZZtThh8vaCGO2wge7W0VdBHn+NmHznM+0RqsFxdyXtLclKc
         wdLqXTDK9xwsqD0M8SLAU/WYT/UrmDdZ2T+MSWE9co0QisMxvtVil1LLehLCNpbfFhie
         f7ezbGFpjIKWfkBXmDuFsoZdRjQneCW9WC9VuR76OWZnZNn/xSf3osLCtCS5afJgYADu
         Jt6p6rJ0HC6rir+y2wG6YFfg7cw1XmIpWPrr+4ewsNHC6Vrp5iZYgquKJ/+YxA7h+iAM
         0Ly29eAVompwslYlBUz3v8DBAdQyB8kJQ1fekKY4i+F2bnviYqRd7EZx7pBviTM32Sqk
         VAjg==
X-Gm-Message-State: AOAM530OJzElPqkaDDglLbgR4SY1KdIpBv3PkS1G2mjzFgtTK1GFpV3d
        m1sv/guH3jp/yuxiBsVDVr0LHiVuq8++sj3HiVW3aWW+9JQ=
X-Google-Smtp-Source: ABdhPJw+O8QER5myZQ7UAlrh/wR7FiJLbl+fsXBvsbh6F4psm79TeDyipxKMQ1NHw82YQLP/Q+R2j4KN6s3X2jaKPWM=
X-Received: by 2002:a19:2d0a:: with SMTP id k10mr4035232lfj.286.1611134518589;
 Wed, 20 Jan 2021 01:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <20210119112211.3196-6-mgorman@techsingularity.net> <20210120083018.GA14462@in.ibm.com>
 <20210120091235.GT3592@techsingularity.net>
In-Reply-To: <20210120091235.GT3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Jan 2021 10:21:47 +0100
Message-ID: <CAKfTPtBYuxKywCPeEd=vYCu31Ni0=uXoJa4v3ZV_T9J0TsVyhg@mail.gmail.com>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 at 10:12, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 20, 2021 at 02:00:18PM +0530, Gautham R Shenoy wrote:
> > > @@ -6157,18 +6169,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > >     }
> > >
> > >     for_each_cpu_wrap(cpu, cpus, target) {
> > > -           if (!--nr)
> > > -                   return -1;
> > > -           if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > -                   break;
> > > +           if (smt) {
> > > +                   i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > +                   if ((unsigned int)i < nr_cpumask_bits)
> > > +                           return i;
> > > +
> > > +           } else {
> > > +                   if (!--nr)
> > > +                           return -1;
> > > +                   i = __select_idle_cpu(cpu);
> > > +                   if ((unsigned int)i < nr_cpumask_bits) {
> > > +                           idle_cpu = i;
> > > +                           break;
> > > +                   }
> > > +           }
> > >     }
> > >
> > > -   if (sched_feat(SIS_PROP)) {
> > > +   if (smt)
> > > +           set_idle_cores(this, false);
> >
> > Shouldn't we set_idle_cores(false) only if this was the last idle
> > core in the LLC ?
> >
>
> That would involve rechecking the cpumask bits that have not been
> scanned to see if any of them are an idle core. As the existance of idle
> cores can change very rapidly, it's not worth the cost.

But don't we reach this point only if we scanned all CPUs and didn't
find an idle core ?
If there is an idle core, it returns early
And in case of smt == true, nr is set to INt_MAX and we loop on all CPUs/cores

>
> --
> Mel Gorman
> SUSE Labs
