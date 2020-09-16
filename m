Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C226BD98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgIPHCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPHCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:02:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:02:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so4995674ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCJLW8nQvOXApbk3la0saDMNsQyaJXyRyrTzDbvW5Rc=;
        b=U4P0nr9G63Cva5pVGBaKs47mb81G+pvTqF10ch8Jn+azXrumWjC5bdVF+hH77EugPv
         Pug3o0Ef3t+MnLGEv9CfSmIKnMvdBSKBSeGawr3u3YST8CFk7AXhSsL1A8qJOtpzz2Je
         /aL9eVWxY7IBaLYZyu1esacISpUUKiTba4RDXTVaeXL4ApUU6fTqEvs+t4GXD0p0ciGJ
         on9r6tzhvwy/Vv0Q5VSzrMzEN+7dZNmNpOSgjAyYba/BkCCCNOJmK/g/JXS7dzAAwzIE
         19HGllLJ+Jpxo5III0r58G6LIraU9PoDSmtRo294SvwfGl8e9iZ/hnG3tlXznzqkyhBo
         h+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCJLW8nQvOXApbk3la0saDMNsQyaJXyRyrTzDbvW5Rc=;
        b=QgKj0PBRM0O4VpABx5LRL3LbOxnsVqp4iJKkG1c2E9wd8lWVI5GQmuQamP8pqCvOVp
         gXwfGs/ceIY4T5cVyMPyHlOzlF78nj3iw8+oE/xwK0jw1tQQeqw6sSa2jcUE5DcyDcy1
         tEuFpUPSj3P2EuPnXTFkXbuBWQUHLlwSpqxfDKTBuJs7Mz3Ico9ejgtyJtHJLIuSAQc+
         IT3gRXQKt+QzQv1Zw8fv/1de7ISwigKY/EGOwU90yBHobR9yoW8Ien6/ZSjhAUzfrJpv
         9Sq5+9zaHvk+jgHIUbPJ1bk8SwUZMig+PF026H8bTODy65yFF3cE/ytIvjUsPzSYMNTI
         k8ig==
X-Gm-Message-State: AOAM5322t/aRYNxJSISFJMMIkHWXKnMwoPGuVt1A7j4PIJifIy9wGuX0
        sowyfl1SyLjt6isytye4zIh69k1Y46AoaFgIkngiGw==
X-Google-Smtp-Source: ABdhPJyCPfOsELzk8kXXxR4gmEFNdpu0oCVWHVSM5wiadvljBL5qQT56LsRG023SXY1KECVsly8w89auNKJVQmIyTGg=
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr8530997ljp.177.1600239732998;
 Wed, 16 Sep 2020 00:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914100340.17608-5-vincent.guittot@linaro.org> <jhjft7i6euf.mognet@arm.com>
In-Reply-To: <jhjft7i6euf.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Sep 2020 09:02:01 +0200
Message-ID: <CAKfTPtBmNF8WrXLrnQow037bk=7z285ub7yLp2KdFQcJK1fsUw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: reduce busy load balance interval
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 21:04, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 14/09/20 11:03, Vincent Guittot wrote:
> > The busy_factor, which increases load balance interval when a cpu is busy,
> > is set to 32 by default. This value generates some huge LB interval on
> > large system like the THX2 made of 2 node x 28 cores x 4 threads.
> > For such system, the interval increases from 112ms to 3584ms at MC level.
> > And from 228ms to 7168ms at NUMA level.
> >
> > Even on smaller system, a lower busy factor has shown improvement on the
> > fair distribution of the running time so let reduce it for all.
> >
>
> ISTR you mentioned taking this one step further and making
> (interval * busy_factor) scale logarithmically with the number of CPUs to
> avoid reaching outrageous numbers. Did you experiment with that already?

Yes I have tried the logarithmically scale but It didn't give any
benefit compared to this solution for the fairness problem but
impacted other use cases because it impacts idle interval and it also
adds more constraints in the computation of the interval and
busy_factor because we can end up with the same interval for 2
consecutive levels .

That being said, it might be useful for other cases but i haven't look
further for this

>
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
> >       *sd = (struct sched_domain){
> >               .min_interval           = sd_weight,
> >               .max_interval           = 2*sd_weight,
> > -             .busy_factor            = 32,
> > +             .busy_factor            = 16,
> >               .imbalance_pct          = 117,
> >
> >               .cache_nice_tries       = 0,
