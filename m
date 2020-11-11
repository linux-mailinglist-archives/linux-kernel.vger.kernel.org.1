Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83952AF472
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKKPJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgKKPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:09:08 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CB7C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:09:08 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 11so1928334qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AP20IjKPEiFXMZmCcqvgPxuG9Q2kK77mjoFZj0OZZoQ=;
        b=lW1TBKqiHfp1CIKpViQDUNAHCra8fhHaB43Vddd/gI2W6QjdTQ+C67NLugPEf5ywNV
         Hdh6WNIxkyUUkRBOFLwF7FjlqCfMB26gdW/rPHiyJT700zYb1hIW0NsgrsjiRl4aiZpe
         vTcUx4kFlZWPphLXajq2J0oCwnONR7VKEX10VlcSdL0ohHQnyQlLTyrU7sm8tM2wGOQb
         THLhNxZFSVFETbZhXdG0nEX/QBsA9QWnbB3fi4zhhe8OCIxUBGBzHxeA9bt49chsWB6E
         8siXfeXF9hcTeik8luSgil6mber5Bp7rWpCq/hCmBxaJNKEmYhLgm7Im1Rl3RQp9Xotz
         Xd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AP20IjKPEiFXMZmCcqvgPxuG9Q2kK77mjoFZj0OZZoQ=;
        b=dGR/5Y4nqRk90SjZr4/sPEuAWwAnHZl0x0K5wIKNCZKIqYsZn7m7EFzR5jJGrJFKLN
         goxYBDk3jsAWEacoDftQk5R3FvoWWYN+sUcV5uXLhJVls5HTZJUk73QW5O/BvvkVHQ0c
         vT7j3bu3nbFvovdPu65x8DEouGJMC8cEz/aD1+RvcJhX8cyYr11T+RE+PRwAImJouTD7
         FngbZ91OOZrW8ADy4El8d66PACk963xbpK0Froavuvf1xWlZgZi4OOVaC+dV1QLQNCy0
         teSouvioAQmRmDDfdagm9Vj5rEUNIRx5c/4ymfQGbnKqecehdU+dy1KBRggoA1ocrh9d
         eDdw==
X-Gm-Message-State: AOAM5300eWb9lty5l/u/hrLsz29CcUb7wtSlxfsQs5383QrGFaBtmuVu
        dmrPSnPw8b/cxng8PfJdDzg6Nuq01rzIzFKuZNb/ag==
X-Google-Smtp-Source: ABdhPJwsaubt8h4fnMz+2Pvlw6c7i/aa/2FkCSOslDuvZkkXLEsLDI1RcIJEdJeC8ltaKWZIJiSOlSTnfnq4X1GSiHI=
X-Received: by 2002:a37:4552:: with SMTP id s79mr19382613qka.6.1605107347099;
 Wed, 11 Nov 2020 07:09:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <49f7f2c12b0d5805f9a7b7092b986bbc2dd077a1.1605046192.git.andreyknvl@google.com>
In-Reply-To: <49f7f2c12b0d5805f9a7b7092b986bbc2dd077a1.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:08:55 +0100
Message-ID: <CAG_fn=VXhK0d__FkNdhdquy9F4VmB64_6eJQOQBRecy2oL6huQ@mail.gmail.com>
Subject: Re: [PATCH v9 21/44] kasan: kasan_non_canonical_hook only for
 software modes
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> kasan_non_canonical_hook() is only applicable to KASAN modes that use
> shadow memory, and won't be needed for hardware tag-based KASAN.
>
> No functional changes for software modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
> Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
> ---
>  mm/kasan/report.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5d5733831ad7..594bad2a3a5e 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -403,7 +403,8 @@ bool kasan_report(unsigned long addr, size_t size, bo=
ol is_write,
>         return ret;
>  }
>
> -#ifdef CONFIG_KASAN_INLINE
> +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && =
\
> +       defined(CONFIG_KASAN_INLINE)
>  /*
>   * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the hig=
h
>   * canonical half of the address space) cause out-of-bounds shadow memor=
y reads

Perhaps this comment also needs to be updated.

> --
> 2.29.2.222.g5d2a92d10f8-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
