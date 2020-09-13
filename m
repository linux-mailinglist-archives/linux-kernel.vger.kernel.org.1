Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17740267F33
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIMKRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 06:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgIMKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 06:17:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA79C061573
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 03:17:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o16so14183721qkj.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2/rTINPcp/OFtffjcOu1onBIlOhuthR1U8PEEQixv6o=;
        b=nyykmS9AkG4i9TMnFMtKZHTav1DMaE8SUFI+3OiVcdw3B0DLu+pwVWzwQ6kGDjXf+l
         K7px0dO6gMMsvi3FkubJfozBEGHG+rP93NI06PRHsQgki8OoPHqY4TXz13GUqzh7kCbd
         eNxIqk344Vpp0aL3iLW26m4v2V5FRN8BDQVamB8DMWFVrdn5Qah6vQTLKhO0Wcbgi3Lw
         nasjdseAWfh5Qv3irs0+8a5dzF3edJvciMdqoCgZAggoLv6zwMFraDCMREsb8aernu5v
         dqog9E6ULf0mB0oCupoPtZXG7qAqgf8qf6NbYBR8vFecPrkM+QmWOQrwLg7/iw0aaUS+
         w0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2/rTINPcp/OFtffjcOu1onBIlOhuthR1U8PEEQixv6o=;
        b=BSZr/74yXAcpSAN5UZFO/T7N2HhSYSrFgcmwP2csfsGvcONtC0sJAJOto+n46EwogI
         EU1x+Kh2OcIvog1XlTi1862oxMDgW+7mWbRK10o1nDqsqqrV+vckHRJLo+aKZ4Dwxwsq
         v3o1ews+ta97+2te3YONQeZeKb+VArxWL7KbnKCPsgjEjqpOZVaInmJh6oPpw+MpDYnn
         +OhjGIHV3enClETrhTRoFuT3q8qTFZ4hxQ3rHwqKh8BvBqCXM0dFm8GGEZUUAUH2bf/o
         P9CxW6P9ZERz/a3LTUPjPXVv+FiYraoA/UpZj0t8mpK/nmBHxzMhmPs95NxeWWqAkm1f
         vIcQ==
X-Gm-Message-State: AOAM530YN6nqc8DvWzAat41HxFh9l/m3SWwLaydNcmrIW4eUbUBFtE2m
        cIHJtu5hFGzpVYKWSpd6JaZrm00IXXLpPooXb66L6g==
X-Google-Smtp-Source: ABdhPJwU0iwVFH+xDwbhrGpX0QTr2ldrPpq71OiTnxbsBdPs9HzLJVfQX1DW0ujxC9OEcCab5tZQ/lNJtojI2hTfw9A=
X-Received: by 2002:a37:5684:: with SMTP id k126mr8015895qkb.43.1599992264608;
 Sun, 13 Sep 2020 03:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200825015654.27781-1-walter-zh.wu@mediatek.com>
 <CANpmjNOvj+=v7VDVDXpsUNZ9o0+KoJVJs0MjLhwr0XpYcYQZ5g@mail.gmail.com> <CAAeHK+yVShDPCxVKDsO_5SwoM2ZG7x7byUJ74PtB7ekY61L2YQ@mail.gmail.com>
In-Reply-To: <CAAeHK+yVShDPCxVKDsO_5SwoM2ZG7x7byUJ74PtB7ekY61L2YQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 13 Sep 2020 12:17:33 +0200
Message-ID: <CACT4Y+b1OimWNQCx-rGvSgC1RheLAv9mv2xzRnwkn98AsdTgXA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] kasan: add workqueue and timer stack for generic KASAN
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Marco Elver <elver@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:30 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, Aug 25, 2020 at 10:26 AM 'Marco Elver' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > On Tue, 25 Aug 2020 at 03:57, Walter Wu <walter-zh.wu@mediatek.com> wro=
te:
> > >
> > > Syzbot reports many UAF issues for workqueue or timer, see [1] and [2=
].
> > > In some of these access/allocation happened in process_one_work(),
> > > we see the free stack is useless in KASAN report, it doesn't help
> > > programmers to solve UAF on workqueue. The same may stand for times.
> > >
> > > This patchset improves KASAN reports by making them to have workqueue
> > > queueing stack and timer stack information. It is useful for programm=
ers
> > > to solve use-after-free or double-free memory issue.
> > >
> > > Generic KASAN also records the last two workqueue and timer stacks an=
d
> > > prints them in KASAN report. It is only suitable for generic KASAN.
> > >
> > > [1]https://groups.google.com/g/syzkaller-bugs/search?q=3D%22use-after=
-free%22+process_one_work
> > > [2]https://groups.google.com/g/syzkaller-bugs/search?q=3D%22use-after=
-free%22%20expire_timers
> > > [3]https://bugzilla.kernel.org/show_bug.cgi?id=3D198437
> > >
> > > Walter Wu (6):
> > > timer: kasan: record timer stack
> > > workqueue: kasan: record workqueue stack
> > > kasan: print timer and workqueue stack
> > > lib/test_kasan.c: add timer test case
> > > lib/test_kasan.c: add workqueue test case
> > > kasan: update documentation for generic kasan
> >
> > Acked-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks! The UAF reports with RCU stacks that I see now are just =F0=9F=94=
=A5=F0=9F=94=A5=F0=9F=94=A5

> > > ---
> > >
> > > Changes since v2:
> > > - modify kasan document to be more readable.
> > >   Thanks for Marco suggestion.
> > >
> > > Changes since v1:
> > > - Thanks for Marco and Thomas suggestion.
> > > - Remove unnecessary code and fix commit log
> > > - reuse kasan_record_aux_stack() and aux_stack
> > >   to record timer and workqueue stack.
> > > - change the aux stack title for common name.
> > >
> > > ---
> > >
> > > Documentation/dev-tools/kasan.rst |  4 ++--
> > > kernel/time/timer.c               |  3 +++
> > > kernel/workqueue.c                |  3 +++
> > > lib/test_kasan.c                  | 54 ++++++++++++++++++++++++++++++=
++++++++++++++++++++++++
> > > mm/kasan/report.c                 |  4 ++--
> > > 5 files changed, 64 insertions(+), 4 deletions(-)
> > >
> > > --
> > > You received this message because you are subscribed to the Google Gr=
oups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/=
msgid/kasan-dev/20200825015654.27781-1-walter-zh.wu%40mediatek.com.
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kasan-dev/CANpmjNOvj%2B%3Dv7VDVDXpsUNZ9o0%2BKoJVJs0MjLhwr0XpYcYQZ5g%40m=
ail.gmail.com.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/CAAeHK%2ByVShDPCxVKDsO_5SwoM2ZG7x7byUJ74PtB7ekY61L2YQ%40mail.gm=
ail.com.
