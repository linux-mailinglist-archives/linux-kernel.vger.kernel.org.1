Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770CF2F37BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbhALR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389851AbhALR4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:56:45 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD96CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:56:04 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 15so1920891pgx.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Upx2oTWYrPXCgwMubh2XCOEphSc2BQiSntB9Zcy4eo4=;
        b=cFM44SJt4abZ2k0N/V/wvcE+AypSBPzNcoOxxYjffEcM2P8o375Gcpk0hRg//m2AyP
         B8MBGDmbE93WM/ABHzmES0GG7vJ8kr0Ca6WpeiTHfnweGBO+ADGfM1oS8DiycWfgiC05
         nvnBP8uU4QZYD/yUH0Yklwuby9KJ0qwxkGzSusHtCPYkJuAIFU2u+mTN8Olwfa65edko
         7Q9JzlDJWZLHf706c0q0ztV8AaXE6lK/IBUA0arTGFyaBA249HkJCNl8b9bOdAhFaQk/
         3c9Oj6HZKVnZAGPijvbvnUTfxG6XY48a5Q6joR1mdHNVE1idU4/BwmiZY6M7cY3KE09P
         Pq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Upx2oTWYrPXCgwMubh2XCOEphSc2BQiSntB9Zcy4eo4=;
        b=MHO+1TPmYlRhL5ZbxV0qVZWkemVssBlrm/PlG4epQb75oDNd8Kjm+YOCYzhaHGXeG4
         1+F+W1sLl9GSYYwozDtv+i1GLH5GiogNHE2Bbh70BXC8/nEmFoG/rHHWz2UhKhzbKZCd
         uMbh+88T3mFDV/Sm1K7/EE7r6eXaMydVXM6RxsK+7GEB0I2YQADThADOUAi4rZ/AHyhG
         lCMf/EwZzMMwLBQjOLvC8FoUcWPGveRHZAHUGH1CnxaO8ZV6syh1AgG+L+AoGxFp5yQ1
         CjXyQDHiehzhzJ7GzzBWxDTEz1NTPaunq7dSaqYI2rgYxbHi2swJT0RgrsE3WYm8jnju
         FHHg==
X-Gm-Message-State: AOAM531wTftUbfVtuOVV86OiuwCLOJOVj6u4+mrgNCp9wEIuAo2bDq5K
        xP6cdYlEk4nxNeptkmC9vkHJ8XvIETVgTis9rYI/hA==
X-Google-Smtp-Source: ABdhPJwjRRI5HrAEIHOrVyzD1kiLcgKTLsKMByfy+UQlsos5Ug2vA6ueDXrnXl6mdKeyh958GyNLYgxd4T1U3qSPUl4=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr435587pfh.24.1610474164246; Tue, 12 Jan
 2021 09:56:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <cb4e610c6584251aa2397b56c46e278da0050a25.1609871239.git.andreyknvl@google.com>
 <CAG_fn=VDPR2bkHA_CeDP-m8vwr3rTH+3-qwMNHNUQA2g6VghKA@mail.gmail.com>
In-Reply-To: <CAG_fn=VDPR2bkHA_CeDP-m8vwr3rTH+3-qwMNHNUQA2g6VghKA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 18:55:53 +0100
Message-ID: <CAAeHK+yJ=fLMXtH0o0YEri+pn0k+zN_YSY9a93DeYZL0wrLzow@mail.gmail.com>
Subject: Re: [PATCH 03/11] kasan: clean up comments in tests
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Tue, Jan 12, 2021 at 8:53 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Clarify and update comments and info messages in KASAN tests.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I6c816c51fa1e0eb7aa3dead6bda1f339d2af46c8
>
> >  void *kasan_ptr_result;
> >  int kasan_int_result;
> Shouldn't these two variables be static, by the way?

No, then the compiler starts eliminating accesses.

> > @@ -39,14 +38,13 @@ static struct kunit_resource resource;
> >  static struct kunit_kasan_expectation fail_data;
> >  static bool multishot;
> >
> > +/*
> > + * Temporarily enable multi-shot mode. Otherwise, KASAN would only report the
> > + * first detected bug and panic the kernel if panic_on_warn is enabled.
> > + */
>
> YMMV, but I think this comment was at its place already.

It gets updated by one of the subsequent patches.

> >  static int kasan_test_init(struct kunit *test)
> >  {
> > -       /*
> > -        * Temporarily enable multi-shot mode and set panic_on_warn=0.
> > -        * Otherwise, we'd only get a report for the first case.
> > -        */
> >         multishot = kasan_save_enable_multi_shot();
>
> Unrelated to this change, but have you considered storing
> test-specific data in test->priv instead of globals?

I'd say that test->priv is for some per-test data that's used in the
tests, and multishot is not a part of that.

> >         if (!IS_ENABLED(CONFIG_SLUB)) {
> > -               kunit_info(test, "CONFIG_SLUB is not enabled.");
> > +               kunit_info(test, "skipping, CONFIG_SLUB required");
> >                 return;
> >         }
>
> You may want to introduce a macro that takes a config name and prints
> the warning/returns if it's not enabled.

Good idea, will do in v2.

Thanks!
