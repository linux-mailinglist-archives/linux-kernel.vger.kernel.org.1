Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914A72B0E06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKLT1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKLT1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:27:17 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A01FC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:27:17 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a18so5475219pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xycyBHYzWiVaz+V9gLDQX6HE1E3HaoQ5YhnMfRsWwHI=;
        b=d77qtn8YZRh/AQDOvMteWddTQy3QqcvCr4HFZmmE3hz1br3LMK/NbAG3k+k3xODi3/
         ASmDD98lubGa9NJ8Wzq9bKaVt9JY3HKEfCzk1Qh0lFmf2QUIztT7WPPDaH0BUeoqbTnW
         xn7YIWG3wK1v+c4PTAtSNQ2k8ND/UsrXhn21Aa8zwn+oL90K4kZiCMSEsWBG2Bzbxj0E
         OFsIiTJa2sxHM1pLhsdmsrPH9ig+NRIOEAfJjt4L+pHacdAyKbjqyfjMPU2DTVON8YNl
         k1NkpxfgAzm4bQr8QVJioD816VUeh0n4KcQUFM1RBtdN9NR05kj470o+m4p6tMw2+ck/
         vYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xycyBHYzWiVaz+V9gLDQX6HE1E3HaoQ5YhnMfRsWwHI=;
        b=iIN0vsw39DhdxU2Xf3peXw799Vmc1tubOvEGYCQ3GjREx0oucLp4QmFTbpnuVC0XrC
         Q8br969sgzUaBtc5JTTGvYf6HenURdX6gpl0I7jWSseTz9j+S/dPXg3opHTKGnKcEhaP
         1WaoeIoJY1NGU/0hzW5APDAbNyWOqxrMihW3/t0C/6GsX61TiC3H/dnR08bmGvC8tlKO
         BnIUDYCd2proFPOEbXS6PuvWzc4jHtiXCfHl9+dz9aYQABTQEf83219N1SoFKQXdChQX
         y8K0uIUmBHFvVxmuUw3APDshbGeXjfvbr2WXeaSrn1u4fHwRVrl+f7F3ua3jxqT0p/dK
         zgjQ==
X-Gm-Message-State: AOAM531HNwpEgY++Bnf/kV+I+X14yEajnwU+SgvBqbcvaoeHqnKKgWWV
        eqvw+tZwHzEwUHImhUNVwHIXLraUgYdjrb99z8TTQg==
X-Google-Smtp-Source: ABdhPJzGsAs7K5YmJeT7a5J9GmyJkaJyaoemUzPhUj2Gpuh+rkQNq9gc9pGSSZ642a8HYgxMYzcYgnpVxakIRaPJJ/I=
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr747894pjz.136.1605209236569;
 Thu, 12 Nov 2020 11:27:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <49f7f2c12b0d5805f9a7b7092b986bbc2dd077a1.1605046192.git.andreyknvl@google.com>
 <CAG_fn=VXhK0d__FkNdhdquy9F4VmB64_6eJQOQBRecy2oL6huQ@mail.gmail.com>
 <CAAeHK+wX+JPyZm2A5mDdGFCqnH6kdSBLyOZ2TnWfZnZuq_V0Bw@mail.gmail.com> <CAG_fn=VPEC4Lk+zaN25M8fygFKpvqLVzwYg-WHB9iXdY5JK1sg@mail.gmail.com>
In-Reply-To: <CAG_fn=VPEC4Lk+zaN25M8fygFKpvqLVzwYg-WHB9iXdY5JK1sg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 20:27:05 +0100
Message-ID: <CAAeHK+wc8Z-mYR=UeA3XwGjiUNr0f+bAoouKu1MP-vsKZ2+4bw@mail.gmail.com>
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

On Thu, Nov 12, 2020 at 4:16 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Wed, Nov 11, 2020 at 7:52 PM 'Andrey Konovalov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 4:09 PM Alexander Potapenko <glider@google.com> wrote:
> > >
> > > On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > >
> > > > This is a preparatory commit for the upcoming addition of a new hardware
> > > > tag-based (MTE-based) KASAN mode.
> > > >
> > > > kasan_non_canonical_hook() is only applicable to KASAN modes that use
> > > > shadow memory, and won't be needed for hardware tag-based KASAN.
> > > >
> > > > No functional changes for software modes.
> > > >
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > Reviewed-by: Marco Elver <elver@google.com>
> > > > ---
> > > > Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
> > > > ---
> > > >  mm/kasan/report.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > > index 5d5733831ad7..594bad2a3a5e 100644
> > > > --- a/mm/kasan/report.c
> > > > +++ b/mm/kasan/report.c
> > > > @@ -403,7 +403,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
> > > >         return ret;
> > > >  }
> > > >
> > > > -#ifdef CONFIG_KASAN_INLINE
> > > > +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
> > > > +       defined(CONFIG_KASAN_INLINE)
> > > >  /*
> > > >   * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
> > > >   * canonical half of the address space) cause out-of-bounds shadow memory reads
> > >
> > > Perhaps this comment also needs to be updated.
> >
> > In what way?
>
> Ok, maybe not. I thought you were restricting the set of configs under
> which this hook is used, so this should've been explained.
> But as far as I understand, CONFIG_KASAN_INLINE already implies
> "defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)",
> doesn't it?
> Maybe this change is not needed at all then?

Ah, yes, you're right. Will drop this patch, thanks!
