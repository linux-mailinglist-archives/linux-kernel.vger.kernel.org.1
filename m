Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB629EE16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgJ2OVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2OTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:19:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:19:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v6so3465282lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xqLKgQRn4fpYiHgxV46U11c/D01Rgj11cfaVUanRmw=;
        b=x8cC4cmzeQg08xXTxSBFjzWkzLcXBVdIw9nGwuLC3vpGBVTLevO+J7FiT4jl6TqfeQ
         uIs4RykVVQGaZ1Icy2q0v4twYtkNXnQH9oMapNgXu9+pypeLoUmYvpKQ6N7xJHIbHoh1
         EjM+cVwKsdFyWlu+K4IB3TEP2e4auq5ulTeTzw6PmMm5TwJa7K32SIOZPs47P9LX5RfG
         u0u4CoFKXsEKW9MhaqM7fg1yZFf4XkZzl0QLwh1wsdw98njE+ShGMws2QCMFrDiNCEZD
         KkzM6KgCDNgu1nRpKx4k5HT07mgl2+8fivFMdup4xwfaADM/C/5qtpVGniDAkT75MhxO
         f6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xqLKgQRn4fpYiHgxV46U11c/D01Rgj11cfaVUanRmw=;
        b=Qo9WIZy3lJxa5YWbzhQue+Hk+r0z9vvkhS0Nrum4JOAXvBjvmSnZz46LaWJByjC57Z
         GX6HJ/8ZCN085fH4qX3xf/g7IyA11TYEdddXFekWp6kt3JMIqSHn2bFGvfD77GVCczLA
         RAdnyKBYrjJ/Nwb/TX4q86Rih+4gbyOSxee5pixgVTuq5j4PvowjpMFkpZqEsBqYdMiQ
         3NTy5IB8g41p/FXVPnIB+WQ6QQnOI3uU0NRJNWiwFv0pTfmHWZ1N00kqqzrWHr+LkEs/
         FViY6Y1F1E0TQRri4BgaYAcRwWEXa0EQujfG8vxCJanNv4CdSKH/ppci825Tl5m/6VSj
         hBeg==
X-Gm-Message-State: AOAM532HDLgIXfijwyMnImYVRp3w2WtwCafQyInSBT5TQ6wgsePsjyM0
        is9JMU8qT6Uxs/AsKFyL/HplhCPGTm00qeWq65dSsQ==
X-Google-Smtp-Source: ABdhPJy05mIFD2bOeXR512eQPI6zIIpBv0eUC8fW0ZBaANVhJhL3/j+WP52rn+FKg0p15VT3GaFo17fSR0uM0QJxFWQ=
X-Received: by 2002:a19:7018:: with SMTP id h24mr1806416lfc.252.1603981191660;
 Thu, 29 Oct 2020 07:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174412.680-1-vincent.guittot@linaro.org> <jhjk0v9p9ic.mognet@arm.com>
In-Reply-To: <jhjk0v9p9ic.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Oct 2020 15:19:39 +0100
Message-ID: <CAKfTPtC1Y_3-8iRhMDe2eU5MGiHWGV4_Nokiy7LgE2OAnkNE_w@mail.gmail.com>
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

On Thu, 29 Oct 2020 at 12:16, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> Hi Vincent,
>
> On 28/10/20 17:44, Vincent Guittot wrote:
> > During fast wakeup path, scheduler always check whether local or prev cpus
> > are good candidates for the task before looking for other cpus in the
> > domain. With
> >   commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > the heterogenous system gains a dedicated path but doesn't try to reuse
> > prev cpu whenever possible. If the previous cpu is idle and belong to the
> > LLC domain, we should check it 1st before looking for another cpu because
> > it stays one of the best candidate and this also stabilizes task placement
> > on the system.
> >
> > This change aligns asymmetric path behavior with symmetric one and reduces
> > cases where the task migrates across all cpus of the sd_asym_cpucapacity
> > domains at wakeup.
> >
> > This change does not impact normal EAS mode but only the overloaded case or
> > when EAS is not used.
> >
> > - On hikey960 with performance governor (EAS disable)
> >
> > ./perf bench sched pipe -T -l 50000
> >              mainline           w/ patch
> > # migrations   999364                  0
> > ops/sec        149313(+/-0.28%)   182587(+/- 0.40) +22%
> >
> > - On hikey with performance governor
> >
> > ./perf bench sched pipe -T -l 50000
> >              mainline           w/ patch
> > # migrations        0                  0
> > ops/sec         47721(+/-0.76%)    47899(+/- 0.56) +0.4%
> >
> > According to test on hikey, the patch doesn't impact symmetric system
> > compared to current implementation (only tested on arm64)
> >
> > Also read the uclamped value of task's utilization at most twice instead
> > instead each time we compare task's utilization with cpu's capacity.
> >
> > Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Other than the below, I quite like this!
>
> > ---
> > Changes in v2:
> > - merge asymmetric and symmetric path instead of duplicating tests on target,
> >   prev and other special cases.
> >
> > - factorize call to uclamp_task_util(p) and use fits_capacity(). This could
> >   explain part of the additionnal improvement compared to v1 (+22% instead of
> >   +17% on v1).
> >
> > - Keep using LLC instead of asym domain for early check of target, prev and
> >   recent_used_cpu to ensure cache sharing between the task. This doesn't
> >   change anything for dynamiQ but will ensure same cache for legacy big.LITTLE
> >   and also simply the changes.
> >
>
> On legacy big.LITTLE systems, sd_asym_cpucapacity spans all CPUs, so we
> would iterate over those in select_idle_capacity() anyway - the policy
> we've been going for is that capacity fitness trumps cache use.
>
> This does require the system to have a decent interconnect, cache snooping
> & co, but that is IMO a requirement of any sane asymmetric system.
>
> To put words into code, this is the kind of check I would see:
>
>   if (static_branch_unlikely(&sched_asym_cpucapacity))
>         return fits_capacity(task_util, capacity_of(cpu));
>   else

You can't make the shortcut that prev will always belong to the domain
so you have to check that prev belongs to the sd_asym_cpucapacity.
Even if it's true with current mobile Soc, This code is generic core
code and must handle any kind of funny topology than HW guys could
imagine

>         return cpus_share_cache(cpu, other);
>
> > - don't check capacity for the per-cpu kthread UC because the assumption is
> >   that the wakee queued work for the per-cpu kthread that is now complete and
> >   the task was already on this cpu.
> >
> > - On an asymmetric system where an exclusive cpuset defines a symmetric island,
> >   task's load is synced and tested although it's not needed. But taking care of
> >   this special case by testing if sd_asym_cpucapacity is not null impacts by
> >   more than 4% the performance of default sched_asym_cpucapacity path.
> >
> > - The huge increase of the number of migration for hikey960 mainline comes from
> >   teh fact that the ftrace buffer was overloaded by events in the tests done
> >   with v1.
