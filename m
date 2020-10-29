Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8929EE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgJ2OeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgJ2OeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:34:04 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18689C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:34:04 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 141so3592002lfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6YJS0b+pYP/MsynD9GOvCTaXK0yReM+zNE5V4vS6P4=;
        b=QJWQaf9SUm0HHznyoQwA232fVY28NjxzrFJ7jgguXgwPQFYIBTvYC6AfXb+5Hjv2DH
         j3p+SeKY1pkyfbxFoI2f5gR9ynem43x9jgsPsbYgTnqVEQLYDeyWsEIv2LdJf4PBL0vP
         PHMZstsqbRz6DbQbqWrV0vTIxp4l+P4SYCSMUfaGXKFk/y/WOZngL36yJvs3Qyr3Xg81
         OXdoT15wGqcqzR85meb3sbzMbFXo1HCbAK2vmv69i9BhNky5KIvCAHbyFs3ixKOtPVrz
         ebZ5pFCXj7wPZzZ017KUqOGMKWRjS7JmTTiK0ErJ6Ygg9zK25RbEU1iLAYODXBhaXzs/
         GPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6YJS0b+pYP/MsynD9GOvCTaXK0yReM+zNE5V4vS6P4=;
        b=D8xqeSAKL92OkRC56ijSpcn3qJUhxwZXpGSbXGb24d8WswLAZzWLB8pPQQ3u7ca/EP
         PzOcqWIopgxMQO/7eNSJugbxEC7A6af9gtmvdYhjekJXvBmRyfVgV5Hm5IQ0x8duFOeQ
         QPZYUYSwaL9vSWl5M4O9NaQt5YD7henoWU9fe8fS4jCC00e7Axx1u1Sz3hXvG1m1qDRf
         b4SUMMJXSx5YNvcmoArEhHGgep1W9SCCl4MLYA7pG85IiPPXvZ2BKCB6YfFGKElEdQ7r
         8TpgkiLUheCQqhXjZ3qlg8hvggmvBfEPDcOdexMd0jodZggPH8nkJkaEBmg/dsfbhww4
         0uvQ==
X-Gm-Message-State: AOAM533RNcvUHGAAecL7muxwluXG8lt27YjN40GR4axQGDSH/h4uChHM
        DpeNwdgVlvFMH7Zccx9PC3SIDlU/6UZMSNTezJqrsw==
X-Google-Smtp-Source: ABdhPJxDizqKt3I/2bhv+jHrK1Vd+3bWRDMgUkw8weo1WWlXihpsaW0SjegkuhL6itcrZrxKiThlc78pbLwkOJ1iPpE=
X-Received: by 2002:a19:7018:: with SMTP id h24mr1828833lfc.252.1603982042398;
 Thu, 29 Oct 2020 07:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174412.680-1-vincent.guittot@linaro.org>
 <jhjk0v9p9ic.mognet@arm.com> <CAKfTPtC1Y_3-8iRhMDe2eU5MGiHWGV4_Nokiy7LgE2OAnkNE_w@mail.gmail.com>
 <CAKfTPtA-F9RaYJ=mMS84KZfrXnvNru2j=tki+e2Vs9ndgow4NA@mail.gmail.com>
In-Reply-To: <CAKfTPtA-F9RaYJ=mMS84KZfrXnvNru2j=tki+e2Vs9ndgow4NA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Oct 2020 15:33:51 +0100
Message-ID: <CAKfTPtBXZEGNYs00wA7BORcJQ7ZxX+9Di7m7h7x3ZtbYrX4TMw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: prefer prev cpu in asymmetric wakeup path
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tao Zhou <ouwen210@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 at 15:30, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 29 Oct 2020 at 15:19, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 29 Oct 2020 at 12:16, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> > >
> > >
> > > Hi Vincent,
> > >
> > > On 28/10/20 17:44, Vincent Guittot wrote:
> > > > During fast wakeup path, scheduler always check whether local or prev cpus
> > > > are good candidates for the task before looking for other cpus in the
> > > > domain. With
> > > >   commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > > > the heterogenous system gains a dedicated path but doesn't try to reuse
> > > > prev cpu whenever possible. If the previous cpu is idle and belong to the
> > > > LLC domain, we should check it 1st before looking for another cpu because
> > > > it stays one of the best candidate and this also stabilizes task placement
> > > > on the system.
> > > >
> > > > This change aligns asymmetric path behavior with symmetric one and reduces
> > > > cases where the task migrates across all cpus of the sd_asym_cpucapacity
> > > > domains at wakeup.
> > > >
> > > > This change does not impact normal EAS mode but only the overloaded case or
> > > > when EAS is not used.
> > > >
> > > > - On hikey960 with performance governor (EAS disable)
> > > >
> > > > ./perf bench sched pipe -T -l 50000
> > > >              mainline           w/ patch
> > > > # migrations   999364                  0
> > > > ops/sec        149313(+/-0.28%)   182587(+/- 0.40) +22%
> > > >
> > > > - On hikey with performance governor
> > > >
> > > > ./perf bench sched pipe -T -l 50000
> > > >              mainline           w/ patch
> > > > # migrations        0                  0
> > > > ops/sec         47721(+/-0.76%)    47899(+/- 0.56) +0.4%
> > > >
> > > > According to test on hikey, the patch doesn't impact symmetric system
> > > > compared to current implementation (only tested on arm64)
> > > >
> > > > Also read the uclamped value of task's utilization at most twice instead
> > > > instead each time we compare task's utilization with cpu's capacity.
> > > >
> > > > Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >
> > > Other than the below, I quite like this!
> > >
> > > > ---
> > > > Changes in v2:
> > > > - merge asymmetric and symmetric path instead of duplicating tests on target,
> > > >   prev and other special cases.
> > > >
> > > > - factorize call to uclamp_task_util(p) and use fits_capacity(). This could
> > > >   explain part of the additionnal improvement compared to v1 (+22% instead of
> > > >   +17% on v1).
> > > >
> > > > - Keep using LLC instead of asym domain for early check of target, prev and
> > > >   recent_used_cpu to ensure cache sharing between the task. This doesn't
> > > >   change anything for dynamiQ but will ensure same cache for legacy big.LITTLE
> > > >   and also simply the changes.
> > > >
> > >
> > > On legacy big.LITTLE systems, sd_asym_cpucapacity spans all CPUs, so we
> > > would iterate over those in select_idle_capacity() anyway - the policy
> > > we've been going for is that capacity fitness trumps cache use.
> > >
> > > This does require the system to have a decent interconnect, cache snooping
> > > & co, but that is IMO a requirement of any sane asymmetric system.
> > >
> > > To put words into code, this is the kind of check I would see:
> > >
> > >   if (static_branch_unlikely(&sched_asym_cpucapacity))
> > >         return fits_capacity(task_util, capacity_of(cpu));
> > >   else
> >
> > You can't make the shortcut that prev will always belong to the domain
> > so you have to check that prev belongs to the sd_asym_cpucapacity.
> > Even if it's true with current mobile Soc, This code is generic core
> > code and must handle any kind of funny topology than HW guys could
> > imagine
>
> We would have something like that
>
> static inline bool cpus_share_domain(int this_cpu, int that_cpu)
> {
>     if (static_branch_unlikely(&sched_asym_cpucapacity))
>         return per_cpu(sd_asym_cpucapacity, this_cpu) ==
> per_cpu(sd_asym_cpucapacity, that_cpu);

hmm this doesn't work

>
>     return cpus_share_cache(this_cpu, that_cpu);
> }
>
> >
> > >         return cpus_share_cache(cpu, other);
> > >
> > > > - don't check capacity for the per-cpu kthread UC because the assumption is
> > > >   that the wakee queued work for the per-cpu kthread that is now complete and
> > > >   the task was already on this cpu.
> > > >
> > > > - On an asymmetric system where an exclusive cpuset defines a symmetric island,
> > > >   task's load is synced and tested although it's not needed. But taking care of
> > > >   this special case by testing if sd_asym_cpucapacity is not null impacts by
> > > >   more than 4% the performance of default sched_asym_cpucapacity path.
> > > >
> > > > - The huge increase of the number of migration for hikey960 mainline comes from
> > > >   teh fact that the ftrace buffer was overloaded by events in the tests done
> > > >   with v1.
