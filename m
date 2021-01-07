Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E892ED3D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbhAGQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAGQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:01:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0370C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:01:06 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 23so15657512lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbH1SU/ruZ1vJXPdJiQDwDjioZXlaRMWkVmWvW//4OY=;
        b=QrEGzhhRgk+vhoHJ3PAEhz50M+p5lrffCNc+dUoxhM2OXVD/uCEhB82SsQDQiSyoIP
         PcyTcqgdLFNXVb0Y19uLS+9M0YWMnTLfobm9+WUdka2pxcYX0ru4i3XsFdLJgYsBI0Bp
         N/ggWaFUMDAlQc4Vew5Nc/64TXk3WDqFUjN7dp69DwTfWGtUt96qiDYDiR9yd+iYfVAA
         8EuP3QsraeOnDH6G/Pve5UJm3CbKQKKjsSRhMrgzp7Hi5XVJNeB+tlpFIYLQxeO4sBg+
         LBL8e3AvWIllDcyTznEZlSd+Qudo/j6HnoiauJ/xG0Eyhu7zHD2asal1zRGEcSZHJnR0
         65yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbH1SU/ruZ1vJXPdJiQDwDjioZXlaRMWkVmWvW//4OY=;
        b=LLwjR0nbJCbniOG6ZNxAL3ylGQKyfG9l22DDdW7hZEXzEIyZsujy0ahe8d43Z+6zJM
         OZUm+Kh/K8D6TtlSol3P3gZYlvVJLG++nWugwnlls/jAlowmPwE37nGT2HbHJRuVKJh0
         e/2NhY1zmm5V+6jqerKHFh7FarUF6LJJ4ln88Aq6ZIhI/wfyacS+RZO+Fcmk//s+MWXI
         H9MgmicjyrrJMuRjHVlUjefx7Ceaevivdd/ljJ6ElPiSve6m75qeMAcheIYbGabhKM7S
         98Yj45QdkMimpqiftVnlqLvKi2/ZoPnMFyidfF6RNu6RxtwBwMwuvRiU4q0lM3hnPRwZ
         magg==
X-Gm-Message-State: AOAM53007YKJ3SoQ4Usy1v5Md5dv438a4eRblZDaos7Gl8RhvpQ/Ljrg
        p+gKYxzY63QubFdqchjUC+wSXQD4nWNjzEqxTw0JvQ==
X-Google-Smtp-Source: ABdhPJyQIUS/iml4N4Cs8h84Xxoecy/E5sNS2fjPk+wosruwjf15v6cU6AS7Y+7LAkKKJMN5KifyXYGXxFMQ8r9fG0g=
X-Received: by 2002:ac2:4d91:: with SMTP id g17mr4003001lfe.254.1610035264994;
 Thu, 07 Jan 2021 08:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
 <20210107103325.30851-3-vincent.guittot@linaro.org> <BN8PR12MB2978EC9CFBAF529C527D05919AAF0@BN8PR12MB2978.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB2978EC9CFBAF529C527D05919AAF0@BN8PR12MB2978.namprd12.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Jan 2021 17:00:53 +0100
Message-ID: <CAKfTPtBrqZQevDmV6QhoOhbdKGSe-AogkjaRNogxQKq_NTiOwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] sched/fair: don't set LBF_ALL_PINNED unnecessarily
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 at 16:08, Tao Zhou <ouwen210@hotmail.com> wrote:
>
> Hi Vincent,
>
> On Thu, Jan 07, 2021 at 11:33:24AM +0100, Vincent Guittot wrote:
> > Setting LBF_ALL_PINNED during active load balance is only valid when there
> > is only 1 running task on the rq otherwise this ends up increasing the
> > balance interval whereas other tasks could migrate after the next interval
> > once they become cache-cold as an example.
> >
> > LBF_ALL_PINNED flag is now always set it by default. It is then cleared
> > when we find one task that can be pulled when calling detach_tasks() or
> > during active migration.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5428b8723e61..a3515dea1afc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9626,6 +9626,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >       env.src_rq = busiest;
> >
> >       ld_moved = 0;
> > +     /* Clear this flag as soon as we find a pullable task */
> > +     env.flags |= LBF_ALL_PINNED;
> >       if (busiest->nr_running > 1) {
> >               /*
> >                * Attempt to move tasks. If find_busiest_group has found
> > @@ -9633,7 +9635,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                * still unbalanced. ld_moved simply stays zero, so it is
> >                * correctly treated as an imbalance.
> >                */
> > -             env.flags |= LBF_ALL_PINNED;
> >               env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> >
> >  more_balance:
> > @@ -9759,10 +9760,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                       if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
> >                               raw_spin_unlock_irqrestore(&busiest->lock,
> >                                                           flags);
> > -                             env.flags |= LBF_ALL_PINNED;
>
> busiest->nr_running > 1, LBF_ALL_PINNED cleared but !ld_moved and get here.
> This is not consistent with the tip sched code because the original code
> from this path unconditionally set LBF_ALL_PINNED. But is this intentional
> to not increase balance interval and allow other tasks migrate not in the
> next balance interval.
>
> In v1, there was a condition here to allow that only one task running on rq
> can set LBF_ALL_PINNED. But in v2, when busiest->nr_running > 1, !ld_moved,
> LBF_ALL_PINNED is not cleared and can get here. Increase the balance interval.
> Not consist with v1. If I am not wrong, need a condition like:
>
>   if (busiest->nr_running != 1 /* && env.flags & LBF_ALL_PINNED */)
>       env.flags &= ~LBF_ALL_PINNED;

if (nr_running > 1) then LBF_ALL_PINNED can't be set when we reach the
active migration  (if (!ld_moved) { ...) because we go to
out_all_pinned if LBF_ALL_PINNED is set and we tried all cpus of the
sched_group

>
> I hope this is not a noise to this new thread.
>
> Thanks,
> Tao
>
> > once they become cache-cold as an example
>
> >                               goto out_one_pinned;
> >                       }
> >
> > +                     /* Record that we found atleast one task that could run on this_cpu */
> > +                     env.flags &= ~LBF_ALL_PINNED;
> > +
> >                       /*
> >                        * ->active_balance synchronizes accesses to
> >                        * ->active_balance_work.  Once set, it's cleared
> > --
> > 2.17.1
> >
