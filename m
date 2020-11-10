Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9152AD617
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgKJMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgKJMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:22:29 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:22:29 -0800 (PST)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AF4A95C2D98;
        Tue, 10 Nov 2020 13:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1605010940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsKAQhsjBAFRDGDj3c5k8MVs+xkOLwwQU+TEcjoUYn8=;
        b=bbp/I2FtCw6mOgT0qPJOd3lzI/1lpJiWfOcaEXzLWCwaI05gsT515QaI/aTSdOsajR8w9E
        ZGrP/D9lcA8UxuKm/CiMj5uvOLIv+wiW86w8q4BdBELTv50eEKJGRL/EL3HJKwKTyrG6HJ
        FPEKZ4Wg6uBj+0JGfRYgkY8wG5eSMSU=
MIME-Version: 1.0
Date:   Tue, 10 Nov 2020 13:22:20 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
In-Reply-To: <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
 <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <48fdc3631bc74dd77fea1a30085c8af9@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Russell King for ARM]

On 2020-11-10 12:21, Arnd Bergmann wrote:
> On Tue, Nov 10, 2020 at 10:58 AM Mike Rapoport <rppt@kernel.org> wrote:
>> > >
>> > > asm/sparsemem.h is not available on some architectures.
>> > > It's better to use linux/mmzone.h instead.
> 
> Ah, I missed that, too.
> 
>> > Hm, linux/mmzone.h only includes asm/sparsemem.h when CONFIG_SPARSEMEM
>> > is enabled. However, on ARM at least I can have configurations without
>> > CONFIG_SPARSEMEM and physical address extension on (e.g.
>> > multi_v7_defconfig + CONFIG_LPAE + CONFIG_ZSMALLOC).
>> >
>> > While sparsemem seems to be a good idea with LPAE it really seems not
>> > required (see also https://lore.kernel.org/patchwork/patch/567589/).
>> >
>> > There seem to be also other architectures which define MAX_PHYSMEM_BITS
>> > only when SPARSEMEM is enabled, e.g.
>> > arch/riscv/include/asm/sparsemem.h...
>> >
>> > Not sure how to get out of this.. Maybe make ZSMALLOC dependent on
>> > SPARSEMEM? It feels a bit silly restricting ZSMALLOC selection only due
>> > to a compile time define...
>>
>> I think we can define MAX_POSSIBLE_PHYSMEM_BITS in one of
>> arch/arm/inclide/asm/pgtable-{2,3}level-*.h headers to values supported
>> by !LPAE and LPAE.

Hm I see mm/zsmalloc.c really only needs to know how many bits are
potentially used to calculate how many bits it can use for object
indexing.

> 
> Good idea. I wonder what other architectures need the same though.
> Here are some I found:
> 
> $ git grep -l PHYS_ADDR_T_64BIT arch | grep Kconfig
> arch/arc/Kconfig
> arch/arm/mm/Kconfig
> arch/mips/Kconfig
> arch/powerpc/platforms/Kconfig.cputype
> arch/x86/Kconfig
> 
> arch/arc has a CONFIG_ARC_HAS_PAE40 option
> arch/riscv has 34-bit addressing in rv32 mode
> arch/mips has up to 40 bits with mips32r3 XPA, but I don't know what
>     supports that
> 
> arch/powerpc has this:
> config PHYS_64BIT
>         bool 'Large physical address support' if E500 || PPC_86xx
>         depends on (44x || E500 || PPC_86xx) && !PPC_83xx && !PPC_82xx
> 
> Apparently all three (4xx, e500v2, mpc86xx/e600) do 36-bit physical
> addressing, but each one has a different page table format.
> 
> Microblaze has physical address extensions, but neither those nor
> 64-bit mode have so far made it into the kernel.
> 
> To be on the safe side, we could provoke a compile-time error
> when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> 
>> That's what x86 does:
>>
>> $ git grep -w MAX_POSSIBLE_PHYSMEM_BITS arch/
>> arch/x86/include/asm/pgtable-3level_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS   36
> 
> Doesn't x86 also support a 40-bit addressing mode? I suppose
> those machines that actually used it are long gone.
> 
>> arch/x86/include/asm/pgtable_64_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS       52
>>
>> It seems that actual numbers would be 36 for !LPAE and 40 for LPAE, but
>> I'm not sure about that.
> 
> Close enough, yes.
> 
> The 36-bit addressing is on !LPAE is only used for early static mappings,
> so I think we can pretend it's always 32-bit. I checked the ARMv8 reference,
> and it says that ARMv8-Aarch32 actually supports 40 bit physical addressing
> both with non-LPAE superpages (short descriptor format) and LPAE (long
> descriptor format), but Linux only does 36-bit addressing on superpages
> as specified for ARMv6/ARMv7 short descriptors.

Oh so, more than 4GB of memory can be supported by !LPAE systems via
superpages? Wasn't aware of that.

Since only ARM_LPAE selects CONFIG_PHYS_ADDR_T_64BIT it really is safe
to assume 32 bits for non-LPAE systems.

I guess that would mean adding a #define MAX_POSSIBLE_PHYSMEM_BITS 32 to
arch/arm/include/asm/pgtable-2level.h and a MAX_POSSIBLE_PHYSMEM_BITS 40
in arch/arm/include/asm/pgtable-3level.h. Seems straight forward and
would solve the problem I had. I can prepare a patch for ARM, not sure
about the other architectures...

--
Stefan
