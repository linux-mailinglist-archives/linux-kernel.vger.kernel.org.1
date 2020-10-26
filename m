Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A1299151
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784328AbgJZPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:42:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39399 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773997AbgJZPma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:42:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id 184so12663325lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=APUTThowmaphi/dPHjlQ2KyI7yS+CDGCc0/xkzY/dB8=;
        b=JHB7UJDuBbgKsEWILDcE7shYgBDBVvYgxEV8vp+w42KEXVTKth39A4/Sv6Pd+/orU6
         ZoiUuZ3yfWu3r+lerpBBg8EXbOrblEPvdchGvLq0bN4LCtMkOUEWXGNXK3kO9OQ5p/x/
         0OED2q1Etx/imM315H4lvXQXf/cSL4xJbx2A/a9auDImcL/HlAhOdNJOmvyneOzipgiz
         qO9zUWowt0KyM2s7KVao0TuEDlB5t1mEVxvjS5QggZ1ECr3gSXjRn+9nwj0iDh6/N9Fj
         bCLkuazU93bvcq2d/7mzJMyiBrhmebYba5U9r1bOokMOBrbgRTEXTT87Q+pIc30Zw+dv
         J8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=APUTThowmaphi/dPHjlQ2KyI7yS+CDGCc0/xkzY/dB8=;
        b=qsyjd2UJxyDDaedo/ole21MuI03g1KOh81vEYhhtPTESEB+ftY8q3aeis79RwHl5GV
         rrgEtebrvxTk07/gHilIXanycMT7pMHxEC+W8VhadTyiUglKwFGVM6VBtcMBNeAM4gjb
         2SIWn8X6F9VhPTF+db0Cw4FLpQU725zdUh/ZS7ceQ6mo/09R9lShXRGjIBrtHQz2QygE
         UWwVCg95qs0vtKlkpsNKIzDac7OYYxp6rPqpm9OH5g7VKuxEAOw0asxZf9aIiub9dz93
         pspLCml6gHzUHcmtfD7IGAKAQNA80ILBqMgLbPPbYXbZuomBgNYsczS1SzMFAOQGNM3L
         6sEA==
X-Gm-Message-State: AOAM5336+vE01EQFc3L+3Lrolwz2KbqiWbGkm5uojNz7ue5poVLdFkKc
        WNibHAwTN5LIWC7TdNkhFFoWUi9V+bTzv8Ykfoj1Ow==
X-Google-Smtp-Source: ABdhPJzisCLSLJreZ3snqkwMimizxNulwciBjRUlCkA9mHyOiIkf35yEFy38go9tqmPncJLiXY/IfeWJdPDtE2PhxB0=
X-Received: by 2002:a19:e308:: with SMTP id a8mr5082953lfh.573.1603726946580;
 Mon, 26 Oct 2020 08:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com> <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com> <20201026142455.GA13495@vingu-book>
 <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
 <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com> <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
In-Reply-To: <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Oct 2020 16:42:14 +0100
Message-ID: <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework load_balance()"
To:     Rik van Riel <riel@surriel.com>
Cc:     Chris Mason <clm@fb.com>, Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 at 16:04, Rik van Riel <riel@surriel.com> wrote:
>
> On Mon, 2020-10-26 at 15:56 +0100, Vincent Guittot wrote:
> > On Mon, 26 Oct 2020 at 15:38, Rik van Riel <riel@surriel.com> wrote:
> > > On Mon, 2020-10-26 at 15:24 +0100, Vincent Guittot wrote:
> > > > Le lundi 26 oct. 2020 =C3=A0 08:45:27 (-0400), Chris Mason a =C3=A9=
crit :
> > > > > On 26 Oct 2020, at 4:39, Vincent Guittot wrote:
> > > > >
> > > > > > Hi Chris
> > > > > >
> > > > > > On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
> > > > > > > Hi everyone,
> > > > > > >
> > > > > > > We=E2=80=99re validating a new kernel in the fleet, and compa=
red
> > > > > > > with
> > > > > > > v5.2,
> > > > > >
> > > > > > Which version are you using ?
> > > > > > several improvements have been added since v5.5 and the
> > > > > > rework of
> > > > > > load_balance
> > > > >
> > > > > We=E2=80=99re validating v5.6, but all of the numbers referenced =
in
> > > > > this
> > > > > patch are
> > > > > against v5.9.  I usually try to back port my way to victory on
> > > > > this
> > > > > kind of
> > > > > thing, but mainline seems to behave exactly the same as
> > > > > 0b0695f2b34a wrt
> > > > > this benchmark.
> > > >
> > > > ok. Thanks for the confirmation
> > > >
> > > > I have been able to reproduce the problem on my setup.
> > > >
> > > > Could you try the fix below ?
> > > >
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -9049,7 +9049,8 @@ static inline void
> > > > calculate_imbalance(struct
> > > > lb_env *env, struct sd_lb_stats *s
> > > >          * emptying busiest.
> > > >          */
> > > >         if (local->group_type =3D=3D group_has_spare) {
> > > > -               if (busiest->group_type > group_fully_busy) {
> > > > +               if ((busiest->group_type > group_fully_busy) &&
> > > > +                   (busiest->group_weight > 1)) {
> > > >                         /*
> > > >                          * If busiest is overloaded, try to fill
> > > > spare
> > > >                          * capacity. This might end up creating
> > > > spare
> > > > capacity
> > > >
> > > >
> > > > When we calculate an imbalance at te smallest level, ie between
> > > > CPUs
> > > > (group_weight =3D=3D 1),
> > > > we should try to spread tasks on cpus instead of trying to fill
> > > > spare
> > > > capacity.
> > >
> > > Should we also spread tasks when balancing between
> > > multi-threaded CPU cores on the same socket?
> >
> > My explanation is probably misleading. In fact we already try to
> > spread tasks. we just use spare capacity instead of nr_running when
> > there is more than 1 CPU in the group and the group is overloaded.
> > Using spare capacity is a bit more conservative because it tries to
> > not pull more utilization than spare capacity
>
> Could utilization estimates be off, either lagging or
> simply having a wrong estimate for a task, resulting
> in no task getting pulled sometimes, while doing a
> migrate_task imbalance always moves over something?

task and cpu utilization are not always up to fully synced and may lag
a bit which explains that sometimes LB can fail to migrate for a small
diff

>
> Within an LLC we might not need to worry too much
> about spare capacity, considering select_idle_sibling
> doesn't give a hoot about capacity, either.
>
> --
> All Rights Reversed.
