Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1442F6B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbhANT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbhANT5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:57:13 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C612C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:56:33 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id k7so1666011ooa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAcc3zNp7VGprtlxhdh/3qjDl2q8+DBIOh9GzZOOC9c=;
        b=vmXs67opHZMsHKBRz9S4jhbrtQZYZ2sk+Iu4XwbNOhJMP2WH2LrsKhHrAzFKTliWM0
         Ic/2n1TyYxSkKaJicov1ee5QzQYe6QangS0QfCGICadiwrvUxaNQdX2mD5IAIvEJ0KKu
         gsbgPlA2PaEpJztqi1Io7QAXMJG44t4Q/I1czERV5oIMmhaBs68dDdAKnGSS0Z+SOm5R
         LuHDT8sF1qDUkDNYGUGMkwh8CQIRosW41Kw4XLfZT+uEpDpB+bt3aCunI/9LwmmpLYG5
         QWt23AAJb4k2kb9M6QDq0EMpYUTk5WR491MD8qMyFlXez0+1GzobQVjqlMp/SLJL1y7I
         +JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAcc3zNp7VGprtlxhdh/3qjDl2q8+DBIOh9GzZOOC9c=;
        b=uYsb8AedMQ2sdLTunt0yzF7okk614SikzTW8MTbpWtYaXGu00KEjSX62wWdDWIopNk
         w4vauy+iefAl5Tgn9Qxr81qn3hXsGaHHwfPkAMyOsjXQwAtRk4ukHpAf3zopZiRT1CE7
         KEtEHKQjymRviTE60/Oa2OH8EKhv+rZzuBHgmtnDbCq5Ek2ALOS4BPDJa3+nEXTncfDL
         P83TF/GR/RUCGRMXb+gSp8QZSV8fi5+XdccyQ4nQGh+77+jc/3Qh5jf5eq/wRCLDBAfU
         T4THv3fOZme0xPBLVFGGfI3iXEpfe0UeE+u0dD8h1xCVOFQfV0dMJ6YRhXB3wrt3StR+
         0WRw==
X-Gm-Message-State: AOAM531VMO2crM/6Dj9tfIFo4GKZeDXfhKeIzipoJWqyZW8NZOlvGrch
        79NxK3RPYn9DBl15RTW8rNGMIXOmTn575SwqgEFOJw==
X-Google-Smtp-Source: ABdhPJyLa62+jHhxWdEgxjXJycNhlQSq/fBgOo4qQHvR5bY4u6pn3J9ETjhhgibepZ6UyHJfmzBm5klziTjyWZtArz0=
X-Received: by 2002:a4a:e1c1:: with SMTP id n1mr5779219oot.36.1610654192707;
 Thu, 14 Jan 2021 11:56:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <77015767eb7cfe1cc112a564d31e749d68615a0f.1610554432.git.andreyknvl@google.com>
 <CANpmjNPX9yn5izxtYMq14Aas2y4NA1ijkcS9KN4QQ-7Hv8qZEQ@mail.gmail.com> <CAAeHK+zD17_esgDvsUd3Yku4cCKDdADo82_u3c47tMWtHL63oQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zD17_esgDvsUd3Yku4cCKDdADo82_u3c47tMWtHL63oQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 Jan 2021 20:56:21 +0100
Message-ID: <CANpmjNNGBCrTwcm=3wrXfdy5A5=3Vd-MVdLd8BBzHRseykFX6Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] kasan: fix bug detection via ksize for HW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 19:01, 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On Wed, Jan 13, 2021 at 5:54 PM Marco Elver <elver@google.com> wrote:
> >
> > > +/*
> > > + * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
> > > + * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> > > + */
> > > +bool __kasan_check_byte(const void *addr, unsigned long ip);
> > > +static __always_inline bool kasan_check_byte(const void *addr, unsigned long ip)
> > > +{
> > > +       if (kasan_enabled())
> > > +               return __kasan_check_byte(addr, ip);
> > > +       return true;
> > > +}
> >
> > Why was this not added to kasan-checks.h? I'd assume including all of
> > kasan.h is also undesirable for tag-based modes if we just want to do
> > a kasan_check_byte().
>
> It requires kasan_enabled() definition. I can move both to
> kasan-checks.h if you prefer. However, the only place where
> kasan_check_byte() is currently used includes kasan.h anyway.

Hmm, if it makes too much of a mess, let's just leave as-is.

Thanks,
-- Marco
