Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D82E2885F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbgJIJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgJIJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:33:28 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E8C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:33:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id j21so2846229uak.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v+fxjFTNy9qYOdGWYnBZ+Bx12EHqMqR1doJg1uBh8u0=;
        b=i1b6EK1fWOJb9kYRbX98lfmNYVVSmPCgLqpCmdiRqudgjdZOloSaF0KsW7sQtSnr3m
         R9ex/tHUlI0dVNpPLsaRmoaXairgEGDFxsz3+ofWgWg2WODTvnPSNkf/4JXY3Ya+Xwvg
         s2pq7LO+4AhtwlmmqSfAcBrqqaIli2hM1rXmw3voE5pl5jZorKoD71BzAz832pdbMfZd
         P3jqHCi0GyBEqvsiSVxtUUfvspvfBpPONdlNjBufCgSLc53ObI8IaBzNOOd3ZAZGrHkc
         pOYgKfba/G5/x0SiiYh84PnbzFxc6iRFR/xFFAgvKdSAU8RzprFAp2FicmJFOy99OCzP
         /4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v+fxjFTNy9qYOdGWYnBZ+Bx12EHqMqR1doJg1uBh8u0=;
        b=hhfwtVdKl1/v53pwkYseO+YmIDnS+JeoOuK6Bb/6a0DxzzLEFqxw7HmNJag83ZPP5z
         Y2PWS9Zwgt5z3OiNvCqb6R0qB7+0bpDbFOfSgaR6FxnpZkqTDdlGHOD3WLSTOzzYrsPy
         eozmv0I1njcWMqhNzADQfSO+aWbcMp6pZ9+mSOKr1tSV6AJQQ9BQJJNEmhUu9hC8up9I
         WTEc7axS6ecPsEhDfmN/b0CJjOYWf7aC5l8eYTus3blXweAiqtlVW0znB3nX6UcbOxBv
         0seICEVkA7460gBssi4OBPcWAQnfF+kukitztmIBEu731QSAGqR0X3pc8sZkdvk+CqM1
         jNIw==
X-Gm-Message-State: AOAM531+l7m4/tc63V4lu/RercmrA45xqriCrSnLPh3eqbcRyZjewnty
        Wb1agITFZUkpTEPlmOgxujdA3ZBlPv9Ffw0e1hyBU5Q3yxhN8hSR
X-Google-Smtp-Source: ABdhPJwaIDvjFu5DCtmzj47BcJuvq8mRYiKklcFkAsvonAS6lWUxWExS0EtQdKunIdqRGczuh4jl2N2sYMKc6HJDVek=
X-Received: by 2002:ab0:39d1:: with SMTP id g17mr7452535uaw.34.1602236005663;
 Fri, 09 Oct 2020 02:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200930024712.88258-1-qianjun.kernel@gmail.com>
 <20200930081953.GU2628@hirez.programming.kicks-ass.net> <CAKc596Jc6H5qFxrzSp_fGhqTZt-5ORLoP=E4bwG-QzkpRiL2bA@mail.gmail.com>
 <20200930095719.GW2628@hirez.programming.kicks-ass.net> <CAKc596L6vzf=C7BvzWQH7kObSM_kGSxuf7idY6fr722sguNykA@mail.gmail.com>
In-Reply-To: <CAKc596L6vzf=C7BvzWQH7kObSM_kGSxuf7idY6fr722sguNykA@mail.gmail.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Fri, 9 Oct 2020 17:33:14 +0800
Message-ID: <CAKc596+8cH7ELFdGJyKMwdNEJ_On12J0K998gYbym5_LWM=TQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix the wrong sched_stat_wait time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, Vincent Guittot <vincent.guittot@linaro.org>,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jun qian <qianjun.kernel@gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=889:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Wed, Sep 30, 2020 at 05:16:29PM +0800, jun qian wrote:
> > > Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:20=E5=86=99=E9=81=93=
=EF=BC=9A
> > > >
> > > > On Wed, Sep 30, 2020 at 10:47:12AM +0800, qianjun.kernel@gmail.com =
wrote:
> > > > > From: jun qian <qianjun.kernel@gmail.com>
> > > > >
> > > > > When the sched_schedstat changes from 0 to 1, some sched se maybe
> > > > > already in the runqueue, the se->statistics.wait_start will be 0.
> > > > > So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> > > > > wrong. We need to avoid this scenario.
> > > >
> > > > Is this really the only problem there? Did you do a full audit of t=
hat
> > > > schedstat nonsense?
> > > >
> > >
> > > Did you mean that the sched_stat_xxx's xxx_start(sched_stat_sleep
> > > sched_stat_iowait sched_stat_blocked
> > > sched_stat_runtime) may be also depend the schedstat_enabled?
> >
> > Yeah, this runtime schedstat_enabled thing is fairly recent, it used to
> > be an always on/off kinda thing.
> >
> > At the time we figured inconsistencies from dynamically
> > enabling/disabling it were okay, it's just stats after all.
> >
> > But if you now want to 'fix' that, then a full audit might be nice.
> >
> > > I have searched the codes, and found that these sched_stat_xxx's
> > > xxx_start don't depend the schedstat_enabled
> > > except the wait_start.
> >
> > OK, so you did the audit and only found this one issue? That's good
> > Changelog material :-)
> >
>
> I found another problem, when the sched_schedstat changes from 1 to 0,
> the sched se
> which is already in the runqueue, the statistics.wait_start already
> has a value. At this moment
> sched_schedstat changes from 0 to 1 again, the (rq_of(cfs_rq)) -
> se->statistics.wait_start)
> will not be 0 and the wait time will be bigger than the real one. So
> we need to modify the  patch
> to resolve the problem with this scenario.
>

hi Peter

I have sent another patch to  improve the accuracy of sched_stat_wait
statistics.
I have no good idea to solve the another problem what i described up,
but the new
patch can  improve the accuracy.

Thanks

> So I really need a full audit might, =EF=BC=9A-)
>
> Thanks
>
> > Thanks!
