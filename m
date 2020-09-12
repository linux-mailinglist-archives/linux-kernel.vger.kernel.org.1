Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0DA26787D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgILHRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 03:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgILHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:17:31 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DEBC061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 00:17:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x14so11861712oic.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kyA9YtQ3NyZlB7jY8mSitmoi2ZbTbdLnpoPYgA69EOM=;
        b=dVDK2B+tnK4afdlTetp4wL1UOZueTDvIH6qYlDffqfN4vlJi8FMaj1WvWNfLGFHgD5
         YYFYiLxH+Ya35cH1fLnTteFvHKPcXJbhCL4zpTDxRax34dtzEfHQVZIfvQ2Jd+PN6M5U
         YwyqVUa2pUSja0xAGdDmc7KBFftXdy7DM+vsTkc+FjrcQFJbzJDvTKPKP25qj/gpWFug
         S6x+RP1KwcJ+BMn4CX28Luj2wa20zWrE83QFAbjZaqCUbVwji5HISz0jAtIAT0HucApv
         Ytzw/g+jB/fFIX8OLhIDELClkZ8r7jTdJV9uz8yfnVJjP4j1TyUc+I3p1ohBW4vGgZGR
         GVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kyA9YtQ3NyZlB7jY8mSitmoi2ZbTbdLnpoPYgA69EOM=;
        b=ULa6QDAIdMgSsn8vWFADTTDcHgrpeXPMnNXy7SceT6coUVw/KyKBAK4+9wMedE24Pb
         kebRd3/E8nOx/Gs+gkWgJ/HiCLaIypH56e6ePB99q1uVsLyvGyffxNrwZorXfljSZ0N0
         ssCyj35YEqX3ffT2pPtHhWwx4QpvfeFalM+onQGVGicvd7tGZAkLMjqCb6V9nAetjL7y
         wHrPOU2a40jRKpFRvVd1WEHWX9FoherJafcXfcUn8rbtY43FEaIt/kRP+oOULrtcHxBJ
         BQeGqQjJ0nM7StbuFk7hzI9EfAkY9CqcjrpFqnnOV/UkIailQF9o9rN2QMkOXf4/1MFe
         oCYg==
X-Gm-Message-State: AOAM533eW7526ihZ/+SPnmtFWn9IRAU5q3jfMfvo1G9OABky8b5XJSdX
        09aK3dSuKTHQtQTuBcRWAij8SgJlCMLGix8f1Rw=
X-Google-Smtp-Source: ABdhPJztElp3Wg/DHREK6CUfOW2mSxiYaN9uVfbxdNgkbl6oMbtjyGZ/gU66zg749VLre5Rnzah/pSlTL1HdbFA25oU=
X-Received: by 2002:aca:f40a:: with SMTP id s10mr3392599oih.126.1599895048122;
 Sat, 12 Sep 2020 00:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200909090931.8836-1-qianjun.kernel@gmail.com> <20200911155555.GX2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200911155555.GX2674@hirez.programming.kicks-ass.net>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Sat, 12 Sep 2020 15:17:17 +0800
Message-ID: <CAKc596LcHyjbTdnjSvhrPrCd3BMjDGGTe4DDzOqApeqb2ypSgA@mail.gmail.com>
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending softirqs
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<peterz@infradead.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=8811=E6=97=A5=E5=91=A8=
=E4=BA=94 =E4=B8=8B=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 09, 2020 at 05:09:31PM +0800, qianjun.kernel@gmail.com wrote:
> > From: jun qian <qianjun.kernel@gmail.com>
> >
> > When get the pending softirqs, it need to process all the pending
> > softirqs in the while loop. If the processing time of each pending
> > softirq is need more than 2 msec in this loop, or one of the softirq
> > will running a long time, according to the original code logic, it
> > will process all the pending softirqs without wakeuping ksoftirqd,
> > which will cause a relatively large scheduling delay on the
> > corresponding CPU, which we do not wish to see. The patch will check
> > the total time to process pending softirq, if the time exceeds 2 ms
> > we need to wakeup the ksofirqd to aviod large sched delay.
>
> But what is all that unreadaable gibberish with pending_new_{flag,bit} ?
>
> Random comments below..
>
>
> > +#define MAX_SOFTIRQ_TIME_NS 2000000
>
>         2*NSEC_PER_MSEC
>
>
> > +DEFINE_PER_CPU(__u32, pending_new_flag);
> > +DEFINE_PER_CPU(__u32, pending_next_bit);
>
> __u32 is for userspace ABI, this is not it, use u32
>
> > +#define SOFTIRQ_PENDING_MASK ((1UL << NR_SOFTIRQS) - 1)
> > +
> >  asmlinkage __visible void __softirq_entry __do_softirq(void)
> >  {
> > -     unsigned long end =3D jiffies + MAX_SOFTIRQ_TIME;
> > +     u64 end =3D sched_clock() + MAX_SOFTIRQ_TIME_NS;
> >       unsigned long old_flags =3D current->flags;
> >       int max_restart =3D MAX_SOFTIRQ_RESTART;
> >       struct softirq_action *h;
> >       bool in_hardirq;
> > -     __u32 pending;
> > -     int softirq_bit;
> > +     __u32 pending, pending_left, pending_new;
> > +     int softirq_bit, next_bit;
> > +     unsigned long flags;
> >
> >       /*
> >        * Mask out PF_MEMALLOC as the current task context is borrowed f=
or the
> > @@ -277,10 +282,33 @@ asmlinkage __visible void __softirq_entry __do_so=
ftirq(void)
> >
> >       h =3D softirq_vec;
> >
> > -     while ((softirq_bit =3D ffs(pending))) {
> > -             unsigned int vec_nr;
> > +     next_bit =3D per_cpu(pending_next_bit, smp_processor_id());
> > +     per_cpu(pending_new_flag, smp_processor_id()) =3D 0;
>
>         __this_cpu_read() / __this_cpu_write()
>
> > +
> > +     pending_left =3D pending &
> > +             (SOFTIRQ_PENDING_MASK << next_bit);
> > +     pending_new =3D pending &
> > +             (SOFTIRQ_PENDING_MASK >> (NR_SOFTIRQS - next_bit));
>
> The second mask is the inverse of the first.
>
> > +     /*
> > +      * In order to be fair, we shold process the pengding bits by the
> > +      * last processing order.
> > +      */
> > +     while ((softirq_bit =3D ffs(pending_left)) ||
> > +             (softirq_bit =3D ffs(pending_new))) {
> >               int prev_count;
> > +             unsigned int vec_nr =3D 0;
> >
> > +             /*
> > +              * when the left pengding bits have been handled, we shou=
ld
> > +              * to reset the h to softirq_vec.
> > +              */
> > +             if (!ffs(pending_left)) {
> > +                     if (per_cpu(pending_new_flag, smp_processor_id())=
 =3D=3D 0) {
> > +                             h =3D softirq_vec;
> > +                             per_cpu(pending_new_flag, smp_processor_i=
d()) =3D 1;
> > +                     }
> > +             }
> >               h +=3D softirq_bit - 1;
> >
> >               vec_nr =3D h - softirq_vec;
> > @@ -298,17 +326,44 @@ asmlinkage __visible void __softirq_entry __do_so=
ftirq(void)
> >                       preempt_count_set(prev_count);
> >               }
> >               h++;
> > -             pending >>=3D softirq_bit;
> > +
> > +             if (ffs(pending_left))
>
> This is the _third_ ffs(pending_left), those things are _expensive_ (on
> some archs, see include/asm-generic/bitops/__ffs.h).
>
> > +                     pending_left >>=3D softirq_bit;
> > +             else
> > +                     pending_new >>=3D softirq_bit;
> > +
> > +             /*
> > +              * the softirq's action has been run too much time,
> > +              * so it may need to wakeup the ksoftirqd
> > +              */
> > +             if (need_resched() && sched_clock() > end) {
> > +                     /*
> > +                      * Ensure that the remaining pending bits will be
> > +                      * handled.
> > +                      */
> > +                     local_irq_save(flags);
> > +                     if (ffs(pending_left))
>
> *fourth*...
>
> > +                             or_softirq_pending((pending_left << (vec_=
nr + 1)) |
> > +                                                     pending_new);
> > +                     else
> > +                             or_softirq_pending(pending_new << (vec_nr=
 + 1));
> > +                     local_irq_restore(flags);
> > +                     per_cpu(pending_next_bit, smp_processor_id()) =3D=
 vec_nr + 1;
> > +                     break;
> > +             }
> >       }
> >
> > +     /* reset the pending_next_bit */
> > +     per_cpu(pending_next_bit, smp_processor_id()) =3D 0;
> > +
> >       if (__this_cpu_read(ksoftirqd) =3D=3D current)
> >               rcu_softirq_qs();
> >       local_irq_disable();
> >
> >       pending =3D local_softirq_pending();
> >       if (pending) {
> > -             if (time_before(jiffies, end) && !need_resched() &&
> > -                 --max_restart)
> > +             if (!need_resched() && --max_restart &&
> > +                 sched_clock() <=3D end)
> >                       goto restart;
> >
> >               wakeup_softirqd();
>
> This really wants to be a number of separate patches; and I quickly lost
> the plot in your code. Instead of cleaning things up, you're making an
> even bigger mess of things.
>
> That said, I _think_ I've managed to decode what you want. See the
> completely untested patches attached.
>
>

thanks a lot thank for your suggestion. I will rewrite the patch by
following you sugestion, Useing multiple patches to clarify ideas.
