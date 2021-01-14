Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902B82F68A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbhANR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbhANR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:59:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C02C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:59:08 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c132so4302022pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2auPNUUUKSqA2spBBB38ITsZONoHBGZrmNd5ga3XBtk=;
        b=PiWe9Ubm2QbW6BtuO6wL1fEVZT8NR6DfhlxC/GA4BPn/RYau9sOW2oP5qfxTt1UMO9
         XyiVuuQ6BWVA5ARXyNfG78mVg4ByoWzWUloj+fqes6TlbfYPW1eV9xJhWWK2KMAI5QTo
         p147499r6HH/cKSonOwi6snhx0Szt/rBsw6jn1AeGGy9lkJIX5Q1wb0k07COvfYZT/+v
         PMlGy8Q9eeQ6qbIMFE12qQdN+1u+qWvc4IeuMrF5mNnD3qq13LS4SeJZQiOZg5U03+ll
         DEMJxmcI5q6jDk0F2j66wLbar9QUTyCOWR5J7DyuGOw2Nnlbthiy4yjLEsuqqDxlEa8c
         2gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2auPNUUUKSqA2spBBB38ITsZONoHBGZrmNd5ga3XBtk=;
        b=h1sbSrnpYxqWh1swDTci8VbGbahP60KAat6Nh0JbWTQyiIEI7q0Mk8yw/dH02UYn++
         wtBPdJ+Qgv+cpV/DsqoBaFu0wS2xAu49brySqLWLaI0oLf3FbfGNZHalXxVOhLGe1y4J
         4Gc0fzxWK9pOvCLe933Xn+FfW5txbNiffubTQqcqYTmpwicdOn6CKe8B50erxzipfZ0W
         DyJ3C+SAGZnXnDALPkZ+EFh7x7IwDGRkefsxnWOpkuF/4eLEUKhSmvN4WfDjhspykjFc
         /wOfbsTjX3gGa/U5caQrS3M0xQpLrGkYtrJNGhPQEz1YzPEc6wRIS7pMwplIkweEVvi0
         8V9Q==
X-Gm-Message-State: AOAM531wsiygm1l7yxJAilPk996k1MKmG9HUIfEmi6YYVmx+/RmeEzmm
        LIbKI+l6oIn/c63by9zDSUFsnQ1iac+s8rMoHRjBUg==
X-Google-Smtp-Source: ABdhPJx4VS5YGc6JIdMS7jp/YUaTjt3UZQAO/wy44uVSMkIarns3UWOfwsr7qEmhIniqX6dkYtp4kq4VrEIvGKtW8XY=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr8242200pfh.24.1610647148349; Thu, 14 Jan
 2021 09:59:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <77015767eb7cfe1cc112a564d31e749d68615a0f.1610554432.git.andreyknvl@google.com>
 <CANpmjNPX9yn5izxtYMq14Aas2y4NA1ijkcS9KN4QQ-7Hv8qZEQ@mail.gmail.com>
In-Reply-To: <CANpmjNPX9yn5izxtYMq14Aas2y4NA1ijkcS9KN4QQ-7Hv8qZEQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Jan 2021 18:58:57 +0100
Message-ID: <CAAeHK+xberuUH0cn8U1N8X0n56Fy=uLCxZ=P3q+E2PPRsfuKNQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] kasan: fix bug detection via ksize for HW_TAGS mode
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

On Wed, Jan 13, 2021 at 5:54 PM Marco Elver <elver@google.com> wrote:
>
> > +bool __kasan_check_byte(const void *addr, unsigned long ip);
> > +static __always_inline bool kasan_check_byte(const void *addr, unsigned long ip)
> > +{
> > +       if (kasan_enabled())
> > +               return __kasan_check_byte(addr, ip);
> > +       return true;
> > +}
>
> Why was this not added to kasan-checks.h? I'd assume including all of
> kasan.h is also undesirable for tag-based modes if we just want to do
> a kasan_check_byte().
>
> Was requiring 'ip' intentional? Unlike the other
> kasan_check-functions, this takes an explicit 'ip'. In the case of
> ksize() usage, this is an advantage, so I'd probably keep it, but the
> rationale to introducing 'ip' vs. before wasn't mentioned.

Yes, to avoid having a ksize() frame in the report. However, I'll move
_RET_IP_ inside of kasan_check_byte() as it's inline.

> > +bool __kasan_check_byte(const void *address, unsigned long ip)
> > +{
> > +       if (!kasan_byte_accessible(address)) {
> > +               kasan_report((unsigned long)address, 1, false, ip);
> > +               return false;
> > +       }
> > +       return true;
> > +}
>
> Like the other __kasan_check*, should this have been EXPORT_SYMBOL()?
> Or was it intentional to not export as it's currently only used by
> non-modules?

We can add EXPORT_SYMBOL as soon as there's a need for it.

Thanks!
