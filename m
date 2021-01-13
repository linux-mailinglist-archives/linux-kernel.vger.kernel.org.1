Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE52F5005
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbhAMQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbhAMQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:32:15 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73A5C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:31:34 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id k7so668012ooa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5O0XZaro4xKRzF3tZMIIKYZ6A4RiPSbA4A/IZtlADzQ=;
        b=lzTuCstBMF+4HZDKsJ2s+dATMMBlbJN4oiCZrltzT7iPCeTLlE7+oAba5DNQXeTy0H
         qnKfdwCvwwJcYXRKpllziNLCQtKD41I5lhVoPGowMm/CG46eJ+BwQOB6Yo6sHWaXoL64
         Zttlt6SxFpqtcQTZ2Wlt8mDNiTU8bVQfvuTim1f6Yd6x+ZYZLOgkUfwCxdhCuQaqqiHe
         zqQU4ViWaQkwZtWNZxM7l4jNac4w4bHWKcQ3M4w7CXgj860cWMXp7y3S8E7/Tv2ElzbY
         bj5MG0hUvolK/49TUScOj0jqyd2RQAeMaGPKv1Pah9wue2u7bYsy8mIGs02PPCQKFlyd
         uAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5O0XZaro4xKRzF3tZMIIKYZ6A4RiPSbA4A/IZtlADzQ=;
        b=I5WwSpugjw3nz2hlyn4oZ7q5iSQE9QY9yoojC57emqxEJOQmYiyq1w0g6o/wSbJPOn
         ZjOPxKMDNUhHVkhx+b3WgqlsdmgPq6+EdDSqGvdTyZ6u/a4leHL4MnxolqDbL7PBlhif
         lNe7kXFatWq1NWmLm1gLAtmAB3X/19HOXTacqRuN1TjVlwQTiS5xu4G7Qh6xJsXI+KeM
         +SUv0AHSMwaMrWT3K16pRWg4A320fPPPZUdGwNrMrQChwZ3bxl0kSAeFjoQwNLnGW5tf
         dT7P+l8FSBB47n7BlvUoRV1nPBtnrZ73IYawYoLs91VHKbCZoiczHV12Ey++hlVKWk4s
         c7Ig==
X-Gm-Message-State: AOAM5317ialLcza5kS4ms2uWPt52uW1spFIzW+zSnVdPSwwW1cNbAKKV
        cvOxWuupo2KHp79Anz2GfL59QEwSsvSEyKetwoFsaw==
X-Google-Smtp-Source: ABdhPJxMHdtWXMdBmVhNTyaR2Hfpgf6YY2QydFrNCbzcFdY/EBICBgCHdnSsfezkhLCPbsegKv261UfVBkRIZ4EGaIs=
X-Received: by 2002:a4a:a11a:: with SMTP id i26mr1812321ool.54.1610555494097;
 Wed, 13 Jan 2021 08:31:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <1b884616c85091d6d173f7c1a8647d25424f1e7e.1610554432.git.andreyknvl@google.com>
In-Reply-To: <1b884616c85091d6d173f7c1a8647d25424f1e7e.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:31:22 +0100
Message-ID: <CANpmjNMzQ7v_wwdzf9q72nwJ8paMbvJTA9u7SpyCER858at9EA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] kasan: adapt kmalloc_uaf2 test to HW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Wed, 13 Jan 2021 at 17:22, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> In the kmalloc_uaf2() test, the pointers to the two allocated memory
> blocks might happen to be the same, and the test will fail. With the
> software tag-based mode, the probability of the that is 1/254, so it's
> hard to observe the failure. For the hardware tag-based mode though,
> the probablity is 1/14, which is quite noticable.
>
> Allow up to 16 attempts at generating different tags for the tag-based
> modes.
>
> Link: https://linux-review.googlesource.com/id/Ibfa458ef2804ff465d8eb07434a300bf36388d55
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 283feda9882a..a1a35d75ee1e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -382,7 +382,9 @@ static void kmalloc_uaf2(struct kunit *test)
>  {
>         char *ptr1, *ptr2;
>         size_t size = 43;
> +       int counter = 0;
>
> +again:
>         ptr1 = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>
> @@ -391,6 +393,15 @@ static void kmalloc_uaf2(struct kunit *test)
>         ptr2 = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>
> +       /*
> +        * For tag-based KASAN ptr1 and ptr2 tags might happen to be the same.
> +        * Allow up to 16 attempts at generating different tags.
> +        */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 == ptr2 && counter++ < 16) {
> +               kfree(ptr2);
> +               goto again;
> +       }
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr1[40] = 'x');
>         KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
