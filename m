Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9282A6DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgKDTWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKDTWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:22:19 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD1C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:22:19 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so10743563pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AS6LJKOijonuhwsBoB44CLu/ocg1LiPjNjpXhH5Y8E=;
        b=c+mg+DzLn/N+UEJNBB+4veQnmWwotqeTUw/rCUoIWXye/WJzZBi0M/Pyxx/PNq2rEQ
         jMxwH1zM+yd4q8gmwV4ru1iRUrC6U6ndNLcad8yba/pdW8hMvLnWF+FMdvsO+CPTimYy
         ajQmH/Wrn8dsI56XipHtodaGZyqJHT9xM81ZYDJ4RE7++id4RUHCu3a8pLthQ8H1Sfa1
         Wv5yA5rI8k+08XW1XzaJdOFMvy2qXEJw+vfCBXfd7TrfB2oXGm9VpTRnOAkkOc5qOmDS
         dOY1e3gQCxdOla/C5iLBjYMoF6+1417bhfo2zIhDLLOIb/XAmo8SaVVGGu8cybI6ZI9C
         8mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AS6LJKOijonuhwsBoB44CLu/ocg1LiPjNjpXhH5Y8E=;
        b=AbLQFa+As6EW3M50kaUqExVDcGN4XjhyqQRjCngGEQNVRmZiMTdlnVYGHqoJqZeDyI
         FcQdSnoEB2hi+Bu3rA1sRoy8I5TCCgKRvvYWVEp9h72XFW0eykHinHZJlKfiNVspWrmA
         UKlP8GTPpw2YsLpDjvr3mFHe/hDbAWS8+NXGn6H9moGgdX8RSRUmnBXKC5XVustexQxn
         KMpZOQB5rmC5LlVGgt/hbO5reeH+aqNHZHPR89Z3DZhlnJE9wpDwMOY/dAH2L5PSoVQC
         IdrRJahh073clx64+9OGi3dK3JLOy+oaBjbqhXdIGXxTF0lIGyQ81O85C6fTIj2YHb0x
         It+Q==
X-Gm-Message-State: AOAM533YRUC9n+tGWwkPLMZJeHm4hgelUfcVolW8qZoWrl1d7k1uYM/c
        xiURdcIrHb7GNzkDsm+UVY0231wWMgsJR9QUs2s3jQ==
X-Google-Smtp-Source: ABdhPJw0130ycGFYPg+WxQoIUzb5lSobSiqo0GY/ZxXtvcSA/Z47gVexTwvVanpaUPrMOfMNVUylwlZMpHbm1Bk2oGU=
X-Received: by 2002:a17:902:d90d:b029:d6:ecf9:c1dd with SMTP id
 c13-20020a170902d90db02900d6ecf9c1ddmr3847240plz.13.1604517738891; Wed, 04
 Nov 2020 11:22:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com> <4dee872cf377e011290bbe2e90c7e7fd24e789dd.1604333009.git.andreyknvl@google.com>
 <your-ad-here.call-01604517065-ext-2603@work.hours>
In-Reply-To: <your-ad-here.call-01604517065-ext-2603@work.hours>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 4 Nov 2020 20:22:07 +0100
Message-ID: <CAAeHK+wuJ5HuGgyor903VcBJSx8sUewJqmhA_nsbVbw0h2UFXg@mail.gmail.com>
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

On Wed, Nov 4, 2020 at 8:11 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Mon, Nov 02, 2020 at 05:03:56PM +0100, Andrey Konovalov wrote:
> > This is a preparatory commit for the upcoming addition of a new hardware
> > tag-based (MTE-based) KASAN mode.
> >
> > The new mode won't be using shadow memory, but will still use the concept
> > of memory granules. Each memory granule maps to a single metadata entry:
> > 8 bytes per one shadow byte for generic mode, 16 bytes per one shadow byte
> > for software tag-based mode, and 16 bytes per one allocation tag for
> > hardware tag-based mode.
> >
> > Rename KASAN_SHADOW_SCALE_SIZE to KASAN_GRANULE_SIZE, and KASAN_SHADOW_MASK
> > to KASAN_GRANULE_MASK.
> >
> > Also use MASK when used as a mask, otherwise use SIZE.
> >
> > No functional changes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > ---
> > Change-Id: Iac733e2248aa9d29f6fc425d8946ba07cca73ecf
> > ---
> >  Documentation/dev-tools/kasan.rst |  2 +-
> >  lib/test_kasan.c                  |  2 +-
> >  mm/kasan/common.c                 | 39 ++++++++++++++++---------------
> >  mm/kasan/generic.c                | 14 +++++------
> >  mm/kasan/generic_report.c         |  8 +++----
> >  mm/kasan/init.c                   |  8 +++----
> >  mm/kasan/kasan.h                  |  4 ++--
> >  mm/kasan/report.c                 | 10 ++++----
> >  mm/kasan/tags_report.c            |  2 +-
> >  9 files changed, 45 insertions(+), 44 deletions(-)
>
> hm, this one got escaped somehow
>
> lib/test_kasan_module.c:
> 18 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_SHADOW_SCALE_SIZE)

You mean it's not on the patch? It is, almost at the very top.

Or do you mean something else?
