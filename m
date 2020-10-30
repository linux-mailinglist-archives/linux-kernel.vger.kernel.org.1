Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10DE2A00FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgJ3JQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJ3JQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:16:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957BBC0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:16:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l28so6916978lfp.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=axY5NcdwlSv1c1KvaEFDb7PC+MtewMuvPnKh1EeG+e0=;
        b=lFC4zom2i++6RSIOY13b+KTLAOAtrZzNIvyK2kvrVzQ4s1GVbQUAd/1WbMXuXxfmgV
         ML7UN6s2C5EgCvBYLfRmNumwHSuRgXX4siPmdUBSNiY9sHH5dNXqmXQi37NJBA9o1TFd
         NM2IxSbisOihdV9l5r3Iy03WFIpW4J/a6LXZMcD+SRovFqq3ZtcodnSSMqyP5TJjz9UA
         hlW15eYZqoNT/4ae3epHQjVWOLfGfgNByEyP0vvuRD4DPTCBwzd0QrObhJTYqCjjGdLr
         88GeEJ8oR/CISep0VEVWpxn0xcI7E3q8YiIlcLxRlQ0nHZ7+DTk76lAm3aOMDR1dIHoH
         qI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=axY5NcdwlSv1c1KvaEFDb7PC+MtewMuvPnKh1EeG+e0=;
        b=fca6rAZyTDkCeaz/jmNSmlxoagafGCv4XYOoKW7YJ4UubFuxWGK+cPAcuP6yDz8Bm3
         TLlN1VG0UdgNXRGdijht/XT6aBWA3taiWJmfcBpkhD6fDvgHdL7gooGw/SMYsnNElDYu
         QFpUHuoErJsTY8USQdZ0UtqEZUCAzMfxttdFFualER+E2PUTQ2MMNdfV9PhGoXyzDDYK
         WMVM9nPAwMJwFcCghDnRnIwRM3RNA7nZj9mNw14/fqdFohPpnhZJFgTSdl5FAYd6Bk/7
         daXpYZvgP37Y/wYmS8EJBWA52R5t89V98BOS2aHr2plU9uBEsfKWv5j9cg3Uk3GcKCdI
         vcTw==
X-Gm-Message-State: AOAM532I7l2WoUYAVQbc7cb1Agvhf9fWCp5HUZE4CSUWM+T/0wjAiPrd
        tBKXrp8keA35lFV2m1AIUtNRPcB1XgOE4s0//m/wnA==
X-Google-Smtp-Source: ABdhPJypeWp27nLOJgUO1aa9262/jxLVAuXOHvXLFSdI3nyOxVzb5QgEBHG38ZbxC8Ow2WPekfJMtmLbLMsM0E+SPo8=
X-Received: by 2002:a19:2355:: with SMTP id j82mr490414lfj.385.1604049372054;
 Fri, 30 Oct 2020 02:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com> <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com> <20201026142455.GA13495@vingu-book>
 <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
 <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
 <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
 <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
 <20201026120445.6a5dbbbe@imladris.surriel.com> <20201026162029.GA11367@vingu-book>
 <B23038A4-945F-48E9-8D38-EABE8204F208@fb.com> <CAKfTPtCROc_+rPYm8FGHDNJ-U6h1iZ0nm2+xy+tZ+L1q09h28w@mail.gmail.com>
 <3cac87ec39253019bfa04a9dfd61ce40ac85cc31.camel@surriel.com>
In-Reply-To: <3cac87ec39253019bfa04a9dfd61ce40ac85cc31.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Oct 2020 10:16:00 +0100
Message-ID: <CAKfTPtAspXqAoBTsyC_d1TOr=or3wq6F=2UFFuWBf04f7K7s-g@mail.gmail.com>
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

On Fri, 30 Oct 2020 at 03:11, Rik van Riel <riel@surriel.com> wrote:
>
> On Mon, 2020-10-26 at 17:52 +0100, Vincent Guittot wrote:
> > On Mon, 26 Oct 2020 at 17:48, Chris Mason <clm@fb.com> wrote:
> > > On 26 Oct 2020, at 12:20, Vincent Guittot wrote:
> > >
> > > > what you are suggesting is something like:
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 4978964e75e5..3b6fbf33abc2 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -9156,7 +9156,8 @@ static inline void
> > > > calculate_imbalance(struct
> > > > lb_env *env, struct sd_lb_stats *s
> > > >          * emptying busiest.
> > > >          */
> > > >         if (local->group_type =3D=3D group_has_spare) {
> > > > -               if (busiest->group_type > group_fully_busy) {
> > > > +               if ((busiest->group_type > group_fully_busy) &&
> > > > +                   !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
> > > >                         /*
> > > >                          * If busiest is overloaded, try to fill
> > > > spare
> > > >                          * capacity. This might end up creating
> > > > spare
> > > > capacity
> > > >
> > > > which also fixes the problem for me and alignes LB with wakeup
> > > > path
> > > > regarding the migration
> > > > in the LLC
> > >
> > > Vincent=E2=80=99s patch on top of 5.10-rc1 looks pretty great:
> > >
> > > Latency percentiles (usec) runtime 90 (s) (3320 total samples)
> > >          50.0th: 161 (1687 samples)
> > >          75.0th: 200 (817 samples)
> > >          90.0th: 228 (488 samples)
> > >          95.0th: 254 (164 samples)
> > >          *99.0th: 314 (131 samples)
> > >          99.5th: 330 (17 samples)
> > >          99.9th: 356 (13 samples)
> > >          min=3D29, max=3D358
> > >
> > > Next we test in prod, which probably won=E2=80=99t have answers until
> > > tomorrow.  Thanks again Vincent!
> >
> > Great !
> >
> > I'm going to run more tests on my setup as well to make sure that it
> > doesn't generate unexpected side effects on other kinds of use cases.
>
> We have tested the patch with several pretty demanding
> workloads for the past several days, and it seems to
> do the trick!
>
> With all the current scheduler code from the Linus tree,
> plus this patch on top, performance is as good as it ever
> was before with one workload, and slightly better with
> the other.

Thanks for the test results.
I still have a few tests to run on my systems but current results look
good for me too.


>
> --
> All Rights Reversed.
