Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005352C979D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 07:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgLAGnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 01:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLAGnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 01:43:18 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C27AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 22:42:38 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 10so839869ybx.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 22:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EOiNWj/v6Om5VbHvbnqPmQ1bxPyl/1tDTw/4vrS4ViU=;
        b=MDH6kKZNcuE+x0wA2aKQV5mLdCXchzgkVD4xXQxeojQo/XijvImmyvlJRX1QiHiwKQ
         Rv61O1wKULDeBFBVrfKCL5wTyKjO7D4Y1dGbUgaBEeotqrVTtQ2CNxdlQCxWdXKD93Mv
         4uN0NM+PGqjhyRPEPtQZIjUG8UAddw7zO1g3YWS2Y9e9CG5mKaflGC9A+GciP/RuYIqX
         I/1jaAPO244zBY9e8hxVC4oRDMf4+BeYiiyy8aEn7CrRyf+JjBTpCvUzmlQnAfvdGgzG
         WM9bubknPfDuOCVstZEQkelCyPLeDB+9n7E0IZDshjUOyY32kVZY2rNL5LUMTPl3Rr5L
         U1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EOiNWj/v6Om5VbHvbnqPmQ1bxPyl/1tDTw/4vrS4ViU=;
        b=X1Fp5/msrpq9IshtTgpE4D/VR2QbVwY/LirkF81QzncUFzWnxy/kkiCVtGyVInXMuD
         DC55Je9WpIbRIN+oPZWLoLvn9Vvkre0bOd/vf2UUwPmEvi5DUIZUFwj1tpyyQyAcYI2K
         cgD45n5YdRJyMEmrWqp2AvxKixHnOoV/jS1ADi6bOuSEvFoaOrzakZuGDAzYNCgvokIZ
         6TRZjzfVgNUMSBwC6hECAES0dWid2/fsMEkLhuuqh7m4E7mKSB7aoMbcgf3eAr04upvk
         LXWBBRXnEH+09AdNRRhfN9N1+iqIrJPwtSlnV2uVGmMbgg0eSDr/D7M+xq9wAF5VjRYE
         r9eQ==
X-Gm-Message-State: AOAM530ocuX6To1p3WhFaY5hRHafSiWRLjZrE0WrudHqZsMXd0l/A3Ug
        KkYcAYmocNaDa27zQvtuHDKoRYNqFcIWOsX/SgM=
X-Google-Smtp-Source: ABdhPJx/xBa64C7S+AtfHSeAYMSxvozLYhRQfucH8clQLsAAyQDk2FB5gdpnJp5DZ+OXZf6+WTxk072nG1/MoOnjLZA=
X-Received: by 2002:a25:d606:: with SMTP id n6mr1713217ybg.360.1606804957425;
 Mon, 30 Nov 2020 22:42:37 -0800 (PST)
MIME-Version: 1.0
References: <1602471178-59526-1-git-send-email-zhaoqianligood@gmail.com>
In-Reply-To: <1602471178-59526-1-git-send-email-zhaoqianligood@gmail.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Tue, 1 Dec 2020 14:42:26 +0800
Message-ID: <CAPx_LQH_CTOUUYTB_Vy0FRe9yZYV=2P4yTbVh8xQhCHGpFmBEA@mail.gmail.com>
Subject: Re: [PATCH V6] kthread: Add debugobject support
To:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     axboe@kernel.dk, akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        John Stultz <john.stultz@linaro.org>,
        ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,tglx

Would you like to continue to review the new patch set?I made some
changes according to your suggestion.
Unless this change will not be considered or unnecessary.

Thanks

Qianli Zhao <zhaoqianligood@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:00=E5=86=99=E9=81=93=EF=BC=
=9A
>
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
>
> kthread_work is not covered by debug objects, but the same problems as wi=
th
> regular work objects apply.
>
> Some of the issues like reinitialization of an active kthread_work are ha=
rd
> to debug because the problem manifests itself later in a completely
> different context.
>
> Add debugobject support along with the necessary fixup functions to make
> debugging of these problems less tedious.
>
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> ---
> V6:
> - Changelog update follow tglx's suggestion
> - Completion initialized as part of kthread_init_work_onstack() in kthrea=
d_flush_worker()/kthread_flush_work()
>
> V5:
> - Fix format error checked by checkpatch.pl
>
> V4:
> - Changelog update
> - Add comment for KWORK_ENTRY_STATIC
> - Code format modification
> - Check worker availability early in kthread_flush_work
>
> V3:
> - changelog update
> - add fixup_assert_init support
> - move debug_kwork_activate/debug_kwork_deactivate before list operation
> - name the kconfig CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
> - use kthread_init_work_onstack/destroy_kwork_on_stack when kthread_work =
used on stack
> - __init_kwork before clear kthread_work in kthread_init_work
> ---
>  include/linux/kthread.h |  30 +++++++++-
>  include/linux/poison.h  |   4 ++
>  kernel/kthread.c        | 142 ++++++++++++++++++++++++++++++++++++++++++=
+++---
>  lib/Kconfig.debug       |  10 ++++
>  4 files changed, 176 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 65b81e0..706302b 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -108,6 +108,17 @@ struct kthread_delayed_work {
>         struct timer_list timer;
>  };
>
> +#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
> +extern void __init_kwork(struct kthread_work *kwork, int onstack);
> +extern void destroy_kwork_on_stack(struct kthread_work *kwork);
> +extern void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *=
kdwork);
> +#else
> +static inline void __init_kwork(struct kthread_work *kwork, int onstack)=
 { }
> +static inline void destroy_kwork_on_stack(struct kthread_work *kwork) { =
}
> +static inline void destroy_delayed_kwork_on_stack(struct kthread_delayed=
_work *kdwork) { }
> +#endif
> +
> +
>  #define KTHREAD_WORKER_INIT(worker)    {                               \
>         .lock =3D __RAW_SPIN_LOCK_UNLOCKED((worker).lock),               =
 \
>         .work_list =3D LIST_HEAD_INIT((worker).work_list),               =
 \
> @@ -115,7 +126,7 @@ struct kthread_delayed_work {
>         }
>
>  #define KTHREAD_WORK_INIT(work, fn)    {                               \
> -       .node =3D LIST_HEAD_INIT((work).node),                           =
 \
> +       .node =3D { .next =3D KWORK_ENTRY_STATIC },                      =
   \
>         .func =3D (fn),                                                  =
 \
>         }
>
> @@ -159,6 +170,15 @@ extern void __kthread_init_worker(struct kthread_wor=
ker *worker,
>
>  #define kthread_init_work(work, fn)                                    \
>         do {                                                            \
> +               __init_kwork(work, 0);                                   =
       \
> +               memset((work), 0, sizeof(struct kthread_work));         \
> +               INIT_LIST_HEAD(&(work)->node);                          \
> +               (work)->func =3D (fn);                                   =
 \
> +       } while (0)
> +
> +#define kthread_init_work_onstack(work, fn)                             =
       \
> +       do {                                                            \
> +               __init_kwork(work, 1);                                   =
       \
>                 memset((work), 0, sizeof(struct kthread_work));         \
>                 INIT_LIST_HEAD(&(work)->node);                          \
>                 (work)->func =3D (fn);                                   =
 \
> @@ -172,6 +192,14 @@ extern void __kthread_init_worker(struct kthread_wor=
ker *worker,
>                              TIMER_IRQSAFE);                            \
>         } while (0)
>
> +#define kthread_init_delayed_work_onstack(dwork, fn)                    =
       \
> +       do {                                                            \
> +               kthread_init_work_onstack(&(dwork)->work, (fn));         =
       \
> +               __init_timer_on_stack(&(dwork)->timer,                   =
       \
> +                            kthread_delayed_work_timer_fn,             \
> +                            TIMER_IRQSAFE);                            \
> +       } while (0)
> +
>  int kthread_worker_fn(void *worker_ptr);
>
>  __printf(2, 3)
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index dc8ae5d..50811c74 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -82,4 +82,8 @@
>  /********** security/ **********/
>  #define KEY_DESTROY            0xbd
>
> +/********** kernel/kthread **********/
> +/*indicate a static kthread_work initializer for the object debugging co=
de.*/
> +#define KWORK_ENTRY_STATIC     ((void *) 0x600 + POISON_POINTER_DELTA)
> +
>  #endif
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 3edaa38..426b80f 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -68,6 +68,119 @@ enum KTHREAD_BITS {
>         KTHREAD_SHOULD_PARK,
>  };
>
> +#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
> +static struct debug_obj_descr kwork_debug_descr;
> +
> +static void *kwork_debug_hint(void *addr)
> +{
> +       return ((struct kthread_work *) addr)->func;
> +}
> +
> +static bool kwork_is_static_object(void *addr)
> +{
> +       struct kthread_work *kwork =3D addr;
> +
> +       return (kwork->node.prev =3D=3D NULL &&
> +               kwork->node.next =3D=3D KWORK_ENTRY_STATIC);
> +}
> +
> +static bool kwork_fixup_init(void *addr, enum debug_obj_state state)
> +{
> +       struct kthread_work *kwork =3D addr;
> +
> +       switch (state) {
> +       case ODEBUG_STATE_ACTIVE:
> +               kthread_cancel_work_sync(kwork);
> +               debug_object_init(kwork, &kwork_debug_descr);
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static bool kwork_fixup_free(void *addr, enum debug_obj_state state)
> +{
> +       struct kthread_work *kwork =3D addr;
> +
> +       switch (state) {
> +       case ODEBUG_STATE_ACTIVE:
> +               kthread_cancel_work_sync(kwork);
> +               debug_object_free(kwork, &kwork_debug_descr);
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static void stub_kthread_work(struct kthread_work *unuse)
> +{
> +       WARN_ON(1);
> +}
> +
> +static bool kwork_fixup_assert_init(void *addr, enum debug_obj_state sta=
te)
> +{
> +       struct kthread_work *kwork =3D addr;
> +
> +       switch (state) {
> +       case ODEBUG_STATE_NOTAVAILABLE:
> +               kthread_init_work(kwork, stub_kthread_work);
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static struct debug_obj_descr kwork_debug_descr =3D {
> +       .name                   =3D "kthread_work",
> +       .debug_hint             =3D kwork_debug_hint,
> +       .is_static_object       =3D kwork_is_static_object,
> +       .fixup_init             =3D kwork_fixup_init,
> +       .fixup_free             =3D kwork_fixup_free,
> +       .fixup_assert_init      =3D kwork_fixup_assert_init,
> +};
> +
> +static inline void debug_kwork_activate(struct kthread_work *kwork)
> +{
> +       debug_object_activate(kwork, &kwork_debug_descr);
> +}
> +
> +static inline void debug_kwork_deactivate(struct kthread_work *kwork)
> +{
> +       debug_object_deactivate(kwork, &kwork_debug_descr);
> +}
> +
> +static inline void debug_kwork_assert_init(struct kthread_work *kwork)
> +{
> +       debug_object_assert_init(kwork, &kwork_debug_descr);
> +}
> +
> +void __init_kwork(struct kthread_work *kwork, int onstack)
> +{
> +       if (onstack)
> +               debug_object_init_on_stack(kwork, &kwork_debug_descr);
> +       else
> +               debug_object_init(kwork, &kwork_debug_descr);
> +}
> +EXPORT_SYMBOL_GPL(__init_kwork);
> +
> +void destroy_kwork_on_stack(struct kthread_work *kwork)
> +{
> +       debug_object_free(kwork, &kwork_debug_descr);
> +}
> +EXPORT_SYMBOL_GPL(destroy_kwork_on_stack);
> +
> +void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork)
> +{
> +       destroy_timer_on_stack(&kdwork->timer);
> +       debug_object_free(&kdwork->work, &kwork_debug_descr);
> +}
> +EXPORT_SYMBOL_GPL(destroy_delayed_kwork_on_stack);
> +#else
> +static inline void debug_kwork_activate(struct kthread_work *kwork) { }
> +static inline void debug_kwork_deactivate(struct kthread_work *kwork) { =
}
> +static inline void debug_kwork_assert_init(struct kthread_work *kwork) {=
 }
> +#endif
> +
>  static inline void set_kthread_struct(void *kthread)
>  {
>         /*
> @@ -698,6 +811,7 @@ int kthread_worker_fn(void *worker_ptr)
>         if (!list_empty(&worker->work_list)) {
>                 work =3D list_first_entry(&worker->work_list,
>                                         struct kthread_work, node);
> +               debug_kwork_deactivate(work);
>                 list_del_init(&work->node);
>         }
>         worker->current_work =3D work;
> @@ -834,6 +948,7 @@ static void kthread_insert_work(struct kthread_worker=
 *worker,
>  {
>         kthread_insert_work_sanity_check(worker, work);
>
> +       debug_kwork_activate(work);
>         list_add_tail(&work->node, pos);
>         work->worker =3D worker;
>         if (!worker->current_work && likely(worker->task))
> @@ -858,6 +973,7 @@ bool kthread_queue_work(struct kthread_worker *worker=
,
>         bool ret =3D false;
>         unsigned long flags;
>
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
>         if (!queuing_blocked(worker, work)) {
>                 kthread_insert_work(worker, work, &worker->work_list);
> @@ -896,6 +1012,7 @@ void kthread_delayed_work_timer_fn(struct timer_list=
 *t)
>
>         /* Move the work from worker->delayed_work_list. */
>         WARN_ON_ONCE(list_empty(&work->node));
> +       debug_kwork_deactivate(work);
>         list_del_init(&work->node);
>         kthread_insert_work(worker, work, &worker->work_list);
>
> @@ -926,6 +1043,7 @@ static void __kthread_queue_delayed_work(struct kthr=
ead_worker *worker,
>         /* Be paranoid and try to detect possible races already now. */
>         kthread_insert_work_sanity_check(worker, work);
>
> +       debug_kwork_activate(work);
>         list_add(&work->node, &worker->delayed_work_list);
>         work->worker =3D worker;
>         timer->expires =3D jiffies + delay;
> @@ -955,6 +1073,7 @@ bool kthread_queue_delayed_work(struct kthread_worke=
r *worker,
>         unsigned long flags;
>         bool ret =3D false;
>
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
>
>         if (!queuing_blocked(worker, work)) {
> @@ -987,17 +1106,17 @@ static void kthread_flush_work_fn(struct kthread_w=
ork *work)
>   */
>  void kthread_flush_work(struct kthread_work *work)
>  {
> -       struct kthread_flush_work fwork =3D {
> -               KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> -               COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> -       };
> +       struct kthread_flush_work fwork;
>         struct kthread_worker *worker;
>         bool noop =3D false;
>
> +       debug_kwork_assert_init(work);
>         worker =3D work->worker;
>         if (!worker)
>                 return;
>
> +       fwork.done =3D COMPLETION_INITIALIZER_ONSTACK(fwork.done);
> +       kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
>         raw_spin_lock_irq(&worker->lock);
>         /* Work must not be used with >1 worker, see kthread_queue_work()=
. */
>         WARN_ON_ONCE(work->worker !=3D worker);
> @@ -1014,6 +1133,7 @@ void kthread_flush_work(struct kthread_work *work)
>
>         if (!noop)
>                 wait_for_completion(&fwork.done);
> +       destroy_kwork_on_stack(&fwork.work);
>  }
>  EXPORT_SYMBOL_GPL(kthread_flush_work);
>
> @@ -1054,6 +1174,7 @@ static bool __kthread_cancel_work(struct kthread_wo=
rk *work, bool is_dwork,
>          * be from worker->work_list or from worker->delayed_work_list.
>          */
>         if (!list_empty(&work->node)) {
> +               debug_kwork_deactivate(work);
>                 list_del_init(&work->node);
>                 return true;
>         }
> @@ -1092,6 +1213,7 @@ bool kthread_mod_delayed_work(struct kthread_worker=
 *worker,
>         unsigned long flags;
>         int ret =3D false;
>
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
>
>         /* Do not bother with canceling when never queued. */
> @@ -1116,10 +1238,12 @@ bool kthread_mod_delayed_work(struct kthread_work=
er *worker,
>
>  static bool __kthread_cancel_work_sync(struct kthread_work *work, bool i=
s_dwork)
>  {
> -       struct kthread_worker *worker =3D work->worker;
> +       struct kthread_worker *worker;
>         unsigned long flags;
>         int ret =3D false;
>
> +       debug_kwork_assert_init(work);
> +       worker =3D work->worker;
>         if (!worker)
>                 goto out;
>
> @@ -1194,13 +1318,13 @@ bool kthread_cancel_delayed_work_sync(struct kthr=
ead_delayed_work *dwork)
>   */
>  void kthread_flush_worker(struct kthread_worker *worker)
>  {
> -       struct kthread_flush_work fwork =3D {
> -               KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> -               COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> -       };
> +       struct kthread_flush_work fwork;
>
> +       fwork.done =3D COMPLETION_INITIALIZER_ONSTACK(fwork.done);
> +       kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
>         kthread_queue_work(worker, &fwork.work);
>         wait_for_completion(&fwork.done);
> +       destroy_kwork_on_stack(&fwork.work);
>  }
>  EXPORT_SYMBOL_GPL(kthread_flush_worker);
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0c781f9..81e0322 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -583,6 +583,16 @@ config DEBUG_OBJECTS_WORK
>           work queue routines to track the life time of work objects and
>           validate the work operations.
>
> +config DEBUG_OBJECTS_KTHREAD_WORK
> +       bool "Debug kthread work objects"
> +       depends on DEBUG_OBJECTS
> +       help
> +         If you say Y here, additional code will be inserted into the
> +         kthread routines to track the life time of kthread_work objects
> +         and validate the kthread_work operations.
> +
> +         If unsure, say N.
> +
>  config DEBUG_OBJECTS_RCU_HEAD
>         bool "Debug RCU callbacks objects"
>         depends on DEBUG_OBJECTS
> --
> 1.9.1
>
