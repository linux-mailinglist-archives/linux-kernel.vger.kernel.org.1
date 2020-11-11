Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1849B2AF892
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgKKSwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:52:20 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1406C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:52:20 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r10so1956107pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9me8OLCg9caFbPV5Uj2BdRlxnobSrjFoBA3jMpvquw=;
        b=iNz4Bk2UGOrF47EtwH9pt5EnTDKRQsVk6o+2eNqF0Gzn9RZmx1bK1W3xFKAi6lu5mh
         NLodQxAAUrOH0IC6qvoyUVZ3EODMH1Z0+vc+u2a0PWf334XenrxvguUFdi/A/fE5gL68
         pjTTB8LMjFW7Kqj4I6zw5y04j8C5ENS1yXmJuKHiIFmk3X9+E4QzFU3QhP6dLblIyd3X
         NbKNYXPBJUTUVIFA/jPVc5Yb6cfI8XjI8qEXYDUvPfWI4gedug0Hs1e9lePIKfUf8a7o
         IUlc1ecYlKirHhIg5vyNg2FrNu3FCvhfR6tHBEGI/zxrvK159EqM76lAxfdOIsCNvqxl
         v6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9me8OLCg9caFbPV5Uj2BdRlxnobSrjFoBA3jMpvquw=;
        b=K2tjM9CZ7FMR0VQacYiqEuAdRrJL5oMnpjWwU6leUhNYuTR1ScgXqXkrkIFfI9b9/4
         8TXkrlHSIL2WYMymi3ztJPaKrV+lvREmDgQZbxB6MGKivt2Z78ZtlwtQJjTo9cAGkj3S
         tKvvqEDYUgimsaaKtFzE0X9fDWsXsWOqrFpTDw66hyGIAuUZ0UIubxV3nq6ZNOYkXt3F
         AfhpFHdeh5cwlPM3/IyPu/xSCZcPUQqrEMLyk7QiaRW1Sv13UPmxiq69/URgBncc3tZ1
         ICZyDroJYqFmvgjrezbanRaTKdOncAzYM2V3U9TZxBV37CSG/67WNhldv8mv1NW1FPDB
         fd6w==
X-Gm-Message-State: AOAM531N4g9+vATTGz2rSHKaaqHSGtNVDcBWzxsYRfYKgo+cieTPsk9s
        kjhuee7zixCtn8AxxwdmBQz8E/WyzfdcV88/7XxEcw==
X-Google-Smtp-Source: ABdhPJykU80dffJSIdNduPLXhQGxEkHGO5yecTSm+N651CeXvmn1GahM1mQkhtZRZnMW2ZlVA9Yu+8f659ZlUSnD150=
X-Received: by 2002:a62:cec6:0:b029:18a:d620:6b86 with SMTP id
 y189-20020a62cec60000b029018ad6206b86mr23279253pfg.2.1605120740077; Wed, 11
 Nov 2020 10:52:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <49f7f2c12b0d5805f9a7b7092b986bbc2dd077a1.1605046192.git.andreyknvl@google.com>
 <CAG_fn=VXhK0d__FkNdhdquy9F4VmB64_6eJQOQBRecy2oL6huQ@mail.gmail.com>
In-Reply-To: <CAG_fn=VXhK0d__FkNdhdquy9F4VmB64_6eJQOQBRecy2oL6huQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Nov 2020 19:52:09 +0100
Message-ID: <CAAeHK+wX+JPyZm2A5mDdGFCqnH6kdSBLyOZ2TnWfZnZuq_V0Bw@mail.gmail.com>
Subject: Re: [PATCH v9 21/44] kasan: kasan_non_canonical_hook only for
 software modes
To:     Alexander Potapenko <glider@google.com>
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

On Wed, Nov 11, 2020 at 4:09 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This is a preparatory commit for the upcoming addition of a new hardware
> > tag-based (MTE-based) KASAN mode.
> >
> > kasan_non_canonical_hook() is only applicable to KASAN modes that use
> > shadow memory, and won't be needed for hardware tag-based KASAN.
> >
> > No functional changes for software modes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > ---
> > Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
> > ---
> >  mm/kasan/report.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 5d5733831ad7..594bad2a3a5e 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -403,7 +403,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
> >         return ret;
> >  }
> >
> > -#ifdef CONFIG_KASAN_INLINE
> > +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
> > +       defined(CONFIG_KASAN_INLINE)
> >  /*
> >   * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
> >   * canonical half of the address space) cause out-of-bounds shadow memory reads
>
> Perhaps this comment also needs to be updated.

In what way?
