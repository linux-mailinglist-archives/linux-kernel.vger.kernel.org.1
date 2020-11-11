Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0AB2AF610
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgKKQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:19:42 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61289C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:19:41 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h15so2129777qkl.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdgljsAg/2kl6g/hQQs/nkDVrJD6gaQwZKzBgT4Tycw=;
        b=EDK8+6vZvqG4lgainA6noaRoMS9BYL+HJyKxtdibIsYOyZM4+qBxmZYkjgcHILiuDB
         r40ch7x5Hjr5lgJR2vl9f1hOU89IOY66J65dPWlRrlzn7cZt76xAhN/UEf5UsU5g9UHg
         M4S10l5GvCixHcZky2v9mm9O8up6atKysDwV79yZFLogABjYKXRT1+qE9FaSUL6s57Vq
         fWyEZ9MTjhv0SIq5Uz0tw5H8w5A5HR8r6cTl9av+YTUeZySii+2RtklJpxppjIb+SZ8C
         MKXiYkK8qN8K6nRNYiktCQ9p7zMAnXWsfWiDJY2NSp+gKMG6kfpSe5blI4Xca2i+JCR0
         TfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdgljsAg/2kl6g/hQQs/nkDVrJD6gaQwZKzBgT4Tycw=;
        b=hC1+WajdJSfENlPp2R1oib0wqYJU5igYqYuCy2lqrtzLMmUqQaIrujHrWcDtEbqHn5
         lJ+H3MSCcyU9DGCdkPmry02/AG1DOBygLviaeIEJOxctaqtL4+arDs/P3V+lGMbdLFUG
         fHO8Sgv1BpfuBJO+hVIEBgWOZgTtSSlDTQwQuzQSKkvJp3L9g6DPZza+9HoA3z/WhefD
         57P7/fEVOkD447gcBVIpBOWXw9rEZembuGdSRl5Hya4T/kuVd7Na+53o3nWtz4ZKq93i
         vgZH4TIhP3/FWu7mlwOVNcmiZ1O8iKbeHD8rJ167VoJUTBoREddxBAZsQwB60FyD/53u
         q8og==
X-Gm-Message-State: AOAM533205NfcFYUh6/+4Rnt93f3pFvEP1qCf12+/vFQFEbJY4zyfTBu
        cJiB71CBQlurpt/geQ3NE8YoQnKmufEC79GLj7OhIg==
X-Google-Smtp-Source: ABdhPJwEWFsczvA9eGNn3bEDLsp5Wc6vUSPX+LtgEiTHwNZx9oxkijXqdSW/eG5CPEGhKgzP1CrHtnGP6gHxFCccMO4=
X-Received: by 2002:a37:4552:: with SMTP id s79mr19714490qka.6.1605111580407;
 Wed, 11 Nov 2020 08:19:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <560e04850b62da4fd69caa92b4ce3bebf275ea59.1605046192.git.andreyknvl@google.com>
 <CAG_fn=W-H8nHc_DmBOsnJOUygDJ+wg78K-QSY_wHTSHg-b8vFQ@mail.gmail.com>
In-Reply-To: <CAG_fn=W-H8nHc_DmBOsnJOUygDJ+wg78K-QSY_wHTSHg-b8vFQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:19:28 +0100
Message-ID: <CAG_fn=WOeX3u7KQaMq1acSszWg=Kq5FLVhK_rWSrXsvzbbvq2g@mail.gmail.com>
Subject: Re: [PATCH v9 23/44] kasan: separate metadata_fetch_row for each mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

On Wed, Nov 11, 2020 at 4:22 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This is a preparatory commit for the upcoming addition of a new hardware
> > tag-based (MTE-based) KASAN mode.
> >
> > Rework print_memory_metadata() to make it agnostic with regard to the
> > way metadata is stored. Allow providing a separate metadata_fetch_row()
> > implementation for each KASAN mode. Hardware tag-based KASAN will provide
> > its own implementation that doesn't use shadow memory.
> >
> > No functional changes for software modes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> > +void metadata_fetch_row(char *buffer, void *row)
> > +{
> > +       memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
>
> I think it is important to use __memcpy() instead of memcpy() in KASAN
> runtime to avoid calling instrumented code.

Please disregard this. Turns out we define memcpy to __memcpy for
non-instrumented files.
