Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1527E933
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgI3NIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3NIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:08:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE63C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:08:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so1239091wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUcX7CIsrhuza3QEfhaZv/H1JCPr/l4RGV3Smep/FWY=;
        b=QI2/iCHqdIsZTJ6zEQraRYPFQWVuus9tecHYWTJgOKiuD130Eof+7xKCu0vGlMQ3Ju
         Ee/3x/bQb83e9MgCgW+918RPRDWlLO6S3BR6d0TTee62iJyuU4zLDavq7rUyQfxpvELU
         X1Ebury36YwAu7MVuL1pE/uePaDnkG3zUxXCVMJRc4FY7oYXhb7t1ckhrXdzUQxjSc7B
         PpCgIENHzJavkDy8g92whDpSBFef94mZEpr/eLTUACF1Wzf78Qy8n66JQAFbu+LAZ21f
         ZjUMqlKBk03pW/DT1zraaHa9s5hpHStbuvGFimD+B9ktsMJm7Hh1UOCE/7YMEdKSUf8B
         33bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUcX7CIsrhuza3QEfhaZv/H1JCPr/l4RGV3Smep/FWY=;
        b=kILXv+1t0BnR459u8D/onaNEJOE/YvOG2vo28OfrRrL3zHO7eYWWEs9KScliXwxaW/
         7zBcyQ+MPVlfsLN0KTuEuq/mTzxZiCEkjU3roSQ77i+eh+qay1ikdIzfzoE43hSiISA4
         1xTJdj1SPr89Jg6euuuHQ06v5a/xCsjjN3roIexdqGeb3ZmNeqkLhlmaP1PIpFhnROsV
         94PzLxUS7rSP2zzNaFfNNuk7rRiUW2T+H8pbpLbAdDrK79A5GsvFeDyBEMGcT8lxei/A
         AorSQugrL9EKaoQJUqI0Ac2ePc4B3M9MWAvjAtcD4SMjYQizPJBZ6u+iu3gBcGIzERax
         lQMQ==
X-Gm-Message-State: AOAM532UzppD8bRZa03/ji5DdztYE+L2eFVLN9Xo1iQG8SRFzjQvRP5X
        uAIQ1o0CQSdWeuvFP8MIds7/GJcS4RmlKdj4nhY=
X-Google-Smtp-Source: ABdhPJyPJ7pbucWJRPEB1dBokbX/SeV627p6Vg47Awi5xr3txHGP1YyNdLlCn45H+M6xR3MxgSG1UnuJxBteUK8mAe8=
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr3063744wma.11.1601471297090;
 Wed, 30 Sep 2020 06:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930024712.88258-1-qianjun.kernel@gmail.com>
 <20200930081953.GU2628@hirez.programming.kicks-ass.net> <CAKc596Jc6H5qFxrzSp_fGhqTZt-5ORLoP=E4bwG-QzkpRiL2bA@mail.gmail.com>
 <20200930095719.GW2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20200930095719.GW2628@hirez.programming.kicks-ass.net>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 30 Sep 2020 21:08:05 +0800
Message-ID: <CAKc596L6vzf=C7BvzWQH7kObSM_kGSxuf7idY6fr722sguNykA@mail.gmail.com>
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

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 30, 2020 at 05:16:29PM +0800, jun qian wrote:
> > Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=883=
0=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:20=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, Sep 30, 2020 at 10:47:12AM +0800, qianjun.kernel@gmail.com wr=
ote:
> > > > From: jun qian <qianjun.kernel@gmail.com>
> > > >
> > > > When the sched_schedstat changes from 0 to 1, some sched se maybe
> > > > already in the runqueue, the se->statistics.wait_start will be 0.
> > > > So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> > > > wrong. We need to avoid this scenario.
> > >
> > > Is this really the only problem there? Did you do a full audit of tha=
t
> > > schedstat nonsense?
> > >
> >
> > Did you mean that the sched_stat_xxx's xxx_start(sched_stat_sleep
> > sched_stat_iowait sched_stat_blocked
> > sched_stat_runtime) may be also depend the schedstat_enabled?
>
> Yeah, this runtime schedstat_enabled thing is fairly recent, it used to
> be an always on/off kinda thing.
>
> At the time we figured inconsistencies from dynamically
> enabling/disabling it were okay, it's just stats after all.
>
> But if you now want to 'fix' that, then a full audit might be nice.
>
> > I have searched the codes, and found that these sched_stat_xxx's
> > xxx_start don't depend the schedstat_enabled
> > except the wait_start.
>
> OK, so you did the audit and only found this one issue? That's good
> Changelog material :-)
>

I found another problem, when the sched_schedstat changes from 1 to 0,
the sched se
which is already in the runqueue, the statistics.wait_start already
has a value. At this moment
sched_schedstat changes from 0 to 1 again, the (rq_of(cfs_rq)) -
se->statistics.wait_start)
will not be 0 and the wait time will be bigger than the real one. So
we need to modify the  patch
to resolve the problem with this scenario.

So I really need a full audit might, =EF=BC=9A-)

Thanks

> Thanks!
