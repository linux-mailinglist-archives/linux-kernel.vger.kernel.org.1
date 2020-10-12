Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12828BB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbgJLPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389225AbgJLPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:15:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A9C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:15:01 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so18011827ior.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aopq3bWlyudeE0F1obi/ohMkIFf3denWD7+q5Q1/76Q=;
        b=NlZfCgBepBO3p7AThICPnp1xjH8hkVObWLmfguiUKUnRf61VZrAfUcWGFEi0fdhK3c
         L5YJbaL6cLB47otNtxPfSWp/b7HKHxOn9VA4APAXRNx+3TXA9MFWoIk3zQlTD+lN5Osk
         Xymgk4UbKuNQR7ZQvh4F8PDoDWk/h+jdGmmOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aopq3bWlyudeE0F1obi/ohMkIFf3denWD7+q5Q1/76Q=;
        b=gitQ6gxt7F/VZFvtVIb/5m/yG93JqWl/A+XEXmhSpUfoCFKx40mSjnX0C/KjNoDgDI
         dTfB1BELNI37bUlX8a+TUtzHg91cl4UVd/6t2Rp6Q+X8k+Nb5UeIA7e22HeyIVCL5hf8
         DfuOXKMea1NvnErkQ8jMBBZujgRi0X+WOrpJjz2MqrRWIVHZTVUHBSGcMmRqytOaURqn
         lVdHYkzWpfrk6weoj08a3wGwEnsPJwYtv/+RrmPz/+C9dEtiVloA08gy3VvJwFjj1MUW
         tCEi1lFt7zrCF6PLmM6nLUcv393TrAqlePC6gSobMt/Zqa4pR66Bch+AgPY0J7MkyDmR
         Ayrw==
X-Gm-Message-State: AOAM53200bE3yK2GFnmt8HFuhavGbi3xiyUh1tFdt5Zlx+hIMElsKdvj
        IiELiK+Nre178qIvZzR5uHlXVG5WZbs5yL8OsgVIsWs8aW8=
X-Google-Smtp-Source: ABdhPJxO/t6b0YLIr1p/givst+C1fgAosSNr7nGTAoYMZ4ulnxXPxtCs0/jrVSIg5+JRnEXt7TLOfokvuMfzEmBQdg8=
X-Received: by 2002:a05:6638:2395:: with SMTP id q21mr19119566jat.94.1602515700748;
 Mon, 12 Oct 2020 08:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201010180323.126634-1-robdclark@gmail.com> <20201012095955.0741313b@gandalf.local.home>
In-Reply-To: <20201012095955.0741313b@gandalf.local.home>
From:   Rob Clark <robdclark@chromium.org>
Date:   Mon, 12 Oct 2020 08:14:50 -0700
Message-ID: <CAJs_Fx69jUs5jJdX6ZpP4Z4K_iFdkUAAiium6xAuBiM00Gd4SA@mail.gmail.com>
Subject: Re: [PATCH] kthread: Add kthread_work tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "J. Bruce Fields" <bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 6:59 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 10 Oct 2020 11:03:22 -0700
> Rob Clark <robdclark@gmail.com> wrote:
>
> > /**
> > + * sched_kthread_work_execute_start - called immediately before the work callback
> > + * @work:    pointer to struct kthread_work
> > + *
> > + * Allows to track kthread work execution.
> > + */
> > +TRACE_EVENT(sched_kthread_work_execute_start,
> > +
> > +     TP_PROTO(struct kthread_work *work),
> > +
> > +     TP_ARGS(work),
> > +
> > +     TP_STRUCT__entry(
> > +             __field( void *,        work    )
> > +             __field( void *,        function)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->work           = work;
> > +             __entry->function       = work->func;
> > +     ),
> > +
> > +     TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
> > +);
> > +
> > +/**
> > + * sched_kthread_work_execute_end - called immediately after the work callback
> > + * @work:    pointer to struct work_struct
> > + * @function:   pointer to worker function
> > + *
> > + * Allows to track workqueue execution.
> > + */
> > +TRACE_EVENT(sched_kthread_work_execute_end,
> > +
> > +     TP_PROTO(struct kthread_work *work, kthread_work_func_t function),
> > +
> > +     TP_ARGS(work, function),
> > +
> > +     TP_STRUCT__entry(
> > +             __field( void *,        work    )
> > +             __field( void *,        function)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->work           = work;
> > +             __entry->function       = function;
> > +     ),
> > +
> > +     TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
> > +);
> > +
>
>
> Please combine the above into:
>
> DECLARE_EVENT_CLASS(sched_kthread_work_execute_template,
>
>         TP_PROTO(struct kthread_work *work),
>
>         TP_ARGS(work),
>
>         TP_STRUCT__entry(
>                 __field( void *,        work    )
>                 __field( void *,        function)
>         ),
>
>         TP_fast_assign(
>                 __entry->work           = work;
>                 __entry->function       = work->func;
>         ),
>
>         TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
> );
>
> DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_start,
>         TP_PROTO(struct kthread_work *work),
>         TP_ARGS(work));
>
> DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_end,
>         TP_PROTO(struct kthread_work *work),
>         TP_ARGS(work));
>
> As events are cheap, classes are expensive (size wise), and a TRACE_EVENT()
> is really just a CLASS and EVENT for a single instance.

I think we cannot quite do this, because we should not rely on being
able to dereference work after it finishes.  Although I suppose I
could just define it to explicitly pass the fxn ptr to both
tracepoints..

BR,
-R
