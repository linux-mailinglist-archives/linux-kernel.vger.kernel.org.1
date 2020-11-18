Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECACA2B8126
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgKRPs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgKRPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:48:26 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C2C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:48:26 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so2155596qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KBY9We200Ww5HcRzOJ8cRuFVemnXKCvdsbdmO5AOcVM=;
        b=DjawgnSVG89v7wr/Gr+ltHDb4OHdbCIcsLmE8BSZ9tbwftIu5Zmki058cO7+lb7okR
         6cijOLq6V3iYcVEEcbw6xoXc+h5jsX5Eo/oWe8sbXBiJ7f4752VjcYXa0x/S43fRXkLL
         zkjaaTz50pUAURSTTBoiHWyu8yF9++Vf9wHhkFgVP98WMg4MUN9eRTte6A4gRFSb00To
         eqKLbIiWIY/XVfFplPBAy/27PgHe+PMGwSqsIVhRP4OKYL5L/MJiqIKrlgE4aH8t2iCV
         w7+oJbrogWRt1faTIiSfOxN+xZSwOS7kJbhszobWU8FX1wzQrNN8fEf90RR9wP8vFoFI
         HrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KBY9We200Ww5HcRzOJ8cRuFVemnXKCvdsbdmO5AOcVM=;
        b=fW+kOOSMH6LkXH4hlFi/BRXl7wxaHo2CYXKUJ9wm+MnoMWEhyko1sAse2XZkU9vCZI
         qeIyEQJYN0AieT8SW+tuYuGBGLehrb+XtP4tS7+PoKKCggjSYEJP8QPmwSAbZ5qAT6tg
         J+Ra1peR5DH0yoasQaokka+V763ny/vVpbL/st0I4Hy3Mvyb5RPxELztiTc+Y0uaqEd+
         6yajCNutKA96ldyhez6JIlWcqAIhgfzCuqYhYg5vfx6x3IRDz/lViOvLtZe1mKZrNlwp
         a4xi5+17QWIJQ5zzMZsWNvWLfAWzL+peaEgeuOgOLsrV+v823PpjcDchZG8GcENoXJ/r
         aM3w==
X-Gm-Message-State: AOAM532KlksftATpfPONcwXUsvcxfy0xpIMnqolrFk6cmZ/VzkiMP80O
        93mdZpmTlDCBpxuSB1lk2XojY3DQIb8WCoNJgkEVSA==
X-Google-Smtp-Source: ABdhPJx/yfnNmN5TGe9kEOUkbx1+PLi7+syOg6mYKxBY4pNTXfABG02vtqlLmbV0ea5DKMsuqcGeEOpGyMthWDxuCzk=
X-Received: by 2002:a37:b545:: with SMTP id e66mr5394773qkf.392.1605714505255;
 Wed, 18 Nov 2020 07:48:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com> <ba9dc492214fea3a88e05544bb0697b3237e743e.1605305705.git.andreyknvl@google.com>
In-Reply-To: <ba9dc492214fea3a88e05544bb0697b3237e743e.1605305705.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 18 Nov 2020 16:48:14 +0100
Message-ID: <CAG_fn=X4Wpn3oTUwgRPHXnWtBQtmH3VURbzpC5=xiDtzGw2bcg@mail.gmail.com>
Subject: Re: [PATCH mm v10 24/42] arm64: Enable armv8.5-a asm-arch option
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:17 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Hardware tag-based KASAN relies on Memory Tagging Extension (MTE) which
> is an armv8.5-a architecture extension.
>
> Enable the correct asm option when the compiler supports it in order to
> allow the usage of ALTERNATIVE()s with MTE instructions.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
> Change-Id: I172e15e4c189f073e4c14a10276b276092e76536
> ---
>  arch/arm64/Kconfig  | 4 ++++
>  arch/arm64/Makefile | 5 +++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c999da4f2bdd..b7d1f1a5705d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1591,6 +1591,9 @@ endmenu
>
>  menu "ARMv8.5 architectural features"
>
> +config AS_HAS_ARMV8_5
> +       def_bool $(cc-option,-Wa$(comma)-march=3Darmv8.5-a)
> +
>  config ARM64_BTI
>         bool "Branch Target Identification support"
>         default y
> @@ -1665,6 +1668,7 @@ config ARM64_MTE
>         bool "Memory Tagging Extension support"
>         default y
>         depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
> +       depends on AS_HAS_ARMV8_5
>         select ARCH_USES_HIGH_VMA_FLAGS
>         help
>           Memory Tagging (part of the ARMv8.5 Extensions) provides
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 5789c2d18d43..50ad9cbccb51 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -100,6 +100,11 @@ ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
>  asm-arch :=3D armv8.4-a
>  endif
>
> +ifeq ($(CONFIG_AS_HAS_ARMV8_5), y)
> +# make sure to pass the newest target architecture to -march.
> +asm-arch :=3D armv8.5-a
> +endif
> +
>  ifdef asm-arch
>  KBUILD_CFLAGS  +=3D -Wa,-march=3D$(asm-arch) \
>                    -DARM64_ASM_ARCH=3D'"$(asm-arch)"'
> --
> 2.29.2.299.gdc1121823c-goog
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
