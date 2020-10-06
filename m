Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF680284BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgJFMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJFMqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:46:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D968C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 05:46:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f21so1847867ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jP890aQ29q17O0YA3h3fbo/APME+LuZ0LXeEcHUUP9M=;
        b=xy7wXs/p6Mb8Guvxlk1kOeRr031mUo4NTuTlTeLXOb0PBuKEE3q6x6nAhWyCruWBVm
         v6tXkadbs6Js7050ToSU5eLnz3Q4Cb8hNC3PffAdYpL7iY89G/70lOvpwvWUowg5qfgm
         kPkCil0AJKntT9HQkzBlOS1IAZ6GVUNouyc6gIaPRLS+3j6Twf7NPrdyrLCph2wb2Agq
         XMA7mUpeAGu7tkMCf0vStQLGDbHGzpcHHxRlCBPnw5EUd3hxZP/JTLJZCOM4z+rmO1fQ
         1KW3GmjNAti671ocIy/zItnY4vmgPHGyByWWfeDAdrApnLNxv2cgRroUuzsyphlE5IQm
         tnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jP890aQ29q17O0YA3h3fbo/APME+LuZ0LXeEcHUUP9M=;
        b=FOsoIqo84orPy1LoPkfr8t+BdkaXVcoSrGEw2ieK7I0eYHQEcCWU1TcKw1IWOt3lKG
         opQeG3g+PZ2kS7YuYF5HdUPfdmWJjZJSG2xikPc9kzqTEwNY2WXSPcslJYG1bAYoGmHk
         cF1kaCjJuMWbMlcz/mvb4+5+DGGWCy/cQhMhH2GWUrU/Hs5rKNHzS4WVcxLle8CDRRuI
         mkjajLCvc9nLx1j/ykt2IpxFDwUVXBVASpzMo33n41r1ctduutubN/Ee69P8QLT7y8IS
         8aOGxz2xsEllMcou5lSjRiPFMTC5dNoa61BodDn8Fu0+JZsRr9RwDXa5iwfstWAhMWmG
         SE7g==
X-Gm-Message-State: AOAM5303KOjdkcZjEtzh61SVQ9Gya01dXfPFcXR5VlA3UrR2CfsFVHxt
        1hB+Nsh9JQI+8HGybZJi98NTLG0HjzR0TJnlaM9/1A==
X-Google-Smtp-Source: ABdhPJxxoG/yzntRtW8FNpGjW0u1GohWgtoWpmZB2YK6r+6la/bAh8s1+lit1ut6jon3t7AhMX6AN8lNbsbksztijZs=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr1839351ljn.226.1601988399515;
 Tue, 06 Oct 2020 05:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201005145717.346020688@infradead.org> <20201005150921.661842442@infradead.org>
In-Reply-To: <20201005150921.661842442@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Oct 2020 14:46:28 +0200
Message-ID: <CAKfTPtDr+pOxEninW5m_R6bKPWqwpFYsrHVLcQ-LimLvk3hDAw@mail.gmail.com>
Subject: Re: [PATCH -v2 07/17] sched: Fix hotplug vs CPU bandwidth control
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 at 17:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Since we now migrate tasks away before DYING, we should also move
> bandwidth unthrottle, otherwise we can gain tasks from unthrottle
> after we expect all tasks to be gone already.
>
> Also; it looks like the RT balancers don't respect cpu_active() and
> instead rely on rq->online in part, complete this. This too requires
> we do set_rq_offline() earlier to match the cpu_active() semantics.
> (The bigger patch is to convert RT to cpu_active() entirely)
>
> Since set_rq_online() is called from sched_cpu_activate(), place
> set_rq_offline() in sched_cpu_deactivate().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c     |   14 ++++++++++----
>  kernel/sched/deadline.c |    5 +----
>  kernel/sched/rt.c       |    5 +----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6979,6 +6979,8 @@ int sched_cpu_activate(unsigned int cpu)
>
>  int sched_cpu_deactivate(unsigned int cpu)
>  {
> +       struct rq *rq = cpu_rq(cpu);
> +       struct rq_flags rf;
>         int ret;
>
>         set_cpu_active(cpu, false);
> @@ -6993,6 +6995,14 @@ int sched_cpu_deactivate(unsigned int cp
>
>         balance_push_set(cpu, true);
>
> +       rq_lock_irqsave(rq, &rf);
> +       if (rq->rd) {
> +               update_rq_clock();

Tried to compile but rq parameter is missing

> +               BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
> +               set_rq_offline(rq);
> +       }
> +       rq_unlock_irqrestore(rq, &rf);
> +
>  #ifdef CONFIG_SCHED_SMT
>         /*
>          * When going down, decrement the number of cores with SMT present.
> @@ -7074,10 +7084,6 @@ int sched_cpu_dying(unsigned int cpu)
>         sched_tick_stop(cpu);
>
>         rq_lock_irqsave(rq, &rf);
> -       if (rq->rd) {
> -               BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
> -               set_rq_offline(rq);
> -       }
>         BUG_ON(rq->nr_running != 1);
>         rq_unlock_irqrestore(rq, &rf);
>
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -543,7 +543,7 @@ static int push_dl_task(struct rq *rq);
>
>  static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
>  {
> -       return dl_task(prev);
> +       return rq->online && dl_task(prev);
>  }
>
>  static DEFINE_PER_CPU(struct callback_head, dl_push_head);
> @@ -2326,9 +2326,6 @@ static void rq_online_dl(struct rq *rq)
>  /* Assumes rq->lock is held */
>  static void rq_offline_dl(struct rq *rq)
>  {
> -       if (rq->dl.overloaded)
> -               dl_clear_overload(rq);
> -
>         cpudl_clear(&rq->rd->cpudl, rq->cpu);
>         cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
>  }
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -265,7 +265,7 @@ static void pull_rt_task(struct rq *this
>  static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
>  {
>         /* Try to pull RT tasks here if we lower this rq's prio */
> -       return rq->rt.highest_prio.curr > prev->prio;
> +       return rq->online && rq->rt.highest_prio.curr > prev->prio;
>  }
>
>  static inline int rt_overloaded(struct rq *rq)
> @@ -2245,9 +2245,6 @@ static void rq_online_rt(struct rq *rq)
>  /* Assumes rq->lock is held */
>  static void rq_offline_rt(struct rq *rq)
>  {
> -       if (rq->rt.overloaded)
> -               rt_clear_overload(rq);
> -
>         __disable_runtime(rq);
>
>         cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);
>
>
