Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68E29EDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgJ2N7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgJ2N6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:58:35 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385FFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:58:35 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id f9so3450712lfq.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuG70p/PNHH0fXRFGKl2mIRzMcvk5iCe2y3MsQ0AjGw=;
        b=ku26SCUmnfE3tlpOOIPg5nfzyiPfiXWcDb84M69hmoq6nHxa52HWz2+SKiWJZkNQii
         kLUmKBJuoSxakGkFlwnqeVkX4JSzUtQdCA2wC2qcyRDfU+OikdRN6bSehnNTNb8SoAkJ
         CCu13zPhMKVEj3QzZfoc1ds/DET5fVH6clKLKI1nKttgOAmUnHwebj2E2uuu2FCqoGiL
         PDPWdkZCQZXLhyGaRIANvVq/O6qSWoG+ZLSpNzSi5GYAaK3Ax7zMpZDdGfN2w8vm6VkO
         FIrkoFcNe/mkEV1TzzpswmcIbDEGSzJgEuXRtQrX9EmgHWjjJyQIKsUaeOi/7jF8FMmh
         IyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuG70p/PNHH0fXRFGKl2mIRzMcvk5iCe2y3MsQ0AjGw=;
        b=haHFucVtngeaoCfn9sdojSikYSBDAW+SCcN788xqV/zuBeBWmIOk1GY1/tZjyKUKGa
         Fs3BIladsc5Id1cAtf0hydl56OH3pFcfX52jKaZAjteRpcfek+p6vEid6SKkbmNkeozN
         lC002FXoRQtAW1zJSRpE3GDpvAkhXntgFb7SgzQV3IaQycwbNNCUM5zoQ95n7pXn8dQ6
         ot4MOA4duSrHHlaifYG2R61Vh9ieOSuuna2Jax1y+BCLEZcm5KXU1Xh57F5iPzEmmi3M
         jOXEBxib5pyIo2Rd+I+YvX6YZlTLx9GctFswxZCkRPORztrNswJac4tusxLFCK0bDfwS
         Y8BA==
X-Gm-Message-State: AOAM533rYbjn4VjvDSRE0MmUYDia26TZ+sJs4qZUYy+IB0OFIvmS/Vzd
        d1V7M2eeCN7iqCMaxpQMunQQWSnIqDxMhlDQKGIjKA==
X-Google-Smtp-Source: ABdhPJzitoFFGtTllZVvZn9ARhw51BbCMYtml+lavoNgufsnLiG0qyjSrdAC9UpxvFE63pnursT+el3fXV0X5qRQvC8=
X-Received: by 2002:ac2:5a4f:: with SMTP id r15mr1854852lfn.258.1603979913627;
 Thu, 29 Oct 2020 06:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174412.680-1-vincent.guittot@linaro.org> <jhjk0v9p9ic.mognet@arm.com>
In-Reply-To: <jhjk0v9p9ic.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Oct 2020 14:58:22 +0100
Message-ID: <CAKfTPtDNzMa_vEr69eUXQBoc_5M978w=m+nykVG40gamz0YBBw@mail.gmail.com>
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

I agree on that but I haven't been able to convince myself that adding
the complexity for the 3 shortcuts (target, prev and recent_used) will
give any benefit.
For example, the problem that I raised with perf bench sched pipe, is
solved on legacy bg.LITTLE with this version because the 2 threads
ends up on the same cache domain

>
> This does require the system to have a decent interconnect, cache snooping
> & co, but that is IMO a requirement of any sane asymmetric system.
>
> To put words into code, this is the kind of check I would see:
>
>   if (static_branch_unlikely(&sched_asym_cpucapacity))
>         return fits_capacity(task_util, capacity_of(cpu));
>   else
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
