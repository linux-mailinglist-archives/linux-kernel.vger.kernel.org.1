Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92136303667
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbhAZGTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbhAYNZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:25:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:24:04 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id q12so17669020lfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34Hjx1PO1OKBRWQUrjxNAC4+pp7naMbUXfnreuKppo0=;
        b=U1BRxsxgIXCQkdb0WfGZa6suAj/6wG3+04a9HPdPlYnpnX1pHCsj+4/RYbxvNDntbz
         bJKJctzgbm/etLBAwiqLEq8ALBDPdKjNL4l8aWc8y2UvDKjrUBTmYLUluzgm7LTjqsSF
         VVowa2M2X+IUhNJL3Hhaf0vMZdkig92DVd35r4Iryl9rNu2v6TnXGf5DzfWikQlbAPgT
         lqS4eScXIHsoy1z79984dOtw8VVqNNru0v6jhtizPxArhQ9w1Y6bL0dzJSJ/oNXP+qcI
         C2o+wU74/Gq2sT8tqz5cBms2PQlcoMp/MiLxW8+VQAGy4LA0QnO7LkQrWoKG8eZNboOR
         5ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34Hjx1PO1OKBRWQUrjxNAC4+pp7naMbUXfnreuKppo0=;
        b=Z7zlUFEJpe41OTpWY0x37jkle2DJJtu5ojlrg9ceGEqeJf4YYSrOgqXh8I+NDvy26s
         273fnaNn0Wl+msTIy78fS0esnUDrwVTIgXN4jTtwvnO6jEJna77vzmJrQh5VhVZ8KvRR
         /k+V8r++vhpbkp3zq0zsok90kaZe01e3xJJjOEh/h7Qpriv2ZqUjFt2+HEGTrKXU5agH
         IruGLHRA1Ot/gWE8fVqwFkucqz/RwBOP3+ZQpOkTAhi6jKfRHnnr+Fz3DIzXbL0DIGN/
         kyy7cn8J/fsCiMoOSGQ9jUAjZzq6481Rutmlk+peo9Qr9Kn2wn3jVvKK956QzzB8ja3A
         MGSA==
X-Gm-Message-State: AOAM531z6Dbo1QNrCQSWmk/uHCpOu4LDhk8Tz00cdLqcAJnD2lBSYiIK
        HNWb5xe6guia/3gnO7FpvZXGperR0RfFVb9sHV0lNQ==
X-Google-Smtp-Source: ABdhPJy0nwZ5Xc+AK9TDpDG68Lvr+X4i3hL2Vjj1dgWwa7U9qcvyGCF00i2TLUkL5k/YTscMh6dKEv2v+PJsmQ1Kl7U=
X-Received: by 2002:a19:ac45:: with SMTP id r5mr283498lfc.305.1611581042784;
 Mon, 25 Jan 2021 05:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com> <20210122183927.ivqyapttzd6lflwk@e107158-lin>
In-Reply-To: <20210122183927.ivqyapttzd6lflwk@e107158-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Jan 2021 14:23:51 +0100
Message-ID: <CAKfTPtA=Cv3N6EQ7UcgeUsRaAMy7U242xzH+rfJJzE73bYFZ5A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 19:39, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 01/22/21 17:56, Vincent Guittot wrote:
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 04a3ce20da67..fe2dc0024db5 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8381,7 +8381,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
> > >         if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> > >                 return false;
> > >
> > > -       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> > > +       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick + (HZ/20)))
> >
> > This condition is there to make sure to update blocked load at most
> > once a tick in order to filter newly idle case otherwise the rate
> > limit is already done by load balance interval
> > This hard coded (HZ/20) looks really like an ugly hack
>
> This was meant as an RFC patch to discuss the problem really.
>
> Joel is seeing update_blocked_averages() taking ~100us. Half of it seems in
> processing __update_blocked_fair() and the other half in sugov_update_shared().
> So roughly 50us each. Note that each function is calling an iterator in

Can I assume that a freq change happens if sugov_update_shared() takes 50us ?
which would mean that the update was useful at the end ?

> return. Correct me if my numbers are wrong Joel.
>
> Running on a little core on low frequency these numbers don't look too odd.
> So I'm not seeing how we can speed these functions up.
>
> But since update_sg_lb_stats() will end up with multiple calls to
> update_blocked_averages() in one go, this latency adds up quickly.
>
> One noticeable factor in Joel's system is the presence of a lot of cgroups.
> Which is essentially what makes __update_blocked_fair() expensive, and it seems
> to always return something has decayed so we end up with a call to
> sugov_update_shared() in every call.
>
> I think we should limit the expensive call to update_blocked_averages() but

At the opposite, some will complain that block values  stay stall to
high value and prevent any useful adjustment.

Also update_blocked average is already rate limited with idle and busy
load_balance

Seems like the problem raised by Joel is the number of newly idle load balance

> I honestly don't know what would be the right way to do it :-/
>
> Or maybe there's another better alternative too..
>
> Thanks
>
> --
> Qais Yousef
>
> >
> > >                 return true;
> > >
> > >         update_blocked_averages(cpu);
> > > --
> > > 2.30.0.280.ga3ce27912f-goog
> > >
