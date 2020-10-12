Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48A228BD53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbgJLQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390416AbgJLQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:11:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D3C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:11:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y14so14721900pgf.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSpAv/fxRMOHTxluR8E95d+3QzXvftAghz+wgrWZCqU=;
        b=gTaWKrodTeiz1dkPBFjT+oBUaHzNQszgeBWosfXzAxHDjbkrix5YeRZCao696oEtEt
         X8WtdxGOJqsepORmIhpaHvR8nck5xkPqYVmF0w9JXtdXE3oMhtjHQt1ZnUJgHW8PCzIC
         xw02OK0ZeqyZIEwXTd+FPaojF2hApTSSjtfaSNnReG2NTxaEnvDCA7gpH77OqHkosHiC
         flF91EeDtIQY8S8iYwNsQonLNk/tKV30pYs2v+bbaCE80dIdaR0lSa8br0KW9/Y9Tw1g
         NmlW+NIjbxpedF4iY7pi40QmE0xfkKpSfBCt/JMMBoqrug9eJWncVADzC0M5ZrK4iDDa
         hOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSpAv/fxRMOHTxluR8E95d+3QzXvftAghz+wgrWZCqU=;
        b=ir6PZAf3Qdow5v1bby2GrSjsEuE08l+wSrIgpWTLibekAHSxohMzRLXMu87nhIV7nL
         IfHRNWfUAz0yrxaviowZvC5ViH753WftmmZ3/NuQS8rfGoRFZ6TVVTzl+AD0H9rhkt6W
         BMc1cBiDMiLzAqDmSoLV2Ab+1hJvDnH5+BD0okEwrCilXtTlDPMKFgc3ZPlvrCkew9qy
         ebn2w0y90FhSyU0pO/S4pti296PrI6FaMEj7LFYHo3YqQY081Gd6K6Bovmmk0pVeGo0g
         M/Sq/Z2bHr7WH68GnhnOt528axn6Zz1qYYy+kuujj8EmCd2vuEDfxgqptmpQJvqoUiXm
         vucw==
X-Gm-Message-State: AOAM531l01bF8qrrCEOHk+WUaHEae/UBmvmiV1x6kmQ8EcqSoe8v3c9j
        mJVzoi/7+VEPxqs8kLTjAfmiy+Jw1+X2LupVz7kO1UVp+ls=
X-Google-Smtp-Source: ABdhPJyhx8MVq4+bIFEgAUcAS0Ckgzr9RgTBRsaCivvXReaeGJG4gmh486y2GpaxAHTTTUEgzbbMbe692+qcodcNFN4=
X-Received: by 2002:a17:90a:cb92:: with SMTP id a18mr20594678pju.136.1602519107803;
 Mon, 12 Oct 2020 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <6b6f14a32fc13e2f8de0f384cab5ae32ce5eb8e0.1602516273.git.andreyknvl@google.com>
 <CANpmjNMc4FHQPjSfPTrmx-wFj-tmcWwubaGJwb+zxZuzws4u6g@mail.gmail.com>
In-Reply-To: <CANpmjNMc4FHQPjSfPTrmx-wFj-tmcWwubaGJwb+zxZuzws4u6g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 12 Oct 2020 18:11:36 +0200
Message-ID: <CAAeHK+yoi-o3XnpwDp2d6pnJ2=5setPQe4w=1Stm=QZHYCasqw@mail.gmail.com>
Subject: Re: [PATCH v3] kcov, usb: specify contexts for remote coverage sections
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 6:08 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 12 Oct 2020 at 17:25, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Currently there's a KCOV remote coverage collection section in
> > __usb_hcd_giveback_urb(). Initially that section was added based on the
> > assumption that usb_hcd_giveback_urb() can only be called in interrupt
> > context as indicated by a comment before it. This is what happens when
> > syzkaller is fuzzing the USB stack via the dummy_hcd driver.
> >
> > As it turns out, it's actually valid to call usb_hcd_giveback_urb() in task
> > context, provided that the caller turned off the interrupts; USB/IP does
> > exactly that. This can lead to a nested KCOV remote coverage collection
> > sections both trying to collect coverage in task context. This isn't
> > supported by KCOV, and leads to a WARNING.
> >
> > The approach this patch takes is to add another set of kcov_remote_*()
> > callbacks that specify the context they are supposed to be executed in.
> > If the current context doesn't match the mask provided to a callback,
> > that callback is ignored. KCOV currently only supports collecting remote
> > coverage in two contexts: task and softirq. This patch constraints KCOV to
> > only collect coverage from __usb_hcd_giveback_urb() when it's executed in
> > softirq context.
> >
> > As the result, the coverage from USB/IP related usb_hcd_giveback_urb() calls
> > won't be collected, but the WARNING is fixed.
> >
> > A potential future improvement would be to support nested remote coverage
> > collection sections, but this patch doesn't address that.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >
> > Changes v2->v3:
> > - Keep behavoir of existing callbacks the same except for the
> >   __usb_hcd_giveback_urb() one.
> > - Fix build error with KOV disabled.
> >
> > ---
> >  Documentation/dev-tools/kcov.rst |  6 ++++++
> >  drivers/usb/core/hcd.c           |  4 ++--
> >  include/linux/kcov.h             | 31 +++++++++++++++++++++++++++++--
> >  kernel/kcov.c                    | 26 +++++++++++++++++++-------
> >  4 files changed, 56 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> > index 8548b0b04e43..2c0f58988512 100644
> > --- a/Documentation/dev-tools/kcov.rst
> > +++ b/Documentation/dev-tools/kcov.rst
> > @@ -235,6 +235,12 @@ saved to the kcov_handle field in the current task_struct and needs to be
> >  passed to the newly spawned threads via custom annotations. Those threads
> >  should in turn be annotated with kcov_remote_start()/kcov_remote_stop().
> >
> > +Besides the annotations that only accept a handle, there are also
> > +kcov_remote_start_context()/kcov_remote_stop_context() that accept a
> > +context mask. This mask describes the contexts in which these annotations
> > +should be applied. E.g. specifying KCOV_CONTEXT_SOFTIRQ will result in the
> > +corresponding annotations being ignored in any context other than softirq.
> > +
> >  Internally kcov stores handles as u64 integers. The top byte of a handle
> >  is used to denote the id of a subsystem that this handle belongs to, and
> >  the lower 4 bytes are used to denote the id of a thread instance within
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index a33b849e8beb..ea93d9ebcb2e 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -1646,9 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
> >
> >         /* pass ownership to the completion handler */
> >         urb->status = status;
> > -       kcov_remote_start_usb((u64)urb->dev->bus->busnum);
> > +       kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
> >         urb->complete(urb);
> > -       kcov_remote_stop();
> > +       kcov_remote_stop_softirq();
> >
> >         usb_anchor_resume_wakeups(anchor);
> >         atomic_dec(&urb->use_count);
> > diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> > index a10e84707d82..9e31b71ee3f9 100644
> > --- a/include/linux/kcov.h
> > +++ b/include/linux/kcov.h
> > @@ -22,6 +22,10 @@ enum kcov_mode {
> >         KCOV_MODE_TRACE_CMP = 3,
> >  };
> >
> > +#define KCOV_CONTEXT_TASK      (1u << 0)
> > +#define KCOV_CONTEXT_SOFTIRQ   (1u << 1)
> > +#define KCOV_CONTEXT_MASK      (KCOV_CONTEXT_TASK | KCOV_CONTEXT_SOFTIRQ)
> > +
> >  #define KCOV_IN_CTXSW  (1 << 30)
> >
> >  void kcov_task_init(struct task_struct *t);
> > @@ -38,10 +42,21 @@ do {                                                \
> >  } while (0)
> >
> >  /* See Documentation/dev-tools/kcov.rst for usage details. */
> > -void kcov_remote_start(u64 handle);
> > -void kcov_remote_stop(void);
> > +
> > +void kcov_remote_start_context(u64 handle, unsigned int context);
> > +void kcov_remote_stop_context(unsigned int context);
> >  u64 kcov_common_handle(void);
> >
> > +static inline void kcov_remote_start(u64 handle)
> > +{
> > +       return kcov_remote_start_context(handle, KCOV_CONTEXT_MASK);
> > +}
> > +
> > +static inline void kcov_remote_stop(void)
> > +{
> > +       return kcov_remote_stop_context(KCOV_CONTEXT_MASK);
> > +}
>
> These are returning void whereas kcov_remote_start_usb_softirq isn't.
> Was it intentional?

Not intentional, thank you for noticing! Will fix in v4.

>
> Other than that,
>
> Acked-by: Marco Elver <elver@google.com>
>
> Thank you!

Thanks!

>
> >  static inline void kcov_remote_start_common(u64 id)
> >  {
> >         kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
> > @@ -52,6 +67,16 @@ static inline void kcov_remote_start_usb(u64 id)
> >         kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id));
> >  }
> >
> > +static inline void kcov_remote_start_usb_softirq(u64 id)
> > +{
> > +       kcov_remote_start_context(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id), KCOV_CONTEXT_SOFTIRQ);
> > +}
> > +
> > +static inline void kcov_remote_stop_softirq(void)
> > +{
> > +       return kcov_remote_stop_context(KCOV_CONTEXT_SOFTIRQ);
> > +}
> > +
> >  #else
> >
> >  static inline void kcov_task_init(struct task_struct *t) {}
> > @@ -66,6 +91,8 @@ static inline u64 kcov_common_handle(void)
> >  }
> >  static inline void kcov_remote_start_common(u64 id) {}
> >  static inline void kcov_remote_start_usb(u64 id) {}
> > +static inline void kcov_remote_start_usb_softirq(u64 id) {}
> > +static inline void kcov_remote_stop_softirq(void) {}
> >
> >  #endif /* CONFIG_KCOV */
> >  #endif /* _LINUX_KCOV_H */
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 6b8368be89c8..3ccdbe060f47 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -808,7 +808,8 @@ static void kcov_remote_softirq_stop(struct task_struct *t)
> >         }
> >  }
> >
> > -void kcov_remote_start(u64 handle)
> > +/* Also see kcov_remote_start() defined in include/linux/kcov.h. */
> > +void kcov_remote_start_context(u64 handle, unsigned int context)
> >  {
> >         struct task_struct *t = current;
> >         struct kcov_remote *remote;
> > @@ -821,7 +822,11 @@ void kcov_remote_start(u64 handle)
> >
> >         if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
> >                 return;
> > -       if (!in_task() && !in_serving_softirq())
> > +       if (WARN_ON((context & ~KCOV_CONTEXT_MASK) || !context))
> > +               return;
> > +       if (in_task() && !(context & KCOV_CONTEXT_TASK))
> > +               return;
> > +       if (in_serving_softirq() && !(context & KCOV_CONTEXT_SOFTIRQ))
> >                 return;
> >
> >         local_irq_save(flags);
> > @@ -894,7 +899,7 @@ void kcov_remote_start(u64 handle)
> >         local_irq_restore(flags);
> >
> >  }
> > -EXPORT_SYMBOL(kcov_remote_start);
> > +EXPORT_SYMBOL(kcov_remote_start_context);
> >
> >  static void kcov_move_area(enum kcov_mode mode, void *dst_area,
> >                                 unsigned int dst_area_size, void *src_area)
> > @@ -951,8 +956,11 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
> >         }
> >  }
> >
> > -/* See the comment before kcov_remote_start() for usage details. */
> > -void kcov_remote_stop(void)
> > +/*
> > + * Also see kcov_remote_stop() defined in include/linux/kcov.h.
> > + * See the comment before kcov_remote_start_context() for usage details.
> > + */
> > +void kcov_remote_stop_context(unsigned int context)
> >  {
> >         struct task_struct *t = current;
> >         struct kcov *kcov;
> > @@ -962,7 +970,11 @@ void kcov_remote_stop(void)
> >         int sequence;
> >         unsigned long flags;
> >
> > -       if (!in_task() && !in_serving_softirq())
> > +       if (WARN_ON((context & ~KCOV_CONTEXT_MASK) || !context))
> > +               return;
> > +       if (in_task() && !(context & KCOV_CONTEXT_TASK))
> > +               return;
> > +       if (in_serving_softirq() && !(context & KCOV_CONTEXT_SOFTIRQ))
> >                 return;
> >
> >         local_irq_save(flags);
> > @@ -1018,7 +1030,7 @@ void kcov_remote_stop(void)
> >         /* Get in kcov_remote_start(). */
> >         kcov_put(kcov);
> >  }
> > -EXPORT_SYMBOL(kcov_remote_stop);
> > +EXPORT_SYMBOL(kcov_remote_stop_context);
> >
> >  /* See the comment before kcov_remote_start() for usage details. */
> >  u64 kcov_common_handle(void)
> > --
> > 2.28.0.1011.ga647a8990f-goog
> >
