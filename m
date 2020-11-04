Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F214E2A6DCC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgKDT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgKDT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:26:32 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BF1C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:26:32 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p4so3429677plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEU9I/sSHhuQeVi3XIRAFCC61r4m2vgIPksqGF6T7cY=;
        b=QaU/Brb9ubKtJ+UmXAU+wMvbSYfqqAwfeWlEQpFpEGxDAi3owrUgZX2ocw3QDH9kH2
         jDolQ4IYya9FfscNGC0/4+k96h96nMLHyORIqhIrioyvbfSYsdxRHaS0Dnw/kLm8yXrD
         GJRFi34wPeF+0LZLh1tecoO+K5twq4ckJR2RzYcjcpQy+kmXeoB7c96JH1WUo5L3IZ3Q
         KZdQzHhJua+9q9Dil5XGqsIsPS04hgWhvsS2dKINrRF9VUPal8OZWIZe+y43jBQPYVO/
         /0dG4KW+S+a6zzw+iqgXqX6LOCFnI8vybqW0JmPi0lfNNbr4ovfcnc3AQo5z77s6Td5v
         F62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEU9I/sSHhuQeVi3XIRAFCC61r4m2vgIPksqGF6T7cY=;
        b=Io/UKSaLFdP4QuthNqpeaiXFXar2KvcfKW44fwe9iUjx0/yaugJQEybenwCn5HQ7ak
         bSGhrYKFvQwS3boQKzABiiieLTPoiC1PjlMbLZQW1FudYmDk0djtHzYvnegN2rvZCKv7
         U/JOw07dVf0zLwANzQc3Ex6dwmxZ3+36blx/gbidfUVSIaIKYahjca28WOInnsTRF9GD
         KynHdqUOx2ApmwLj8JznXyqHfPyr7hfH3ogkYwoRf6F569YUwJqcdrzCDKcnKGvXIglv
         MWoLIldlsVgKx3pp0q7LNbidaE747dIckGuMFY1qlmwzQtNA/ZL1vtmBIM9d4hqeDEu5
         2ZaA==
X-Gm-Message-State: AOAM532VKOZPfYwMDcfq6Hepag9FWim+DY5P9nRChUdRbPijv3K057An
        XAXEGTHswJA9RzxhDAfpSYS5vJAvTX5mthwnba+sCg==
X-Google-Smtp-Source: ABdhPJzkwewt6K1zE1uoNPrHkLphDrGmDjvihFe/mxpdVUR6Hgh3MwMetX3VEeZNuz7nDWoUs2X0nyJvEZA/xLRZEDQ=
X-Received: by 2002:a17:902:d90d:b029:d6:ecf9:c1dd with SMTP id
 c13-20020a170902d90db02900d6ecf9c1ddmr3858971plz.13.1604517991448; Wed, 04
 Nov 2020 11:26:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com> <5e7c366e68844a0fe8e18371c5a76aef53905fae.1604333009.git.andreyknvl@google.com>
 <your-ad-here.call-01604517929-ext-5900@work.hours>
In-Reply-To: <your-ad-here.call-01604517929-ext-5900@work.hours>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 4 Nov 2020 20:26:20 +0100
Message-ID: <CAAeHK+wD_TgqYvqvp6fiQ_558CpvQyt67uahxLDYkp2hr_QUZw@mail.gmail.com>
Subject: Re: [PATCH v7 13/41] s390/kasan: include asm/page.h from asm/kasan.h
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

On Wed, Nov 4, 2020 at 8:25 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Mon, Nov 02, 2020 at 05:03:53PM +0100, Andrey Konovalov wrote:
> > asm/kasan.h relies on pgd_t type that is defined in asm/page.h. Include
> > asm/page.h from asm/kasan.h.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> > Change-Id: I369a8f9beb442b9d05733892232345c3f4120e0a
> > ---
> >  arch/s390/include/asm/kasan.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/include/asm/kasan.h b/arch/s390/include/asm/kasan.h
> > index e9bf486de136..a0ea4158858b 100644
> > --- a/arch/s390/include/asm/kasan.h
> > +++ b/arch/s390/include/asm/kasan.h
> > @@ -2,6 +2,8 @@
> >  #ifndef __ASM_KASAN_H
> >  #define __ASM_KASAN_H
> >
> > +#include <asm/page.h>
>
> Could you please include
> #include <asm/pgtable.h>
>
> instead? This file is also using _REGION1_SHIFT which is defined there.
> And I have some s390 kasan changes pending, which include
> asm/pgtable.h as well, so this would make merging simpler. Thank you.
>
> With that changed
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>

No problem, thank you!
