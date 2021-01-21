Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478962FF246
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbhAURps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbhAURpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:45:08 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E211C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:44:27 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o17so3716512lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGFFrNGI7jcGt2Ckr0yJXz+AGAE1X7qRw3reHpjfkCo=;
        b=J12Eeog0Fmap+TFn4o/BsRtL7RlGoYr9aj69/43ryqDeIrWZz8O6eH3sz5fK53lCfO
         qnr/dqzpguIc3RrhDca00qs4rrR0tqou94HFCsKOtEhd6HDtMGGi54t6i46TsgWVebuX
         jKtbmWIYK6O0f/MtgRBg3y4uGtbSbHc2ls/2t51tJbSZYZRBJXCaPqDZnq6snLtBxBEi
         hMB6HkZ19FL5DDJDI2OYkePCcK2PizBGXnk+KQuX26g1Qc6qJyN4wPWHML2sUt4qKUHq
         HxWsl17O7gfL/vzw25lb5ywfX54GGxZK23gwpTeixXxKkOCl/TYKKeCU11uxcI60XHEC
         /vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGFFrNGI7jcGt2Ckr0yJXz+AGAE1X7qRw3reHpjfkCo=;
        b=bXlzzt5BGIqVYxD1AFIJQfaJs32v11YfGg+lE5j5GnJiiMS0MPPWPD2p9FbJ+e3WlZ
         w1xbq8iyGoHCtDf2/q8Bc2lwJG7GYeVwzy2lWdiN+RRbJ45KpQfLc73vXp2c9TKp3GUM
         Zyk2il/sTCrRHEpRKp5eetF0qJU+J36CDd0tdOE2Kjgv02CbjNd9flhfm9kGMkLnmXqU
         RtAnM4EZIrr72vY1X1PjDGmJUeXu+3R1J2l8sU0V2LzqUj9f54U5btAjPIkg7W+rmvC6
         rTOfbHlXacCLR+SbdAN6HXV/fOd7b/HS6eyztGgoD416XFs/7DaKYxojhZAfr2b+tu7n
         DU7Q==
X-Gm-Message-State: AOAM532diBsGToojAOyk0eCJXP0dI3B8mwJBrnOU/TmDZBBhx2ePZ4CU
        XTIgCOnIjTkAg4+u8e705itkVScedv1jtFiWqBGnXQ==
X-Google-Smtp-Source: ABdhPJz1rdXjr4kjJRfAIPtA5v/PBKyGfr+IQ8wFx1vJw2FImN+X5pXM0D8QGr3CCQmd07fO+vj8gob8yfyQ4f+xWfg=
X-Received: by 2002:a19:434e:: with SMTP id m14mr162866lfj.73.1611251065593;
 Thu, 21 Jan 2021 09:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20210109103252.812517-1-lecopzer@gmail.com>
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 18:44:14 +0100
Message-ID: <CAAeHK+z3oYx4WqX7Xor7gD=eqYkzW0UBS4h4is00HnfNnNkpDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, yj.chiang@mediatek.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, rppt@kernel.org,
        tyhicks@linux.microsoft.com, Robin Murphy <robin.murphy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        gustavoars@kernel.org, Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 11:33 AM Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
>
> Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> by not to populate the vmalloc area except for kimg address.
>
> Test environment:
>     4G and 8G Qemu virt,
>     39-bit VA + 4k PAGE_SIZE with 3-level page table,
>     test by lib/test_kasan.ko and lib/test_kasan_module.ko
>
> It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL
> and randomize module region inside vmalloc area.
>
>
> [1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")
>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Acked-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
>
>
> v2 -> v1
>         1. kasan_init.c tweak indent
>         2. change Kconfig depends only on HAVE_ARCH_KASAN
>         3. support randomized module region.
>
> v1:
> https://lore.kernel.org/lkml/20210103171137.153834-1-lecopzer@gmail.com/
>
> Lecopzer Chen (4):
>   arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
>   arm64: kasan: abstract _text and _end to KERNEL_START/END
>   arm64: Kconfig: support CONFIG_KASAN_VMALLOC
>   arm64: kaslr: support randomized module area with KASAN_VMALLOC
>
>  arch/arm64/Kconfig         |  1 +
>  arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
>  arch/arm64/kernel/module.c | 16 +++++++++-------
>  arch/arm64/mm/kasan_init.c | 29 +++++++++++++++++++++--------
>  4 files changed, 41 insertions(+), 23 deletions(-)
>
> --
> 2.25.1
>

Hi Will,

Could you PTAL at the arm64 changes?

Thanks!
