Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56DA206258
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 23:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393116AbgFWU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391418AbgFWU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:59:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF9C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:59:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so3454003otv.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMK5qVAbSt1rK51R9btGsARYaJbNedHeaCPVNS4QMh0=;
        b=iyeMTBPEtKOQUdZksy9A2LphrJXXdLKwANILu0UWPQPF+YBcKyR676TocMuovRULka
         S6GfGaka/7SOVuzQGvTVhj8e7ZKf/i0r7sQPog6f8FYszAIQ5NLlZVyTk6RBdnF6+uic
         4CU4tjvcwG4yY1Wzzkd7ehtkqi/21o2D1nwqBxVTjLkpCYbqbQYQDSIL3TIhNeh6ydrr
         eHgPcbAZqrYjSPraev/Ip7rwuOU2xeMs96G2jiDEWSV/prNfIeZeolWMgDUon7tczct7
         hEG74eT2y8VoOTFVPso5xd7Kcuh3TBEw9OyvUzd98MAueq7T27CRQmbDu8+VQGaxOxer
         Ub8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMK5qVAbSt1rK51R9btGsARYaJbNedHeaCPVNS4QMh0=;
        b=Q0X+doqSZORyrXmjXBKasMWzTRAnPgins9xFtIJoay7j3SO2wU8bAcY9AXX1DhL51N
         6NPafwkW/m9WRgWRKSsh2TMLEXuqHe52mQDkk2E5m489qPHLHvkxl2iw5BprAtvaI8TM
         MvBEDIjbDw0ebo/YP/BLxixjDOGF45y7mvLnHTQeTEH3eoVz/Y8PjNto3dqsiQsz5ooN
         ahMV36fcXH5xRNls61v0MIKynTU0h4ux2Vh5fcl9zqXJVM/doZH75LjYzhJMJ3A0P9I9
         zGTPViBtM8xSclDYDjZgZKWqfNaDMe6gdluBGEHOYDRMzoVL65vgLy1B/5iGs6EnN9AH
         Os1w==
X-Gm-Message-State: AOAM533J1K5qiAIWQnWxQqnJKKtTvV4nrN59SmkZfzPbhgEMyenWO2sa
        YfFM8OmyhYgeazPemLjwIZOZb9eAU/UpLlhT29oTDQ==
X-Google-Smtp-Source: ABdhPJyHuNZxBjdsvKwLfr+iff/2GdI2ai1mugVC+vZAzM5Srohzqfwls5UvX5BiAG+czjXrWmLupnGITM07tg6B1O8=
X-Received: by 2002:a4a:e702:: with SMTP id y2mr10264640oou.36.1592945973716;
 Tue, 23 Jun 2020 13:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
 <20200623132507.GA875@aaronlu-desktop> <d29a2ba031ecd96f785a602e703d97e24980ef15.camel@posk.io>
 <20200623194529.GA71413@gmail.com>
In-Reply-To: <20200623194529.GA71413@gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 23 Jun 2020 13:59:22 -0700
Message-ID: <CAPNVh5eNJfe6yBhXeOikdBRyjKJc_p3PJRzK4kX0rRGUswZa0A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Peter Oskolkov <posk@posk.io>, Aaron Lu <aaron.lwe@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrei Vagin <avagin@google.com>,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:45 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> On Tue, Jun 23, 2020 at 11:30:30AM -0700, Peter Oskolkov wrote:
> ...
> > > >  /**
> > > > +static int futex_swap(u32 __user *uaddr, unsigned int flags, u32
> > > > val,
> > > > +               ktime_t *abs_time, u32 __user *uaddr2)
> > > > +{
> > > > + u32 bitset = FUTEX_BITSET_MATCH_ANY;
> > > > + struct task_struct *next = NULL;
> > > > + DEFINE_WAKE_Q(wake_q);
> > > > + int ret;
> > > > +
> > > > + ret = prepare_wake_q(uaddr2, flags, 1, bitset, &wake_q);
> > > > + if (!wake_q_empty(&wake_q)) {
> > > > +         /* Pull the first wakee out of the queue to swap into.
> > > > */
> > > > +         next = container_of(wake_q.first, struct task_struct,
> > > > wake_q);
> > > > +         wake_q.first = wake_q.first->next;
> > > > +         next->wake_q.next = NULL;
> > > > +         /*
> > > > +          * Note that wake_up_q does not touch wake_q.last, so
> > > > we
> > > > +          * do not bother with it here.
> > > > +          */
> > > > +         wake_up_q(&wake_q);
> > >
> > > wake_up_q() doesn't seem to serve any purpose in that the above
> > > assignment of wake_q.first shall make it an empty queue now?
> > > Also, I don't see a need to touch wake_q.first either so I think we
> > > can
> > > get rid of wake_q altogether here.
> >
> > The futex at uaddr2 may have more than one waiter, so we cannot assume
> > that wake_q will be empty when we remove the first element.
>
> The third argument of prepare_wake_q is nr_wake which is one in this
> case, so we can be sure that wake_q will be empty, can't we?

Right, sorry. In an early draft it was possible to wake more than one waiter,
and the code carried over from then/there in this form. I'll remove wake_up_q()
if/when the API will be deemed acceptable by the maintainers.

>
> >
> > >
> > > > + }
> > > > + if (ret < 0)
> > > > +         return ret;
> > > > +
> > > > + return futex_wait(uaddr, flags, val, abs_time, bitset, next);
> > > > +}
> > >
