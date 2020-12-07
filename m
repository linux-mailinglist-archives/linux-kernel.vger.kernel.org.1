Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D311B2D08E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgLGBlS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Dec 2020 20:41:18 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2085 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgLGBlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:41:18 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Cq5b44yPYzVgTc;
        Mon,  7 Dec 2020 09:39:44 +0800 (CST)
Received: from dggemm753-chm.china.huawei.com (10.1.198.59) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Dec 2020 09:40:35 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm753-chm.china.huawei.com (10.1.198.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Mon, 7 Dec 2020 09:40:35 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 7 Dec 2020 09:40:35 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Rapoport <rppt@linux.ibm.com>, Will Deacon <will@kernel.org>
CC:     "liwei (CM)" <liwei213@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        butao <butao@hisilicon.com>
Subject: RE: [PATCH] arm64: mm: decrease the section size to reduce the memory
 reserved for the page map
Thread-Topic: [PATCH] arm64: mm: decrease the section size to reduce the
 memory reserved for the page map
Thread-Index: AQHWyd8Pm9rJc08RmUuZbQcVlySHKKnmQzeAgAAIcQCABJBfwA==
Date:   Mon, 7 Dec 2020 01:40:35 +0000
Message-ID: <60cb36d5dfcb4f9c904a83b520ecfe84@hisilicon.com>
References: <20201204014443.43329-1-liwei213@huawei.com>
 <20201204111347.GA844@willie-the-truck>
 <20201204114400.GT123287@linux.ibm.com>
In-Reply-To: <20201204114400.GT123287@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Rapoport [mailto:rppt@linux.ibm.com]
> Sent: Saturday, December 5, 2020 12:44 AM
> To: Will Deacon <will@kernel.org>
> Cc: liwei (CM) <liwei213@huawei.com>; catalin.marinas@arm.com; fengbaopeng
> <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de; steve.capper@arm.com;
> Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; butao
> <butao@hisilicon.com>
> Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the memory
> reserved for the page map
> 
> On Fri, Dec 04, 2020 at 11:13:47AM +0000, Will Deacon wrote:
> > On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
> > > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> > > do not free the reserved memory for the page map, decrease the section
> > > size can reduce the waste of reserved memory.
> > >
> > > Signed-off-by: Wei Li <liwei213@huawei.com>
> > > Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
> > > Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> > > ---
> > >  arch/arm64/include/asm/sparsemem.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/include/asm/sparsemem.h
> b/arch/arm64/include/asm/sparsemem.h
> > > index 1f43fcc79738..8963bd3def28 100644
> > > --- a/arch/arm64/include/asm/sparsemem.h
> > > +++ b/arch/arm64/include/asm/sparsemem.h
> > > @@ -7,7 +7,7 @@
> > >
> > >  #ifdef CONFIG_SPARSEMEM
> > >  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> > > -#define SECTION_SIZE_BITS	30
> > > +#define SECTION_SIZE_BITS	27
> >
> > We chose '30' to avoid running out of bits in the page flags. What changed?
> 
> I think that for 64-bit there are still plenty of free bits. I didn't
> check now, but when I played with SPARSEMEM on m68k there were 8 bits
> for section out of 32.
> 
> > With this patch, I can trigger:
> >
> > ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds
> SECTION_SIZE
> > #error Allocator MAX_ORDER exceeds SECTION_SIZE
> >
> > if I bump up NR_CPUS and NODES_SHIFT.
> 
> I don't think it's related to NR_CPUS and NODES_SHIFT.
> This seems rather 64K pages that cause this.
> 
> Not that is shouldn't be addressed.

Right now, only 4K PAGES will define ARM64_SWAPPER_USES_SECTION_MAPS.
Other cases will use vmemmap_populate_basepages().
The original patch should be only addressing the issue in 4K pages:
https://lore.kernel.org/lkml/20200812010655.96339-1-liwei213@huawei.com/

would we do something like the below?
#ifdef CONFIG_ARM64_4K_PAGE
#define SECTION_SIZE_BITS	27
#else
#define SECTION_SIZE_BITS	30
#endif

> 
> > Will
> 
> --
> Sincerely yours,
> Mike.

Thanks
Barry

