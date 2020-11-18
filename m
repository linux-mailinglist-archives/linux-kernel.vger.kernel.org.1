Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1522B8581
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgKRUZ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Nov 2020 15:25:59 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:25:58 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CbvSm6hTjzVpDN;
        Thu, 19 Nov 2020 04:25:28 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 19 Nov 2020 04:25:56 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 19 Nov 2020 04:25:56 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 19 Nov 2020 04:25:56 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] arm64: mm: add support for memmap kernel parameters
Thread-Topic: [PATCH] arm64: mm: add support for memmap kernel parameters
Thread-Index: AQHWvXVLtrpWHgsWH0upIuwmJUX89KnNolcAgAAa/ICAAJI6cA==
Date:   Wed, 18 Nov 2020 20:25:56 +0000
Message-ID: <1d3780422d2648dfa80a6de87585819a@hisilicon.com>
References: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
 <20201118173854.GA8537@kernel.org> <20201118191528.GA2680@willie-the-truck>
In-Reply-To: <20201118191528.GA2680@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.71]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: Thursday, November 19, 2020 8:15 AM
> To: Mike Rapoport <rppt@kernel.org>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> catalin.marinas@arm.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; akpm@linux-foundation.org;
> anshuman.khandual@arm.com; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] arm64: mm: add support for memmap kernel parameters
> 
> On Wed, Nov 18, 2020 at 07:38:54PM +0200, Mike Rapoport wrote:
> > On Wed, Nov 18, 2020 at 07:33:14PM +1300, Barry Song wrote:
> > > memmap should be an useful kernel parameter which has been supported
> by
> > > x86, mips and xtensa.
> >
> > Why is this parameter should be useful for ARM64?
> > My understanding is that it is required only to work around really
> > broken bootloaders, isn't it?
> 

Good question. Originally I wrote this patch to debug and verify the vmemmap
leak issue reported in this patch:
[PATCH v2] arm64: mm: free unused memmap for sparse memory model that define VMEMMAP
https://lore.kernel.org/linux-arm-kernel/20200812010655.96339-1-liwei213@huawei.com/
I don't have a machine which really has holes in memory_section to debug, but memmap
can help. With memmap, I could specified a machine with various holds in mem_sections.

After that, I figured out this is not only useful for debugging purpose. it can have some real user cases.
For example:

1. DAX on DRAM.
kernel parameter memmap=XG!YG specifies a range of RAM to emulate pmem. Then we are able
to run DAX and filesystem on top of it. Furthermore, this will probably also benefit the case
this big patchset wants to "fix" via direct access to memory:
https://lore.kernel.org/lkml/cover.1602093760.git.yuleixzhang@tencent.com/T/#m1a77074b8e1dadc590a5f45a52d9c3cda69c0780
as the comments have clearly shown.

2. reserve some memory for userspace to manage via /dev/mem


> Agreed, I can't see this being something we really want to support. If it
> turns out that it is generally useful, then the implementation should
> probably be somewhere outside of arch/ where I don't have to look at it :)
> 

What stops this becoming common code is that each platform has different ways
and boot sequences to populate memblock.
For example, on Arm64, while early_param is populated, dt has populated
memblock before that. Other platforms might been much different.

> Will

Thanks
Barry

