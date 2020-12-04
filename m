Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368122CE568
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgLDBvZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 20:51:25 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2330 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLDBvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:51:24 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CnFyB1NRjz13Pqk;
        Fri,  4 Dec 2020 09:49:54 +0800 (CST)
Received: from dggpemm000002.china.huawei.com (7.185.36.174) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Dec 2020 09:50:41 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm000002.china.huawei.com (7.185.36.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 4 Dec 2020 09:50:41 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 4 Dec 2020 09:50:41 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "liwei (CM)" <liwei213@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     fengbaopeng <fengbaopeng2@hisilicon.com>,
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
Thread-Index: AQHWyd8Pm9rJc08RmUuZbQcVlySHKKnmKYSA
Date:   Fri, 4 Dec 2020 01:50:40 +0000
Message-ID: <731f9389df474a968b2799fa698821da@hisilicon.com>
References: <20201204014443.43329-1-liwei213@huawei.com>
In-Reply-To: <20201204014443.43329-1-liwei213@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: liwei (CM)
> Sent: Friday, December 4, 2020 2:45 PM
> To: catalin.marinas@arm.com; rppt@linux.ibm.com; will@kernel.org; liwei (CM)
> <liwei213@huawei.com>
> Cc: fengbaopeng <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de;
> steve.capper@arm.com; Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; butao
> <butao@hisilicon.com>
> Subject: [PATCH] arm64: mm: decrease the section size to reduce the memory
> reserved for the page map
> 
> For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> do not free the reserved memory for the page map, decrease the section
> size can reduce the waste of reserved memory.
> 
> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> ---

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

When page size is 4K, for each 1GB memory, we need 16MB vmemmap;
For each 128MB memory, we need 2MB vmemmap.

So while we have memory hole like 928MB(1GB-64MB),if SECTION_SIZE_BITS
is 30, we waste 15MB; if SECTION_SIZE_BITS is 27, we waste 1MB only.

>  arch/arm64/include/asm/sparsemem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h
> b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..8963bd3def28 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,7 @@
> 
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> -#define SECTION_SIZE_BITS	30
> +#define SECTION_SIZE_BITS	27
>  #endif
> 
>  #endif
> --
> 2.15.0

Thanks
Barry

