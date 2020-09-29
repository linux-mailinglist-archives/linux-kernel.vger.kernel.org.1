Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D860E27D41B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgI2REr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2REr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:04:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D933C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:04:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so5376065wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q2qSwq54NZdSyl2veBn7BJhqFUUK7iFcl9H/GTVRA5E=;
        b=Kj6x+I9cpVOamlCJIgk428ZZjQD3Ram2H3tsw6dNDyvgDRU3/KFlN90ns697nKZWu7
         RzzEqhATAxXA0SrIWPrYoME1NRaW8XZh7zPOUdsDBaL7r+XSn/wUhDXpZaTSoCVGnmRt
         oYAKDo7MMsMDeqmLAEHqtr19kyIB9LXuipTQL0fHRpIoWgVv8KWm8Y1pUm0UmlH9XfHw
         TZIbVllK4uZTzqDNSv3vaoGJM+CKHu0KwPJ5Nsn6Scz88EIIJKCklV6TtMW9QFNHsEny
         k7kdHOq0TIM/DR0b2ODgOjiqqwyVZF1qhZEndTBkhrTdYO96wv4TpsS1PVLOf+GQrGoe
         y/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q2qSwq54NZdSyl2veBn7BJhqFUUK7iFcl9H/GTVRA5E=;
        b=t9whFr2WkXz+jAU21EJxTO6Xh96E/MJ9KCa7yjQnZiIyHOICQ355UzlDV0bU3Vmnvn
         1b0oKfNVK+USq/b1ksi7c0HwoPdSSDY3Q3vmdnwfyW8jVn0VIgdj5ite79SFY7Xjnw5k
         7jP2cnyRZEFpYeWseScp0vo1+eEzfFGx/R9gF90bn42R0CGVdKBfWhhZVoQtMw8JdmZq
         4lLSit5FgDlVjNIIqtHjSbD0RzeXXQBVa0nOv5MYYsF5A55Hve11tbzb8pKG5gie48iP
         GBqrIyGgWs0mA7CqJfawwhHw9Iy9rpyeQcZ27Li8sX7lN2XBoobuTsF5b6y59sU3uN5c
         XLDQ==
X-Gm-Message-State: AOAM530FnVBnoWOSGZNUc233eF/FsoAy8b2xcZIsoW4kCTPKRLX931t2
        yTdzZaIo1Ga8I2udA5fjBJ9N/VAH+n51PVQYHPGdow==
X-Google-Smtp-Source: ABdhPJwOscngdOaqUBSevTARqhUo/ERncaL04LQq5TSuhVCcud+q5tyftAYFQVDVPNIYRkTJhAhEM/eqsuDS5QzBDsI=
X-Received: by 2002:a7b:c749:: with SMTP id w9mr5250095wmk.29.1601399083707;
 Tue, 29 Sep 2020 10:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-4-elver@google.com>
 <20200929142752.GD53442@C02TD0UTHF1T.local>
In-Reply-To: <20200929142752.GD53442@C02TD0UTHF1T.local>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 29 Sep 2020 19:04:32 +0200
Message-ID: <CAG_fn=X5ZwMLC9OJaMzcV2WpRgxHyfSeb+0A+1rPYcRYu27V=g@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 4:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Sep 21, 2020 at 03:26:04PM +0200, Marco Elver wrote:
> > Add architecture specific implementation details for KFENCE and enable
> > KFENCE for the arm64 architecture. In particular, this implements the
> > required interface in <asm/kfence.h>. Currently, the arm64 version does
> > not yet use a statically allocated memory pool, at the cost of a pointe=
r
> > load for each is_kfence_address().
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Co-developed-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > For ARM64, we would like to solicit feedback on what the best option is
> > to obtain a constant address for __kfence_pool. One option is to declar=
e
> > a memory range in the memory layout to be dedicated to KFENCE (like is
> > done for KASAN), however, it is unclear if this is the best available
> > option. We would like to avoid touching the memory layout.
> > ---
> >  arch/arm64/Kconfig              |  1 +
> >  arch/arm64/include/asm/kfence.h | 39 +++++++++++++++++++++++++++++++++
> >  arch/arm64/mm/fault.c           |  4 ++++
> >  3 files changed, 44 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/kfence.h
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6d232837cbee..1acc6b2877c3 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -132,6 +132,7 @@ config ARM64
> >       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >       select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> >       select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> > +     select HAVE_ARCH_KFENCE if (!ARM64_16K_PAGES && !ARM64_64K_PAGES)
> >       select HAVE_ARCH_KGDB
> >       select HAVE_ARCH_MMAP_RND_BITS
> >       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> > diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/k=
fence.h
> > new file mode 100644
> > index 000000000000..608dde80e5ca
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/kfence.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_KFENCE_H
> > +#define __ASM_KFENCE_H
> > +
> > +#include <linux/kfence.h>
> > +#include <linux/log2.h>
> > +#include <linux/mm.h>
> > +
> > +#include <asm/cacheflush.h>
> > +
> > +#define KFENCE_SKIP_ARCH_FAULT_HANDLER "el1_sync"
> > +
> > +/*
> > + * FIXME: Support HAVE_ARCH_KFENCE_STATIC_POOL: Use the statically all=
ocated
> > + * __kfence_pool, to avoid the extra pointer load for is_kfence_addres=
s(). By
> > + * default, however, we do not have struct pages for static allocation=
s.
> > + */
> > +
> > +static inline bool arch_kfence_initialize_pool(void)
> > +{
> > +     const unsigned int num_pages =3D ilog2(roundup_pow_of_two(KFENCE_=
POOL_SIZE / PAGE_SIZE));
> > +     struct page *pages =3D alloc_pages(GFP_KERNEL, num_pages);
> > +
> > +     if (!pages)
> > +             return false;
> > +
> > +     __kfence_pool =3D page_address(pages);
> > +     return true;
> > +}
> > +
> > +static inline bool kfence_protect_page(unsigned long addr, bool protec=
t)
> > +{
> > +     set_memory_valid(addr, 1, !protect);
> > +
> > +     return true;
> > +}
>
> This is only safe if the linear map is force ot page granularity. That's
> the default with rodata=3Dfull, but this is not always the case, so this
> will need some interaction with the MMU setup in arch/arm64/mm/mmu.c.

On x86 we ensure this by reallocating the necessary page tables.

But looks like your suggestion is what we need for arm64 as long as we
also want virt_to_page() to work for our pool.
It's still unclear to me whether a carveout you suggest can be placed
at a fixed (known at link time) address, as the main point of this
dance is to remove memory accesses from is_kfence_addr().

> Thanks,
> Mark.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
