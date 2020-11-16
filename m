Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45712B3EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgKPId4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 03:33:56 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2370 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgKPId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:33:56 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CZMmH5wmHz54hV;
        Mon, 16 Nov 2020 16:33:35 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 16 Nov 2020 16:33:43 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 16 Nov 2020 16:33:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 16 Nov 2020 16:33:43 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "liwei (CM)" <liwei213@huawei.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Topic: [PATCH v2] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Index: AQHWgeqeF9IRtLcIvk+OGBJGQD8vganK4CWw
Date:   Mon, 16 Nov 2020 08:33:43 +0000
Message-ID: <eacfa2bb19df4126a476566512d93dab@hisilicon.com>
References: <20200812010655.96339-1-liwei213@huawei.com>
 <20200817080405.GL969206@linux.ibm.com> <20200903120558.GB31409@gaia>
In-Reply-To: <20200903120558.GB31409@gaia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.147]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> Sent: Friday, September 4, 2020 12:06 AM
> To: Mike Rapoport <rppt@linux.ibm.com>
> Cc: liwei (CM) <liwei213@huawei.com>; will@kernel.org; Xiaqing (A)
> <saberlily.xia@hisilicon.com>; Chenfeng (puck) <puck.chen@hisilicon.com>;
> butao <butao@hisilicon.com>; fengbaopeng <fengbaopeng2@hisilicon.com>;
> nsaenzjulienne@suse.de; steve.capper@arm.com; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; sujunfei <sujunfei2@hisilicon.com>
> Subject: Re: [PATCH v2] arm64: mm: free unused memmap for sparse memory
> model that define VMEMMAP
> 
> On Mon, Aug 17, 2020 at 11:04:05AM +0300, Mike Rapoport wrote:
> > On Wed, Aug 12, 2020 at 09:06:55AM +0800, Wei Li wrote:
> > > For the memory hole, sparse memory model that define
> SPARSEMEM_VMEMMAP
> > > do not free the reserved memory for the page map, this patch do it.
> >
> > I've been thinking about it a bit more and it seems that instead of
> > freeing unused memory map it would be better to allocate the exact
> > memory map from the beginning.
> >
> > In sparse_init_nid() we can replace PAGES_PER_SECTION parameter to
> > __populate_section_memmap() with the calculated value for architectures
> > that define HAVE_ARCH_PFN_VALID.
> 
> Or just use a smaller PAGES_PER_SECTION and reduce the waste ;).
> 
> Just to be clear, are you suggesting that we should use pfn_valid() on
> the pages within a section to calculate the actual range? The
> pfn_valid() implementation on arm64 checks for the validity of a sparse
> section, so this would be called from within the sparse_init() code
> path. I hope there's no dependency but I haven't checked. If it works,
> it's fine by me, it solves the FLATMEM mem_map freeing as well.
> 
> With 4KB pages on arm64, vmemmap_populate() stops at the pmd level, so
> it always allocates PMD_SIZE. Wei's patch also only frees in PMD_SIZE
> amounts. So, with a sizeof(struct page) of 64 (2^6), a PMD_SIZE mem_map
> section would cover 2^(21-6) pages, so that's equivalent to a
> SECTION_SIZE_BITS of 21-6+12 = 27.
> 
> If we reduce SECTION_SIZE_BITS to 27 or less, this patch is a no-op.

It would be the simplest way to fix this issue. It seems X86_64 is
also using 27.

@wei, has you ever tried to send a patch to change SECTION_SIZE_BITS
to 27 for ARM64?

> 
> --
> Catalin

Thanks
Barry
