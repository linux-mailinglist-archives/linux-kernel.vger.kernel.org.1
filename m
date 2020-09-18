Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D126FC71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIRM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:26:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:26:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so3094997pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtDuINtc2G9zXnT6yMkHKsVlqkwJ9oqFqRt0wDdeL5k=;
        b=AJCCnnw6tN19AAXWg3y1FLDWhgP3sqtVLj3UtkH7f5Gj5EBbXqJiaR76bYfgB5yW1j
         tWEk0FgH5vpUtFcFOesKYhV682HXzfo3Z0A34PgGF44tY5nNk+Px0apQRU6glvov9LQu
         p4bZD6g1GqqgtBaAeUOpeUpEu0TRyx8Ke+6r1FXgxr2zQkx5HE+F2ZpbboqjDAGSYRe+
         viX6grNfng/GGxSAU9lPI/k/MAP6An+7vvjI3w52E+XJZsxRqr9yPl1eITgCQ5i4DtT/
         LyXqyF4EL75ZLLTfnE5RhxhV80diK25ZXt7GBISXN8ampQT416w9K6nu8SY+RVhhmlsd
         BAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtDuINtc2G9zXnT6yMkHKsVlqkwJ9oqFqRt0wDdeL5k=;
        b=smAFs/AUjCeXlQDebGs35sGBwouBHI5D2sa6SU7YY2MAKgRcYzHNuusuMy0eaphxHl
         1tXh4Fyvm8VZB8fZxmRSZ2rsPJ63P2slyYz0d+S9hTWPOMdRnnzDVfcUr+9MgRpR4fxb
         jMoAG5KvSQYLgfiesuLxypCGJUJdA0Q5f+xLNLBHC/6fIlcX7Udj/5SCzNnBkCPxU1sr
         Y02SAg137K8f5dQKhjF2eVQgmx8eppt+tow2oRc5YRVGVxA30KSsm7jbDsYmo3/5Em2F
         JgwC59Wf+EhqvTLJHBEeZljWUSynd5vr/JCsnScW5iVkJVEi4ft8dBJUEdgDUqqctW5K
         vxfw==
X-Gm-Message-State: AOAM533x8J4ByxW65HioArOW3QJN56ium/PsQzUsAkNqRpVDkEGdoTK2
        fYO/kqBVOHQuDrcR/VvfVZspbBAF7F4095uhQBzRXg==
X-Google-Smtp-Source: ABdhPJyYLEBC1Xln3czd1Uy/zFGyusoJcCgkY1nP7tWnG45muc49K7pFb6HuBunJOrmB5mw4FOQtyVhIyRqFtb7C9Gk=
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id
 b8-20020a170902d888b02900d0cb2df274mr32829839plz.13.1600432014609; Fri, 18
 Sep 2020 05:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <fb70dc86ccb3f0e062c25c81d948171d8534ee63.1600204505.git.andreyknvl@google.com>
 <20200917170418.GI10662@gaia>
In-Reply-To: <20200917170418.GI10662@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 14:26:43 +0200
Message-ID: <CAAeHK+zLzajA8-TTJ4OjoMtgPB=hyJRxzz7WwG4gc=tHTuB3Yw@mail.gmail.com>
Subject: Re: [PATCH v2 34/37] kasan, arm64: print report from tag fault handler
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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

On Thu, Sep 17, 2020 at 7:04 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16:16PM +0200, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index cdc23662691c..ac79819317f2 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/init.h>
> > +#include <linux/kasan.h>
> >  #include <linux/kprobes.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/page-flags.h>
> > @@ -295,17 +296,23 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> >       do_exit(SIGKILL);
> >  }
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> >  static void report_tag_fault(unsigned long addr, unsigned int esr,
> >                            struct pt_regs *regs)
> >  {
> > -     bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> > +     bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> >
> > -     pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
> > -     pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
> > -     pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
> > -                     mte_get_ptr_tag(addr),
> > -                     mte_get_mem_tag((void *)addr));
> > +     /*
> > +      * SAS bits aren't set for all faults reported in EL1, so we can't
> > +      * find out access size.
> > +      */
> > +     kasan_report(addr, 0, is_write, regs->pc);
> >  }
> > +#else
> > +/* Tag faults aren't enabled without CONFIG_KASAN_HW_TAGS. */
> > +static inline void report_tag_fault(unsigned long addr, unsigned int esr,
> > +                                 struct pt_regs *regs) { }
> > +#endif
>
> So is there a point in introducing this function in an earlier patch,
> just to remove its content here?

I added it to make the first patch somewhat self-consistent. But we
can drop it in v3 if you think it's not needed.
