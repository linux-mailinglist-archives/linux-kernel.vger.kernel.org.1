Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8112F27AC3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgI1KwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1Kv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:51:59 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D54C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:51:59 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id o64so2027978uao.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SiY/fxcjly07AYC6UVog8C8EU3u0KHh2dbaMA7X6uFo=;
        b=l2Ex0uqOP2vEg6q34gHXy6uph9r0EXqW2fTF81zYWD93ThqgWkWfmonQoyx6N3aToO
         yOuEfCuOzYn+bigU/CnbU8We0baBCJ8e498XmP/uj8EIpCnuM7tI45L5dt9DMn9UXWav
         wIkODNPzlrrGwri96tfGAwtIyw5vxSin4VKsbdRRFFLSgudbbWvNd4rWOczFIUNIhrmP
         FDFCKQZ3HMKgF0W+BraeyWRG+Mv6dmDMDCRoE8VXDIy0nQdWGn+8w6tDgwU3/Oksi6ep
         7lWacnbx39q7yv9VlGinCZAq+wR85a4uxkmTQ//UT5i3FsWvMMdtnCNo9rNdl3bUW381
         pMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SiY/fxcjly07AYC6UVog8C8EU3u0KHh2dbaMA7X6uFo=;
        b=FsyLIqENG2MSGHrslxQgygLvN9bq/ZKMpzgiz2ekegMyz7bFvX2OrSw9t2tspyo2Q0
         rIQhPZLl0dJxX7LMhwvFzPgZdgli19VKimOqT/Xwaw4SVcb/ciptPDqiDNnOz9wJYMjl
         stLy833P26PnkrW8+8DPwFZumKaAXUqpGCFQiY9JqhuFtv6E8fim10xJ7FxHRusko/KD
         igsiUWsG/qPoSyCdwY7fAzjDlQfZyA/wIuxoRhfwQiQ3lfu/85Nr4yNWyG/ll0X7yiqg
         rJIBb81FNMtOcAJBYCo36P2JbyRub4e0uxu40o/14oa87y6z5WTmhpcYd0PoBsmRnKAD
         nigQ==
X-Gm-Message-State: AOAM530UvjDakTWoPHjA+5k+oU2ErLveQVL4HKYXLa/E1XLgcKqCcr6H
        haTzjSGYckH8UQMxuG99L6gqLLj3HOAq0QQEpCQ=
X-Google-Smtp-Source: ABdhPJw5Zg6gJDGfyzfikc51EqXYjrlh8ZgUxHQWDrneOWcbhD8IGbHw003hqoVQAkPbje4lr9Qn+PbJhR4Q+CInEz4=
X-Received: by 2002:ab0:6ce6:: with SMTP id l6mr223585uai.55.1601290319046;
 Mon, 28 Sep 2020 03:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com> <878scz89tl.fsf@nanos.tec.linutronix.de>
 <20200925004207.GE19346@lenoir>
In-Reply-To: <20200925004207.GE19346@lenoir>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Mon, 28 Sep 2020 18:51:48 +0800
Message-ID: <CAKc596Km6kjQcp2MJmH9BZLY_7i7yFmHDmRnaJGsm4WzUNjwaA@mail.gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>, qais.yousef@arm.com,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=882=
5=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, Sep 24, 2020 at 05:37:42PM +0200, Thomas Gleixner wrote:
> > Subject: softirq; Prevent starvation of higher softirq vectors
> [...]
> > +     /*
> > +      * Word swap pending to move the not yet handled bits of the prev=
ious
> > +      * run first and then clear the duplicates in the newly raised on=
es.
> > +      */
> > +     swahw32s(&cur_pending);
> > +     pending =3D cur_pending & ~(cur_pending << SIRQ_PREV_SHIFT);
> > +
> >       for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
> >               int prev_count;
> >
> > +             vec_nr &=3D SIRQ_VECTOR_MASK;
>
> Shouldn't NR_SOFTIRQS above protect from that?
>
> >               __clear_bit(vec_nr, &pending);
> >               kstat_incr_softirqs_this_cpu(vec_nr);
> >
> [...]
> > +     } else {
> > +             /*
> > +              * Retain the unprocessed bits and swap @cur_pending back
> > +              * into normal ordering
> > +              */
> > +             cur_pending =3D (u32)pending;
> > +             swahw32s(&cur_pending);
> > +             /*
> > +              * If the previous bits are done move the low word of
> > +              * @pending into the high word so it's processed first.
> > +              */
> > +             if (!(cur_pending & SIRQ_PREV_MASK))
> > +                     cur_pending <<=3D SIRQ_PREV_SHIFT;
>
> If the previous bits are done and there is no timeout, should
> we consider to restart a loop?
>
> A common case would be to enter do_softirq() with RCU_SOFTIRQ set
> in the SIRQ_PREV_MASK and NET_RX_SOFTIRQ set in the normal mask.
>
> You would always end up processing the RCU_SOFTIRQ here and trigger
> ksoftirqd for the NET_RX_SOFTIRQ.

yes, I found that this problem also exists in our project. The RCU
softirq may cost
9ms, that will delay the net_rx/tx softirq to process, Peter's branch
maybe can slove
the problem
git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/softirq

>
> Although that's probably no big deal as we should be already in ksoftirqd
> if we processed prev bits. We are just going to iterate the kthread loop
> instead of the do_softirq loop. Probably no real issue then...
>
>
> >
> > +             /* Merge the newly pending ones into the low word */
> > +             cur_pending |=3D new_pending;
> > +     }
> > +     set_softirq_pending(cur_pending);
> >       wakeup_softirqd();
> >  out:
> >       lockdep_softirq_end(in_hardirq);
>
