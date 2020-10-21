Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3686295552
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507292AbgJUXsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408091AbgJUXsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:48:35 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D134C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:48:35 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id n2so977393ooo.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUWpT0xSzb04KdW+F3F/7B/sEhkE2FW0IA92LIadnb8=;
        b=TzGB+PcZPJBYfA334G4mwAHms3nMJQgO5kBKCplD5ftTsIpzHst8Wc5qy2s4GmdU6y
         cTD6tBkz9zWLHCR5djxMlXNbxXIKc4cjaKSKiL2GNLfbVEguNaX3DCqNuO47Bw2vDmai
         YT1gMmrR2EQniWYS8Wurbon7JAUhBHTfxVx8tq+a3TFs4jqrl9maJUGKhlSOS9Uasxff
         Wo5HjQ64IZeDrU29Vu7dtcNtYAD0nLtQ9FP9BixRBFn/ATtcjTE/d2THfDZRjkP71DRU
         mX/Usmi4LdNK6g0+k/U9RUt0I3DXnB1Lz/FFSn1BI7mr4tgt2j2c1Yy2ophLt5R2ulcp
         LqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUWpT0xSzb04KdW+F3F/7B/sEhkE2FW0IA92LIadnb8=;
        b=HG1tlx3DFcREeyaz8Lh0pTWRxsV4NKoD4gIQChX69AvP41aXlbtOwgnhEDuNEcVSpx
         LPcTPjIgtBhb0Riy5lub5etVqifRgwVH1XJiwu4cTCIBJA8LcSKe9PTVSbKKsay5GDT0
         xU9rhvrhccxJCQ0wYp7ThXO+BKe1g1/rmAj071oN/kEpx2QqikV1mFQKGEXeIYJnPIXf
         BkInATwXF6fCKvNvsphjZKoLgELKeQhVzk1MCcUwd9FFcFpd0XTOmGVB4zxy7lLK7pKr
         u/D82agwnDqX3cscYomeBqVfVEpDHhhyPi9vx9FPHL/DjnUdRUURTd2XtgwYOt5KHLMo
         C0tg==
X-Gm-Message-State: AOAM531/Di6Iko6kM7ZyqK2XUx9mESYT21hhqVBptUjUO0Q6R9giTqCd
        zu50Gs4JgDajqhxOGOiQd0WmTT0ntXRi2bsMA1KdOg==
X-Google-Smtp-Source: ABdhPJyB2FC2rlEH1r9EaJUtkAHoI4Y4o5gBI6sfghZB+w+2PxHcuAUrRjnCcGgTMGQVK+lisMXcgkfNyAiId+kJ2TE=
X-Received: by 2002:a4a:ce90:: with SMTP id f16mr22653oos.55.1603324114795;
 Wed, 21 Oct 2020 16:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201020205704.1741543-1-xii@google.com> <20201020205704.1741543-2-xii@google.com>
 <20201021101257.GC2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201021101257.GC2628@hirez.programming.kicks-ass.net>
From:   Xi Wang <xii@google.com>
Date:   Wed, 21 Oct 2020 16:48:38 -0700
Message-ID: <CAOBoifg5wGYb_XvZiRysf0iH=binaiVZE2ds=cU=6Y+KhbQJAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched: watchdog: Touch kernel watchdog with sched count
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 3:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 20, 2020 at 01:57:04PM -0700, Xi Wang wrote:
>
> > +     if (watchdog_touch_with_sched) {
> > +             /* Trigger reschedule for the next round */
> > +             set_tsk_need_resched(current);
> > +             set_preempt_need_resched();
>
> Blergh.. that's gross. This relies on this being in IRQ context and
> either: PREEMPT=y *OR* this always being from userspace. Otherwise
> there's no guarantee the return-from-interrupt will actually schedule.
>

Maybe I missed something but I think immediate rescheduling is not
required? E.g. software watchdog should fire if there is a kernel busy
loop and kernel preemption is not enabled. The current method ends up
with a thread wakeup so there is no guaranteed reschedule either?

-Xi
