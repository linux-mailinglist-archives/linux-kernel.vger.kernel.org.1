Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6A2CEC9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgLDK5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387968AbgLDK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:57:36 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B694CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:56:49 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so6070718ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/ulECtCSXzSKoxUaJ1QEkGElO9ZYt5/QA/JLrUZB0Y=;
        b=lunNdgUHzHWml7dbzizMXhpNiyobkj7YqQ/iJjPQLBkh++DRMYVaU8RKprFK9gwEMj
         UCFH/K+yw2BAwwBcZrUbWsE0z2jHCUhtSqbnXK55r3YcEnE6zZbUrCRK0YDfmS9d3sCG
         Apti7sPF0OsUCK8+oIBqntSGHbz0QWVizsUaIkyf0iAC7CvJ7sm1a1qkNJomjw9bNffo
         XRMmjnWkmhRFltdhAoqWSQ/bG/it3FWwSO9+2lryRgB0KR8jSePb1L+dn8zrg3INDFcw
         lodZUXo0aHqleYah8Kl+2SVXCnKwpQKAcsWMGIPUXXhejPPbsmE7IXYqZxD0bSXXCqMZ
         EnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/ulECtCSXzSKoxUaJ1QEkGElO9ZYt5/QA/JLrUZB0Y=;
        b=NuXPOf0ha3wHeuV4Lm0NbDFGRRZvEPjhjbdZrXp++NppoTaEPsztOmjRr76zBC3jLt
         J88h2aX0LsTMsrDeDHZ7UhTLucZq7uzvXZaT6kpiF2whognjtgVm7arc9b3oCYaLAFvh
         A/XBb1DDcjlvZW/IT3XJkIybyn5GIGba5ZP1Z6WIp5aOMa9CIS8p4GsabuwceHDurYm5
         lzVIcg3C7+OXHT/32L2C051LSMo2CQYxJcbYhKcZLEn7Wny0vMtorrIKz1lUSN6BEYI6
         4/z8+PWHHUyh3sG90+THM1Uzj0gy4O7eb7ORXr1R60xqkQ4jV+obh4io8EIqe0q377RO
         Ivrg==
X-Gm-Message-State: AOAM530+FhROO9ug2iwoS8BKNN3KAcBOAADNvHN7cpvTG0VGpEEPmDRs
        Kw9GS1nW1EevZ6G9n18CR40BwG5JCQbCLftoWRFD/w==
X-Google-Smtp-Source: ABdhPJxiUW3QWdUlQDCH2peBDQGgU56OCiyZEL6Lh5Deq02R0gC4h377qhXEbuPmRcmASLokvURxNfUz+DixsrZ5W+A=
X-Received: by 2002:a2e:b536:: with SMTP id z22mr3145836ljm.177.1607079407960;
 Fri, 04 Dec 2020 02:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net> <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net>
In-Reply-To: <20201203175204.GY3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Dec 2020 11:56:36 +0100
Message-ID: <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
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

On Thu, 3 Dec 2020 at 18:52, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Dec 03, 2020 at 05:38:03PM +0100, Vincent Guittot wrote:
> > On Thu, 3 Dec 2020 at 15:11, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > The target CPU is definitely not idle in both select_idle_core and
> > > select_idle_cpu. For select_idle_core(), the SMT is potentially
> > > checked unnecessarily as the core is definitely not idle if the
> > > target is busy. For select_idle_cpu(), the first CPU checked is
> > > simply a waste.
> >
> > >
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > ---
> > >  kernel/sched/fair.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 68dd9cd62fbd..1d8f5c4b4936 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6077,6 +6077,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> > >                 return -1;
> > >
> > >         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > +       __cpumask_clear_cpu(target, cpus);
> >
> > should clear cpu_smt_mask(target) as we are sure that the core will not be idle
> >
>
> The intent was that the sibling might still be an idle candidate. In
> the current draft of the series, I do not even clear this so that the
> SMT sibling is considered as an idle candidate. The reasoning is that if
> there are no idle cores then an SMT sibling of the target is as good an
> idle CPU to select as any.

Isn't the purpose of select_idle_smt ?

select_idle_core() looks for an idle core and opportunistically saves
an idle CPU candidate to skip select_idle_cpu. In this case this is
useless loops for select_idle_core() because we are sure that the core
is not idle


>
> --
> Mel Gorman
> SUSE Labs
