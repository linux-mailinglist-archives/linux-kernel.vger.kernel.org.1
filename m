Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E345288372
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgJIH0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbgJIH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:26:33 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 00:26:33 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id c3so6555439ybl.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 00:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nX8LaYlgFI8pSxcFor1JWVzHslHCgNEFBImUZwGXD/s=;
        b=qjC4QvUagjX3m085IM+aCTiCw1n6/oUCOqJ1ODyb10/u6ToyEmSnR7d2n3CVBaQ+eJ
         yrIhLwzfo/Cc4FgQ2iJaw4TYvJUWdMgL6MQ1wEyTFg3NN/k1nmL1AOGmoYwlwNSgib3h
         1GeQlhVSXESLJM6T0ia8+spUD+6B5L036kwFu5+KUxp+Rp4MVq3+cQPeHLlmpKMUwrah
         zb4ukC6A3TtIfSoVY6shi9Q63IjaiEfMOEU8dMRTDlSf0M+xEo6vbyDlAlRH9mTJnKG2
         i0BdF7VCjGII/3c/uEGvHdfOOs3vQrOy2DGq9oJ4PiEMYv7CaUXDi5ju7RP8LED0lmkn
         3H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nX8LaYlgFI8pSxcFor1JWVzHslHCgNEFBImUZwGXD/s=;
        b=VMqvT9FzboYKZ3h2RFAGrOrXAMAV4NWvYNd5WiX+DgsccHHwFZ6DldorUhnoI03FcG
         onm73GozfbKLXeijHhGKl8hTD9SqQnE74db0SIEldEKV1Hu6Sk/PC4GfHRm7z3UCIb39
         OpucGlbw1OzvleBZBgJhssPjRnMfG4MFVL8YOwipO8FZzi/BSayw7bJTwJYrbt/cRdWn
         3wihIzk1EwHirb0/GJL1Jqdy+ryWoKROI4xamZX6XX1Wo2PWtbNUhLbNjp2Rod3HDutF
         29sNKMbjBTkcoAkTn81LDIZ3YeHXYuXJLNz7ifJTy0sSi/merq1PUOHCFHvFexUWFlf9
         Rzwg==
X-Gm-Message-State: AOAM532xnQoMzQt4RQM2Y1HTKk9g34R8He67i8ynPU//j8A0ldySRQNb
        3oKW8v20IXzZaDYWv2tgkQxamUGSdxXytkUWxuw=
X-Google-Smtp-Source: ABdhPJzgQRWQGAbDFKvyzxXVMBIFJtVWQb+bA8M62jv8HT6aXK9ROo0Nq9YUFZ4V4U8/BKp6GzrJxwIIHsaaNfybvjs=
X-Received: by 2002:a25:d74f:: with SMTP id o76mr16988395ybg.55.1602228392258;
 Fri, 09 Oct 2020 00:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <7a7af0e893e3ceb0d8d1f055bffca1d47025d7ba.1597645588.git.zhaoqianli@xiaomi.com>
 <87a6x6f21t.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87a6x6f21t.fsf@nanos.tec.linutronix.de>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Fri, 9 Oct 2020 15:26:21 +0800
Message-ID: <CAPx_LQGWETZYDpHA1-pVfjo7JuAEQ4o7cQyGFhFcVepp1UqDcw@mail.gmail.com>
Subject: Re: [PATCH v5] kthread: Add debugobject support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Thomas

Thanks for your reply


On Thu, 1 Oct 2020 at 22:34, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Aug 17 2020 at 14:37, Qianli Zhao wrote:
> > From: Qianli Zhao <zhaoqianli@xiaomi.com>
> >
> > Add debugobject support to track the life time of kthread_work
> > which is used to detect reinitialization/free active object problems
> > Add kthread_init_work_onstack()/kthread_init_delayed_work_onstack() for
> > kthread onstack support
> >
> > If we reinitialize a kthread_work that has been activated,
> > this will cause delayed_work_list/work_list corruption.
> > enable this config,there is an chance to fixup these errors
> > or WARNING the wrong use of kthread_work
> >
> > [30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88, but was ffffffe388ebb588
> > [30858.395788] WARNING: CPU: 2 PID: 387 at kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
> > ...
> > [30858.395906] Call trace:
> > [30858.395909]  __list_del_entry_valid+0xc8/0xd0
> > [30858.395912]  __kthread_cancel_work_sync+0x98/0x138
> > [30858.395915]  kthread_cancel_delayed_work_sync+0x10/0x20
> > [30858.395917]  sde_encoder_resource_control+0xe8/0x12c0
> > [30858.395920]  sde_encoder_prepare_for_kickoff+0x5dc/0x2008
> > [30858.395923]  sde_crtc_commit_kickoff+0x280/0x890
> > [30858.395925]  sde_kms_commit+0x16c/0x278
> > [30858.395928]  complete_commit+0x3c4/0x760
> > [30858.395931]  _msm_drm_commit_work_cb+0xec/0x1e0
> > [30858.395933]  kthread_worker_fn+0xf8/0x190
> > [30858.395935]  kthread+0x118/0x128
> > [30858.395938]  ret_from_fork+0x10/0x18
> >
> > crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
> >  [ffffffe389392620] delayed_work_list = {
> >     next = 0xffffffe388ebbf88,
> >     prev = 0xffffffe388ebb588
> >   }
> > crash> list 0xffffffe388ebbf88
> > ffffffe388ebbf88
>
> This changelog is confusing at best. Something like this perhaps?
>
>   kthread_work is not covered by debug objects, but the same problems as with
>   regular work objects apply.
>
>   Some of the issues like reinitialization of an active kthread_work are hard
>   to debug because the problem manifests itself later in a completely
>   different context.
>
>   Add debugobject support along with the necessary fixup functions to make
>   debugging of these problems less tedious.
>

Will follow your tips to improve.

> > +static void stub_kthread_work(struct kthread_work *unuse)
>
> unused?
>
> > +{
> > +     WARN_ON(1);
> > +}

When the kthread_work is not initialized, kwork_fixup_assert_init()
will call kthread_init_work() to fixup this kthread_work,and
kthread_init_work() needs a function as a parameter,so we have to
quote an empty function(refer to stub_timer()).

> >  void kthread_flush_work(struct kthread_work *work)
> >  {
> >       struct kthread_flush_work fwork = {
> > -             KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> > -             COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> > +             .done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
>
> Eew. Why is the completion initialized seperately instead of being
> initialized as part of kthread_init_work_onstack() ?
>

I just try to keep the same as before,how about change as below?
completion initialized as part of kthread_init_work_onstack()
@@ -1319,10 +1318,9 @@ bool kthread_cancel_delayed_work_sync(struct
kthread_delayed_work *dwork)
  */
 void kthread_flush_worker(struct kthread_worker *worker)
 {
-       struct kthread_flush_work fwork = {
-               .done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
-       };
+       struct kthread_flush_work fwork;

+       fwork.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done);
        kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);

> >       };
> >       struct kthread_worker *worker;
> >       bool noop = false;
> >
> > +     debug_kwork_assert_init(work);
> >       worker = work->worker;
> >       if (!worker)
> >               return;
> >
> > +     kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
> >
> > @@ -1194,12 +1319,13 @@ EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
> >  void kthread_flush_worker(struct kthread_worker *worker)
> >  {
> >       struct kthread_flush_work fwork = {
> > -             KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> > -             COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> > +             .done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> >       };
>
> Ditto.
>
> > +     kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
> >       kthread_queue_work(worker, &fwork.work);
> >       wait_for_completion(&fwork.done);
> > +     destroy_kwork_on_stack(&fwork.work);
>
> Thanks,
>
>         tglx
