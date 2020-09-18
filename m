Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8027004A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIRO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIRO4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:56:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC6C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:56:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u9so3119308plk.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84mJPr8Gpr4/Tq1Lxh29BXusyQ2UCdZanSBlBtKi1cQ=;
        b=W3Tpv9wPrKPr2FuI5kSboSbfFrAviXfAq10rKNlEr5QMi7YEK6zpgtYA0SDH6noIVk
         1TimskWwsw43RSLr7GlMZ7jsyWqLvpBx/5PekZYCvG5GQbvR2tjeek0TRTvBgVxFg6TI
         dvPUB5zrCNI0QS81Swllg3ZPa8mF+ztZx+G5Yykp8s18Ce0b+A4OsBbia67sPM6JvugV
         aPX+MldJLA2uOSBmYHFS2JhEiOQDTT0o8SEknH2I48gQUAdoJIrPraArbNFwKwmASD8J
         ugL70jCKfOqX8Dm4Cj2mp8h9sWTUV0s9TTQSVImQ0uqYgCnZlzO5kbyhZRtNIV3kPjrp
         O/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84mJPr8Gpr4/Tq1Lxh29BXusyQ2UCdZanSBlBtKi1cQ=;
        b=HJWv3KHweBp79OX5tVzQxbDCo9Yc44ZJJi0bYGJtoSiaAzlNU9xun/smKFiJT3gLJN
         gVoHenc7EkOUjCNOZ6zcZ6uMWeiMwzKxGCxJsmW+Cc9/NRIkwslt9CWcNQ9WLABwhCIg
         D5X4Kc2eF0aWE6WlEo9VqLjMYR7trChCl0Bd7ZMtlLdf8prWJrXM6BSmdFOM0wCYpZdE
         6m8rajyssDWeV56I43xuXFI05fbKBsbx3vaICflgCR2X6jF1Wn9rsn28ooKk94dC96aV
         u9ILST3X+1wndXQcN0hH5oPYkIKQwRQ0lNsIOZovq5EGuhjUXotNBbip/b83IaHFwFaC
         KdMw==
X-Gm-Message-State: AOAM530MwYLi56mcxsz1dRLG1op9o6OZbZ3FMu5bNIV8yCH8TL+H63ZN
        hQecbmbzm3IIkI0Sld23Gf4KQOC6Nzr3dX4vqWXKNg==
X-Google-Smtp-Source: ABdhPJy4gRGHqzM1DVK6jgclHTM6k7zcc+JlhOQZI8hqLajfveJ0hHLmlzeGrvovDPdwwOPiC8qlJIeDpJffpp94I+g=
X-Received: by 2002:a17:90a:81:: with SMTP id a1mr13066299pja.136.1600440996199;
 Fri, 18 Sep 2020 07:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <272b331db9919432cd6467a0bd5ce73ffc46fc97.1597425745.git.andreyknvl@google.com>
 <20200918145541.GA2458536@elver.google.com>
In-Reply-To: <20200918145541.GA2458536@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 16:56:25 +0200
Message-ID: <CAAeHK+w-RyACkoeKXSXaLsZWDRQ-cy3oGFSTJ2J=Hb3CUQnWHw@mail.gmail.com>
Subject: Re: [PATCH 03/35] kasan: shadow declarations only for software modes
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

On Fri, Sep 18, 2020 at 4:55 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:26PM +0200, Andrey Konovalov wrote:
> > This is a preparatory commit for the upcoming addition of a new hardware
> > tag-based (MTE-based) KASAN mode.
> >
> > Group shadow-related KASAN function declarations and only define them
> > for the two existing software modes.
> >
> > No functional changes for software modes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  include/linux/kasan.h | 44 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index bd5b4965a269..44a9aae44138 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> [...]
> > +static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> > +{
> > +     return 0;
> > +}
> > +static inline void kasan_remove_zero_shadow(void *start,
> > +                                     unsigned long size)
> > +{}
>
> Readability suggestion (latest checkpatch.pl allows up to 100 cols):
>
> -static inline void kasan_remove_zero_shadow(void *start,
> -                                       unsigned long size)
> -{}
> +static inline void kasan_remove_zero_shadow(void *start, unsigned long size) {}

Will do in v3, thanks!
