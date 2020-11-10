Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B982AD4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgKJLVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:21:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732110AbgKJLV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:21:29 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECEA3207BB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605007288;
        bh=PS/kHAZVQF4vdeKJ/VmmbLCqTWoEVOY/pzMF/p4PlTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uh+3Fb6C6Atqe1voXPCA2r1FLJs72jKHGSr7B6kbIXsy78QkqElOGKvZv5BdekvWx
         lzjf9rrEmqnFeLs+N6vmnXA7mJSWOTIEJJgwAcoMWQ5bay60wvJFT355zkxWYuI93e
         VFOAzv80wFRQCVrq27haai3hE46vNHO62KFcpXE0=
Received: by mail-ot1-f44.google.com with SMTP id 79so12095951otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 03:21:27 -0800 (PST)
X-Gm-Message-State: AOAM531PJKMgCtWh6Gg/qG8NCxRKxSyugAGnRAOmaP8jqYMDAVqJNj3l
        5wjEtqrKU6yPyjXeV95tMJFZVDv/W8lM06Ni0zE=
X-Google-Smtp-Source: ABdhPJydWZ+qVqjNBQKB7NRqQskTI00kbru8Yb5/ZqvL2ydH3aQAWKPfoTlgG1dw2AtliyGv5WSBYdJxp7kkZUtof5M=
X-Received: by 2002:a9d:23a6:: with SMTP id t35mr13003260otb.210.1605007287164;
 Tue, 10 Nov 2020 03:21:27 -0800 (PST)
MIME-Version: 1.0
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org> <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
In-Reply-To: <20201110095806.GH301837@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 10 Nov 2020 12:21:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
Message-ID: <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:58 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > asm/sparsemem.h is not available on some architectures.
> > > It's better to use linux/mmzone.h instead.

Ah, I missed that, too.

> > Hm, linux/mmzone.h only includes asm/sparsemem.h when CONFIG_SPARSEMEM
> > is enabled. However, on ARM at least I can have configurations without
> > CONFIG_SPARSEMEM and physical address extension on (e.g.
> > multi_v7_defconfig + CONFIG_LPAE + CONFIG_ZSMALLOC).
> >
> > While sparsemem seems to be a good idea with LPAE it really seems not
> > required (see also https://lore.kernel.org/patchwork/patch/567589/).
> >
> > There seem to be also other architectures which define MAX_PHYSMEM_BITS
> > only when SPARSEMEM is enabled, e.g.
> > arch/riscv/include/asm/sparsemem.h...
> >
> > Not sure how to get out of this.. Maybe make ZSMALLOC dependent on
> > SPARSEMEM? It feels a bit silly restricting ZSMALLOC selection only due
> > to a compile time define...
>
> I think we can define MAX_POSSIBLE_PHYSMEM_BITS in one of
> arch/arm/inclide/asm/pgtable-{2,3}level-*.h headers to values supported
> by !LPAE and LPAE.

Good idea. I wonder what other architectures need the same though.
Here are some I found:

$ git grep -l PHYS_ADDR_T_64BIT arch | grep Kconfig
arch/arc/Kconfig
arch/arm/mm/Kconfig
arch/mips/Kconfig
arch/powerpc/platforms/Kconfig.cputype
arch/x86/Kconfig

arch/arc has a CONFIG_ARC_HAS_PAE40 option
arch/riscv has 34-bit addressing in rv32 mode
arch/mips has up to 40 bits with mips32r3 XPA, but I don't know what
    supports that

arch/powerpc has this:
config PHYS_64BIT
        bool 'Large physical address support' if E500 || PPC_86xx
        depends on (44x || E500 || PPC_86xx) && !PPC_83xx && !PPC_82xx

Apparently all three (4xx, e500v2, mpc86xx/e600) do 36-bit physical
addressing, but each one has a different page table format.

Microblaze has physical address extensions, but neither those nor
64-bit mode have so far made it into the kernel.

To be on the safe side, we could provoke a compile-time error
when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.

> That's what x86 does:
>
> $ git grep -w MAX_POSSIBLE_PHYSMEM_BITS arch/
> arch/x86/include/asm/pgtable-3level_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS   36

Doesn't x86 also support a 40-bit addressing mode? I suppose
those machines that actually used it are long gone.

> arch/x86/include/asm/pgtable_64_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS       52
>
> It seems that actual numbers would be 36 for !LPAE and 40 for LPAE, but
> I'm not sure about that.

Close enough, yes.

The 36-bit addressing is on !LPAE is only used for early static mappings,
so I think we can pretend it's always 32-bit. I checked the ARMv8 reference,
and it says that ARMv8-Aarch32 actually supports 40 bit physical addressing
both with non-LPAE superpages (short descriptor format) and LPAE (long
descriptor format), but Linux only does 36-bit addressing on superpages
as specified for ARMv6/ARMv7 short descriptors.

       Arnd
