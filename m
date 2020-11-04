Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B02A6DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgKDTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKDTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:32:57 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A636C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:32:56 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 1so10777407ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gp5b6Mr5Qne4OLUNKLGgmsC9HZETysD3ixRMlsHSDMc=;
        b=N5iD+1F5uK/kOBzhFYBZ0IzKOpjBGNCgKj8530rROc8SKWuoKXrZ8aU5u/UtoSG0v0
         I0Z0XWi4q4u2a1TlsnMy+FTFoqDv/Qn735BY6cMeepjbea79QsEFfDhzMV5PGaWNUmXH
         Uct41CfIYwD89j7Rg6tjcyQbRDYRz6nVcmhwwtKsWgVROXy8wg/LaI8Q7Bm9HPngYdy0
         RIiczr/wo/E6Ber+by1Zrc9Pi4MrKiT55D8VHKRy1uBTFnu4gHWxAXVkmNZIgYCLYf1c
         pFQ7R9TOuotRJMZpsh3XmmiR5NrW4ryDKmBWYhukFQfk7t+vZogJPkIxC6ziTJbgFp9v
         yfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gp5b6Mr5Qne4OLUNKLGgmsC9HZETysD3ixRMlsHSDMc=;
        b=SuykD2CzxQ2eRUASXqYh10a1QhfbUYZCKADyH0WlS3Wy5XQKoH9vDtO1pOdtLc2ngf
         /Nkys6SSz5/Rpm3vVFHc9Nddgz1yxJOfBewJu7mKUBQ3dwnycVOCbRNHPYLk1weBOb6m
         SUykKoGpjnJoYp4ZBnB58lj6IL3w3NxVKx9nNT/Y6856I2p4H465Opcc2J+OcVqH4lhq
         c2HZZ9wOLkqTmkKf6AHkUMGPkM4NCMKNQu8vXvlF3tRjvSpv0f++oyL2DaPbRukKi/9e
         QyTegpjXfW2MDIERhHeM6wQv53mIBt8I4IQbPsseK34/jJ40vaVwCII0C8aSOBRhjdN3
         qfyw==
X-Gm-Message-State: AOAM530KwBGMf3UCX0+yDHaQl/F9+W3SuE+6+NUx3J/AmduENREsfIcF
        TDxciWjCRALpggFzsmbPmkBDmw8UM1ugKsZ0nOWx6A==
X-Google-Smtp-Source: ABdhPJyAnyC37voV+ffqeE/IhReZhVQ3JFVD+XLQetQ/ANZXU3wdL6dME3kIHqAQgZFoNFrpYn4D6tvjyWbLAd1IbKA=
X-Received: by 2002:a17:902:e993:b029:d6:41d8:9ca3 with SMTP id
 f19-20020a170902e993b02900d641d89ca3mr32168650plb.57.1604518375779; Wed, 04
 Nov 2020 11:32:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com> <4dee872cf377e011290bbe2e90c7e7fd24e789dd.1604333009.git.andreyknvl@google.com>
 <your-ad-here.call-01604517065-ext-2603@work.hours> <CAAeHK+wuJ5HuGgyor903VcBJSx8sUewJqmhA_nsbVbw0h2UFXg@mail.gmail.com>
 <your-ad-here.call-01604518242-ext-7611@work.hours>
In-Reply-To: <your-ad-here.call-01604518242-ext-7611@work.hours>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 4 Nov 2020 20:32:44 +0100
Message-ID: <CAAeHK+wddqC7WeeiDsEUNB9pWMpZz7ZSpJvMPtHCfbBO=uXoMg@mail.gmail.com>
Subject: Re: [PATCH v7 16/41] kasan: rename KASAN_SHADOW_* to KASAN_GRANULE_*
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 8:30 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Wed, Nov 04, 2020 at 08:22:07PM +0100, Andrey Konovalov wrote:
> > On Wed, Nov 4, 2020 at 8:11 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
> > >
> > > On Mon, Nov 02, 2020 at 05:03:56PM +0100, Andrey Konovalov wrote:
> > > > This is a preparatory commit for the upcoming addition of a new hardware
> > > > tag-based (MTE-based) KASAN mode.
> > > >
> > > > The new mode won't be using shadow memory, but will still use the concept
> > > > of memory granules. Each memory granule maps to a single metadata entry:
> > > > 8 bytes per one shadow byte for generic mode, 16 bytes per one shadow byte
> > > > for software tag-based mode, and 16 bytes per one allocation tag for
> > > > hardware tag-based mode.
> > > >
> > > > Rename KASAN_SHADOW_SCALE_SIZE to KASAN_GRANULE_SIZE, and KASAN_SHADOW_MASK
> > > > to KASAN_GRANULE_MASK.
> > > >
> > > > Also use MASK when used as a mask, otherwise use SIZE.
> > > >
> > > > No functional changes.
> > > >
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > Reviewed-by: Marco Elver <elver@google.com>
> > > > ---
> > > > Change-Id: Iac733e2248aa9d29f6fc425d8946ba07cca73ecf
> > > > ---
> > > >  Documentation/dev-tools/kasan.rst |  2 +-
> > > >  lib/test_kasan.c                  |  2 +-
> > > >  mm/kasan/common.c                 | 39 ++++++++++++++++---------------
> > > >  mm/kasan/generic.c                | 14 +++++------
> > > >  mm/kasan/generic_report.c         |  8 +++----
> > > >  mm/kasan/init.c                   |  8 +++----
> > > >  mm/kasan/kasan.h                  |  4 ++--
> > > >  mm/kasan/report.c                 | 10 ++++----
> > > >  mm/kasan/tags_report.c            |  2 +-
> > > >  9 files changed, 45 insertions(+), 44 deletions(-)
> > >
> > > hm, this one got escaped somehow
> > >
> > > lib/test_kasan_module.c:
> > > 18 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_SHADOW_SCALE_SIZE)
> >
> > You mean it's not on the patch? It is, almost at the very top.
>
> lib/test_kasan_module.c != lib/test_kasan.c
>
> I fetched your branch. And I had to fix it up to build old good kasan
> test module CONFIG_TEST_KASAN_MODULE=m

Ah, right, it was just recently merged into mainline, that's why it's
missing. Thanks for noticing!
