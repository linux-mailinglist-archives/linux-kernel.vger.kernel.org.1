Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99E52EEE5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAHIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbhAHIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:12:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B923C0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 00:11:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b26so20940764lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 00:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykLwi22uno/ZUjFcOacOZhhHNN05mWohWUNupC81uj4=;
        b=lTyK/BfG+JkQVfLCmWY5HMcGqkSrzSxUhzof4/T94WejouG5IyZSy6bU51Zd3+pv8R
         YaGrtuKSYhXDrK6MtDhskCm/6ZDofs0+b38Q0HAnKiyUxTdaQpABBVxR4LglqbcxpUvi
         cuj4b8HWtmq66Pd8ynj7TUh+1jEvWgshpxud1R8mERlpoKoHfTHfThIqsrC72beRblL7
         Ruzw8cOzsLCfkmRxgWDVWJKgY+i3qw2jOAU/Afdy4yaGSLOoiW0k+ns0pfvsWwKoRRaF
         Ki10HLHtViCT8Es4J7yHh/TcGEoyZwF4EinfFz5xwnP2Z3qXKAtYQStH1CHPhLiziCoq
         FZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykLwi22uno/ZUjFcOacOZhhHNN05mWohWUNupC81uj4=;
        b=fQPGbaTmgyG4a58sdbzGnb3yhLPgugWdZmUUJnGPaqJQB4duXc3UdYoOtpLGRbp3Df
         r68gbeJQ+ghWsN1Zd6uTDDai36bKhsAHQZKe5TFt3LXyW1YsYyF0XKc/bCQsQR/3g5KL
         rvW2yyZESMr9Gh5RC5/LCp5LPS8TOW+LTPy2STCL0OdH13aIIrLNu5UIgEl4Vq94ZKt8
         gOOPAHqXE9MX1ZTWqKlLrsYmrW/yejAGuCGKdwMFZhqrgY7J91NM5NzUR/mijKGSjOcN
         S2A2H52Fsi4CNoN6NQFjL4bgACMpctEeO6xBo08ZdyWF2GOxddv05sK6t74MzHueX9UB
         +OkA==
X-Gm-Message-State: AOAM531/y6GvDyKR6OFkchuLksZCfx2+Ir+fA+Jz8dC4sUAWJyxlv79z
        y8wBxbpMNol43YmkXoCLvFmybfqW/hiE2ESzJAy2xQ==
X-Google-Smtp-Source: ABdhPJyJdJRh71P1Lh1v5aXIW6LPrCFdjCFM8GiI8t1LTU1NHQipffYZyVAEjV3lytCax92ooXz0l0TqzpFnYwYQpz4=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr1098021ljm.445.1610093505064;
 Fri, 08 Jan 2021 00:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
 <20210107103325.30851-4-vincent.guittot@linaro.org> <jhjczyhasy0.mognet@arm.com>
 <CAKfTPtAW1e=AFfD3O58sZqAW281WA43gj6VDJUVjFLK4STWfHA@mail.gmail.com> <jhjo8i063yc.mognet@arm.com>
In-Reply-To: <jhjo8i063yc.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Jan 2021 09:11:34 +0100
Message-ID: <CAKfTPtDhyD2qzjmSGJSsnQwv2M7KSbFhFYkkKUJ0rmvJx632vw@mail.gmail.com>
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

On Thu, 7 Jan 2021 at 18:40, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 07/01/21 13:20, Vincent Guittot wrote:
> > On Thu, 7 Jan 2021 at 12:26, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >> > @@ -9499,13 +9499,32 @@ asym_active_balance(struct lb_env *env)
> >> >  }
> >> >
> >> >  static inline bool
> >> > -voluntary_active_balance(struct lb_env *env)
> >> > +imbalanced_active_balance(struct lb_env *env)
> >> > +{
> >> > +     struct sched_domain *sd = env->sd;
> >> > +
> >> > +     /*
> >> > +      * The imbalanced case includes the case of pinned tasks preventing a fair
> >> > +      * distribution of the load on the system but also the even distribution of the
> >> > +      * threads on a system with spare capacity
> >> > +      */
> >>
> >> Do you mean s/imbalanced/migrate_task/? This part here will affect
> >> group_imbalanced, group_asym_packing, and some others.
> >
> > I really mean the imbalanced case which refers to the function name
> > and includes:
> > - the pinned tasks case aka group_imbalanced and which is the primary
> > target of this function ( which explains its name)
> > - but also the case where we want to evenly spread tasks on system
> > with spare capacity and removed this imbalance
> >
>
> But can't this also affect other group_types? calculate_imbalance() can
> set
>
>   env->migration_type = migrate_task;
>
> for
>
>   busiest->group_type > group_fully_busy

yes but we are still in the case of evenly spread tasks on system with
spare capacity. Also, this is already the behavior for such cases.
