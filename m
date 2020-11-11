Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91CD2AF894
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKKSx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKSx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:53:26 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F380C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:53:26 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id w7so1151768pjy.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzAJlsJ6yvoLH7Y3l/4EC1l7M1jcLwaE/y+qJVhny6w=;
        b=BCG7CNt1NmuKyNEhN5IiEudKQgRhbXT1I4KlGnavkqFp/6O3N2xlwq1hwnpX2Crb9p
         gic29g+xJ1VJt5JmghQPcAECHuy+8XDZo7Nbxh2iBoqJFXVHS9mZyvJJpOW+KeCdyvgA
         FKt6jm0NQA5wRTVk6MS0LlFAYc7WLW+X63Hr4QrevGjNA0ArmiflBeVplCVARoWtXqFo
         TBrKY/tXHhD96rm3lKqAsX8k5l4BiNQKU0KkuIjtw8bBb6wEm2WZl2WJMbgyjGumsCeC
         SyQGOIQWRIP1grzdg04ZmFewtHsDunnhcxUEYXJ/Q+ZK/HFrUFXUo87kiyJrGxJwnlKt
         8XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzAJlsJ6yvoLH7Y3l/4EC1l7M1jcLwaE/y+qJVhny6w=;
        b=myo7qe4SIUPkRTxXgr72xDXR1TAOtUYDmFoMy08ysbUNkNU4z8RsM2V9C3cgF2+Owz
         2N2S8Kg8nA0bgMkknB0/i0jQ1L4oRE4VUCXQRR4ZdrvkC3rezVHvqOXJrrEHM8ZEjAqD
         8EM+OA7P7W1uuzPq4m2SZpsEy2D9AyIeJLL+kfY/R20PP9fLW1PgN3IC35okuLixEBcR
         9YCC3zlF/UJciShTr9cE6Ti31uQiLWtza3bVmqgURYav2AznhtOB4uUJZh8hp9QjToBa
         iYinWKp1FzsMKv/IpVf4eqmorYFtJWN5dIkpREuBYkX7LsKToHLcprnD6Jv6J/rNzZnC
         WjaQ==
X-Gm-Message-State: AOAM533wyAHi91NWvYVQw2PNyV6O6daZ6Efe3vDiXFbEgzAn+69/x3td
        Ojrf6gr1Lf0BOUZjilaWH2anWJkPIRwV0/ZoQnSfpA==
X-Google-Smtp-Source: ABdhPJzzvguaZRzQ4niZDcNwy0J6QkvHxGMLdg2lfO3l/vVwnh1A/JGKPRbPLafEHWrb1LvldgGHyEfUAVyZT7BKNzY=
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr5058987pjz.136.1605120805834;
 Wed, 11 Nov 2020 10:53:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <55d90be0a5815917f0e1bd468ea0a257f72e7e46.1605046192.git.andreyknvl@google.com>
 <CAG_fn=V1Pu1NED5K6rJJZ5ufeQwrjN_JShO4m_V=gbLwry7cyg@mail.gmail.com>
In-Reply-To: <CAG_fn=V1Pu1NED5K6rJJZ5ufeQwrjN_JShO4m_V=gbLwry7cyg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Nov 2020 19:53:14 +0100
Message-ID: <CAAeHK+xT6oL_FqJVvgCFA55bLQF72318CaS8F_aSthJmMbMuMA@mail.gmail.com>
Subject: Re: [PATCH v9 25/44] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 4:58 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This patch adds a configuration option for a new KASAN mode called
> > hardware tag-based KASAN. This mode uses the memory tagging approach
> > like the software tag-based mode, but relies on arm64 Memory Tagging
> > Extension feature for tag management and access checking.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > ---
> > Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
> > ---
> >  lib/Kconfig.kasan | 58 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 41 insertions(+), 17 deletions(-)
> >
> > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > index ec59a0e26d09..e5f27ec8b254 100644
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
> >  config HAVE_ARCH_KASAN_SW_TAGS
> >         bool
> >
> > -config HAVE_ARCH_KASAN_VMALLOC
> > +config HAVE_ARCH_KASAN_HW_TAGS
> > +       bool
> > +
> > +config HAVE_ARCH_KASAN_VMALLOC
> >         bool
> >
> >  config CC_HAS_KASAN_GENERIC
> > @@ -20,11 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
> It might make sense to add a comment to
> CC_HAS_WORKING_NOSANITIZE_ADDRESS describing which modes need it (and
> why).

OK, will do in v10, thanks!
