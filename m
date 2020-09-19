Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0C270A78
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 06:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgISEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 00:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgISEEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 00:04:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B445C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 21:04:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so4605758pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Tw/VT6abRABuCODOnmZy5z2Kq1FJN33mmLRQftQB9M=;
        b=SLgzzufE74BEoJjpZcOn3EKPfDfc/uhsl2wl+I6FP3DDJfZmFvGr9OMgqfYeaYSbO4
         c/ioBqnUlYb+by5MXp/LkSEG4WpgYtoHTXsn9TVp2CT04+/I3OTXCBTJ5EIE4IBlcjy6
         nRXRN9Hfr92edtA+aKOYd3rRs6tuMTokFPsXdP/XQ+89Xh1sIleSQ5K87GozIjGPY8Js
         T6LswBBgqHGqZ/zwI92ueJZXkTqLPdnEYsIKADKcZkOA4QfyCDl838cNt47qm9g65SbU
         /ITeJ343EhacZMWf0IevCnawFNpDg264s8gs0xqYdSUMFO2/Q2cBKS4j1uwhcrjfi+yi
         4yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Tw/VT6abRABuCODOnmZy5z2Kq1FJN33mmLRQftQB9M=;
        b=qV9QYKVy8kW2kVDSOkez5lJ7GaFfJoOC8GeolcQYDBFrvhSpp3We1xnnvQ5UGuiruQ
         vck9VVdDpWNp0kYNCUDoigxZu5PF9PyFzc+Vnmfpzy0CCCP/+stYfGqBLQ5130n3jnr/
         ip57Hfk70hC8AK4nEADZp+OLVoTt2x23J/ycQkzBPp4dcQXi7ufEyMyU0RfP0OEpulgM
         uOTVxE8IY5AaDcH0ItG5vc+iTN81iNMc70I982edn6chKvlKUItSl0K9qGmQX495KU/m
         nmvpykoRGQ3f5i08xHOFF9YEpDjf0gAO4YYqgZm4KGCCoLqB7PcK6aYuoCNCoOPeczfE
         dqzg==
X-Gm-Message-State: AOAM532G+a3lT/FZiGmmeeP473QzQwVpj6YcXWGdMj4AeQWiPKdDIr2a
        Co2Hxhc1vvF2ICJkq2HaCdMI4V8yC4qlRMWIL9fMag==
X-Google-Smtp-Source: ABdhPJw78K/EoK2HyOpx187ms+jNQII1MEFnLFRwW5iZxScNP+NMKFBYliXJncTEafPEtV8yUK129CnKtnGWbejEAio=
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id
 s7-20020aa782870000b0290142250139ecmr18340385pfm.59.1600488290025; Fri, 18
 Sep 2020 21:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200905060412.88560-1-songmuchun@bytedance.com> <20200918124600.69e94b71@gandalf.local.home>
In-Reply-To: <20200918124600.69e94b71@gandalf.local.home>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 19 Sep 2020 12:04:13 +0800
Message-ID: <CAMZfGtViXY2F-fMxGeegiCqrFs5wTUpQKmovbDSGwzvCfe8T3Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] tasklet: Introduce tasklet tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, romain.perier@gmail.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 12:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat,  5 Sep 2020 14:04:12 +0800
> Muchun Song <songmuchun@bytedance.com> wrote:
>
> > Introduce tracepoints for tasklets just like softirq does. In this case,
> > we can calculate tasklet latency and know what tasklet run.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/trace/events/irq.h | 44 ++++++++++++++++++++++++++++++++++++++
> >  kernel/softirq.c           |  2 ++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
> > index eeceafaaea4c..69a16f3a21c2 100644
> > --- a/include/trace/events/irq.h
> > +++ b/include/trace/events/irq.h
> > @@ -160,6 +160,50 @@ DEFINE_EVENT(softirq, softirq_raise,
> >       TP_ARGS(vec_nr)
> >  );
> >
> > +DECLARE_EVENT_CLASS(tasklet,
> > +
> > +     TP_PROTO(struct tasklet_struct *t),
> > +
> > +     TP_ARGS(t),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(        void *, callback        )
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->callback = t->callback;
>
> I think you need to replicate the logic in the code:
>
>                 if (t->use_callback)
>                         __entry->callback = t->callback;
>                 else
>                         __entry->callback = t->func;

The `callback` and `func` is union and `callback` will replace
`func` someday in the feature. So I think that here we use
`t->callback` is enough. Right? Thanks.

>
> -- Steve
>
> > +     ),
> > +
> > +     TP_printk("callback=%ps", __entry->callback)
> > +);
> > +
> > +/**
> > + * tasklet_entry - called immediately before the tasklet handler
> > + * @t: pointer to struct tasklet_struct
> > + *
> > + * When used in combination with the tasklet_exit tracepoint
> > + * we can determine the tasklet handler routine.
> > + */
> > +DEFINE_EVENT(tasklet, tasklet_entry,
> > +
> > +     TP_PROTO(struct tasklet_struct *t),
> > +
> > +     TP_ARGS(t)
> > +);
> > +
> > +/**
> > + * tasklet_exit - called immediately after the tasklet handler returns
> > + * @t: pointer to struct tasklet_struct
> > + *
> > + * When used in combination with the tasklet_entry tracepoint
> > + * we can determine the tasklet handler routine.
> > + */
> > +DEFINE_EVENT(tasklet, tasklet_exit,
> > +
> > +     TP_PROTO(struct tasklet_struct *t),
> > +
> > +     TP_ARGS(t)
> > +);
> >  #endif /*  _TRACE_IRQ_H */
> >
> >  /* This part must be outside protection */
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index bf88d7f62433..0f9f5b2cc3d3 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -553,10 +553,12 @@ static void tasklet_action_common(struct softirq_action *a,
> >                               if (!test_and_clear_bit(TASKLET_STATE_SCHED,
> >                                                       &t->state))
> >                                       BUG();
> > +                             trace_tasklet_entry(t);
> >                               if (t->use_callback)
> >                                       t->callback(t);
> >                               else
> >                                       t->func(t->data);
> > +                             trace_tasklet_exit(t);
> >                               tasklet_unlock(t);
> >                               continue;
> >                       }
>


-- 
Yours,
Muchun
