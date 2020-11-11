Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328C72AF581
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgKKPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKKPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:53:14 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F7C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:53:13 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so2054605qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vRyAuwdRnLChBCBVFGTKtTcLQ1KujUMWRxgegUE/csw=;
        b=eNIdoik2auBvbeQYmWPz0kJqW6IQFCpCkajeE2HOzgsScRJC2MtR3ebHwzbvOlZYDE
         kQwHYAigewhLNATkbarT7JhAny9sC0sDqb35ofvQfTMYnI/WAX36P2tyYfGWOKh/GT8y
         1vzpcmB6OaCYQNU40d5y7o0OiASJZtPSKdfLP+i0EfaQT1pzfhXXpU3NB0ST+RlRSE5s
         RstTZaaIpTclcDobVyw3Zliym8vOVH4vY6sCM/gPIxogmxPl1osALQSxUoX2YX/T/9h4
         gD//4L9L9ybqoB6Xz9FkoN9OOheZ1VOWo3bazsSTyxtb0ry9ijPIcKi3pYcvLa3G4NBE
         o/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vRyAuwdRnLChBCBVFGTKtTcLQ1KujUMWRxgegUE/csw=;
        b=PYkeAiV52nlJfwOTmjOlQc0itbrQn8Eybr0wdHJoB9oBZAZJrSa4vYZpyCCSV6fGQJ
         TrVIqQf3XG/jaSK91wKE3qtvt3J8+dhEXLzaxkks3ztfftizd9yFfhkj+XH+NpK36EaO
         d5RMGsmanVmUZoFLafPF+wkg5GPtC2Q6+59UPUehprnPqgZWTTrtxUxLGfDKp2lnQa5n
         VxSAcSNzWDTHXNzbp4d8HU+jGlPsS/rTL3NEhaYLc/uI9KPc3WUDNaE+bQ346LeWFUuE
         sHK9JgyEu8RFXKeUng8jDgOTckM6uNVO7wEVQDwnoR2A0w8mj1LkMxYh3G3iB9roDVpa
         Ijmg==
X-Gm-Message-State: AOAM533clQTqoPlEA+ajmUBKXdYAwjRLQtSntAoKGTwiPAIz9E2niqz0
        tuKubDZvCkR7h5pIBNWJdlsfP9V54Lm+Nomo+DXVmg==
X-Google-Smtp-Source: ABdhPJxNlfRr+d27x7ds3kYfz4Vaet62rX3/WapVLgoXO9ea4Taf/i/gwJ+XXy7eFkysWRMoTyt8gfP91CUOFe7vd9U=
X-Received: by 2002:a37:bf04:: with SMTP id p4mr26719528qkf.326.1605109991955;
 Wed, 11 Nov 2020 07:53:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <67c17dafa28036b628234c8f1d88368af374449c.1605046192.git.andreyknvl@google.com>
In-Reply-To: <67c17dafa28036b628234c8f1d88368af374449c.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:52:59 +0100
Message-ID: <CAG_fn=UmcSrfwvuh36EXj-H1ZkwGxmVwqCm8GD5XZdkqOWpqAA@mail.gmail.com>
Subject: Re: [PATCH v9 24/44] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
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

On Tue, Nov 10, 2020 at 11:12 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Software tag-based KASAN provides its own tag checking machinery that
> can conflict with MTE. Don't allow enabling software tag-based KASAN
> when MTE is enabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..25ead11074bf 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -134,7 +134,7 @@ config ARM64
>         select HAVE_ARCH_JUMP_LABEL
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> -       select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> +       select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_MMAP_RND_BITS
>         select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/67c17dafa28036b628234c8f1d88368af374449c.1605046192.git.andreyk=
nvl%40google.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
