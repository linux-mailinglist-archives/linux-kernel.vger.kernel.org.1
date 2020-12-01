Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B611E2CA655
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389833AbgLAOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbgLAOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:52:07 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:51:27 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 1so1472502qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55sCzQdwTnWWY4frFoH/T/BSKgGKnPew/6aq6eljiTo=;
        b=Od7Oq8i5EKOt7lyAPLohe/T+qZWO41dmeqZhqZpqtDgfvunVjdg9tf32XLjJenj8L+
         JGidx639XPF8hqU42hKavQY/o0ww8LWaxLXeStBRoE5igoG8X9kxoORory35BiCYr0E9
         HzsGUGiqSTL1ts87Bl3ZH1DxxvuqoMl1tWsJ7EuEzbUtwafzKk0fS+JCI3C9x5JMkgFl
         LcOoRC5QQT2Vi2QFULdi/0FU32TizK504jXS8wi2Dtd7rZI3SGHSEPXMul3KJgenD9SV
         q8gQnWlGGaRf4lazzxswYs7WeQYK50tXi0qt5aobSwa6iH5VsOgJtcHrVMLessAf+PNy
         wf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55sCzQdwTnWWY4frFoH/T/BSKgGKnPew/6aq6eljiTo=;
        b=AEDfugba93tFltDLGRdKsuAJFB//+WpLDuT1XvHVgz/TdzMKMeH91w+r3VZ5h2TGSy
         f3xd6LQ3lbyw1Kk+JiK+z1qx7kQxFeJIazSDljmyJRnXIxrJin0HudzSd91BfsdqIgFP
         wahII0wSiq82uUizGDZ77Pkf5g7rG3aeAt+15/arFxq/I+6g6Opn0nto5yiJRRNoETWz
         wV6bxaw3PT1sfQlNm/dxbBWQTpA6Wy2eUHDxTXTWheFZFa+EeP+5HDNA7xUbrbpm4pCD
         PiBSHwM6xHcM/gdeVI2yXUjslZRKMunTUeW85YZop5axp7iCoGlVKNXo3Um3WfOx70Cw
         kaSw==
X-Gm-Message-State: AOAM530QorSdWORfDkUEuMmxZXNR1FbRapFrlMwBQDi2A0z0ptxaw9R7
        M1gMgsPPOl9yTryE1Z7vPi7kSc+6DBCBEakfymy4sA==
X-Google-Smtp-Source: ABdhPJzpKx5kjzDF60IrrSHfJjD1sCFpkAQsI2Hw2vF4+LKJGRJnyv7Y0PWJYKsCVbdIIj/02E5TWg3mKpDOj/VXPo4=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr3270634qkc.350.1606834285972;
 Tue, 01 Dec 2020 06:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
 <87h7rfi8pn.fsf@nanos.tec.linutronix.de> <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
 <871rg9hawf.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rg9hawf.fsf@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Dec 2020 15:51:14 +0100
Message-ID: <CACT4Y+bWm_bPdbes60u=3d_u34yxBBC7rGQz1yAt1FQXXqP4-A@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic KASAN
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
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

On Tue, Dec 1, 2020 at 3:13 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> >> > In some of these access/allocation happened in process_one_work(),
> >> > we see the free stack is useless in KASAN report, it doesn't help
> >> > programmers to solve UAF on workqueue. The same may stand for times.
> >> >
> >> > This patchset improves KASAN reports by making them to have workqueue
> >> > queueing stack and timer stack information. It is useful for programmers
> >> > to solve use-after-free or double-free memory issue.
> >> >
> >> > Generic KASAN also records the last two workqueue and timer stacks and
> >> > prints them in KASAN report. It is only suitable for generic KASAN.
> >
> > Walter, did you mail v5?
> > Checking statuses of KASAN issues and this seems to be not in linux-next.
> >
> >> > [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
> >> > [2]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22%20expire_timers
> >>
> >> How are these links useful for people who do not have a gurgle account?
> >
> > This is a public mailing list archive, so effectively the same way as
> > lore links ;)
>
> Just that it asked me to log in last time. That's why I wrote the
> above. Today it does not, odd.

Some random permissions settings changes were observed before, so I
can believe that.
