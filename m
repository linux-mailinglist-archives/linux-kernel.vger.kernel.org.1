Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD02FC01A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbhASTfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbhASTeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:34:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC5C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:33:40 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g15so13585437pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et5oXk9EBnfayAqZpeLMrHHvh8j8h9yJAXgaYXUhqsI=;
        b=UXLRrAGf55FXqFBtm5JN1IX0SiNXfZcg8vBi/zcTHDGN3ouW/nfab86vXFhIEd1dMw
         g/JFpz0qKMY3jiUmR89QfDXbtfeBSaEmqGQ4yqvB0EMXvU25daKDFaecy0e7EM3feYbT
         utLTkh9x8+B59+dG3Q6Dk0g9ltAwbYhauC7qbwwSrXyoRkTsFSWOD3Jrp/NdwzpN0bEO
         h7kPrrqWO0t85WgLXLrAkGUTr+gK/8DGAyrz3iiqOMyM34ar35hh6A8xuKQ51mYwCPek
         LLRvaq3lB8MrUbhVGKsOrRXGEtZrbhkeSp7Yiqo6lmgKaSZc5vMb2+dDmXBQfvX4GCqG
         5frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et5oXk9EBnfayAqZpeLMrHHvh8j8h9yJAXgaYXUhqsI=;
        b=WUAEBowIjnOUBibviXCTcAYV24dtpKmFcLJSBfnjlIZn7rEuACUsYlJyqD15nOrka/
         XyBrsUXK3fWbq0Rugwv/Y3YnQquNN6wAmsSsdC1jDSCZB6VlPClI3BwPhifDQGg31Uw1
         JwRPCC2prx4nx2jNwLzv+4ptvrYvO2sQodcHiX6oyelK7W/xfgE4h0JPzihTBd31SYKi
         xAEjLZtacRh4BB1mqiOLjs3bCpGP0xew127J+Csn+9uBUbcUCVBIVa2gsa+eoK87numn
         mw5671bD3ygtIkpchS2o7uD1kPf/Fh+g8VyE0HOcQn/IcdYtvtAoTWvuAfXgibuxobb0
         Y3HQ==
X-Gm-Message-State: AOAM533q16X4oXgBbAW/A1fQTOpHOJPHaUaDuU1LCG57BOlzyihu0CsL
        QbZ8WVnEDxucP3MI8uHGuNvX7UNzED8hCWwp20gDDg==
X-Google-Smtp-Source: ABdhPJxbD8OMrOCfs3cBJOgqP7HfmOjdZ1ZHPmgeqYeiJsqyD8QbEDas0BBqydVog+u+PYQcaklHI9Nc4hKQ0aJpGP4=
X-Received: by 2002:aa7:8597:0:b029:1b9:38bd:d0dc with SMTP id
 w23-20020aa785970000b02901b938bdd0dcmr5377887pfn.24.1611084820015; Tue, 19
 Jan 2021 11:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20210119172607.18400-1-vincenzo.frascino@arm.com>
 <CAAeHK+zpB6GZcAbWnmvKu5mk_HuNEaXV2OwRuSNnVjddjBqZMQ@mail.gmail.com>
 <20210119185206.GA26948@gaia> <e3d67672-1825-894a-db68-5709b33b4991@arm.com>
In-Reply-To: <e3d67672-1825-894a-db68-5709b33b4991@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 20:33:28 +0100
Message-ID: <CAAeHK+zKnSdx+=8mA5o1YWR5aV8OSEUaRZiaJiB6wsOo_5kYJQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Add explicit preconditions to kasan_report()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 7:57 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
>
> On 1/19/21 6:52 PM, Catalin Marinas wrote:
> > On Tue, Jan 19, 2021 at 07:27:43PM +0100, Andrey Konovalov wrote:
> >> On Tue, Jan 19, 2021 at 6:26 PM Vincenzo Frascino
> >> <vincenzo.frascino@arm.com> wrote:
> >>>
> >>> With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
> >>> the address passed as a parameter.
> >>>
> >>> Add a comment to make sure that the preconditions to the function are
> >>> explicitly clarified.
> >>>
> >>> Note: An invalid address (e.g. NULL pointer address) passed to the
> >>> function when, KASAN_HW_TAGS is enabled, leads to a kernel panic.
> >>>
> >>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >>> Cc: Alexander Potapenko <glider@google.com>
> >>> Cc: Dmitry Vyukov <dvyukov@google.com>
> >>> Cc: Leon Romanovsky <leonro@mellanox.com>
> >>> Cc: Andrey Konovalov <andreyknvl@google.com>
> >>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >>> ---
> >>>  mm/kasan/report.c | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> >>> index c0fb21797550..2485b585004d 100644
> >>> --- a/mm/kasan/report.c
> >>> +++ b/mm/kasan/report.c
> >>> @@ -403,6 +403,17 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
> >>>         end_report(&flags);
> >>>  }
> >>>
> >>> +/**
> >>> + * kasan_report - report kasan fault details
> >>> + * @addr: valid address of the allocation where the tag fault was detected
> >>> + * @size: size of the allocation where the tag fault was detected
> >>> + * @is_write: the instruction that caused the fault was a read or write?
> >>> + * @ip: pointer to the instruction that cause the fault
> >>> + *
> >>> + * Note: When CONFIG_KASAN_HW_TAGS is enabled kasan_report() dereferences
> >>> + * the address to access the tags, hence it must be valid at this point in
> >>> + * order to not cause a kernel panic.
> >>> + */
> >>
> >> It doesn't dereference the address, it just checks the tags, right?
> >>
> >> Ideally, kasan_report() should survive that with HW_TAGS like with the
> >> other modes. The reason it doesn't is probably because of a blank
> >> addr_has_metadata() definition for HW_TAGS in mm/kasan/kasan.h. I
> >> guess we should somehow check that the memory comes from page_alloc or
> >> kmalloc. Or otherwise make sure that it has tags. Maybe there's an arm
> >> instruction to check whether the memory has tags?
> >
> > There isn't an architected way to probe whether a memory location has a
> > VA->PA mapping. The tags are addressed by PA but you can't reach them if
> > you get a page fault on the VA. So we either document the kasan_report()
> > preconditions or, as you suggest, update addr_has_metadata() for the
> > HW_TAGS case. Something like:
> >
> >         return is_vmalloc_addr(virt) || virt_addr_valid(virt));
> >
>
> Or we could have both ;)

Sounds good! Please also update the comment to avoid mentioning tag
faults. kasan_report() is used for the generic KASAN mode as well, and
it doesn't use tags.

Thanks!
