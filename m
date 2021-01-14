Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4044C2F64AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbhANPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbhANPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:33:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEFC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:32:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b3so3564209pft.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhCmnieS6x/7jX7jC0A67czRT8RpEOexXMJwHSjcG8w=;
        b=F+h+U5OX5I2zlGXN1bvc3pRP91uslplbDiy80/f/k3e71YErhqPRypEZ0JJj/UhdKt
         2AigAsEV5L/t7EwODcHMEj4p+2QgpvIc1RD6t1zDtK1H2XRQne5e5GCtxSM/hy6QryIJ
         7mQjkTB+WjHmD56SIaVjqmPDXdLix3UGuFKyOHuFwxRUJE9GvjooZqnbfoB+ElDcVMCg
         2W12T+MnjHX38ZLQo86AJN5z6vq3SgfSw0K0jFXy0tHmw6sHgAyTFP9XjJ+UXpnrj9TT
         BWNZwlOSbLBi1IpqhBalOOmwGvs3KEiemTY1vzigmGeMamDLfWBNfYBf+ca3tADpgzJn
         SVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhCmnieS6x/7jX7jC0A67czRT8RpEOexXMJwHSjcG8w=;
        b=Xv2CztwIFKwNDBOauxe2tmsqubHu/CxJWZgzaUVB73MiyO1pcaoGfVyTKFRA4k285u
         ShaULEXLVBHNUlJKBKuA19jnIT/vuTQP5VKoirrhUVMPu9IwYjJ9AYuPskPJJiez8cFY
         sUUQqUcEfVMFCzO0DORnl4sblB8mIMQT6l4jN9tKFnfzAaF7mk+XOgIslCd0rW6RT/p+
         mqMAKz7fOW/mXxk5Ge/O4TvGcRp/ZeQPjRL1hM5eyHKuyfklSUu0IAszmItW71amyFL+
         vwYNfm9qGWVaORfm3s+I34sk0zUKshbDC7fr8yxEkrKHUbUBBzrqMhdvuwI+9NW3K5RC
         VR4g==
X-Gm-Message-State: AOAM531H70bRmoHftp8tlVciRYpsu8IxMoeo03ZR3hXzs4Irxa56xuMu
        uGdV40dS1R+AZKKoYeDudX58Obrz2TOUXiagx8GL6Q==
X-Google-Smtp-Source: ABdhPJwxwjEmYCc7k3Kie++FnZeFTarrf4Gsa6+W+ZVUNd+3l6SG5jx3zUwQsiq6GdK62p4Znm8ZMaWwvuG6Lksc80s=
X-Received: by 2002:a65:430b:: with SMTP id j11mr7862747pgq.130.1610638363793;
 Thu, 14 Jan 2021 07:32:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <654bdeedde54e9e8d5d6250469966b0bdf288010.1610554432.git.andreyknvl@google.com>
 <CANpmjNPOtohFy800icx1LU_hzuQZNMQqqTBUSDXZ_9wWO_vHWw@mail.gmail.com>
In-Reply-To: <CANpmjNPOtohFy800icx1LU_hzuQZNMQqqTBUSDXZ_9wWO_vHWw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Jan 2021 16:32:32 +0100
Message-ID: <CAAeHK+yXQN2QWUEATrdpAuEC=s1+VSZ1JzxxJbEuhpXv3nCtAQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] kasan: don't run tests when KASAN is not enabled
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 5:39 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 13 Jan 2021 at 17:22, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Don't run KASAN tests when it's disabled with kasan.mode=off to avoid
> > corrupting kernel memory.
> >
> > Link: https://linux-review.googlesource.com/id/I6447af436a69a94bfc35477f6bf4e2122948355e
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  lib/test_kasan.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index d9f9a93922d5..0c8279d9907e 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -47,6 +47,9 @@ static bool multishot;
> >   */
> >  static int kasan_test_init(struct kunit *test)
> >  {
> > +       if (!kasan_enabled())
> > +               return -1;
>
> This should WARN_ON() or pr_err(). Otherwise it's impossible to say
> why the test couldn't initialize.

Will do in v3, thanks!
