Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64E42992F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786581AbgJZQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:52:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34620 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786574AbgJZQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:52:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id y16so10986625ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zrolNUCz70dAx2P6MUYMitEKr5nhjujkcrp+V/JXYqE=;
        b=n7Do+y63HzkUNh42XzCR259asRdg469z/Pf0xS2g3xsYpJwY4/CeoqwT+UGFHTMzGl
         Bl6QuV0dRAwXBJwQJ3l2QZPJF2HFXmGHGLjPbDDU0Iz0cKTggzElRWiP/O3Asc44D1jP
         qICEh823NYIQUW8SMcSE7yMUL/1g0dReFS1nmmnOb1HcD4AGftTJbhCfl5xVQO17sNB8
         qxBFuK+IK383rmjlL6WQzMBPzIG3UR3InyO+GGArmGpYaEckWSalRzINWABjhJhmZv35
         ePw0QVfy6BZTSqzIPtARPkXozdkpn8AMQV7GphaiEYxg/4FpeplF8n9HZbGhpJAzBtFG
         72FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zrolNUCz70dAx2P6MUYMitEKr5nhjujkcrp+V/JXYqE=;
        b=S7NyU3mjvV0diHXyiefJr1TYgZdxiv0vFy8OjxebJIMjMaF+veP3W0B+iFgmDPfRdo
         In+2oBHwbkdEvRCe3vqZ6xt0b6lB9nb4brQA0Oe/Ifk24OrVDXp0Cc1ZD6fkdrju43Z/
         BwCjfRfj78wh02lPvtwJx6XR7c7ilYt9tzkxLVtc20aWbN/1ZI4Q5COU+jv2/F/yUTdG
         DApYXkpgo3PSkwYCxWVJikfahKR53cX78Kh6S2OnMdUUx/eTAOYHZa+DeSIkPduod3LI
         leqEBw2YSEhAEjS7LPtUvbFg+3BFU9F4yJYgREIFbdZPQsyE4CtsJ8y4zQUzpTCCwCfS
         TD4w==
X-Gm-Message-State: AOAM532UrjCcvmd8yRXzHYZ+pK4pbp0TsJ8fSYN2N4CAeaAYP8jnbDW9
        r/UhhSMpBVoL2SZ5Rt5apbWwkac/yHErdAtu3yeRf+vvOd0=
X-Google-Smtp-Source: ABdhPJy2ty9PcIzWjfuPC5XukWg4SMpn/EKmFrCJTVzep3WkTYwu2zRdz2JS3hpihYGOfNEvVWHgadbKc68sNqoYQeY=
X-Received: by 2002:a05:651c:291:: with SMTP id b17mr6655085ljo.177.1603731172451;
 Mon, 26 Oct 2020 09:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com> <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com> <20201026142455.GA13495@vingu-book>
 <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
 <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
 <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
 <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
 <20201026120445.6a5dbbbe@imladris.surriel.com> <20201026162029.GA11367@vingu-book>
 <B23038A4-945F-48E9-8D38-EABE8204F208@fb.com>
In-Reply-To: <B23038A4-945F-48E9-8D38-EABE8204F208@fb.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Oct 2020 17:52:41 +0100
Message-ID: <CAKfTPtCROc_+rPYm8FGHDNJ-U6h1iZ0nm2+xy+tZ+L1q09h28w@mail.gmail.com>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework load_balance()"
To:     Chris Mason <clm@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 at 17:48, Chris Mason <clm@fb.com> wrote:
>
> On 26 Oct 2020, at 12:20, Vincent Guittot wrote:
>
> > Le lundi 26 oct. 2020 =C3=A0 12:04:45 (-0400), Rik van Riel a =C3=A9cri=
t :
> >> On Mon, 26 Oct 2020 16:42:14 +0100
> >> Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >>> On Mon, 26 Oct 2020 at 16:04, Rik van Riel <riel@surriel.com> wrote:
> >>
> >>>> Could utilization estimates be off, either lagging or
> >>>> simply having a wrong estimate for a task, resulting
> >>>> in no task getting pulled sometimes, while doing a
> >>>> migrate_task imbalance always moves over something?
> >>>
> >>> task and cpu utilization are not always up to fully synced and may
> >>> lag
> >>> a bit which explains that sometimes LB can fail to migrate for a
> >>> small
> >>> diff
> >>
> >> OK, running with this little snippet below, I see latencies
> >> improve back to near where they used to be:
> >>
> >> Latency percentiles (usec) runtime 150 (s)
> >>         50.0th: 13
> >>         75.0th: 31
> >>         90.0th: 69
> >>         95.0th: 90
> >>         *99.0th: 761
> >>         99.5th: 2268
> >>         99.9th: 9104
> >>         min=3D1, max=3D16158
> >>
> >> I suspect the right/cleaner approach might be to use
> >> migrate_task more in !CPU_NOT_IDLE cases?
> >>
> >> Running a task to an idle CPU immediately, instead of refusing
> >> to have the load balancer move it, improves latencies for fairly
> >> obvious reasons.
> >>
> >> I am not entirely clear on why the load balancer should need to
> >> be any more conservative about moving tasks than the wakeup
> >> path is in eg. select_idle_sibling.
> >
> >
> > what you are suggesting is something like:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4978964e75e5..3b6fbf33abc2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9156,7 +9156,8 @@ static inline void calculate_imbalance(struct
> > lb_env *env, struct sd_lb_stats *s
> >          * emptying busiest.
> >          */
> >         if (local->group_type =3D=3D group_has_spare) {
> > -               if (busiest->group_type > group_fully_busy) {
> > +               if ((busiest->group_type > group_fully_busy) &&
> > +                   !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
> >                         /*
> >                          * If busiest is overloaded, try to fill spare
> >                          * capacity. This might end up creating spare
> > capacity
> >
> > which also fixes the problem for me and alignes LB with wakeup path
> > regarding the migration
> > in the LLC
>
> Vincent=E2=80=99s patch on top of 5.10-rc1 looks pretty great:
>
> Latency percentiles (usec) runtime 90 (s) (3320 total samples)
>          50.0th: 161 (1687 samples)
>          75.0th: 200 (817 samples)
>          90.0th: 228 (488 samples)
>          95.0th: 254 (164 samples)
>          *99.0th: 314 (131 samples)
>          99.5th: 330 (17 samples)
>          99.9th: 356 (13 samples)
>          min=3D29, max=3D358
>
> Next we test in prod, which probably won=E2=80=99t have answers until
> tomorrow.  Thanks again Vincent!

Great !

I'm going to run more tests on my setup as well to make sure that it
doesn't generate unexpected side effects on other kinds of use cases.

>
> -chris
