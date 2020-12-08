Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C988A2D2D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgLHOse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgLHOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:48:34 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A3C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:47:53 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 23so10658546lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5EJ4E8Jr0ykoUCPxT2CLHwBX/iKZ3oQwhi/2arf/m4=;
        b=lep5Evmm1QWT8tj7yW4pLaJ/IoRHG9QYGu+YeXef6cpL3PLSFge5pcIPlguQWGLqat
         WrqI4TZgk9gU4SrJ8sgSBUwVM8CwS5rJ/22B91uFF/dWnj+QRROe4q35uoxzxP8TsKYU
         3bvMHAhnT3cob6Q14SXYWMjj7QiUp+2pv76Yw7mlqVxT+gT6WN0Stz6FEyFnTqu/p7wJ
         NRyanrxYs+KsTnrjfVfD42TMUWZm37/AWxKZii6GXsqUE/AqEcFZkNIsCekufqipBuPb
         4RYSv2YvJW82ZgC83fUfMGxcR/+rS32jUZMvFWbmb7Qi7nGb2dCLfa+gK/wL543H21Xs
         /CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5EJ4E8Jr0ykoUCPxT2CLHwBX/iKZ3oQwhi/2arf/m4=;
        b=KnUhV0jTN8fDi8qfEdZ9REfRLyl2QCWk2Af5UefG/DdsG26NYtlVq4cmQD4b2VTjv/
         8cjWwJwOLQP+usA2u95YncQ6mhQr3bsdKEnc5NqnTN6ESRbgqqn9lrH9kqaszCKEogC6
         FPRbsLZqwQltICdYvErlskkdmZrehZx3h9oJpD/b7ieDl3DLdxhC9jh/Tx4uEirTmPCB
         1EpQF5qQJohBFcOLL6TM1lMdXh9bpnxzc8EkF+Qz6TFRuf8f/u5qUeT/vw15jS82VMvV
         rxhuP44EtpOTi1XKOEzgjf/GyDU/ZRFV9x8B0TrH9MoEa3ubgZNqUqWYLZTIJa6RunDo
         6P3Q==
X-Gm-Message-State: AOAM530Gyw6YuC3UiqmqMPnrVPU9vbnYhvq+17yfuZ11KVdjPeRZb/rs
        IAr4Z++9PC61Uj5gMP4KVuuu8STLhogCJpGBl3sJSA==
X-Google-Smtp-Source: ABdhPJzWxvpvF5BjvYRY/SzTvfaC8yiEuCxUvoNrEN7rwAOOYucOZQ8CFwEK6p0hSTMCDyDTuxFUBIkRGyJy8gU2ayc=
X-Received: by 2002:ac2:5dfa:: with SMTP id z26mr4731164lfq.286.1607438871282;
 Tue, 08 Dec 2020 06:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net> <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
 <20201208105900.GG3371@techsingularity.net> <CAKfTPtBgo5vCrN87fqKjyaowONLMWeUusLmvE4bmGmDq10+Yrw@mail.gmail.com>
 <20201208133650.GI3371@techsingularity.net> <CAKfTPtDbUoVSvnjFrpomvTJD0jCA6vH_Y3LP=csW8fHntOG_6A@mail.gmail.com>
 <20201208135358.GJ3371@techsingularity.net>
In-Reply-To: <20201208135358.GJ3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Dec 2020 15:47:40 +0100
Message-ID: <CAKfTPtCqGXJa=GfpBZk5To-xVWVtVL8YVMab9PoxFN1=vOwTWQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 14:54, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 08, 2020 at 02:43:10PM +0100, Vincent Guittot wrote:
> > On Tue, 8 Dec 2020 at 14:36, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Tue, Dec 08, 2020 at 02:24:32PM +0100, Vincent Guittot wrote:
> > > > > > Nitpick:
> > > > > >
> > > > > > Since now avg_cost and avg_idle are only used w/ SIS_PROP, they could go
> > > > > > completely into the SIS_PROP if condition.
> > > > > >
> > > > >
> > > > > Yeah, I can do that. In the initial prototype, that happened in a
> > > > > separate patch that split out SIS_PROP into a helper function and I
> > > > > never merged it back. It's a trivial change.
> > > >
> > > > while doing this, should you also put the update of
> > > > this_sd->avg_scan_cost under the SIS_PROP feature ?
> > > >
> > >
> > > It's outside the scope of the series but why not. This?
> > >
> > > --8<--
> > > sched/fair: Move avg_scan_cost calculations under SIS_PROP
> > >
> > > As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
> > > even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
> > > check and while we are at it, exclude the cost of initialising the CPU
> > > mask from the average scan cost.
> > >
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 19ca0265f8aa..0fee53b1aae4 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6176,10 +6176,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > >                         nr = 4;
> > >         }
> > >
> > > -       time = cpu_clock(this);
> >
> > I would move it in the if (sched_feat(SIS_PROP)) above.
> >
>
> I considered it but made the choice to exclude the cost of cpumask_and()
> from the avg_scan_cost instead. It's minor but when doing the original

At the cost of a less readable code

> prototype, I didn't think it was appropriate to count the cpumask
> clearing as part of the scan cost as it's not directly related.

hmm... I think it is because the number of loop is directly related to
the allowed cpus


>
> --
> Mel Gorman
> SUSE Labs
