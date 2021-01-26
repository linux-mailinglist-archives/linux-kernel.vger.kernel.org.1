Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A530314A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbhAZBbb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 20:31:31 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4150 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbhAZB1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:27:33 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DPpvn5bSwzY1YL;
        Tue, 26 Jan 2021 09:25:41 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 26 Jan 2021 09:26:46 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 09:26:45 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 26 Jan 2021 09:26:45 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ//+YwwCAAIUv4A==
Date:   Tue, 26 Jan 2021 01:26:45 +0000
Message-ID: <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
In-Reply-To: <20210126011304.GZ4605@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.227]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Tuesday, January 26, 2021 2:13 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>; Zhangfei Gao
> <zhangfei.gao@linaro.org>; linux-accelerators@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> linux-mm@kvack.org; Liguozhu (Kenneth) <liguozhu@hisilicon.com>; chensihang
> (A) <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song) wrote:
> 
> > > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song) wrote:
> > > > mlock, while certainly be able to prevent swapping out, it won't
> > > > be able to stop page moving due to:
> > > > * memory compaction in alloc_pages()
> > > > * making huge pages
> > > > * numa balance
> > > > * memory compaction in CMA
> > >
> > > Enabling those things is a major reason to have SVA device in the
> > > first place, providing a SW API to turn it all off seems like the
> > > wrong direction.
> >
> > I wouldn't say this is a major reason to have SVA. If we read the
> > history of SVA and papers, people would think easy programming due
> > to data struct sharing between cpu and device, and process space
> > isolation in device would be the major reasons for SVA. SVA also
> > declares it supports zero-copy while zero-copy doesn't necessarily
> > depend on SVA.
> 
> Once you have to explicitly make system calls to declare memory under
> IO, you loose all of that.
> 
> Since you've asked the app to be explicit about the DMAs it intends to
> do, there is not really much reason to use SVA for those DMAs anymore.

Let's see a non-SVA case. We are not using SVA, we can have
a memory pool by hugetlb or pin, and app can allocate memory
from this pool, and get stable I/O performance on the memory
from the pool. But device has its separate page table which
is not bound with this process, thus lacking the protection
of process space isolation. Plus, CPU and device are using
different address.

And then we move to SVA case, we can still have a memory pool
by hugetlb or pin, and app can allocate memory from this pool
since this pool is mapped to the address space of the process,
and we are able to get stable I/O performance since it is always
there. But in this case, device is using the page table of
process with the full permission control.
And they are using same address and can possibly enjoy the easy
programming if HW supports.

SVA is not doom to work with IO page fault only. If we have SVA+pin,
we would get both sharing address and stable I/O latency.

> 
> Jason

Thanks
Barry

