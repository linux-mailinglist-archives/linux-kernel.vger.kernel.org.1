Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01E729AC77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbgJ0Mtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:49:33 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34907 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbgJ0Mtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:49:32 -0400
Received: by mail-qv1-f65.google.com with SMTP id cv1so562124qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUlB37L5+bTkXv9HMzvRMeckvAGtdpURfCakqFt5pOg=;
        b=MHrMfR8gD67uaEXgoyHF4Xe1ll0z3oEq0uMIFzhw0Mkh2fJEtefIVLQPdIDGyyYqIQ
         6wVkDBNlOZSUhj9A4tZZupar4Ofyp4Wh0355ubNBKVSRCdq7EHN59VZVi1uf0Jrq2a1z
         s4rwuX6sj2kw8SVW2ZWaK5dC0xx2yttlCVA+NzezVv+HSy3h71NlbacAsNhIE8Nqzhe0
         IYKKA4vINkwRhcVC8gBW7B0eamAlUDn1Z/i07ku8YsyS6ycIqh4h37L+rrBpARB8Kl5l
         uboVkt4bcyuFQ6fHMCGERlzVk/tGrR3zpa3sQZHF2OUUHz8ouW4rQwufg09PONxZRprf
         jeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUlB37L5+bTkXv9HMzvRMeckvAGtdpURfCakqFt5pOg=;
        b=TGxfvL0bfQrSBsh/IzUjtZK7tb6KhqXjLrd7Op3t3ZlGy+i+rwoLXYWrPzxunI/1qA
         6HERuDH17iUYlPOCkUChQLhXkCfxKRlw2QcxR60FAZgQSMyOHi00B8WauZo3nVHu068D
         sFIWg9U4UdS+DMEPe17w4FeYpfRwwUdqha9i6WJAYqQFVCFA1z8LfpPjPBD8kwA0NTNi
         r+s9p2m1Df68SycL2lDC7JXCDkPfgnrizR9wrY2TwL2a8MIrREHIg6GZtZYGdDHmsqUS
         REqlLEfkgBK4te9fqAS1rVjWW/kZgHLa4+9QxYSi/1b1CvsVu7k/xKxDNjJ/Ug5bA3If
         dSJw==
X-Gm-Message-State: AOAM530j9txzRB7XqN42OjDRyubPXInQXRMEi1B5HeuCZrf/KxyG76PG
        lDMjnt165CNslhxEPutW1GJlawPxnDTUVpFZ02UrJw==
X-Google-Smtp-Source: ABdhPJzQ+nWuuT5N2rgHn62pl+Y/AW3lHnBNJYsa/hHtYiCdc5nXPF8QN6oZsONfp2UqMq5Fi1oe00xruCnbhefGXO4=
X-Received: by 2002:a0c:ba2a:: with SMTP id w42mr1901434qvf.23.1603802970306;
 Tue, 27 Oct 2020 05:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <1049f02fb4132390a6a314eb21dccfe5500e69d6.1603372719.git.andreyknvl@google.com>
In-Reply-To: <1049f02fb4132390a6a314eb21dccfe5500e69d6.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Oct 2020 13:49:19 +0100
Message-ID: <CACT4Y+a8e3c54Bzf5r2zhoC-cPziaVR=r89ONxrp9gx9arhrnw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/21] kasan: allow VMAP_STACK for HW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Even though hardware tag-based mode currently doesn't support checking
> vmalloc allocations, it doesn't use shadow memory and works with
> VMAP_STACK as is.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..3caf7bcdcf93 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -868,7 +868,7 @@ config VMAP_STACK
>         default y
>         bool "Use a virtually-mapped stack"
>         depends on HAVE_ARCH_VMAP_STACK
> -       depends on !KASAN || KASAN_VMALLOC
> +       depends on !(KASAN_GENERIC || KASAN_SW_TAGS) || KASAN_VMALLOC

I find it a bit simpler to interpret:

    depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC

due to simpler structure. But maybe it's just me.

>         help
>           Enable this if you want the use virtually-mapped kernel stacks
>           with guard pages.  This causes kernel stack overflows to be
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
