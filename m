Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC2269BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgIOCJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOCJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:09:39 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789E9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:09:39 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h17so1794734otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Jy9eauNbFDzBgKyJguCjgDmFC1x20RHctsHosQ27vk=;
        b=BdtId+oISnBdI2PHU0pQTwj2C4jcfRN5mEe9S4xmOc63uEKe7PcfyPFvb25rCQttOP
         jwYSO9mtPDNJd6c01L0KOqoPmXxDMq/ZYX4OyZNI8rMmEeat9f77zJIkZfuPMR3TaxLz
         poiS0gXE5z6juvGKQ86s7hCqTJevGiBsJmiq6UjoM+gC2z5yqTiHPrQ4Q2B3r9XZCxtR
         ptr2Nd/QA3yLWg6WFJVnTWawDODKVi/QRp9iE/qhYn9SaEsVFEWZ3EBAZB+GSyq77xAB
         joSGfYphydelPFxIA4QR2TxpyEkRD++c/yxs/gYnZZFA6vnW1wwqGG47/8MrR93TbPaj
         VItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Jy9eauNbFDzBgKyJguCjgDmFC1x20RHctsHosQ27vk=;
        b=lJhvTxmhChmT4OGOJrNe1+agz5uhwBs7XO5foRRBTXmPq93hfTHF78x2ggVJazDBhP
         U9ku6z5hf2WJMLyrgglaqdCYZwgh0ng97EDF6EWTG+6Vc6c8uQqA8mxrMlHYn1JGKOs1
         506wjLO1aS2TAXZkdr9gaTbK2AeWLVaLrleTEwU+Q9Ob3nCXBi64oQiqEnCldyvy0Ir6
         6mQSkuT6ndNKlcgzJnorszc3yKGPxSVE41bjUlNet+NPvvardvM5dU74nG5muL3JGa55
         KF6GyD5dNGBa+mrOqJhZpes8SU+QR30NUU9PAN4AAmbN44VWio8pFwDGhUjc2xQDVMpz
         CZPQ==
X-Gm-Message-State: AOAM532GiD+pCYmNJF7CRl2QM6p+Il3EKgeQ78H+Nf5Z42KdEPihxIp1
        /m+nGvjQ3OTi9n5UxEKIwFemEyoYNJgIlpuafn4=
X-Google-Smtp-Source: ABdhPJw0UE+Fwr0N9bcADYKYklk1R6yh6Y1btiV9znRWERHXpy6vkKZK/HHom1ep1fB9jeJdVd+CT8NUQsWTVq962bw=
X-Received: by 2002:a9d:1445:: with SMTP id h63mr10855819oth.343.1600135778760;
 Mon, 14 Sep 2020 19:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com> <87sgddaru7.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sgddaru7.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Tue, 15 Sep 2020 10:09:27 +0800
Message-ID: <CAKc596JD=COaLV37nvFqkTnN6hjJyzLpLKo8h5J9W62BJ4W0EA@mail.gmail.com>
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2020=E5=B9=B47=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Qian,
>
> qianjun.kernel@gmail.com writes:
> >  /*
> >   * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times=
,
> >   * but break the loop if need_resched() is set or after 2 ms.
> > - * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but=
 in
> > - * certain cases, such as stop_machine(), jiffies may cease to
> > - * increment and so we need the MAX_SOFTIRQ_RESTART limit as
> > - * well to make sure we eventually return from this method.
> > + * In the loop, if the processing time of the softirq has exceeded 2
> > + * milliseconds, we also need to break the loop to wakeup the
> > ksofirqd.
>
> You are removing the MAX_SOFTIRQ_RESTART limit explanation and I rather
> have MAX_SOFTIRQ_TIME_NS there than '2 milliseconds' in case the value
> gets adjusted later on. Also while sched_clock() is granular on many
> systems it still can be jiffies based and then the above problem
> persists.
>
> > @@ -299,6 +298,19 @@ asmlinkage __visible void __softirq_entry __do_sof=
tirq(void)
> >               }
> >               h++;
> >               pending >>=3D softirq_bit;
> > +
> > +             /*
> > +              * the softirq's action has been running for too much tim=
e
> > +              * so it may need to wakeup the ksoftirqd
> > +              */
> > +             if (need_resched() && sched_clock() > end) {
> > +                     /*
> > +                      * Ensure that the remaining pending bits are
> > +                      * handled.
> > +                      */
> > +                     or_softirq_pending(pending << (vec_nr + 1));
>
> To or the value interrupts need to be disabled because otherwise you can
> lose a bit when an interrupt happens in the middle of the RMW operation
> and raises a softirq which is not in @pending and not in the per CPU
> local softirq pending storage.
>
> There is another problem. Assume bit 0 and 1 are pending when the
> processing starts. Now it breaks out after bit 0 has been handled and
> stores back bit 1 as pending. Before ksoftirqd runs bit 0 gets raised
> again. ksoftirqd runs and handles bit 0, which takes more than the
> timeout. As a result the bit 0 processing can starve all other softirqs.
>
> So this needs more thought.
HI Thomas, The problem as you described, i am trying to solve it, but
i found the
other problem,just like this,for example

the pending bits is 1010110110, when the bit4 was handled, and the
loop processing
time more than 2ms, in my patch, the loop will break early. In the
next time, the loop
will process the bit5, if before the soft action, the
bit6,bit8,bit0,bit3 were set, the loop
will process the bit5,6,7,8,9,0,1,2,3, that will be the bit6 and bit8
wil be processed before
bit0 and bit3.

Do we need to consider this scenario. Do you have any good suggestions.

Thanks.
>
> Thanks,
>
>         tglx
