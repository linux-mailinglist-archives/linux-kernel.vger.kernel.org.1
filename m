Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BAA2EF79C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbhAHSma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbhAHSma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:42:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46CA623A82
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610131309;
        bh=tkonPwlabkLXLyMxiiESIjCklszdN86fUImv8DVDBWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IKNY7oVKNuPzRros5fM/7vBHlMCNd4HwHKfOex1gRPKTK/iE9/h3miejxLoeRK+hV
         gov7ITt3IDhunwKV/Iz3vOI5SlXIaYPrwvIdhyRzrdYlw1XSozjVOc6qCP5P8WdLwI
         7Lwz9a8ssTBS9ZW4gzUcskhNHOiS+arAsFVxq9eqJ1dI2JsFRaJdTSzH6EQEF1zkru
         ysWcgcurunZxBLSj6LwtoTQN+67QHuwoH5st5XI1lCeR7qjxFv6ENJYmHY7wm5M8BB
         ruvlLpCCbDMM0LhohoDGaL6NOOj+7OnHxIwwCeRItOgSALMPRJ+qb+Rj+Y1jIgWm7L
         F4fr9OSbx+cxA==
Received: by mail-oi1-f182.google.com with SMTP id 9so12408039oiq.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:41:49 -0800 (PST)
X-Gm-Message-State: AOAM531UtJFlBhIw6B+CZfyJdwmp96sQUm7L4DktwqJJn6nzkfl+VVvx
        oWlhe45xIcwckUlcUD8TeI1AC1VdSebic3ENNsY=
X-Google-Smtp-Source: ABdhPJyF6RpCzxKa/lecY4GdxCfZbTUh3I+6FsPQwG/WCqXte4+mxyac9+wbRo4e2HSt3x5nd8cXBeC7aZkaX3l5ptc=
X-Received: by 2002:aca:d98a:: with SMTP id q132mr3228281oig.33.1610131308441;
 Fri, 08 Jan 2021 10:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20210103171137.153834-1-lecopzer@gmail.com> <CAAeHK+y=vEuSe-LFOhxkEu4x0Dy2jYts18R0V6Pbv1-5Cwg9_g@mail.gmail.com>
In-Reply-To: <CAAeHK+y=vEuSe-LFOhxkEu4x0Dy2jYts18R0V6Pbv1-5Cwg9_g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 8 Jan 2021 19:41:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHFOQMV_4pYp9u9u++2jjQbHuLU95KeJTzrWXZWQTe_Tg@mail.gmail.com>
Message-ID: <CAMj1kXHFOQMV_4pYp9u9u++2jjQbHuLU95KeJTzrWXZWQTe_Tg@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: kasan: support CONFIG_KASAN_VMALLOC
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Lecopzer Chen <lecopzer@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        yj.chiang@mediatek.com, linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 19:31, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Sun, Jan 3, 2021 at 6:12 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
> >
> > Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > ("kasan: support backing vmalloc space with real shadow memory")
> >
> > Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> > but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> > by not to populate the vmalloc area except for kimg address.
> >
> > Test environment:
> >     4G and 8G Qemu virt,
> >     39-bit VA + 4k PAGE_SIZE with 3-level page table,
> >     test by lib/test_kasan.ko and lib/test_kasan_module.ko
> >
> > It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL,
> > but not test for HW_TAG(I have no proper device), thus keep
> > HW_TAG and KASAN_VMALLOC mutual exclusion until confirming
> > the functionality.
> >
> >
> > [1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")
> >
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
>
> Hi Lecopzer,
>
> Thanks for working on this!
>
> Acked-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
>
> for the series along with the other two patches minding the nit in patch #3.
>
> Will, Catalin, could you please take a look at the arm changes?
>
> Thanks!
>


If vmalloc can now be backed with real shadow memory, we no longer
have to keep the module region in its default location when KASLR and
KASAN are both enabled.

So the check on line 164 in arch/arm64/kernel/kaslr.c should probably
be updated to reflect this change.
