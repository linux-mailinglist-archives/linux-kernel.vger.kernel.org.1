Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6A2CA4E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391478AbgLAODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbgLAODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:03:37 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24343C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:02:51 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so1125908qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DowCnJV0jJLxqPNhupVbMRSWGm+7uLhFQL0+P+g8v1E=;
        b=QfxTVBHwfLM/RTcmqP7qAGpmN8zoVJZN3uVb3RgA5Zx6sxjFNx9EX61ScUd2ihRp4m
         IdIO8X60HUdYF7hm3ofecC6QYqNf7d8muHij1SlMtLgd2Uu98smcn7rsSbLEuBI1yZaE
         JfXW2GDH+VbiCeMRXOq3jTxLpXlL75zY6XJi/8YsFmowA+aWUc2r0smb/Cud0R5TESMz
         UKTvjJFJ2Uzuo8VET0aad5u3KWz1pZDiJBa+PmpH7H3MsNS0eGRCFHTOV4G2j1Ie/uLg
         K+Ezx1gxo/gVWFntyD09ZoPaoloXkC8XQK+bR/543ckQKwNGj1sOvp73JdkaQx5vWrZX
         AnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DowCnJV0jJLxqPNhupVbMRSWGm+7uLhFQL0+P+g8v1E=;
        b=j+0NEwzsaAuIySfYbaThXynz45i3EgNvIvLFiaDbsXh9vVWKAwqOIrbutIAQx8yPE0
         7o5uIjljaouWfEuHtLai8/PfPnGK0bFPAnmMB6eD3wxowQsXGxJ/UkP7Y4+x084kIW8Z
         Ok6TrOgoXZz2gmb7nhLkfjBdF8ULOKqivW4kPR5i+gyiLWU8UvR4i6hyqXnOC3gfcUx9
         XMjMemylqopLCpAMer4qkRz5kC+XimZTRtPJAZfCXFqY02hkWLBmyNcmYxj5+5nfYi/0
         xlTc/1YxQfh3WHsyDFROJEIzMxvrln3lXZx2IzSIl2Wvmtd3wDmea2cbR5lNa2XdldKY
         g1Bg==
X-Gm-Message-State: AOAM5318A5UpAKKAUUXldzy/YpzH3MVIU6wAa39/THUjWpR0tAH+B8de
        4vVjwi8cNor2CYfCBOTBK/OlrEVD7bhazEpY5ngZMg==
X-Google-Smtp-Source: ABdhPJxVr8e6IHqhxlpV/01xGGsXjC2Dt2bzhkooYsHv2mXQAPjcqkx/kLcjhAP7zSaTMnzLAHC47gA77xRhDBnFRuo=
X-Received: by 2002:aed:2664:: with SMTP id z91mr2947243qtc.290.1606831369999;
 Tue, 01 Dec 2020 06:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
 <87h7rfi8pn.fsf@nanos.tec.linutronix.de> <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
 <1606821422.6563.10.camel@mtksdccf07>
In-Reply-To: <1606821422.6563.10.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Dec 2020 15:02:38 +0100
Message-ID: <CACT4Y+Yy8S0L18u3q1Y1K1r-qqXRWzrVVLPNR_En0hJ9nX7Tbw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic KASAN
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 12:17 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Hi Dmitry,
>
> On Tue, 2020-12-01 at 08:59 +0100, 'Dmitry Vyukov' via kasan-dev wrote:
> > On Wed, Sep 30, 2020 at 5:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Thu, Sep 24 2020 at 12:01, Walter Wu wrote:
> > > > Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> > > > In some of these access/allocation happened in process_one_work(),
> > > > we see the free stack is useless in KASAN report, it doesn't help
> > > > programmers to solve UAF on workqueue. The same may stand for times.
> > > >
> > > > This patchset improves KASAN reports by making them to have workqueue
> > > > queueing stack and timer stack information. It is useful for programmers
> > > > to solve use-after-free or double-free memory issue.
> > > >
> > > > Generic KASAN also records the last two workqueue and timer stacks and
> > > > prints them in KASAN report. It is only suitable for generic KASAN.
> >
> > Walter, did you mail v5?
> > Checking statuses of KASAN issues and this seems to be not in linux-next.
> >
>
> Sorry for the delay in responding to this patch. I'm busy these few
> months, so that suspend processing it.
> Yes, I will send it next week. But v4 need to confirm the timer stack is
> useful. I haven't found an example. Do you have some suggestion about
> timer?

Good question.

We had some use-after-free's what mention call_timer_fn:
https://groups.google.com/g/syzkaller-bugs/search?q=%22kasan%22%20%22use-after-free%22%20%22expire_timers%22%20%22call_timer_fn%22%20
In the reports I checked call_timer_fn appears in the "access" stack
rather in the "free" stack.

Looking at these reports I cannot conclude that do_init_timer stack
would be useful.
I am mildly leaning towards not memorizing do_init_timer stack for now
(until we have clear use cases) as the number of aux stacks is very
limited (2).
