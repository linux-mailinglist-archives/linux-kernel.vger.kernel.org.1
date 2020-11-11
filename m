Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4E32AF87F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKKSsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgKKSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:48:01 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C3C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:48:00 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id g21so1144117pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y30nQOc9Erw1djQyyLfK/qeAvjp84VdQVely6oznPn8=;
        b=F4hURf+RTl0225vrWEfSZbmk7Bq//Kjebnui8EwY/qNqYqonykgLg+oX5/8q2RUpEa
         IBKu+B6Kjr8csyGFXKQLcXMl1wFQdLHM3PjHQLOdnm6UhmEv3LEkoQC1hc6wUq/Sthvd
         TKw6SUMvaRqBMi1QFlABZaiIxDsHx05tvJXz8c1HFxNl9P/2CzA8p1rvts3Uvo+LoG68
         uCGnYptuf0HoaOHyOLerQOQxr5IGVfv57rGUGC4eQT2+dPNT2l4atE0UI4tpZjl9bxTT
         eKkIy362bjYc5GOqF7YWK3NoSOxBfeVbQHVn4uO1DrVZkDh2AmOoAE92dRVl8mTd0Hog
         1v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y30nQOc9Erw1djQyyLfK/qeAvjp84VdQVely6oznPn8=;
        b=unHaxXn0p5+obubVgBaDX6fw2xXqKgS/jiElHYolqPnNHep5EJTTVEQVX/XsIf5mU3
         B8W41maru6ruuJaelsfq5/erTUXGmXu2/gYQTAqFZnSgisPxHjXVvFtbh9xb8IUFJJh0
         iHMrJd0RToTOdssNGvK1VmRHwcRJYaSca/1Bn6wj1xKE3bQQuoTvcIIY7NOrd9zguqVk
         6TwEjGQl62tvKA+30v408+HmLgdYmTjevaPbSKF4nUCOOx01zp6zQrcTQIinkB5Jj5H1
         LtjF0+jgnnHVKr0GsQcnyFNlvyivLG4WV8jd5UrZeblIoPxvXk9lwFobItVEVcYAoVUP
         q6RQ==
X-Gm-Message-State: AOAM532k41wMCfDvJvoLS76Fu0FpQE5zWMh6KjKoLBJIaeDRSKj1N00Y
        053XwinGCb1AxlprOc0QwdFI2TJWC3yRDJrmZlL2Xg==
X-Google-Smtp-Source: ABdhPJxyRtx5vT7XfBzyH9lLS1IUWO0PgVwLLoumJN665dnbbcXnWUCn1uGDeLllBgnPNhNPXKk7tkr6Z4OjTzz8vL8=
X-Received: by 2002:a17:90b:3111:: with SMTP id gc17mr5116219pjb.41.1605120479739;
 Wed, 11 Nov 2020 10:47:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <85aba371903b749412fac34e44e54c89e5ddae30.1605046192.git.andreyknvl@google.com>
 <CAG_fn=VuM=4axS6ex7_MgCeZ47o+Scon1WuFGStF78T36sHayw@mail.gmail.com>
In-Reply-To: <CAG_fn=VuM=4axS6ex7_MgCeZ47o+Scon1WuFGStF78T36sHayw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Nov 2020 19:47:48 +0100
Message-ID: <CAAeHK+xq2tuVYGOPx=_uj08Xwa_1o9Wv-ODrgN3yWXxAgEGV3w@mail.gmail.com>
Subject: Re: [PATCH v9 10/44] kasan: define KASAN_GRANULE_PAGE
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

On Wed, Nov 11, 2020 at 3:13 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Define KASAN_GRANULE_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT), which is
> > the same as (KASAN_GRANULE_SIZE * PAGE_SIZE), and use it across KASAN code
> > to simplify it.
>
> What's the physical sense behind KASAN_GRANULE_PAGE? Is it something
> more than just a product of two constants?

No, just a product.

> The name suggests it might be something page-sized, but in reality it is not.

What name would you prefer?
