Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4472B87D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKRWi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgKRWi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:38:29 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DB4246E5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605739108;
        bh=WQyX/8hJp93DcXubyEHojKjD6rA6tjpVqFx+4GPCGWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XfvAA55vzLSvDciYYfWaOV8J2uRfiIq9W6KOpn2wLEfJzERY215/5kUUU5hQn2J/i
         ec7TekJZW7QurgN2rVSl18vGtRTXL7G3MvVJlaYEA3uZSJyx1ebop36Au+o3i5DhDy
         1anmz1o2PV6JEvIbbFxqI2Z9j+aNDHP/DGbNc7BU=
Received: by mail-oi1-f180.google.com with SMTP id k26so4126553oiw.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:38:28 -0800 (PST)
X-Gm-Message-State: AOAM532ZtmzqlL8xUtY4k4V0q2+s72BdqkweJHfzfJC1qOYi3E/DrIuw
        /URaTuoji86eM6llQvml79CHP/4A4WstXaEIYNY=
X-Google-Smtp-Source: ABdhPJz1xIG7kZ1t8IeAkEeOaq6y3wOqL+lDiL5LhkByGurtXT2Ey/6iYlt5uB9+M/XDGcrRskTQ0x5SzjtSKu9HXvk=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr1022019oif.174.1605739107610;
 Wed, 18 Nov 2020 14:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
 <20201118173854.GA8537@kernel.org> <20201118191528.GA2680@willie-the-truck> <1d3780422d2648dfa80a6de87585819a@hisilicon.com>
In-Reply-To: <1d3780422d2648dfa80a6de87585819a@hisilicon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Nov 2020 23:38:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE-Ea7K_U9JUp2uq+kpmTEYaiKrqMK1J1DOG-UAA3J6ow@mail.gmail.com>
Message-ID: <CAMj1kXE-Ea7K_U9JUp2uq+kpmTEYaiKrqMK1J1DOG-UAA3J6ow@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: add support for memmap kernel parameters
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 21:27, Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Will Deacon [mailto:will@kernel.org]
> > Sent: Thursday, November 19, 2020 8:15 AM
> > To: Mike Rapoport <rppt@kernel.org>
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> > catalin.marinas@arm.com; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; akpm@linux-foundation.org;
> > anshuman.khandual@arm.com; Linuxarm <linuxarm@huawei.com>
> > Subject: Re: [PATCH] arm64: mm: add support for memmap kernel parameters
> >
> > On Wed, Nov 18, 2020 at 07:38:54PM +0200, Mike Rapoport wrote:
> > > On Wed, Nov 18, 2020 at 07:33:14PM +1300, Barry Song wrote:
> > > > memmap should be an useful kernel parameter which has been supported
> > by
> > > > x86, mips and xtensa.
> > >
> > > Why is this parameter should be useful for ARM64?
> > > My understanding is that it is required only to work around really
> > > broken bootloaders, isn't it?
> >
>
> Good question. Originally I wrote this patch to debug and verify the vmemmap
> leak issue reported in this patch:
> [PATCH v2] arm64: mm: free unused memmap for sparse memory model that define VMEMMAP
> https://lore.kernel.org/linux-arm-kernel/20200812010655.96339-1-liwei213@huawei.com/
> I don't have a machine which really has holes in memory_section to debug, but memmap
> can help. With memmap, I could specified a machine with various holds in mem_sections.
>
> After that, I figured out this is not only useful for debugging purpose. it can have some real user cases.
> For example:
>
> 1. DAX on DRAM.
> kernel parameter memmap=XG!YG specifies a range of RAM to emulate pmem. Then we are able
> to run DAX and filesystem on top of it. Furthermore, this will probably also benefit the case
> this big patchset wants to "fix" via direct access to memory:
> https://lore.kernel.org/lkml/cover.1602093760.git.yuleixzhang@tencent.com/T/#m1a77074b8e1dadc590a5f45a52d9c3cda69c0780
> as the comments have clearly shown.
>
> 2. reserve some memory for userspace to manage via /dev/mem
>

Apologies for the bluntness, but what you are saying here is that you
need a hack to pile those other hacks onto.

Currently, we use the NOMAP attribute in memblock to describe memory
that is omitted from the direct map. Removing memory from memblock
entirely also strips it of this annotation, which means that
phys_mem_access_prot() will identify it as device memory not DRAM, and
use the wrong attributes when using /dev/mem.

There are likely other places where this distinction matters, and so I
am not buying the justification that we can make meaningful use of
this memory in the general case, and anything that relies on it will
be fragile, and probably only limited to very specific debug
scenarios.

So I don't think we should merge this.


>
> > Agreed, I can't see this being something we really want to support. If it
> > turns out that it is generally useful, then the implementation should
> > probably be somewhere outside of arch/ where I don't have to look at it :)
> >
>
> What stops this becoming common code is that each platform has different ways
> and boot sequences to populate memblock.
> For example, on Arm64, while early_param is populated, dt has populated
> memblock before that. Other platforms might been much different.
>
> > Will
>
> Thanks
> Barry
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
