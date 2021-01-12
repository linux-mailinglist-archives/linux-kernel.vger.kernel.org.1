Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD02F2A14
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405567AbhALIbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405108AbhALIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:31:09 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8D4C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:30:29 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id p14so1197990qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wLcHsg2X/4z8PrpV9akJDkZzB5hyg40jt+7shI/gTg=;
        b=H7l/xBsokZWxuOFzTvS7+hoJXKkGNX+QxRbLwuakj+IdGe//P9o1E5TN3/ENCRlaWg
         +AJQbWcTsANDN0rj16yKPd98Cc5CUH5ram5r0nunqyWgyzBLENpBXaxO6YwkndltHCvx
         9/bLKtn8Oe+7NJ2+HcQFM/ZhpVCi2hlfj8zaVT7J5f7TdQ67PYRgx6+AZgRctanQBAKN
         jWLT/q2+liDdD6foacf7Ge0XEcZQTRAdxih1bMdmgN1optpDDA/L7pfZKgI8qMx/CO8U
         o0Rt+iVuYnvePEIVGWz7OezS2iwIKHYgUMXbwNSwOjkHn4bHNuD81jPhVfx2qHjWg4Oe
         NviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wLcHsg2X/4z8PrpV9akJDkZzB5hyg40jt+7shI/gTg=;
        b=lmIR1Q7OBDmTCCAIkS3k6T4kGf3Q+Z8bwK6l7Etel+4ikP+guHXFTHrLOnlKeSfILe
         6vyEARK3Fhf6nKCPbpgZC/i+lOw4jD7bVrF4ZqoiaK8KrbCJTtAAH8hTmUI/Rm0pyFHc
         YVsiPx26KOU0I9OFBudnfvfeD1tBE1tvwj88g6aAvX4Q7vtGbP+tQefOmzfnZqsa0PHV
         iIXmpG8wUoprSBN7fTbybskXwfQUYt51sl7/tli8EPn4h1ISRZhaI6eRbwpCgVUtc0pz
         XcGE4Pkkt3n3hiJ7iYZwSpTfIu41CVF05WW5nSvvKwDzigizacRAaQ0lRR/qLVLX65oU
         dF2g==
X-Gm-Message-State: AOAM5315sV3vDDnF8WVHt2cJ4k9IZyoTXtsgxCDFf6hd0CyAJBv+dWqU
        2HNVYtpBFit4+njYAahtjjMXswi41m6nD6McmjaQcg==
X-Google-Smtp-Source: ABdhPJzX9ZKlxgtpdQZv9xSZdDB8NQvTnIoH5PwigJDwvVh6x5siBFDoV6HC12Np9+IpbIi/oAruZI7lTvLDSsb8sig=
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr3304130qka.403.1610440228161;
 Tue, 12 Jan 2021 00:30:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <0c51a7266ea851797dc9816405fc40d860a48db1.1609871239.git.andreyknvl@google.com>
In-Reply-To: <0c51a7266ea851797dc9816405fc40d860a48db1.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 09:30:16 +0100
Message-ID: <CAG_fn=VXe2AZZ3q6+HoV+zB=9GLP+kgyW_r9hfqvX-NJHurTRg@mail.gmail.com>
Subject: Re: [PATCH 09/11] kasan: fix memory corruption in kasan_bitops_tags test
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Since the hardware tag-based KASAN mode might not have a redzone that
> comes after an allocated object (when kasan.mode=prod is enabled), the
> kasan_bitops_tags() test ends up corrupting the next object in memory.
>
> Change the test so it always accesses the redzone that lies within the
> allocated object's boundaries.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I67f51d1ee48f0a8d0fe2658c2a39e4879fe0832a
> ---
>  lib/test_kasan.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index b67da7f6e17f..3ea52da52714 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -771,17 +771,17 @@ static void kasan_bitops_tags(struct kunit *test)
>
>         /* This test is specifically crafted for the tag-based mode. */
>         if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -               kunit_info(test, "skipping, CONFIG_KASAN_SW_TAGS required");
> +               kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
>                 return;
>         }
>
> -       /* Allocation size will be rounded to up granule size, which is 16. */
> -       bits = kzalloc(sizeof(*bits), GFP_KERNEL);
> +       /* kmalloc-64 cache will be used and the last 16 bytes will be the redzone. */
> +       bits = kzalloc(48, GFP_KERNEL);

I think it might make sense to call ksize() here to ensure we have
these spare bytes.
