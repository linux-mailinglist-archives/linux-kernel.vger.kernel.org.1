Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB65626A225
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgIOJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIOJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:28:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED1C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:28:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b19so2144298lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sKtwXaKgtYXFz9sToAq2eVmecZM3m/5P7rW2zQ29hs=;
        b=r8/HtN8AkZhnybxMQ2vFb2hL9+b2Rnr1sAYhqd95uaYMSTdASEaRC8H2hmVccGISo/
         IkQehKWH1yQJHYaaEkIoSUp14NZPHNT2ewtmNx615j5CFmtaMV6HMS4d4xGRmyeBsEe8
         UUnZ2YOFDUMKbr6EK2GNIz4U6M5oCzGYnxA1xnlGz3F+g+bN4LW+FNNVwzh8uz99zaTO
         3qcRFbjXA4XkB2eUsk/cRz6e9McTTG3Mix4NHwBCxPmUwKxI9S6VGh4a9nsZkFHMVPeo
         v94saBvNq/BuX/LBur0d5ZCwusIrlzo/2Uc8/EqQib7e/E2Lb2G8VTHx31IpCJlyZRTr
         a1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sKtwXaKgtYXFz9sToAq2eVmecZM3m/5P7rW2zQ29hs=;
        b=l7/biglAXFOOWkXmxZbVhOD5uhC88Fh3zR4JaaLO0sq+SYPmCg9C/tjIrZr5NniCNP
         ydMMFK4FFCIGN6TueDer9osijlMf3Vp369br0dCs5X/eQWvq+0sw0e+MkbNpenf9VM7Y
         CiuEcRiTXyr7EN8/I5o4kRW3hr9eV1IiW7tlkMOQKbvFdmy3NY/gmSl90m4JasFMvNMv
         B3hgJqzCBQR+A72yN1N4D4cTLwUw7fLLNarJ2Cpqs1QIAAFfoBAAMeOiJOkGmm3Xzluq
         r5GH8rVEkiFEBkcc04PIbWJdNJ3Xb8oeEEJDj9AWkdxCmWNhDmpoxo/DxmpInuZCwJ/O
         bn4w==
X-Gm-Message-State: AOAM532EaMfXG8IEnJ4ba3e+mfPC7rNzoNblMjAu1BB93+jyHv+WkyGD
        Bxcm7E8GoC1kEyF21F66WU/fezXNSMsLrUaO6HHRbg==
X-Google-Smtp-Source: ABdhPJyUjnLpOXcDVwEfROkATt5m5l2uzI9Uj4CpydcixBQmqRWVYofOeke4wSbBhnn4fIZrLemvB3rwI/jCNj/ME8E=
X-Received: by 2002:a2e:81d7:: with SMTP id s23mr6971931ljg.69.1600162132403;
 Tue, 15 Sep 2020 02:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914100340.17608-5-vincent.guittot@linaro.org> <CAPJCdBmNK2ZbvsOkzx=6TnzSD=EN28MjD=4ZsmnWjb907MC41g@mail.gmail.com>
In-Reply-To: <CAPJCdBmNK2ZbvsOkzx=6TnzSD=EN28MjD=4ZsmnWjb907MC41g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Sep 2020 11:28:41 +0200
Message-ID: <CAKfTPtC1Z7bAN6WpgdjzpToExR63NL7rGCUpFzT3O6fM1OECkQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: reduce busy load balance interval
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 11:11, Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi, Vincent
>
> On Mon, 14 Sep 2020 at 18:07, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > The busy_factor, which increases load balance interval when a cpu is busy,
> > is set to 32 by default. This value generates some huge LB interval on
> > large system like the THX2 made of 2 node x 28 cores x 4 threads.
> > For such system, the interval increases from 112ms to 3584ms at MC level.
> > And from 228ms to 7168ms at NUMA level.
> Agreed that the interval is too big for that case.
> But would it be too small for an AMD environment(like ROME) with 8cpu
> at MC level(CCX), if we reduce busy_factor?

Are you sure that this is too small ? As mentioned in the commit
message below, I tested it on small system (2x4 cores Arm64) and i
have seen some improvements

> For that case, the interval could be reduced from 256ms to 128ms.
> Or should we define an MIN_INTERVAL for MC level to avoid too small interval?

What would be a too small interval ?

Before this patch we have for a level with 8 cores:
when idle, the interval is 8ms and increase to 256ms when busy
After the patch, we have
When idle the interval is still 8ms and increase to 128ms when busy

Regards,
Vincent

>
> Thx.
> Regards,
> Jiang
>
> >
> > Even on smaller system, a lower busy factor has shown improvement on the
> > fair distribution of the running time so let reduce it for all.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/topology.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 1a84b778755d..a8477c9e8569 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1336,7 +1336,7 @@ sd_init(struct sched_domain_topology_level *tl,
> >         *sd = (struct sched_domain){
> >                 .min_interval           = sd_weight,
> >                 .max_interval           = 2*sd_weight,
> > -               .busy_factor            = 32,
> > +               .busy_factor            = 16,
> >                 .imbalance_pct          = 117,
> >
> >                 .cache_nice_tries       = 0,
> > --
> > 2.17.1
> >
