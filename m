Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D65626FAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRKjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:39:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692F4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:39:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so3215369pgd.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BA74pq9Zk+EY0B+5KtILBM++vfiF9LClb1TtG0VGMg=;
        b=bZzEE8ST+6WycOr5Rst39I67wilv5k5SvyGkHPsn3mRhe7ruYp7AzIfSmSL5YMy4+J
         r+dGj4oYaHC1ALs8NiHp/twhAU0qUWSNOATnubN3m21ylxDXxcTqxofc3KPTdKZad1WQ
         IEHIsCsDpbojqgbChTdgpPxyX+MWPJEX92ERMR2ZEIEyGhcMVmzM4smWPMNyiYGGdwkj
         ly6cdPI8/Wsd16ztLensD3N8jRUmelx6HviINExWraokAC0MFiMos0HLdnF9XbWcMUjN
         RXQqO8k2yiR1wbncuo2s7NM5dEqmzgEaMXaZ1YFX+WAUrMd96adcYIW9Sj0ekeZZli91
         q2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BA74pq9Zk+EY0B+5KtILBM++vfiF9LClb1TtG0VGMg=;
        b=Uy9Em2dvpkX+vjK7BC0hAk4/ZOHNnPZLI27SpvQ2PSvUWzGRCpDRgr9jugl4/AGeKt
         wUQFGrylfkQBi10osn/P5yjwHNZIWi2k/JtYOqyySaB6NMAEJLnBgbOTsDaM1MUPCb6g
         F/4GHIPgRo0TXgMlX0LORvC9sZuOSboaM7LYCvYyNdhKl9emH3erXC/E8LqB5ID1gOKV
         gywWDTViCEIOHrdSphW5aH7zkXDQnoFjjRGAz6BwoQsafHnVwhW8vUIZmgrSehsUJ6hY
         H2uPg6gc8tq051Hi710uwL58GlSno8+c4KeP2YgGKD4BmXgipcanMbibdZd5ll2r+L8U
         /k3A==
X-Gm-Message-State: AOAM532d+/kS2ZdFsYLQSrX0CyYGxU9CA4mkXiYNsIerkG8FwAl3G3oE
        /O42E3lXNM66KwFbdW+6SMIAQosp67mDBCIZrBOV8A==
X-Google-Smtp-Source: ABdhPJxsNJ1/ALFvU9Viq7TgmQqLSQxHS+99JGvGaazSkYkpuVJz6AGEjcS6JGjChCrWVe3VKznLhUu3jPZIQtmbWro=
X-Received: by 2002:a62:ee10:0:b029:142:2501:3972 with SMTP id
 e16-20020a62ee100000b029014225013972mr14985432pfi.55.1600425590587; Fri, 18
 Sep 2020 03:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <88c275dc4eef13c8bcbe74ecec661733dcbc67b8.1600204505.git.andreyknvl@google.com>
 <CAG_fn=Vuu-hiaACaoyvpo7RCzvk4faz=AANX=oyAKEJdHDSxEg@mail.gmail.com>
In-Reply-To: <CAG_fn=Vuu-hiaACaoyvpo7RCzvk4faz=AANX=oyAKEJdHDSxEg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 12:39:39 +0200
Message-ID: <CAAeHK+x1rPq_UCU8rCFhpqQvcT-cX3=-ccE77bwbwZViDfhvpQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/37] kasan: split out shadow.c from common.c
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
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

On Fri, Sep 18, 2020 at 10:17 AM Alexander Potapenko <glider@google.com> wrote:
>
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > new file mode 100644
> > index 000000000000..4888084ecdfc
> > --- /dev/null
> > +++ b/mm/kasan/shadow.c
> > @@ -0,0 +1,509 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This file contains KASAN shadow runtime code.
>
> I think it will be nice to mention here which KASAN modes are going to
> use this file.

Will do in v3.

> > +#undef memset
> > +void *memset(void *addr, int c, size_t len)
> > +{
> > +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > +               return NULL;
> > +
> > +       return __memset(addr, c, len);
> > +}
> > +
>
> OOC, don't we need memset and memmove implementations in the
> hardware-based mode as well?

Hardware mode uses native memset implementation as all memory access
instructions are checked by the hardware anyway.

> > +       region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
> > +       region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
>
> "PAGE_SIZE * KASAN_GRANULE_SIZE" seems to be a common thing, can we
> give it a name?

This patch just moves the already existing code, but I can fix this in
a separate patch.
