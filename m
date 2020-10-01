Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B121C2809CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbgJAV7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJAV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:59:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7FC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 14:59:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so103839pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeLdvrmRrEjRDvLDp8IMeU8yTFWoBJ46ycNhebnMFYM=;
        b=TBqS7OT7BDG31xwQf95dhSonRR7ScCBFJKbqe4+XrINEJhqRuwnwgecZy7tTH6Nbns
         YscWwEDlIRlXGm+eBANlE7YicDfj9W1zjh3Ai23OT/VkZ75yEvb10oPH0BRMtXGB5/FP
         SpV1t5iHjIK3U34Z2OcjJt8GHt4bh+Y0WuFKllrEcyEEknpCOlbICWc0tfrzeebR+iYC
         Xh2CLK5kSrDevWj2ZKC1LpJMQt+XO/y1J9LwIDbsPzVYdhOXELyUImVa0CT6kq1Fd2UH
         +Un4kzN92nO46jJYOMrF/tUbxyzk2h1Wv7J5owXuUB5RNIkn637p/9vkkyYWkQBaFgrS
         8Z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeLdvrmRrEjRDvLDp8IMeU8yTFWoBJ46ycNhebnMFYM=;
        b=srSS3Ftakyh7XW9319uXQC6mzTdvgvmV+14EnvLqzWd33RlQEwDn5eYPKparookqSt
         QkC0qUezIAZ867Z9cBBUo3Soyy0219mYkVOt9w+vadM4GuIwXjbA0ehHkJKw56mQOr58
         bsY7MlOP3beyPlFIbXSPHZ0kKgm/3lTrTguRfPgF86YDoHG2vP6SxRhZZu87g3lKiFBk
         h/U4zSXvb+v3K5rEDFnE7IHnqd8Sk+DPmfajOp5ZQmq/DKJekH7Z8KyWlvZ38icD7RnA
         jfT3utR5dIze5zWpMzsGBc3Lu9kwLpWg1BTTJEH9Z7xu0jefsFGIDTuMP6yuZghOIg7D
         oQtw==
X-Gm-Message-State: AOAM531+4/bkseMxFJ4UmAUkPhXltQDdJTBGIQVTWvLS3eRbJ8mKZpjj
        leBgjMrkNptu1+XpDCSmcj6xarmjTlJYjvuwBeRqeg==
X-Google-Smtp-Source: ABdhPJxpDAhEXXXNzU+k6JEzSlS5oCCC+YHdJ+RToQDBqDvmlBKjtro0xxou2/hL4BdFQAB3kvq6JYo3NiocZoxZbww=
X-Received: by 2002:a17:90b:140c:: with SMTP id jo12mr1907027pjb.41.1601589561599;
 Thu, 01 Oct 2020 14:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com> <08b7f7fe6b20f6477fa2a447a931b3bbb1ad3121.1600987622.git.andreyknvl@google.com>
 <20201001175841.GS4162920@elver.google.com>
In-Reply-To: <20201001175841.GS4162920@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 1 Oct 2020 23:59:10 +0200
Message-ID: <CAAeHK+y4cn5sZeoeL1SkwA70kFcgneZiFgs6EwVR=7SaHgi5LQ@mail.gmail.com>
Subject: Re: [PATCH v3 32/39] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 7:58 PM <elver@google.com> wrote:
>
> On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> > Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
> > KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> > ---
> > Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
> > ---
> >  mm/kasan/kasan.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 9c73f324e3ce..bd51ab72c002 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -5,7 +5,13 @@
> >  #include <linux/kasan.h>
> >  #include <linux/stackdepot.h>
> >
> > +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> >  #define KASAN_GRANULE_SIZE   (1UL << KASAN_SHADOW_SCALE_SHIFT)
> > +#else
> > +#include <asm/mte-kasan.h>
> > +#define KASAN_GRANULE_SIZE   (MTE_GRANULE_SIZE)
>
> Why braces? Shouldn't MTE_GRANULE_SIZE already have braces?

Will fix in v4, thanks!

>
> > +#endif
> > +
> >  #define KASAN_GRANULE_MASK   (KASAN_GRANULE_SIZE - 1)
> >  #define KASAN_GRANULE_PAGE   (KASAN_GRANULE_SIZE << PAGE_SHIFT)
> >
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
