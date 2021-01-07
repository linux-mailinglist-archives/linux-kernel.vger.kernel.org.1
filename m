Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCE2ECF8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbhAGMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbhAGMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:21:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7BFC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 04:20:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 23so14036932lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 04:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q305ql/jKfNfw97DapZFFwaBSwi/kjKvKVuSj2QGggE=;
        b=ksytn3ZcBSkuSQ4HtsnXWBR8+HZFCTJNGX8TLaS26nWkR+/LbRDItfmWKsGDcMTlxK
         AInVbK+8OFYZuIOMh8bu50vc2KtVwZstChjg8pPP12P3einWQRUyghTlvrbTa1th+T6i
         Vb0mDbpKDtcv80wUS4QflsxYZVgEY0r7F77DSQgA6SPjRqzcP9Gj9QtOzL3H/XmTOedY
         cnlluHOFgMSn3rK0W++xeZe/P9W4GK7Bv8tnwHdKA4m/eS/7Sdb9BXV4hRxIyLpPu10+
         L2z/uE5NVvq5mBaqSBMUlj9EcA4JDcLMm5lePStWfBJLa8MFG5klKSPMXchbWdcwF6cl
         CENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q305ql/jKfNfw97DapZFFwaBSwi/kjKvKVuSj2QGggE=;
        b=GqW+eG6tTMEtdYVc4B1yuUSVGu1VFcgn1/eFaeIvEDGc/GbBvMGyey4pay5pXjIRaE
         qE9SWy0pRsCdaXTvS1CGHCcbyQbi0goepMTvS/X1ARYfevlBfpBhku/4F8x1g82Om+5x
         +BpIJGkqBHbYEaUD5qLPSwkHWyXU4GJfhzy7ljjFopSjKbLNQEBKxspg24diAZD+X67R
         FQj4dlVH3ndlG0YyyEgoonCe7sZF4bxfxB+wmujaNX7u/dwixmyAAnkNQpX94dojWhA0
         +qBdkTqvRNc+RinsdGWz7TsCraeMKZwvF0MrsRbuiBKpSLGOO6WRYY7N1f2ekbZgfMm9
         PW+w==
X-Gm-Message-State: AOAM532Hmrf18amkN7uM6GUf4dEedd2FjF0FudIXhDAhsjC1EY3na4pq
        A6mKCf09Qv93LpKtCtSxybwu2pg56hqYwPw/1iv3JlpyRdRolA==
X-Google-Smtp-Source: ABdhPJxqqZWdVdoHozNX3ocBRH+panYiHkzHZX1YGIWB1CWkbhcKIJq9qcEAxvJHltU2kGAzg9Mbk+/TSCIRhqJP5kM=
X-Received: by 2002:ac2:4d91:: with SMTP id g17mr3675596lfe.254.1610022040445;
 Thu, 07 Jan 2021 04:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
 <20210107103325.30851-4-vincent.guittot@linaro.org> <jhjczyhasy0.mognet@arm.com>
In-Reply-To: <jhjczyhasy0.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Jan 2021 13:20:27 +0100
Message-ID: <CAKfTPtAW1e=AFfD3O58sZqAW281WA43gj6VDJUVjFLK4STWfHA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] sched/fair: reduce cases for active balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 at 12:26, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 07/01/21 11:33, Vincent Guittot wrote:
> > Active balance is triggered for a number of voluntary cases like misfit
> > or pinned tasks cases but also after that a number of load balance
> > attempts failed to migrate a task. There is no need to use active load
> > balance when the group is overloaded because an overloaded state means
> > that there is at least one waiting task. Nevertheless, the waiting task
> > is not selected and detached until the threshold becomes higher than its
> > load. This threshold increases with the number of failed lb (see the
> > condition if ((load >> env->sd->nr_balance_failed) > env->imbalance) in
> > detach_tasks()) and the waiting task will end up to be selected after a
> > number of attempts.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 45 +++++++++++++++++++++++----------------------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a3515dea1afc..00ec5b901188 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9499,13 +9499,32 @@ asym_active_balance(struct lb_env *env)
> >  }
> >
> >  static inline bool
> > -voluntary_active_balance(struct lb_env *env)
> > +imbalanced_active_balance(struct lb_env *env)
> > +{
> > +     struct sched_domain *sd = env->sd;
> > +
> > +     /*
> > +      * The imbalanced case includes the case of pinned tasks preventing a fair
> > +      * distribution of the load on the system but also the even distribution of the
> > +      * threads on a system with spare capacity
> > +      */
>
> Do you mean s/imbalanced/migrate_task/? This part here will affect
> group_imbalanced, group_asym_packing, and some others.

I really mean the imbalanced case which refers to the function name
and includes:
- the pinned tasks case aka group_imbalanced and which is the primary
target of this function ( which explains its name)
- but also the case where we want to evenly spread tasks on system
with spare capacity and removed this imbalance

>
> > +     if ((env->migration_type == migrate_task) &&
> > +         (sd->nr_balance_failed > sd->cache_nice_tries+2))
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
