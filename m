Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C822B8CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKSH5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSH5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:57:31 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418E52220B;
        Thu, 19 Nov 2020 07:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605772650;
        bh=gOXz1u76tWhkvKp6lt1lxVqTdmPvAJOuOUyzXoABdes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrazXTMrRpQpk3FBERDS4HgvufWUdlOuxH113+vXxRKCyNjPiwCeJ8499H4Ot3JWk
         xTAEuBPVpEglWKCNb36P/Hlu63w2G19v65+QiqIwdJ8NgP/QO9ylojUT/HuKKUKNXl
         mVaeJ74KLAyTUymZt1ZzNTR9XmHV2pE+3d6+H4wg=
Date:   Thu, 19 Nov 2020 09:57:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: mm: add support for memmap kernel parameters
Message-ID: <20201119075722.GC8537@kernel.org>
References: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
 <20201118173854.GA8537@kernel.org>
 <20201118191528.GA2680@willie-the-truck>
 <1d3780422d2648dfa80a6de87585819a@hisilicon.com>
 <CAMj1kXE-Ea7K_U9JUp2uq+kpmTEYaiKrqMK1J1DOG-UAA3J6ow@mail.gmail.com>
 <0a1de2555ed2458d97e5c79929f74380@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1de2555ed2458d97e5c79929f74380@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:55:33PM +0000, Song Bao Hua (Barry Song) wrote:
> > From: Ard Biesheuvel [mailto:ardb@kernel.org]
> > 
> > On Wed, 18 Nov 2020 at 21:27, Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com> wrote:
> > >
> > > Good question. Originally I wrote this patch to debug and verify the
> > vmemmap
> > > leak issue reported in this patch:
> > > [PATCH v2] arm64: mm: free unused memmap for sparse memory model that
> > define VMEMMAP
> > >
> > https://lore.kernel.org/linux-arm-kernel/20200812010655.96339-1-liwei213@
> > huawei.com/
> > > I don't have a machine which really has holes in memory_section to debug,
> > but memmap
> > > can help. With memmap, I could specified a machine with various holds in
> > mem_sections.
> > >
> > > After that, I figured out this is not only useful for debugging purpose. it can
> > have some real user cases.
> > > For example:
> > >
> > > 1. DAX on DRAM.
> > > kernel parameter memmap=XG!YG specifies a range of RAM to emulate
> > pmem. Then we are able
> > > to run DAX and filesystem on top of it. Furthermore, this will probably also
> > benefit the case
> > > this big patchset wants to "fix" via direct access to memory:
> > >
> > https://lore.kernel.org/lkml/cover.1602093760.git.yuleixzhang@tencent.com/T
> > /#m1a77074b8e1dadc590a5f45a52d9c3cda69c0780
> > > as the comments have clearly shown.
> > >
> > > 2. reserve some memory for userspace to manage via /dev/mem
> > >
> > 
> > Apologies for the bluntness, but what you are saying here is that you
> > need a hack to pile those other hacks onto.
> > 
> > Currently, we use the NOMAP attribute in memblock to describe memory
> > that is omitted from the direct map. Removing memory from memblock
> > entirely also strips it of this annotation, which means that
> > phys_mem_access_prot() will identify it as device memory not DRAM, and
> > use the wrong attributes when using /dev/mem.
> > 
> > There are likely other places where this distinction matters, and so I
> > am not buying the justification that we can make meaningful use of
> > this memory in the general case, and anything that relies on it will
> > be fragile, and probably only limited to very specific debug
> > scenarios.
> 
> Yep. originally I did that for debugging purpose to emulate a machine with
> some holes in mem_section. I guess it should be also useful to other people
> if they need the same thing for debugging.
> 
> > 
> > So I don't think we should merge this.
> 
> It should be in the same situation for other platforms like x86, mips and xtensa
> but they have enabled this kernel parameter.

I didn't check mips and xtensa, but x86 carries this from nineties when
they needed a way to work around broken BIOSes.
I really doubt x86 maintainers would merge such feature these days.
 
> maybe the emulated pmem by DRAM is an useful scenario other than debugging.
> 
> Later, https://lore.kernel.org/lkml/cover.1602093760.git.yuleixzhang@tencent.com/T/#m1a77074b8e1dadc590a5f45a52d9c3cda69c0780
> might be able to use this parameter.

Using kernel parameters to describe complex memory configuration does
not seem scalable and maintainable. 
A simple mem=X should be enough for features like dmemfs to start with
and if/when anything more complex will be required I doubt a kernel
parameter would fit that purpose.

Another thing as as soon as we expose this parameter to the user we'd
have to make sure they can always get the memory layout they defined
with it. Keeping the kernel parameter in sync with other means of memory
detection would complicate things on both sides. Ard mentioned NOMAP
property, there may be some NUMA considerations that could create a
conflict between what user asked and what is possible and other things
that may come up in the future. 

> Anyway, I don't mind keeping it local for debugging at this stage and waiting for a
> more convincing use case.
> 
> Thanks
> Barry
> 

-- 
Sincerely yours,
Mike.
