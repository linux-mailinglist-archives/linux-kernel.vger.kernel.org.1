Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37242B8D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgKSIhi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 03:37:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2495 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKSIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:37:37 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CcCjD59WWzQm1G;
        Thu, 19 Nov 2020 16:37:20 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 19 Nov 2020 16:37:33 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 19 Nov 2020 16:37:28 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 19 Nov 2020 16:37:28 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: mm: add support for memmap kernel parameters
Thread-Topic: [PATCH] arm64: mm: add support for memmap kernel parameters
Thread-Index: AQHWvXVLtrpWHgsWH0upIuwmJUX89KnNolcAgAAa/ICAAJI6cP//pm8AgACWN3CAAAX+AIAAi9fw
Date:   Thu, 19 Nov 2020 08:37:28 +0000
Message-ID: <6b2a7bfb127f45ac8622919241430875@hisilicon.com>
References: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
 <20201118173854.GA8537@kernel.org> <20201118191528.GA2680@willie-the-truck>
 <1d3780422d2648dfa80a6de87585819a@hisilicon.com>
 <CAMj1kXE-Ea7K_U9JUp2uq+kpmTEYaiKrqMK1J1DOG-UAA3J6ow@mail.gmail.com>
 <0a1de2555ed2458d97e5c79929f74380@hisilicon.com>
 <20201119075722.GC8537@kernel.org>
In-Reply-To: <20201119075722.GC8537@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.226]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Rapoport [mailto:rppt@kernel.org]
> Sent: Thursday, November 19, 2020 8:57 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>; Will Deacon <will@kernel.org>;
> anshuman.khandual@arm.com; catalin.marinas@arm.com; Linuxarm
> <linuxarm@huawei.com>; linux-kernel@vger.kernel.org;
> akpm@linux-foundation.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] arm64: mm: add support for memmap kernel parameters
> 
> On Wed, Nov 18, 2020 at 11:55:33PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > From: Ard Biesheuvel [mailto:ardb@kernel.org]
> > >
> > > On Wed, 18 Nov 2020 at 21:27, Song Bao Hua (Barry Song)
> > > <song.bao.hua@hisilicon.com> wrote:
> > > >
> > > > Good question. Originally I wrote this patch to debug and verify the
> > > vmemmap
> > > > leak issue reported in this patch:
> > > > [PATCH v2] arm64: mm: free unused memmap for sparse memory model
> that
> > > define VMEMMAP
> > > >
> > >
> https://lore.kernel.org/linux-arm-kernel/20200812010655.96339-1-liwei213@
> > > huawei.com/
> > > > I don't have a machine which really has holes in memory_section to
> debug,
> > > but memmap
> > > > can help. With memmap, I could specified a machine with various holds in
> > > mem_sections.
> > > >
> > > > After that, I figured out this is not only useful for debugging purpose. it
> can
> > > have some real user cases.
> > > > For example:
> > > >
> > > > 1. DAX on DRAM.
> > > > kernel parameter memmap=XG!YG specifies a range of RAM to emulate
> > > pmem. Then we are able
> > > > to run DAX and filesystem on top of it. Furthermore, this will probably
> also
> > > benefit the case
> > > > this big patchset wants to "fix" via direct access to memory:
> > > >
> > >
> https://lore.kernel.org/lkml/cover.1602093760.git.yuleixzhang@tencent.com/T
> > > /#m1a77074b8e1dadc590a5f45a52d9c3cda69c0780
> > > > as the comments have clearly shown.
> > > >
> > > > 2. reserve some memory for userspace to manage via /dev/mem
> > > >
> > >
> > > Apologies for the bluntness, but what you are saying here is that you
> > > need a hack to pile those other hacks onto.
> > >
> > > Currently, we use the NOMAP attribute in memblock to describe memory
> > > that is omitted from the direct map. Removing memory from memblock
> > > entirely also strips it of this annotation, which means that
> > > phys_mem_access_prot() will identify it as device memory not DRAM, and
> > > use the wrong attributes when using /dev/mem.
> > >
> > > There are likely other places where this distinction matters, and so I
> > > am not buying the justification that we can make meaningful use of
> > > this memory in the general case, and anything that relies on it will
> > > be fragile, and probably only limited to very specific debug
> > > scenarios.
> >
> > Yep. originally I did that for debugging purpose to emulate a machine with
> > some holes in mem_section. I guess it should be also useful to other people
> > if they need the same thing for debugging.
> >
> > >
> > > So I don't think we should merge this.
> >
> > It should be in the same situation for other platforms like x86, mips and
> xtensa
> > but they have enabled this kernel parameter.
> 
> I didn't check mips and xtensa, but x86 carries this from nineties when
> they needed a way to work around broken BIOSes.
> I really doubt x86 maintainers would merge such feature these days.
> 
> > maybe the emulated pmem by DRAM is an useful scenario other than
> debugging.
> >
> > Later,
> https://lore.kernel.org/lkml/cover.1602093760.git.yuleixzhang@tencent.com/T
> /#m1a77074b8e1dadc590a5f45a52d9c3cda69c0780
> > might be able to use this parameter.
> 
> Using kernel parameters to describe complex memory configuration does
> not seem scalable and maintainable.
> A simple mem=X should be enough for features like dmemfs to start with
> and if/when anything more complex will be required I doubt a kernel
> parameter would fit that purpose.
> 
> Another thing as as soon as we expose this parameter to the user we'd
> have to make sure they can always get the memory layout they defined
> with it. Keeping the kernel parameter in sync with other means of memory
> detection would complicate things on both sides. Ard mentioned NOMAP
> property, there may be some NUMA considerations that could create a
> conflict between what user asked and what is possible and other things
> that may come up in the future.
> 

I agree with you in general. I made this patch for debugging purpose to
emulate all kinds of memory holes in memory section of SPARSE_VMEMMAP. 
memmap is documented in kernel, so I believed that was the way for me to
seek for a generic debug method. This "memmap=" patch on arm64 has helped
me much for debugging. so I guess someone else might have the same
requirement someday, then they can use it. For myself, I haven't used it for
any purpose other than debugging.

So I won't try to convince people to merge this patch any more :-)

Regarding the sync issue between the parameter and the users who need
the memory, pmem emulated by DRAM is doing like this:
each "memmap=A!B" will become a /dev/pmem<index>, users just use
the /dev/pmem0, /dev/pmem1 things and don't need to know the real
address. Of course, it seems this is not that decent too.

> > Anyway, I don't mind keeping it local for debugging at this stage and waiting
> for a
> > more convincing use case.
> >

Thanks
Barry
