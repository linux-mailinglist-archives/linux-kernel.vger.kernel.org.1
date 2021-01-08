Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7812EF762
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbhAHSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbhAHSbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:31:24 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F29DC0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:30:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id m6so6769786pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QMtgJrbmi2Dq7xj4bsuhnhgijvRCuVpV/hWagawzWvg=;
        b=NtitF2diZ560VjUqe0aNEmnGnCs9j/OcQDpd7obF4GWgSzxReXHWFgsLG5uZDxRaAK
         X1DFXpWiVX/2j6DXeOECWut1VLvH6JvH4osI5ORI7YpkxZEwZqRAiAG8hdW1JzaXcXki
         1gY1bcNmz91Rf+MF3bt81LWkFTuQ3uJH/z52LZ2MYoapANxl2lO5E2Ckws8FPCS3MkDn
         yCkEOlFMJp8zuATAhPXOhLc00WHUwBjInJ1pMTemnqy7GHRH0qkUqwJs7JScsb2H91kZ
         S7LJaUE0xSS6L5lkVN3wmRJ6FPiAYINlGZINGhD/Uy5sur/SVdr0j9BuRzSpcysjUp5V
         0R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMtgJrbmi2Dq7xj4bsuhnhgijvRCuVpV/hWagawzWvg=;
        b=ro9cT9yhFWnvkNG/LKSBJhbAC2sA8Doy+1RYTT/abdpk1tGckQJfsFRfzN/1kx3AoC
         1Hv7Q/sHAiroLFU44yFsGvEKT70Nr/tVZGKEG3RA2CAlFvWHVe+e0hIkOlDxmtyJR4Ue
         DYg7dxvKsJyqs2bDCDS1Sq9c9LNBp6gy6FPP6faNvjo0PCD29FJRHV09fIdpjeoU4R8X
         3zVnC3+m+6Z5Ka+5dYi8QoLRv+OpvtlvVEQwPDh8z3b2vkBHG9A+73COL++Ixm3A/Hbr
         qO2wrgy/0ad9hVFChc3xOtj//TyP1Y+l6Dnz1qnFLZ2IoLQQk/Yxuoa7qyFvKitZ1ai4
         j3mA==
X-Gm-Message-State: AOAM5324udocngG9LA7XbmtwBpcgpyHcPTx9fx7p8vwv81WJhdV7EUao
        jHqPEq4JD3248G+/qLcOL/mf3o58KP4pwZO1elcBVg==
X-Google-Smtp-Source: ABdhPJyzXMLihNJTmJ4IbqcbioPlGJ22BZ5FodpxuPX9jp6mXZvP5h1beqwhyEPhGYRAZ+ZRoqih0ksqWm0v9X52OkM=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr4942892pfh.24.1610130643942; Fri, 08 Jan
 2021 10:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20210103171137.153834-1-lecopzer@gmail.com>
In-Reply-To: <20210103171137.153834-1-lecopzer@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 8 Jan 2021 19:30:33 +0100
Message-ID: <CAAeHK+y=vEuSe-LFOhxkEu4x0Dy2jYts18R0V6Pbv1-5Cwg9_g@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: kasan: support CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 6:12 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
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
> It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL,
> but not test for HW_TAG(I have no proper device), thus keep
> HW_TAG and KASAN_VMALLOC mutual exclusion until confirming
> the functionality.
>
>
> [1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")
>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>

Hi Lecopzer,

Thanks for working on this!

Acked-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>

for the series along with the other two patches minding the nit in patch #3.

Will, Catalin, could you please take a look at the arm changes?

Thanks!
