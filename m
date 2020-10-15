Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CFE28E9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgJOB15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgJOB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:27:56 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913EFC0613B3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:27:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 67so2254745iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLOACr1Upy7vf7oHVF5/pEcrKvzTlyyjv59H5BxHvSs=;
        b=iQR8YlaJOmts+WjbEsLoEE9pSWvn3NDkUi0opGfDG7lGOa19zGlr1v5MITsSiA142y
         Bg1h2TaJeaW14PzH05w8XhTZqujMlur7EOsX0qVQ69TcFzeHwJvR+3jxe3RiOPi2v8Tg
         TFYYc1LhJEC2GZude+V2g1eAJhAa0chE8flEk3/BBs8gDHvtcBeQydQRgoBq3zYdYoE8
         nXO0E9BvTol1LRq8Y4/Gub4zGiuS8EdG+xyqqO63KxG5gXvXU82/VE2hPhPJjrgXu5cD
         dIgozcPO2+QbQrJx06anE9iZMvXC2WyL4T6vgTuB2p/Dihe9r7tuS4nkSKYPLZiolqPY
         DexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLOACr1Upy7vf7oHVF5/pEcrKvzTlyyjv59H5BxHvSs=;
        b=pqa+IycqQBKPKi3vCvi2PMsMiH+CIG05Xc7uCDh+/dYdwHKDJGF+Pdk1+/ij9wLLaf
         90uKFm40jxqeO/aAYMz3I3C3A9gMJC9aH97TM6zxnccy0tml559KwwetqMnAZV4KGocp
         JZ6on3A++tVe7z21L+Apd9OB6fBgNDepfRV1VilVgLukwBYH4RTNHAeSKOKfxtPnPNb8
         5UADRP9QUdn9/pBS0oGYqke2livoRSRDnwumZtvrgM5HcSKdOj/3Xz+/lC8tczlS6VXA
         5uDEnFOClJn6N9MnJTVq/8abN3EIbSbWftB5+4ffWY/+BdSgS9mcRY85tRs54vGfoPn5
         wVPg==
X-Gm-Message-State: AOAM532izRl1gpQgzTS8Wmdc/Ydjpk1wmEsoAtDAGrDVmhylVWnxplPK
        //869m1q6lkA8FZpLv6aI2gIRQRhoNwDcRSATA==
X-Google-Smtp-Source: ABdhPJyvPB6meL78JmDv9rMOfzr/KbOaz5tX8A1mXzcJwpE4ZMDyo8+1l3v4cHbL8LvZKNUj6/2EOkiZmOIAkYQNiPU=
X-Received: by 2002:a05:6638:97:: with SMTP id v23mr1785476jao.7.1602725275951;
 Wed, 14 Oct 2020 18:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <1602510644-24536-1-git-send-email-kernelfans@gmail.com> <20201014130223.GF2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201014130223.GF2628@hirez.programming.kicks-ass.net>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 15 Oct 2020 09:27:44 +0800
Message-ID: <CAFgQCTvrEdk6WOEpJOX1_Q64PmjvpHq2qrWo_1d_4NBnus+7Fw@mail.gmail.com>
Subject: Re: [PATCH] sched/cputime: correct account of irqtime
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 9:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 12, 2020 at 09:50:44PM +0800, Pingfan Liu wrote:
> > __do_softirq() may be interrupted by hardware interrupts. In this case,
> > irqtime_account_irq() will account the time slice as CPUTIME_SOFTIRQ by
> > mistake.
> >
> > By passing irqtime_account_irq() an extra param about either hardirq or
> > softirq, irqtime_account_irq() can handle the above case.
>
> I'm not sure I see the scenario in which it goes wrong.
>
> irqtime_account_irq() is designed such that we're called with the old
> preempt_count on enter and the new preempt_count on exit. This way we'll
> accumuate the delta to the previous context.
>
Oops! You are right, the time delta between a softirq and a
interrupting hardirq should be accounted into the softrq.

Thanks for your clear explanation.

Regards,
Pingfan
