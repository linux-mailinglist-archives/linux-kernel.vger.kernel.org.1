Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D48300C83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbhAVTYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbhAVTFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:05:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB2023AC1;
        Fri, 22 Jan 2021 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611342308;
        bh=+qH3gg6Meer9DE4CWsvTMl0NEy6N7sOI6C6cFplb2Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAhzpczDkGt+4Q3wMOMG4ZZXBOvrjUmqZqNB6yHgubCMaaFUJ6/FOXNv20BtOGbEL
         y+0kx3bop4iL/FKIG8N8x6obiAHhfyoeT2tZwJkqqiMHoV3Ll5eanEyHXSq61pADAo
         KuCY+6gOu7i7M+fEjba1vK0mXIcdQFNTowLMDJ2h3KdJDBgGUZAyd0pY8nUG9Iaota
         bsOyCWRnhpVW/I2fYed0GkkovQdB2bQ5IzATRdp2a8isQwbRqwA50nvq+AtGfCzZ4g
         gCHP89gVZ0e6MmQ0GnM4WiYyK3n6kurG0uNXOXYFvnWOjXbiNt/EOJg3yhrdYXOZgU
         Vko9JDUN8/sgA==
Date:   Fri, 22 Jan 2021 19:05:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
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
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
Message-ID: <20210122190501.GA25471@willie-the-truck>
References: <20210109103252.812517-1-lecopzer@gmail.com>
 <CAAeHK+z3oYx4WqX7Xor7gD=eqYkzW0UBS4h4is00HnfNnNkpDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+z3oYx4WqX7Xor7gD=eqYkzW0UBS4h4is00HnfNnNkpDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:44:14PM +0100, Andrey Konovalov wrote:
> On Sat, Jan 9, 2021 at 11:33 AM Lecopzer Chen <lecopzer@gmail.com> wrote:
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
> > It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL
> > and randomize module region inside vmalloc area.
> >
> >
> > [1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")
> >
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > Acked-by: Andrey Konovalov <andreyknvl@google.com>
> > Tested-by: Andrey Konovalov <andreyknvl@google.com>
> >
> >
> > v2 -> v1
> >         1. kasan_init.c tweak indent
> >         2. change Kconfig depends only on HAVE_ARCH_KASAN
> >         3. support randomized module region.
> >
> > v1:
> > https://lore.kernel.org/lkml/20210103171137.153834-1-lecopzer@gmail.com/
> >
> > Lecopzer Chen (4):
> >   arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
> >   arm64: kasan: abstract _text and _end to KERNEL_START/END
> >   arm64: Kconfig: support CONFIG_KASAN_VMALLOC
> >   arm64: kaslr: support randomized module area with KASAN_VMALLOC
> >
> >  arch/arm64/Kconfig         |  1 +
> >  arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
> >  arch/arm64/kernel/module.c | 16 +++++++++-------
> >  arch/arm64/mm/kasan_init.c | 29 +++++++++++++++++++++--------
> >  4 files changed, 41 insertions(+), 23 deletions(-)
> >
> > --
> > 2.25.1
> >
> 
> Hi Will,
> 
> Could you PTAL at the arm64 changes?

Sorry, wanted to get to this today but I ran out of time in the end. On the
list for next week!

Will
