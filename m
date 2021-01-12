Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F02F38E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406504AbhALS3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406307AbhALS3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:29:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1BAC06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:28:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b8so1365130plh.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rph5/YWztZo7f+7iLQyy6pT5CxZC682xIlOwCUdZJGU=;
        b=NbtgBBkA5zfh3973/gq4Qp8Ucu8SRBX+BAdV+P8GMTk5pMqtL7sRaUycC3sdKBFjiH
         AeU+3ZRkzNdfnhrpqfo98zwCrH5svzw9CEec2/EibcELKdFBLBDg5SLhAlL+f4nXMuC/
         vkNuQ1b+PaumfFDAZB1T2pYh+HNG3x9z2/jhGc17uUo2ecgD9QLR04a09KmoVnlG4Hh0
         V4OnatAg3Q37PUDOO1GdHAJIbMYLjmtowyqYKmqVkDVgZoIBq4uub4So8glCNQ8/pu21
         9krZwyK/adxxKRXQF9JskoyjuO4Iyyzmcc+iaUubQfuB1WWAkNuvZH7SzgXH2iueUmaZ
         xl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rph5/YWztZo7f+7iLQyy6pT5CxZC682xIlOwCUdZJGU=;
        b=d67zo42Z6MBvlzTV6uL6IpYsUqjk3AWudqmOVQCXk/BwZshGlrVADl5By9DdlfDJRj
         dEj7IuRTxv4euoEkgaJMOO/lB8Q5iK/b/cKUknYsqgNrSC68ke+xBfTkokrC4nTkI8zy
         h44TzfHaMxuo4wguHGlRTV5smG024naX3V10TH9i7/2vYRlrchOPkOdbhzO2DN8n9GRr
         5LYa0kffCaT/qZk9hIO2S2cke5G7xRxa3Yxmu8fbotpTw5Ag6KCxQMOh9xEPG3HTYjtl
         2QhUuETF2BeKYykSaUcgpvfT7mTCxC08Whm8Ejdv04OS53x4jZY2gWCJLPlKs9ju6lG0
         4aDA==
X-Gm-Message-State: AOAM533U27kKoKswjAAHFeRZ/rBVv9QFBLexyp6Y+JM1EI2rPZTxUjCw
        zdWlO1qZvymaxZVMmNQRmcb2hgSJb9TkESQa/FrJLw==
X-Google-Smtp-Source: ABdhPJz6jRq4so9Kku93b/xI4raH9teGz3t3kzluP1hOCGGalLxXVDra8crnobJ/ukY/Q1M04nnYt4HCSk9dpWgnvrQ=
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr421423pjb.41.1610476115545;
 Tue, 12 Jan 2021 10:28:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <ae666d8946f586cfc250205cea4ae0b729d818fa.1609871239.git.andreyknvl@google.com>
 <X/2lLAOWi4PHJh/Q@elver.google.com>
In-Reply-To: <X/2lLAOWi4PHJh/Q@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 19:28:24 +0100
Message-ID: <CAAeHK+z0z4gvbBvyPYnG3bRqcsHD88byMAzzWDQ8H4mb0ZYuYA@mail.gmail.com>
Subject: Re: [PATCH 06/11] kasan: rename CONFIG_TEST_KASAN_MODULE
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
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

On Tue, Jan 12, 2021 at 2:33 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> > Rename CONFIG_TEST_KASAN_MODULE to CONFIG_KASAN_MODULE_TEST.
> >
> > This naming is more consistent with the existing CONFIG_KASAN_KUNIT_TEST.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Id347dfa5fe8788b7a1a189863e039f409da0ae5f
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> For this patch, as-is. But we could potentially do better in future --
> see below.
>
> > ---
> >  Documentation/dev-tools/kasan.rst | 6 +++---
> >  lib/Kconfig.kasan                 | 2 +-
> >  lib/Makefile                      | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index 26c99852a852..72535816145d 100644
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -374,8 +374,8 @@ unmapped. This will require changes in arch-specific code.
> >  This allows ``VMAP_STACK`` support on x86, and can simplify support of
> >  architectures that do not have a fixed module region.
> >
> > -CONFIG_KASAN_KUNIT_TEST & CONFIG_TEST_KASAN_MODULE
> > ---------------------------------------------------
> > +CONFIG_KASAN_KUNIT_TEST and CONFIG_KASAN_MODULE_TEST
> > +----------------------------------------------------
> >
> >  KASAN tests consist on two parts:
> >
> > @@ -384,7 +384,7 @@ KASAN tests consist on two parts:
> >  automatically in a few different ways, see the instructions below.
> >
> >  2. Tests that are currently incompatible with KUnit. Enabled with
> > -``CONFIG_TEST_KASAN_MODULE`` and can only be run as a module. These tests can
> > +``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These tests can
> >  only be verified manually, by loading the kernel module and inspecting the
> >  kernel log for KASAN reports.
> >
> > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > index 3091432acb0a..624ae1df7984 100644
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -192,7 +192,7 @@ config KASAN_KUNIT_TEST
> >         For more information on KUnit and unit tests in general, please refer
> >         to the KUnit documentation in Documentation/dev-tools/kunit.
> >
> > -config TEST_KASAN_MODULE
> > +config KASAN_MODULE_TEST
> >       tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
> >       depends on m && KASAN && !KASAN_HW_TAGS
> >       help
> > diff --git a/lib/Makefile b/lib/Makefile
> > index afeff05fa8c5..122f25d6407e 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -68,7 +68,7 @@ obj-$(CONFIG_TEST_IDA) += test_ida.o
> >  obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
> >  CFLAGS_test_kasan.o += -fno-builtin
> >  CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
> > -obj-$(CONFIG_TEST_KASAN_MODULE) += test_kasan_module.o
> > +obj-$(CONFIG_KASAN_MODULE_TEST) += test_kasan_module.o
> >  CFLAGS_test_kasan_module.o += -fno-builtin
>
> [1] https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-file-and-module-names
>
> Do we eventually want to rename the tests to follow the style
> recommendation more closely?
>
> Option 1: Rename the KUnit test to kasan_test.c? And then
> also rename test_kasan_module.c -> kasan_module_test.c?  Then the file
> names would be mostly consistent with the config names.
>
> Option 2: The style guide [1] also mentions where there are non-KUnit
> tests around to use _kunit for KUnit test, and _test (or similar) for
> the non-KUnit test. So here we'd end up with kasan_kunit.c and
> kasan_test.c. That would get rid of the confusing "module" part. The
> config variable could either remain CONFIG_KASAN_MODULE_TEST, or simply
> become CONFIG_KASAN_TEST, since we already have CONFIG_KASAN_KUNIT_TEST
> to distinguish.
>
> But I won't bikeshed further. If you do a v2, I leave it to your
> judgement to decide what is most appropriate.

Most tests in lib/ start with test_, so not using that pattern for
KASAN tests could be confusing. Maybe we can move them to mm/kasan.
Anyway, I won't look into this right now.

Thanks!
