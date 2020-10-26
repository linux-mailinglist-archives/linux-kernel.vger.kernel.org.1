Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E826299179
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784498AbgJZPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:54:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35316 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773467AbgJZPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:54:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id 77so12726203lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wvpGTKmgqXTaCkFn5ppd9Kxb5MBsrTErP0SBkxdXHXk=;
        b=xb/ABWqj+sqSF8V/fTF5+dlX2f60b9dYyMv5NTKSnQIRqCdKZnCZ+iDUe4IuxDH16a
         q5Q5pmZSrwPBdQ9wj4+vKcP5D8KBsKD5xkOex6wESksPjdxkJbpbE+UeLQ87BrIRflwK
         qWxSDc1K62RuR3J3qOc5WEQHqJ8P78o/YuqY6TdpHKM6q9q7hgxHao2HWafn4sqPaKCE
         3NruaZphSlvCRzNT+6fMqEwJIut0ccxqp1TL/cMeqWPOrjUQfqAI+uxDhgqjHbaBDtXm
         qQyyYW+biT5VsiBJFyXk9rROcjKtV3ximFDnVx3hq64KSADUhXsNmZUGM9C5u3z7Pmek
         68cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wvpGTKmgqXTaCkFn5ppd9Kxb5MBsrTErP0SBkxdXHXk=;
        b=pCrHSMFr90fi0QDW1pQHn61kxT/phDkOo3sE14GBIm2SyCxDerTpojLAzgeotRp9wv
         1fw3N4828svFMqFwqIZTuo4G1F8jmF92+glU3Jt7DXOStuxMdLb3+MFDhPe8gxflJOD4
         RuiclcZGkLiYri8kjTM9SvIxBuVKR2enJqhA654jdpn5bplCczlqz6rpDYOcW+BlGvph
         X0gem3XeKezwdflqXzenCObRiJwHPpwf+43yeQkxnLhqSbPMeP0KxNw7w9Rfe73eCUBP
         SHv5zhE1qG+FsCn/9oLdBAOB6Z5ee/z3XR82T0jZLBEyg3pwtHzv65qyTCjcGLANtPvR
         OkuQ==
X-Gm-Message-State: AOAM532/aBAesMxE1XkhytX7daTSGpQxCaz/L4XsgMRqTN5AJtavLlSP
        VuFmVp+x7zfj8GQCA8AemvZHND64g7WQhlnH7OYKVQ==
X-Google-Smtp-Source: ABdhPJx9uAKy9F7uLrWqV5xtLjpNnwuDv1E4TZXk8PfaU/Wk3rfyceKphig+2gTGKPMhaOrknq7J5WvZvyDgy91mXsc=
X-Received: by 2002:ac2:5e6c:: with SMTP id a12mr5933096lfr.568.1603727658945;
 Mon, 26 Oct 2020 08:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com> <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com> <20201026142455.GA13495@vingu-book>
 <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
 <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
 <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com> <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
In-Reply-To: <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Oct 2020 16:54:07 +0100
Message-ID: <CAKfTPtC10+xn3EGz8agfPCK_xarTDSOPENqoGYJ3mvJCtMUeYw@mail.gmail.com>
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

On Mon, 26 Oct 2020 at 16:42, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 26 Oct 2020 at 16:04, Rik van Riel <riel@surriel.com> wrote:
> >
> > On Mon, 2020-10-26 at 15:56 +0100, Vincent Guittot wrote:
> > > On Mon, 26 Oct 2020 at 15:38, Rik van Riel <riel@surriel.com> wrote:
> > > > On Mon, 2020-10-26 at 15:24 +0100, Vincent Guittot wrote:
> > > > > Le lundi 26 oct. 2020 =C3=A0 08:45:27 (-0400), Chris Mason a =C3=
=A9crit :
> > > > > > On 26 Oct 2020, at 4:39, Vincent Guittot wrote:
> > > > > >
> > > > > > > Hi Chris
> > > > > > >
> > > > > > > On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
> > > > > > > > Hi everyone,
> > > > > > > >
> > > > > > > > We=E2=80=99re validating a new kernel in the fleet, and com=
pared
> > > > > > > > with
> > > > > > > > v5.2,
> > > > > > >
> > > > > > > Which version are you using ?
> > > > > > > several improvements have been added since v5.5 and the
> > > > > > > rework of
> > > > > > > load_balance
> > > > > >
> > > > > > We=E2=80=99re validating v5.6, but all of the numbers reference=
d in
> > > > > > this
> > > > > > patch are
> > > > > > against v5.9.  I usually try to back port my way to victory on
> > > > > > this
> > > > > > kind of
> > > > > > thing, but mainline seems to behave exactly the same as
> > > > > > 0b0695f2b34a wrt
> > > > > > this benchmark.
> > > > >
> > > > > ok. Thanks for the confirmation
> > > > >
> > > > > I have been able to reproduce the problem on my setup.
> > > > >
> > > > > Could you try the fix below ?
> > > > >
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -9049,7 +9049,8 @@ static inline void
> > > > > calculate_imbalance(struct
> > > > > lb_env *env, struct sd_lb_stats *s
> > > > >          * emptying busiest.
> > > > >          */
> > > > >         if (local->group_type =3D=3D group_has_spare) {
> > > > > -               if (busiest->group_type > group_fully_busy) {
> > > > > +               if ((busiest->group_type > group_fully_busy) &&
> > > > > +                   (busiest->group_weight > 1)) {
> > > > >                         /*
> > > > >                          * If busiest is overloaded, try to fill
> > > > > spare
> > > > >                          * capacity. This might end up creating
> > > > > spare
> > > > > capacity
> > > > >
> > > > >
> > > > > When we calculate an imbalance at te smallest level, ie between
> > > > > CPUs
> > > > > (group_weight =3D=3D 1),
> > > > > we should try to spread tasks on cpus instead of trying to fill
> > > > > spare
> > > > > capacity.
> > > >
> > > > Should we also spread tasks when balancing between
> > > > multi-threaded CPU cores on the same socket?
> > >
> > > My explanation is probably misleading. In fact we already try to
> > > spread tasks. we just use spare capacity instead of nr_running when
> > > there is more than 1 CPU in the group and the group is overloaded.
> > > Using spare capacity is a bit more conservative because it tries to
> > > not pull more utilization than spare capacity
> >
> > Could utilization estimates be off, either lagging or
> > simply having a wrong estimate for a task, resulting
> > in no task getting pulled sometimes, while doing a
> > migrate_task imbalance always moves over something?
>
> task and cpu utilization are not always up to fully synced and may lag
> a bit which explains that sometimes LB can fail to migrate for a small
> diff

And also from util_est which reports the max utilization of the task
to be sure that LB migrates a task on a cpu that will have enough
available capacity

>
> >
> > Within an LLC we might not need to worry too much
> > about spare capacity, considering select_idle_sibling
> > doesn't give a hoot about capacity, either.
> >
> > --
> > All Rights Reversed.
