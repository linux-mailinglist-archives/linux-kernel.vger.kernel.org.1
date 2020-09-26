Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECE27961A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 04:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgIZCAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 22:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIZCAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 22:00:48 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 19:00:48 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p24so2496715vsf.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 19:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hl1Q4DpTnlorjszdeqwj09MJbyW3AR0vFcBWHqZ2odk=;
        b=P4qc0yXhmSaVr6w2P0a6Jg1SVu+tCRyLJtKljp3j9VXd4yHhrjQiXaE9tof7aCTDXC
         bLErGyaCYcO/d3lNZ9nPGurbF2hMDGkziPTczSgKdhkhBZdbOX/p4MpAROQ0QcRJoDEi
         Vlg7C6edh+ctRbg7mFAJ1NFboRhUbaYb+p721M+tfmxZaFyIT8pR0/vB1nnTqUmziW1M
         z7c3SDHc8ceIHqn3A88QdNpY1yj26I9K4a+VtyszdnRy6kToh1RnDMMW71tFj6PqBXQo
         nO5zkBnlUV6etg5MHxS4BM60ycRqJTp7zuaplFfUmfsHvp2qto7fL7J+utpVmfImJS6H
         R4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hl1Q4DpTnlorjszdeqwj09MJbyW3AR0vFcBWHqZ2odk=;
        b=VLynGqN/jSOBBUp54SJqj/Cg5E3uK2AtxODWlF240OKXAYw2PUaq7ODzomsOESarMB
         MK/FJakFZngLCKvHbeFte+VavjnZnNhK2xcDQvYmd68pCRfEZ29u9/Py81thM5jUUyR4
         M3E/ZHQsVmCTdXwqj0+nrq4OH/oOi7ZnIseqRa57oZ/Sl/0+2jc2WOljbxvcSpnuBo0s
         xQRef2E5VLPbo3rHvvY1Uj/HeUT7e5uwjhuk1kOrgHxkAa+CEz1pxvQvunJzLUINb98u
         O1b2QbtQ0ZKU/MnLKHre1zAuf0o9tF/vrO8Pzxj2ThWeu3PoK4d9b0sOGDqTyof8xMYq
         ZLwA==
X-Gm-Message-State: AOAM533L2528hu/xngyr+qqrvN6Lg1XE4Iy84x4cpuB1+O7WC6iYjeUA
        Yk/etIvTjtvvmrGoJo6/WPzgNyHT+saZu8UTe7w=
X-Google-Smtp-Source: ABdhPJwnzW7hBYGZ9yAJheuQp7oEACrPOON6ggTNy9iEQ9iGnseTjB50aYngGSY1fvBsbnsJhLOUM+THDzxhI7RmA4o=
X-Received: by 2002:a67:eb89:: with SMTP id e9mr776565vso.49.1601085647701;
 Fri, 25 Sep 2020 19:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com> <878scz89tl.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878scz89tl.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Sat, 26 Sep 2020 10:00:36 +0800
Message-ID: <CAKc596+it+Cf2HuaeqM3kaFR4KTM7LdKcP3cMXC6AeWrixhLow@mail.gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        qais.yousef@arm.com, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2020=E5=B9=B49=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 15 2020 at 19:56, qianjun kernel wrote:
> >
> > +#define SOFTIRQ_PENDING_MASK ((1UL << NR_SOFTIRQS) - 1)
> >
> > +/*
> > + * The pending_next_bit is recorded for the next processing order when
> > + * the loop is broken. This per cpu variable is to solve the following
> > + * scenarios:
> > + * Assume bit 0 and 1 are pending when the processing starts. Now it
> > + * breaks out after bit 0 has been handled and stores back bit 1 as
> > + * pending. Before ksoftirqd runs bit 0 gets raised again. ksoftirqd
> > + * runs and handles bit 0, which takes more than the timeout. As a
> > + * result the bit 0 processing can starve all other softirqs.
> > + *
> > + * so we need the pending_next_bit to record the next process order.
> > + */
> > +DEFINE_PER_CPU(u32, pending_next_bit);
>
> static if at all.
>
> > +
> >  asmlinkage __visible void __softirq_entry __do_softirq(void)
> >  {
> >       u64 start =3D sched_clock();
> > @@ -261,8 +277,11 @@ asmlinkage __visible void __softirq_entry __do_sof=
tirq(void)
> >       unsigned int max_restart =3D MAX_SOFTIRQ_RESTART;
> >       struct softirq_action *h;
> >       unsigned long pending;
> > +     unsigned long pending_left, pending_again;
> >       unsigned int vec_nr;
> >       bool in_hardirq;
> > +     int next_bit;
> > +     unsigned long flags;
> >
> >       /*
> >        * Mask out PF_MEMALLOC as the current task context is borrowed f=
or the
> > @@ -283,25 +302,66 @@ asmlinkage __visible void __softirq_entry __do_so=
ftirq(void)
> >
> >       local_irq_enable();
> >
> > -     for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
> > -             int prev_count;
> > -
> > -             __clear_bit(vec_nr, &pending);
> > -
> > -             h =3D softirq_vec + vec_nr;
> > -
> > -             prev_count =3D preempt_count();
> > -
> > -             kstat_incr_softirqs_this_cpu(vec_nr);
> > +     /*
> > +      * pending_left means that the left bits unhandled when the loop =
is
> > +      * broken without finishing the vectors. These bits will be handl=
ed
> > +      * first in the next time. pending_again means that the new bits =
is
> > +      * generated in the other time. These bits should be handled afte=
r
> > +      * the pending_left bits have been handled.
> > +      *
> > +      * For example
> > +      * If the pending bits is 1101010110, and the loop is broken afte=
r
> > +      * the bit4 is handled. Then, the pending_next_bit will be 5, and
> > +      * the pending_left is 1101000000, the pending_again is 000000110=
.
> > +      */
>
> If you need such a comment to explain the meaning of your variables then
> you did something fundamentaly wrong.
>
> > +     next_bit =3D __this_cpu_read(pending_next_bit);
> > +     pending_left =3D pending &
> > +             (SOFTIRQ_PENDING_MASK << next_bit);
> > +     pending_again =3D pending &
> > +             (SOFTIRQ_PENDING_MASK >> (NR_SOFTIRQS - next_bit));
> > +
> > +     while (pending_left || pending_again) {
> > +             if  (pending_left) {
> > +                     pending =3D pending_left;
> > +                     pending_left =3D 0;
> > +             } else if (pending_again) {
> > +                     pending =3D pending_again;
> > +                     pending_again =3D 0;
> > +             } else
> > +                     break;
>
> Aside of lacking brackets how is that 'else' patch ever going to be
> reached?
>
> But TBH that whole patch is a completely unreviewable maze.
>
> This can be done without all this pending, pending_left, pending_again,
> pending_next_bit, next_bit convolution. It's inconsistent anyway:
>
> __do_softirq()
>
>         pending =3D 0x25;
>         next =3D 0;
>
>         for (...)
>             break after bit 0
>
>         =3D=3D> pending =3D=3D 0x24
>
>         =3D=3D> next =3D 2
>
> now on the next invocation
>
>        pending =3D 0x35;
>        next =3D 2;
>
>        So the processing order is 2, 4, 5, 0
>
> and there is nothing you can do about that with that approach.
>
> But the whole point is to ensure that the not yet processed bits are
> processed first.
>
> Find attached an updated series based on the original one from Peter
> with the authorship preserved, intact SOB chains and proper changelogs.
>
> The last one is new and addressing the starvation issue in a readable
> way.
>
> All of this is again completely untested.
>
> Thanks,
>
>         tglx
>

I will fix it and test. After test, i will send the patch again.

thanks
