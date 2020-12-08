Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B262D2BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgLHNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:25:25 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA8DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 05:24:44 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id w13so10422637lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 05:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2BQFTlmAF0VoZSivAjwMdteB8LaFkS5j4COjgy+4WU=;
        b=L5qV6qz+TJm02IQIwmWHP4QF58cH9gRtwbUR6/jYQzm3GclPzTvfSRqEgVbF+7Z2Hq
         OFovRylyn4vhbQMrL9YPGVN+B32QjjgjcHio9lzXVEy6XprQn0/8D13d/jOAdE0aUIKS
         dPLeDax8fwmkF51cS/QrP637Fho3B3CR7yozuDQR1zM0Q+mp0lPARNSK+Rpzev2DviVH
         ukzQRBuwRmbxFGyRbMa0cVEl3rFtkYqtBLdNvEHWSe/2IWgVGyxGWsZpV/CDrSGxsveZ
         F2+M+cvvOcilCCgVXC4ngZHQH8u0Il6JXyC9JnjWHAqdEDR9vDa46Qx9mJXUFnTur4Nc
         ySww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2BQFTlmAF0VoZSivAjwMdteB8LaFkS5j4COjgy+4WU=;
        b=nvGZXCA5xAc3j+LOo5sNpU52j7q64diOq3DSS7hHkkrpUADJMV//ltJ6a7SppMlXh0
         6R2YY4pBBGYdGHm5WD60x8YLNd7ZgZqtEusEAwg1w77xTHFGTdKv30YvjigrIlPg8fRA
         u5ubdY7LIUja/a7QGAGwc85OOrnC5Bs6SzVxXlsmWISBizX9kJdlcs2gGZbjEXZRpa/Y
         26ybpuorBeVQZ9uZCMMd9eG6YaV+3O1h4Q3XITRSxhbu5juUkByAJjlCAGK70Qw47acl
         73Va3hTi4w7hjDI8PW9cIMincj7NlYHFB70Bk5ylwiL1ek/k46AWnEhZY1Qc35z3iBiM
         HcjQ==
X-Gm-Message-State: AOAM533cHVzX0KrUxFsqtl1no4lforboHTrf4i60DR+YMuBAg0CqyojK
        rm/pjdqvxqNWmQuZg0SHQnuJPH+cK4iSNjVrSluO/g==
X-Google-Smtp-Source: ABdhPJwoCYmdTGueKI6BN1LcxcHhz/X07kMgxe7x2mDLYa1Cr26vIe2DkI3fpmSyBoHgOUVKG5DrMjIDz9cWLT2ObKw=
X-Received: by 2002:a19:ad44:: with SMTP id s4mr9610157lfd.254.1607433883124;
 Tue, 08 Dec 2020 05:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net> <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
 <20201208105900.GG3371@techsingularity.net>
In-Reply-To: <20201208105900.GG3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Dec 2020 14:24:32 +0100
Message-ID: <CAKfTPtBgo5vCrN87fqKjyaowONLMWeUusLmvE4bmGmDq10+Yrw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Tue, 8 Dec 2020 at 11:59, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 08, 2020 at 11:07:19AM +0100, Dietmar Eggemann wrote:
> > On 07/12/2020 10:15, Mel Gorman wrote:
> > > SIS_AVG_CPU was introduced as a means of avoiding a search when the
> > > average search cost indicated that the search would likely fail. It
> > > was a blunt instrument and disabled by 4c77b18cf8b7 ("sched/fair: Make
> > > select_idle_cpu() more aggressive") and later replaced with a proportional
> > > search depth by 1ad3aaf3fcd2 ("sched/core: Implement new approach to
> > > scale select_idle_cpu()").
> > >
> > > While there are corner cases where SIS_AVG_CPU is better, it has now been
> > > disabled for almost three years. As the intent of SIS_PROP is to reduce
> > > the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
> > > on SIS_PROP as a throttling mechanism.
> > >
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > ---
> > >  kernel/sched/fair.c     | 3 ---
> > >  kernel/sched/features.h | 1 -
> > >  2 files changed, 4 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 98075f9ea9a8..23934dbac635 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6161,9 +6161,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > >     avg_idle = this_rq()->avg_idle / 512;
> > >     avg_cost = this_sd->avg_scan_cost + 1;
> > >
> > > -   if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
> > > -           return -1;
> > > -
> > >     if (sched_feat(SIS_PROP)) {
> > >             u64 span_avg = sd->span_weight * avg_idle;
> > >             if (span_avg > 4*avg_cost)
> >
> > Nitpick:
> >
> > Since now avg_cost and avg_idle are only used w/ SIS_PROP, they could go
> > completely into the SIS_PROP if condition.
> >
>
> Yeah, I can do that. In the initial prototype, that happened in a
> separate patch that split out SIS_PROP into a helper function and I
> never merged it back. It's a trivial change.

while doing this, should you also put the update of
this_sd->avg_scan_cost under the SIS_PROP feature ?

>
> Thanks.
>
> --
> Mel Gorman
> SUSE Labs
