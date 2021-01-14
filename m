Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988452F64B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbhANPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbhANPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:33:45 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89184C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:33:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b5so3389906pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZ/Nqkyz1NzBbC9d12mdlvYcjVEDi+jgRuueCoXzbVA=;
        b=eBy7cKZ3wJTClUI2m4kVw3DQiatogxgxrOB9kFInZXzWgT9o1em7B0C8OJhCIexOzK
         +/sswB2OtP1hVYCA6xofoubvfW34RgqeFLiuf5UkQGIPiAhQtzpaWbz4ue1rGh+9R7uA
         k9smac70hwrCG8+H4aGrdKpV/OvylmT1FyiSQd9QOmzCkhseRJLHb2OxUrZkKP/spyNS
         iIF06rNO5kiuxn1nYtwL8r0cKIP85jC+AX+xefTiUHFco4CR6a7vcKK63aY4cH2+k28Y
         7c9hN9hUdwZqAQcswUVPvI+hkmFcpjTyS0hwWiAdcD5EYm3nQSuN8AzuUGdeT1G/Sd1L
         N5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZ/Nqkyz1NzBbC9d12mdlvYcjVEDi+jgRuueCoXzbVA=;
        b=K+8pdxLwvIUkBjbDuQCcpuC9Mn26XdhvNxw8itgVrRZFDbmEwfkC8K0xSVDY9Bf/hP
         MAVhq8fjP+5DIorlfMf9ezqbmdvtCGCwwqd0n5qC9U0eDAXRwO/BocPPmVwl4rs5ajg8
         Ivt/cSd/ulIZuyvSCz3c2qGSuSLTd3v+yzEMjb70fAxHJC9BAai9OQV6wgyX7RW2XWzd
         jPUq0YZ00wH9CfkbmE+TXGaNySgQxX4Rejy5q2SN1ro9v+4/dCAk8ESgUDdfcCn5VsKH
         hzDFyqOtRzIg8LIZkpuufzK7w8dSPi1n68H8LUlgXbnIkvqjScfshFfTTOES8ueI4TEw
         TgoQ==
X-Gm-Message-State: AOAM530aj4NClGhZVH4zQwievvJ9lpsyfq62LSjLvo7DvKPc0IJvBuEV
        CWGhrp2qg9BcieQ+tqTy2KwfS4CPyT8Ac4sGlmyNfA==
X-Google-Smtp-Source: ABdhPJy9YlSK775KH1/FQc1fPdS9o7AWBR5938KXfynV1LFLq0CO1yXSF9AJJK5LDeVRvLPNUiRAuUQSqMPKdmNPjMo=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr5447639pjb.166.1610638384902;
 Thu, 14 Jan 2021 07:33:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <0e994d67a05cbf23b3c6186a862b5d22cad2ca7b.1610554432.git.andreyknvl@google.com>
 <CANpmjNN5t0-dEHJUqKbT8eRQcj2epdiR5xbUkp=JR-Ka7jLM4A@mail.gmail.com>
In-Reply-To: <CANpmjNN5t0-dEHJUqKbT8eRQcj2epdiR5xbUkp=JR-Ka7jLM4A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Jan 2021 16:32:53 +0100
Message-ID: <CAAeHK+zATEUJX+hm0m=jX9Z61CFRoMN3hmHuk8AL1dFy3W9KAg@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] kasan: add a test for kmem_cache_alloc/free_bulk
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

On Wed, Jan 13, 2021 at 5:38 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 13 Jan 2021 at 17:22, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Add a test for kmem_cache_alloc/free_bulk to make sure there are now
> > false-positives when these functions are used.
>
> s/now/no/ (but by itself doesn't necessarily demand a v3)
>
> > Link: https://linux-review.googlesource.com/id/I2a8bf797aecf81baeac61380c567308f319e263d
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  lib/test_kasan.c | 39 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 34 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 5e3d054e5b8c..d9f9a93922d5 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -479,10 +479,11 @@ static void kmem_cache_oob(struct kunit *test)
> >  {
> >         char *p;
> >         size_t size = 200;
> > -       struct kmem_cache *cache = kmem_cache_create("test_cache",
> > -                                               size, 0,
> > -                                               0, NULL);
> > +       struct kmem_cache *cache;
> > +
> > +       cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> > +
> >         p = kmem_cache_alloc(cache, GFP_KERNEL);
> >         if (!p) {
> >                 kunit_err(test, "Allocation failed: %s\n", __func__);
> > @@ -491,11 +492,12 @@ static void kmem_cache_oob(struct kunit *test)
> >         }
> >
> >         KUNIT_EXPECT_KASAN_FAIL(test, *p = p[size + OOB_TAG_OFF]);
> > +
> >         kmem_cache_free(cache, p);
> >         kmem_cache_destroy(cache);
> >  }
> >
> > -static void memcg_accounted_kmem_cache(struct kunit *test)
> > +static void kmem_cache_accounted(struct kunit *test)
> >  {
> >         int i;
> >         char *p;
> > @@ -522,6 +524,32 @@ static void memcg_accounted_kmem_cache(struct kunit *test)
> >         kmem_cache_destroy(cache);
> >  }
> >
> > +static void kmem_cache_bulk(struct kunit *test)
> > +{
> > +       struct kmem_cache *cache;
> > +       size_t size = 200;
> > +       size_t p_size = 10;
>
> s/p_size/ARRAY_SIZE(p)/
> ?
>
> > +       char *p[10];
> > +       bool ret;
> > +       int i;
> > +
> > +       cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> > +
> > +       ret = kmem_cache_alloc_bulk(cache, GFP_KERNEL, p_size, (void **)&p);
> > +       if (!ret) {
> > +               kunit_err(test, "Allocation failed: %s\n", __func__);
> > +               kmem_cache_destroy(cache);
> > +               return;
> > +       }
> > +
> > +       for (i = 0; i < p_size; i++)
> > +               p[i][0] = p[i][size - 1] = 42;
> > +
> > +       kmem_cache_free_bulk(cache, p_size, (void **)&p);
> > +       kmem_cache_destroy(cache);
> > +}
> > +
> >  static char global_array[10];
> >
> >  static void kasan_global_oob(struct kunit *test)
> > @@ -961,7 +989,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
> >         KUNIT_CASE(kfree_via_page),
> >         KUNIT_CASE(kfree_via_phys),
> >         KUNIT_CASE(kmem_cache_oob),
> > -       KUNIT_CASE(memcg_accounted_kmem_cache),
> > +       KUNIT_CASE(kmem_cache_accounted),
> > +       KUNIT_CASE(kmem_cache_bulk),
> >         KUNIT_CASE(kasan_global_oob),
> >         KUNIT_CASE(kasan_stack_oob),
> >         KUNIT_CASE(kasan_alloca_oob_left),
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >

Will fix all in v3, thanks!
