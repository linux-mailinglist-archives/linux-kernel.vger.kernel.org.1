Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F152CA72E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391791AbgLAPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:36:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2185 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbgLAPgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:36:17 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ClmMz6ZdRz67KjJ;
        Tue,  1 Dec 2020 23:33:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 1 Dec 2020 16:35:29 +0100
Received: from [10.47.7.145] (10.47.7.145) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Dec 2020
 15:35:28 +0000
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <xiyou.wangcong@gmail.com>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d87ceec4-b7a1-c600-3b78-6852f0320ce2@huawei.com>
Date:   Tue, 1 Dec 2020 15:35:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.145]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2020 10:25, John Garry wrote:

Hi Will,

Is there any chance that we can get these picked up for 5.11? We've seen 
this issue solved here for a long time.

Or, @Robin, let me know if not happy with this since v1.

BTW, patch #4 has been on the go for ~1 year now, and is a nice small 
optimisation from Cong, which I picked up and already had a RB tag.

Thanks,
John

> This series contains a patch to solve the longterm IOVA issue which
> leizhen originally tried to address at [0].
> 
> A sieved kernel log is at the following, showing periodic dumps of IOVA
> sizes, per CPU and per depot bin, per IOVA size granule:
> https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test
> 
> Notice, for example, the following logs:
> [13175.355584] print_iova1 cpu_total=40135 depot_total=3866 total=44001
> [83483.457858] print_iova1 cpu_total=62532 depot_total=24476 total=87008
> 
> Where total IOVA rcache size has grown from 44K->87K over a long time.
> 
> Along with this patch, I included the following:
> - A smaller helper to clear all IOVAs for a domain
> - Change polarity of the IOVA magazine helpers
> - Small optimisation from Cong Wang included, which was never applied [1].
>    There was some debate of the other patches in that series, but this one
>    is quite straightforward.
> 
> Differnces to v2:
> - Update commit message for patch 3/4
> 
> Differences to v1:
> - Add IOVA clearing helper
> - Add patch to change polarity of mag helpers
> - Avoid logically-redundant extra variable in __iova_rcache_insert()
> 
> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
> [1] https://lore.kernel.org/linux-iommu/4b74d40a-22d1-af53-fcb6-5d70183705a8@huawei.com/
> 
> Cong Wang (1):
>    iommu: avoid taking iova_rbtree_lock twice
> 
> John Garry (3):
>    iommu/iova: Add free_all_cpu_cached_iovas()
>    iommu/iova: Avoid double-negatives in magazine helpers
>    iommu/iova: Flush CPU rcache for when a depot fills
> 
>   drivers/iommu/iova.c | 66 +++++++++++++++++++++++++-------------------
>   1 file changed, 38 insertions(+), 28 deletions(-)
> 

