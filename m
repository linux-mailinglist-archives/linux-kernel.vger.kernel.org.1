Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984A622CEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 21:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:35:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20F0C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:35:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s189so3685690iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfXUqywojfTyPVAtr3dZJqxRQaBJzeI+7fUn5bNK71A=;
        b=qJfJnqhIA6GWl/EQVKkfUjcNv/yM4zbW5MlLKnr3EacZlE/oTx7DBET5AWCXSaoNla
         gP6BBvuYBTdolIYzEh8qR8Bm0zEIlSVkpoH2v8u3xxUy5ZBFm2sO1ff7RKAuTbcFbK6W
         t3Wy80oJ6tlUHSo7iZCPsEHjx4pxZo4u7WCIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfXUqywojfTyPVAtr3dZJqxRQaBJzeI+7fUn5bNK71A=;
        b=Z6NyGwn/UU6EcCBrQLVu+na8ill6rX9x+xpYoIHJpT0raTQK+uurAp5tD5UPPkEmAa
         NH0Gzi4Zubm2wkRdLRaQ/YbyHGGv/0Hx9ONh659DimxMVII/MA/h433nBIzvx4OTS+rq
         yMv4jqb0dxpQ8Z7OGyLOs56LeiZQLdA1jG1qSrZiY7z2e2yh9EfFgea3Lh7/3ZGKALFe
         Q3XlU9A7C35w90Q3e04WuLLf8zwL0GPO4gVG7Ji0h9hNuVigytz//q410L9GygbiIywZ
         tNAyk5CNTJ8rxuewEbZJ9mHIXWs+XXaX7fQXtaSBYDBw/WFeFXyHuPKj67PcMRZvIoBU
         dWlQ==
X-Gm-Message-State: AOAM532qTMZHLlBa+YYPslNpigj1DG+D+0NViA3qZoBpj+37ugMGFGYH
        HGP91CnN3AGNyPlzdZKPTiadmL0Kg9Ip0yEj/EMdMQ==
X-Google-Smtp-Source: ABdhPJy/C/8/7t9G5BmZSyZZzr/kQM/LFbD0WPZmgFsJ5u93Ru2xsRRtyO4TPeyXyPagSucpoAPLysM+CNVKgGb86ao=
X-Received: by 2002:a05:6638:1ec:: with SMTP id t12mr12402601jaq.86.1595619300093;
 Fri, 24 Jul 2020 12:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200719035518.2386828-1-joel@joelfernandes.org>
 <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
 <20200719041841.GA2398236@google.com> <20200720082211.GA35358@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
In-Reply-To: <20200720082211.GA35358@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 24 Jul 2020 15:34:46 -0400
Message-ID: <CAEXW_YR4dxuPV+Yu9HcYCSAdiV1H=9Rk9HJgCST-YMMc7J2Mgg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist datastructure
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 4:22 AM <boqun.feng@gmail.com> wrote:
>
> Hi Joel,

Sorry for the late reply as I was on vacation last several days.

>
> On Sun, Jul 19, 2020 at 12:18:41AM -0400, Joel Fernandes wrote:
> > On Sun, Jul 19, 2020 at 12:06:28AM -0400, Joel Fernandes wrote:
> > > On Sat, Jul 18, 2020 at 11:55 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > [...]
> > > >         /* If no callbacks moved, nothing more need be done. */
> > > > @@ -419,10 +494,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> > > >          * callbacks.  The overall effect is to copy down the later pointers
> > > >          * into the gap that was created by the now-ready segments.
> > > >          */
> > > > -       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
> > > > -               if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
> > > > -                       break;  /* No more callbacks. */
> > > > +       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL && j < RCU_NEXT_TAIL; i++, j++) {
> > > >                 WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> > > > +               rcu_segcblist_move_seglen(rsclp, i, j);
> > > >                 rsclp->gp_seq[j] = rsclp->gp_seq[i];
> > > >         }
> > >
> > > Unfortunately I broke this code, _sigh_.  I need to reinstate the
> > > if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL]) , I completely
> > > misunderstood that.
> >
> > And hopefully, third time's a charm with various extra newlines removed:
> >
> > ---8<-----------------------
> >
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH v3] rcu/segcblist: Add counters to segcblist datastructure
> >
> > Add counting of segment lengths of segmented callback list.
> >
> > This will be useful for a number of things such as knowing how big the
> > ready-to-execute segment have gotten. The immediate benefit is ability
> > to trace how the callbacks in the segmented callback list change.
> >
> > Tested by profusely reading traces when segcblist counts updated.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > v1->v3: minor nits.
> > ---
> >  include/linux/rcu_segcblist.h |  2 +
> >  kernel/rcu/rcu_segcblist.c    | 77 +++++++++++++++++++++++++++++++++--
> >  2 files changed, 76 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > index b36afe7b22c9..d462ae5e340a 100644
> > --- a/include/linux/rcu_segcblist.h
> > +++ b/include/linux/rcu_segcblist.h
> > @@ -69,8 +69,10 @@ struct rcu_segcblist {
> >       unsigned long gp_seq[RCU_CBLIST_NSEGS];
> >  #ifdef CONFIG_RCU_NOCB_CPU
> >       atomic_long_t len;
> > +     atomic_long_t seglen[RCU_CBLIST_NSEGS];
> >  #else
> >       long len;
> > +     long seglen[RCU_CBLIST_NSEGS];
> >  #endif
> >       u8 enabled;
> >       u8 offloaded;
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 9a0f66133b4b..c5841efcd38e 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -88,6 +88,57 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
> >  #endif
> >  }
> >
> > +/* Get the length of a segment of the rcu_segcblist structure. */
> > +static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
> > +{
> > +#ifdef CONFIG_RCU_NOCB_CPU
> > +     return atomic_long_read(&rsclp->seglen[seg]);
> > +#else
> > +     return READ_ONCE(rsclp->seglen[seg]);
> > +#endif
> > +}
> > +
> > +/* Set the length of a segment of the rcu_segcblist structure. */
> > +static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> > +{
> > +#ifdef CONFIG_RCU_NOCB_CPU
> > +     atomic_long_set(&rsclp->seglen[seg], v);
> > +#else
> > +     WRITE_ONCE(rsclp->seglen[seg], v);
> > +#endif
>
> These #ifdef really make me uncomfortable ;-) Since we are allowed to
> use the '_Generic' key from C11 (see include/linux/compiler_types.h), I
> wonder whether it's better if we have a few "generic" primitives like:
>
>         #define gen_long_read(x) _Generic((x),                                          \
>                                           atomic_long_t: atomic_long_read(&x, v),       \
>                                           long: READ_ONCE(x)),                          \
>                                           ...
>
>         #define gen_long_set(x, v) _Generic((x),                                        \
>                                             atomic_long_t: atomic_long_set(&x, v),      \
>                                             long: WRITE_ONCE(x, v)),                    \
>                                             ...
>
> , and similar for _xchg and _add.

This sounds like a good idea. But isn't the kernel compiled with -std=gnu89

Here are the KBUILD_CFLAGS

KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
                   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
                   -Werror=implicit-function-declaration -Werror=implicit-int \
                   -Wno-format-security \
                   -std=gnu89

With "make kernel/rcu/tree.o V=1" confirming it as well:

  gcc -Wp,-MD,kernel/rcu/.tree.o.d  -nostdinc -isystem
/usr/lib/gcc/x86_64-linux-gnu/9/include -I./arch/x86/include
-I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
-I./arch/x86/include/generated/uapi -I./include/uapi
-I./include/generated/uapi -include ./include/linux/kconfig.h -include
./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef
-Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -fshort-wchar -fno-PIE
-Werror=implicit-function-declaration -Werror=implicit-int
-Wno-format-security -std=gnu89

>
> With these primitives introduced, you can avoid () to add those
> rcu_segcblist_*_seglen() which have #ifdefs in them. Of course, an
> alternative would be that we implement rcu_segcblist_*_seglen() using
> _Generic, but I think someone else may have the similar problems or
> requirement (already or in the future), so it might be worthwhile to
> introduce the gen_ primitives for broader usage.

One issue is code using memory barriers around the operation, such as
in rcu_segcblist_add_len() where you use smp_mb__before_atomic() for
the atomic version, and regular smp_mb() for the non-atomic version.
So ifdef will still exist to some degree.

thanks,

 - Joel
