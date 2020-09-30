Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4527E4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgI3JQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3JQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:16:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:16:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so932578wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jMqBRdPp4G62I9pvbONrmi34MiX39nzV5cmOiM0xTwk=;
        b=aWlw+nvSQJkAD3CQ/6WFjBQeVM7/ZpeD5JXgPVz6Z9zy1hvHoXYgd5ypktkG1FFeET
         o6vjz5DxTiY5bwmPi+UTR2Alak2Q2zjzgGLw2lczQrznWy98bvyVM75T/f2VUeZ09sCF
         hRRSIBB7AF341467Q/2E/aWyYeM1knsRgw8NLEW5VEo4E8L9uhupFhjlQAq+nd1bcKri
         /cjSX1BQgizdHiS9FXGEpPbBCQtp++C3g6KIzuYrlacYjbxWtwc5wC+Ot6TXBSAygSx3
         f/cMJH4o24WHZAFXMlRBEanrYXAdJNdfVdujy8dacVuw1o8UBjTdEYOP0Stx1Wg92mY+
         bbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jMqBRdPp4G62I9pvbONrmi34MiX39nzV5cmOiM0xTwk=;
        b=O9FFcqgxbfHJ+lba+whgsEgsWlKdgmt4Xf0FHEEgdjZ6uubZg8TckWGBVKnOH1vO8Q
         +qVNp2kWtV0sayKVfRRoVTs9m4o9SXCpRWDnmurxEoLnH614MW0NaF+iApR7qozqY0yF
         rv1GjXspbAVRgSjC1IWFx8cnQw+vJJ5dfwlsT/pW/dEuADbDz/HMHcXz1+ibfIFc4EMV
         RQD00NZRvMoshfiwBUg097v9ddXK+4nlO5yzuZvX0mFEbrkCl0r51tA+29sat0gEmUcr
         ueyN9tkcExERxsMl8zeVC1xAIS2InQJpQl06MhtAYBQoiIM9te4WikrqLY20WkCKzMXD
         3QZg==
X-Gm-Message-State: AOAM532TICebfNo+Kc62ldtG2z9JoAvB2R0dsyA1zo7LN5L0/rXeCswR
        ipB+j36t1JHq/5ULA1GzFlkVYhA2+Y+xhJNkyMY=
X-Google-Smtp-Source: ABdhPJyP4RA44TEcqflhm1AEaf2+TeU/PnbEZPlKkLCae8saXAmWgR6M+njmkR79Ehx4O67Lr0Ijdqe8eVMdp+YzUEA=
X-Received: by 2002:a5d:568d:: with SMTP id f13mr1982012wrv.303.1601457400766;
 Wed, 30 Sep 2020 02:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200930024712.88258-1-qianjun.kernel@gmail.com> <20200930081953.GU2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20200930081953.GU2628@hirez.programming.kicks-ass.net>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 30 Sep 2020 17:16:29 +0800
Message-ID: <CAKc596Jc6H5qFxrzSp_fGhqTZt-5ORLoP=E4bwG-QzkpRiL2bA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix the wrong sched_stat_wait time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, Vincent Guittot <vincent.guittot@linaro.org>,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 30, 2020 at 10:47:12AM +0800, qianjun.kernel@gmail.com wrote:
> > From: jun qian <qianjun.kernel@gmail.com>
> >
> > When the sched_schedstat changes from 0 to 1, some sched se maybe
> > already in the runqueue, the se->statistics.wait_start will be 0.
> > So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> > wrong. We need to avoid this scenario.
>
> Is this really the only problem there? Did you do a full audit of that
> schedstat nonsense?
>

Did you mean that the sched_stat_xxx's xxx_start(sched_stat_sleep
sched_stat_iowait sched_stat_blocked
sched_stat_runtime) may be also depend the schedstat_enabled?
I have searched the codes, and found that these sched_stat_xxx's
xxx_start don't depend the schedstat_enabled
except the wait_start.

This patch is going to slove the problem that when the
schedstat_enabled is enabled, the sched_stat_wait of
the probed process will become unbelievable big probability in the fist tim=
e.

> > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/sched/fair.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 658aa7a..dd7c3bb 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -908,6 +908,14 @@ static void update_curr_fair(struct rq *rq)
>
> your git-diff is 'funny', it got the function ^ wrong.
>

sorry  :)

> >       if (!schedstat_enabled())
> >               return;
> >
> > +     /*
> > +      * When the sched_schedstat changes from 0 to 1, some sched se ma=
ybe
> > +      * already in the runqueue, the se->statistics.wait_start will be=
 0.
> > +      * So it will let the delta wrong. We need to avoid this scenario=
.
> > +      */
> > +     if (unlikely(!schedstat_val(se->statistics.wait_start)))
> > +             return;
> > +
> >       delta =3D rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.=
wait_start);
> >
> >       if (entity_is_task(se)) {
> > --
> > 1.8.3.1
> >
