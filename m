Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54A02905AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408010AbgJPNEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395484AbgJPNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:04:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECDC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:04:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c6so1245056plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kg/AR7kJChmFU99Vav3gO3g+4etmp4JgAFXVamIUngo=;
        b=tNSpsnAoXl6hnh96DoeAuiP+9EOUyTZtTcPY/OwkinZmpO3A7HkrjrcYP18LRKMST+
         jnHWvwX0skjh8w4jk/LeK03RSW/+9dXJo1bTYdZTS330kul6zZn1hGnRy1DdcYw9glmT
         /RvIywwu0NxUVftMTJgQkc5eJfyFQleUYJWIa0K7zIp+fatBiTxkM1CG3Wux06+AqpP6
         LHOGxJ4QBfh53o3U11gCUZnviexiIXAW6p2ytXlM17ldL44hZQkPb+gnCMdhy50U5tuP
         p/MPnVKVGHxyThS/eN5IImJYY4Q/ClRgblX0lVf+nlcYCtnRd5Wmv9sOw2mKIo1WmWU8
         l8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kg/AR7kJChmFU99Vav3gO3g+4etmp4JgAFXVamIUngo=;
        b=i45Wvna9Yv44AAcI1T1OktXB0wMJGfqPVCgKH08mc4JkJpSbqYFPpRHeSL9O13CTr/
         FRYiVvmqTO20nSD0+VAJ8eN3Fa5pwkF2XhfkVoqb15x2GDpnv+SqhQTEoVhjvbvV/0Zh
         jMLJXlz8btvcNYDjR1hNJz8qiWsR+kyyiuTkY8JCMBmq/UWo0zsSThMKABswPqId+MDb
         7NYi6UPxvPkk+nlTGS+QRJFlz0ZBXqUH0cNcI2gDWPLvUyANC5t3aQdjUshz4pqWBURe
         lVfCAWMgVict7n862cogZX/nDjngoK8arErvA2E/wDl/KPe9UFbiG/flzb/zlQYC+hIl
         GqDw==
X-Gm-Message-State: AOAM531CatJXB634fs88jwrjSBmpriAohRfXFZFBiMDgGTjZ64sJFxfy
        kVDdR6Af+ZUbsqd0BBDCpb3Sqtu06a2sDdngdPFupw==
X-Google-Smtp-Source: ABdhPJxVYeRhYPu4dH98pYdokuk3AKpxRPtCJ5gB3SyjbOn7ZDs5f9+7efIAkIsh5YvuYG2A0YWuC0QInF2LjuGml8Y=
X-Received: by 2002:a17:902:9681:b029:d5:cdbd:c38c with SMTP id
 n1-20020a1709029681b02900d5cdbdc38cmr201999plp.85.1602853490651; Fri, 16 Oct
 2020 06:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <8fe7b641027ea3151bc84e0d7c81d2d8104d50d7.1602708025.git.andreyknvl@google.com>
 <CANpmjNOKM8=MWPR2MPPrdu0fhvzwD4dDO-xnfeqcxOY1DQe09g@mail.gmail.com>
In-Reply-To: <CANpmjNOKM8=MWPR2MPPrdu0fhvzwD4dDO-xnfeqcxOY1DQe09g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 15:04:39 +0200
Message-ID: <CAAeHK+xSa6jMH6x5BgAuArD8kVURm8DCu-xhiN6mWMkR5n1auA@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] kasan: mark kasan_init_tags as __init
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:23 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 14 Oct 2020 at 22:44, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Similarly to kasan_init() mark kasan_init_tags() as __init.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I8792e22f1ca5a703c5e979969147968a99312558
> > ---
> >  include/linux/kasan.h | 4 ++--
> >  mm/kasan/hw_tags.c    | 2 +-
> >  mm/kasan/sw_tags.c    | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 7be9fb9146ac..af8317b416a8 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -185,7 +185,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
> >
> >  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> >
> > -void kasan_init_tags(void);
> > +void __init kasan_init_tags(void);
> >
> >  void *kasan_reset_tag(const void *addr);
> >
> > @@ -194,7 +194,7 @@ bool kasan_report(unsigned long addr, size_t size,
> >
> >  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> >
> > -static inline void kasan_init_tags(void) { }
> > +static inline void __init kasan_init_tags(void) { }
>
> Should we mark empty static inline functions __init? __init comes with
> a bunch of other attributes, but hopefully they don't interfere with
> inlining?

I think it's a good idea to drop __init, as the function call should
be optimized away anyway.

Thanks!
