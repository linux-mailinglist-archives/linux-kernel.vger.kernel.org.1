Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A02F5026
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbhAMQiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbhAMQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:38:51 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F4AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:38:11 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id d8so2470033otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHd/Kicf/hoH6eKoo5AC7GFnFGH61vMiUslEm8Z70PU=;
        b=Ezx3nAz4GFftYjCL/OWE0LNcnj3O/YpHc3uyjRkNy7pFQY24u8im6eAlP2bXOZTKUV
         uGmkoiiluZaE+w6gbmEf3EFHK2lJ6xqrnd+BCLL8RBaDEYZJTUv7HpEoXaCxjlnTOz8l
         NhYlz4mrmLSMuERImCeoMkWdn4zFpgxlbaxPiRJGUB5d+BKqfv781f7QXWUOMmZbC2Yc
         5XpPbeCQTbJUKsjhohIeVMOiCaGgQ2Nl1eNrabb3sxNtgtuDF+2Y3HYPdeovHTu/REvG
         /Qp7q61QVO/UaNErP4h4Vi0foutnzdXW1qEELcBuOUfVnxUa/sbOf5l/j5q334nD2ZQT
         M2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHd/Kicf/hoH6eKoo5AC7GFnFGH61vMiUslEm8Z70PU=;
        b=uOTtOhUpEyO8uznG5v4kR/cigGxb7iG4WJT3XdF7X9g4IkKNA9pHt35P+4JJohP85Y
         d54KDRRBLMpABOdocQ9pcEq7opq45VCOgg6Z/VTkdlepLwbQKwqC+51QE5PeFzzkPPVo
         AHKf1ocKt+mAUdatWL5HIR3nwLf00wuPlVnA0laUcoMV5kxeZQUMxWNTwtyZnLp88GhO
         +BCTzSMP/ENeUK7V9pJh9JMZQ3Ui/yhuuEpfTdE3WpaTScAxlGOsTaW/Ri4P8af2Ilou
         sndJ80PwQ1YPLwofiBSweGuqLQhxhr2XmsWTCpxtD0CRmukxdsrsKaBGXjI4LBkMpMjt
         /L0g==
X-Gm-Message-State: AOAM531RWkaJHZq0j5w/VEyyA5gjQj05dx3f87pK/zm71rfNh1wZ96y+
        CLmY6xSV7sZ8cw5gjz8MzkaGqNFtuyc7Y2piuIZfvw==
X-Google-Smtp-Source: ABdhPJxrXHSavVkk4MhbxgsayCG8kXDnZrYMNzthFK9pismXNnoj6IT/K7Bk+lsQOwYAzgqMXlJ+EOZ/90qErfrlG4k=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr1858158ots.251.1610555890417;
 Wed, 13 Jan 2021 08:38:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <0e994d67a05cbf23b3c6186a862b5d22cad2ca7b.1610554432.git.andreyknvl@google.com>
In-Reply-To: <0e994d67a05cbf23b3c6186a862b5d22cad2ca7b.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:37:58 +0100
Message-ID: <CANpmjNN5t0-dEHJUqKbT8eRQcj2epdiR5xbUkp=JR-Ka7jLM4A@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] kasan: add a test for kmem_cache_alloc/free_bulk
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
> Add a test for kmem_cache_alloc/free_bulk to make sure there are now
> false-positives when these functions are used.

s/now/no/ (but by itself doesn't necessarily demand a v3)

> Link: https://linux-review.googlesource.com/id/I2a8bf797aecf81baeac61380c567308f319e263d
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/test_kasan.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 5e3d054e5b8c..d9f9a93922d5 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -479,10 +479,11 @@ static void kmem_cache_oob(struct kunit *test)
>  {
>         char *p;
>         size_t size = 200;
> -       struct kmem_cache *cache = kmem_cache_create("test_cache",
> -                                               size, 0,
> -                                               0, NULL);
> +       struct kmem_cache *cache;
> +
> +       cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +
>         p = kmem_cache_alloc(cache, GFP_KERNEL);
>         if (!p) {
>                 kunit_err(test, "Allocation failed: %s\n", __func__);
> @@ -491,11 +492,12 @@ static void kmem_cache_oob(struct kunit *test)
>         }
>
>         KUNIT_EXPECT_KASAN_FAIL(test, *p = p[size + OOB_TAG_OFF]);
> +
>         kmem_cache_free(cache, p);
>         kmem_cache_destroy(cache);
>  }
>
> -static void memcg_accounted_kmem_cache(struct kunit *test)
> +static void kmem_cache_accounted(struct kunit *test)
>  {
>         int i;
>         char *p;
> @@ -522,6 +524,32 @@ static void memcg_accounted_kmem_cache(struct kunit *test)
>         kmem_cache_destroy(cache);
>  }
>
> +static void kmem_cache_bulk(struct kunit *test)
> +{
> +       struct kmem_cache *cache;
> +       size_t size = 200;
> +       size_t p_size = 10;

s/p_size/ARRAY_SIZE(p)/
?

> +       char *p[10];
> +       bool ret;
> +       int i;
> +
> +       cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +
> +       ret = kmem_cache_alloc_bulk(cache, GFP_KERNEL, p_size, (void **)&p);
> +       if (!ret) {
> +               kunit_err(test, "Allocation failed: %s\n", __func__);
> +               kmem_cache_destroy(cache);
> +               return;
> +       }
> +
> +       for (i = 0; i < p_size; i++)
> +               p[i][0] = p[i][size - 1] = 42;
> +
> +       kmem_cache_free_bulk(cache, p_size, (void **)&p);
> +       kmem_cache_destroy(cache);
> +}
> +
>  static char global_array[10];
>
>  static void kasan_global_oob(struct kunit *test)
> @@ -961,7 +989,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kfree_via_page),
>         KUNIT_CASE(kfree_via_phys),
>         KUNIT_CASE(kmem_cache_oob),
> -       KUNIT_CASE(memcg_accounted_kmem_cache),
> +       KUNIT_CASE(kmem_cache_accounted),
> +       KUNIT_CASE(kmem_cache_bulk),
>         KUNIT_CASE(kasan_global_oob),
>         KUNIT_CASE(kasan_stack_oob),
>         KUNIT_CASE(kasan_alloca_oob_left),
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
