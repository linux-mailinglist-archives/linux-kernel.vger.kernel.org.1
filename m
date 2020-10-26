Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A411D298847
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771690AbgJZI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:28:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39334 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771683AbgJZI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:28:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id 184so10636214lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4q79d55ID3Bf9O2H+Un8Zr9ufQ3leLyMW7CEeiGEmtE=;
        b=XBdr2IkuNHK2a0R61eLOEMb/qNEha7Oxs9+R/wiQRJeZUF3cIousXkxwQdgl15gzVA
         Fyc0Vr3A2hO2cDOIaoH6TGTBWsnak1pZCaSKMJoeCcg8Vxolc1IymOGLyS7kW4c0mKto
         hmuA0xrfDwI+hONsw1TjVSUhjL96t+raB2fO62AGghwKuplvvYiIxqiBgQaft/Yickh1
         phdZu4XRvlKMKWBx0xifEbVjBoxkdQfKlZAOO9QKAXy554M1uiE9ImglWqBs9wEhQGkJ
         A+NPg8XvX6EV5sN2ju+AeGHoKCKQ6hTkWNvJFgjyxIyr5s9d0Qj6MCA1ofa6/MBBdmhD
         vTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4q79d55ID3Bf9O2H+Un8Zr9ufQ3leLyMW7CEeiGEmtE=;
        b=Ay7ehjjd6tsT2GRf9mwG/3iohGFkSKTS0wJ/G37YD/cC0RS7d1fns3SUo6DsfPU1qX
         YkdvCzQ44B5F3LbRdSzrPBTP9TycMwog03PD3fiCVK3jNDNSf8brOrW5mUcXlrAp5x0m
         2JG54xHsnT3mwffvJtlU/3mN4ZlF06XUSeZC1qkwsFf9irnItSIsrSRu1EEn0pU697wa
         gx3jHVzswwz3f84XUeKjCB+kXfyI8dqSoMPpWi69VrmUfRnJVozVBZ7zasPyJGhaIex7
         hHZhWADaIyZziR+3RxB6t31fXyB7C1ICfYkZ2HuMzJ+G1+2ALX9HVAmTnTvIHvP3/0yB
         Hi4w==
X-Gm-Message-State: AOAM531XZN1atw0sbqYf8y8MBvYFB8M4r+CLVo4cCkXa770hMGkPqtT/
        P38jwqA3t2QarvycQkcEwuWaD+5qZXS+HfUOb4Wcbw==
X-Google-Smtp-Source: ABdhPJyAZ1kYr8wb0J+VNfSip1H3LgwRgXs/qQ2d44b3JJ0rJyyfQXycIaLmqhsl3/rS/34EUnCesEou2UWBIXJ3Wtk=
X-Received: by 2002:a19:4a88:: with SMTP id x130mr4401986lfa.31.1603700878745;
 Mon, 26 Oct 2020 01:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201022134354.3485-1-vincent.guittot@linaro.org>
 <jhj1rhqqplq.mognet@arm.com> <CAKfTPtBP8GntXP40mkq6NeppeFU1vZfFN_u41Athwouw-BBAMA@mail.gmail.com>
 <2a2699ee-e62f-1590-c846-009af0478c59@arm.com>
In-Reply-To: <2a2699ee-e62f-1590-c846-009af0478c59@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Oct 2020 09:27:47 +0100
Message-ID: <CAKfTPtBFy2aG3wVAgF2CwhORBn194dm7M_4RpCAm5YpUv8YPpQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: prefer prev cpu in asymmetric wakeup path
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 at 19:14, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 22/10/2020 17:33, Vincent Guittot wrote:
> > On Thu, 22 Oct 2020 at 16:53, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >>
> >> Hi Vincent,
> >>
> >> On 22/10/20 14:43, Vincent Guittot wrote:
>
> [...]
>
> >>>  static int
> >>> -select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >>> +select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int prev, int target)
> >>>  {
> >>>       unsigned long best_cap = 0;
> >>>       int cpu, best_cpu = -1;
> >>> @@ -6178,9 +6178,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >>>
> >>>       sync_entity_load_avg(&p->se);
> >>>
> >>> +     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> >>> +         task_fits_capacity(p, capacity_of(target)))
> >>> +             return target;
> >>> +
> >>
> >> I think we still need to check for CPU affinity here.
> >
> > yes good point
>
> We don't check CPU affinity on target and prev in the symmetric case.

Yes that's what i have noticed while reworking the patch to merge asym
and symmetric
>
> I always thought that since we:
>
> (1) check 'want_affine = ... && cpumask_test_cpu(cpu, p->cpus_ptr);' in
>     select_task_rq_fair() and
>
> (2) we have the select_fallback_rq() in select_task_rq() for prev
>
> that this would be sufficient?
>
> [...]
