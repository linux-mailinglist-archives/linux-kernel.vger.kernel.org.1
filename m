Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567042770CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgIXMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgIXMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:21:33 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2516C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:21:32 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w16so3447649oia.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMi05EnEOfVdGhWpH6feACxpwD+9PbH32BgxYxZVzjg=;
        b=Wh7FyLoZl05ePrScyIDLbNcW93hNy+bh0MlhKgZYBOD4Asb3pfcIWi1Qpm7l3BqHeX
         aq07/YxMJCgggcHSlXRtbFTT+8k7eueARAT3utPtwb4GZW4AENnLmytJkt8R0GevA56h
         lS8l36/AWFDMX7UM7y0Fu9rrUir7atUDweXTHLhJujpZM6B+ApPh26tQfFHOhtgOin6G
         +sfgjdXPNGwWX59Da2Kxi4uheKAY3xHsOVuAvvKGwoOiYj6ct+q2HQoYIA+oxQMnVvxJ
         pzJuS3UvRV+oA4msapQoTTiiQiUb8URNxOrJQ/zHTUdOK5EFIZzhhIVAWDye1y587M2d
         weXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMi05EnEOfVdGhWpH6feACxpwD+9PbH32BgxYxZVzjg=;
        b=SQByc3YREWg+Nw29RwGRmiXexBDv4f5dCE1Oy1TBSdCTPd8zLEcTsy+xliqDmHlr69
         XvbMacjrFX58bp73VMUsbHpmyemBJmZfF/FcypvP4H3lQYlWgGok9BSua5NvsDC0DN3N
         fjxOtRyzI8TnWw6O0xheJGOVp5fCJQu6zKSp/U6/sQhdCdRn8RX7g4/zLHn8nAe0SXMN
         YTfNsDaA9kz075aOGeJQu7kJs+LAreKlNMGF0UAoF6eXkhrxcctCGu+GTHjh/3wLthZM
         ME+yk5TMLoOwWIgQh+vo72RnryWk8BTxZKBHykUG10HblxH9dTWrGnQmMO2TZf4TCfbq
         0xUw==
X-Gm-Message-State: AOAM530YR5yFdoRbJ37YmLf1vmsSCLS1lwkwAPwMAcb8mvXRCFatngaK
        D+V5s82IXHQINdeMepZ/yj/DF6GnlDpsY6fEuOiTKA==
X-Google-Smtp-Source: ABdhPJyUQSlF1yD+fBHh7KRRnvI1RKY1nulFZ3b80Oct6GlWUeHTquzqD3/u7BnXcXHItepe9G+Pxs7iu3ZAEntp++0=
X-Received: by 2002:aca:5158:: with SMTP id f85mr2388516oib.121.1600950091824;
 Thu, 24 Sep 2020 05:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200924040513.31051-1-walter-zh.wu@mediatek.com>
 <CAG_fn=W2dcGKFKHpDXzNvbPUp3USYyWi2DEpEewboqYBodnSsQ@mail.gmail.com>
 <CANpmjNNmeqfMLZ0aFC49fHTYS5k7BqTZHP4FmDc=sfZe+j6bOg@mail.gmail.com> <CAG_fn=UFnju7qBw2FC8nGxTKQ5VB2QeG-DKik_t=eWzu6p+H6A@mail.gmail.com>
In-Reply-To: <CAG_fn=UFnju7qBw2FC8nGxTKQ5VB2QeG-DKik_t=eWzu6p+H6A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Sep 2020 14:21:20 +0200
Message-ID: <CANpmjNP6gKToqT-EZM88ZoedWfyHr86EB2s9sKEtzTxBVQe_Lg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] kasan: print timer and workqueue stack
To:     Alexander Potapenko <glider@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 at 14:11, Alexander Potapenko <glider@google.com> wrote:
>
> On Thu, Sep 24, 2020 at 1:55 PM Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 24 Sep 2020 at 13:47, Alexander Potapenko <glider@google.com> wrote:
> > >
> > > On Thu, Sep 24, 2020 at 6:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > >
> > > > The aux_stack[2] is reused to record the call_rcu() call stack,
> > > > timer init call stack, and enqueuing work call stacks. So that
> > > > we need to change the auxiliary stack title for common title,
> > > > print them in KASAN report.
> > > >
> > > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > Suggested-by: Marco Elver <elver@google.com>
> > > > Acked-by: Marco Elver <elver@google.com>
> > > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> > > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > > Cc: Alexander Potapenko <glider@google.com>
> > > > ---
> > > >
> > > > v2:
> > > > - Thanks for Marco suggestion.
> > > > - We modify aux stack title name in KASAN report
> > > >   in order to print call_rcu()/timer/workqueue stack.
> > > >
> > > > ---
> > > >  mm/kasan/report.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > > index 4f49fa6cd1aa..886809d0a8dd 100644
> > > > --- a/mm/kasan/report.c
> > > > +++ b/mm/kasan/report.c
> > > > @@ -183,12 +183,12 @@ static void describe_object(struct kmem_cache *cache, void *object,
> > > >
> > > >  #ifdef CONFIG_KASAN_GENERIC
> > > >                 if (alloc_info->aux_stack[0]) {
> > > > -                       pr_err("Last call_rcu():\n");
> > > > +                       pr_err("Last potentially related work creation:\n");
> > >
> > > This doesn't have to be a work creation (expect more callers of
> > > kasan_record_aux_stack() in the future), so maybe change the wording
> > > here to "Last potentially related auxiliary stack"?
> >
> > I suggested "work creation" as it's the most precise for what it is
> > used for now.
>
> I see, then maybe my suggestion is premature.
>
> > What other users do you have in mind in future that are not work creation?
>
> I think saving stacks may help in any case where an object is reused
> for a different purpose without reallocation.
> SKBs, maybe?

I currently don't know, it's hard to say without having a report that
we can't debug without it.

The litmus test for if it's useful would probably be "do we need this
stacktrace to debug a use-after-free/double-free?". If the answer is
maybe (and not yes!), I'd err on the side of not going overboard with
these, because we only have limited storage anyway. "Work creation" is
a clear case of "we loose information to the original caller" and need
it to debug. But of course, if there are similar issues elsewhere, we
need to identify them and then decide if we need it.
