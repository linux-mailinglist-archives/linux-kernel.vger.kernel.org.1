Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F612F9D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbhARK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:58:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2363 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389685AbhARK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:57:58 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DK7vC4YwQz67d8r;
        Mon, 18 Jan 2021 18:53:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 18 Jan 2021 11:57:05 +0100
Received: from [10.47.8.82] (10.47.8.82) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 10:57:04 +0000
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
 <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com> <YAVeDOiKBEKZ2Tdq@myrica>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
Date:   Mon, 18 Jan 2021 10:55:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YAVeDOiKBEKZ2Tdq@myrica>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.82]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2021 10:08, Jean-Philippe Brucker wrote:
>>> Any idea why that's happening?  This fix seems ok but if we're expecting
>>> allocation failures for the loaded magazine then we could easily get it
>>> for cpu_rcaches too, and get a similar abort at runtime.
>> It's not specifically that we expect them (allocation failures for the
>> loaded magazine), rather we should make safe against it.
>>
>> So could you be more specific in your concern for the cpu_rcache failure?
>> cpu_rcache magazine assignment comes from this logic.
> If this fails:
> 
> drivers/iommu/iova.c:847: rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
> 
> then we'll get an Oops in __iova_rcache_get(). So if we're making the
> module safer against magazine allocation failure, shouldn't we also
> protect against cpu_rcaches allocation failure?

Ah, gotcha. So we have the WARN there, but that's not much use as this 
would still crash, as you say.

So maybe we can embed the cpu rcaches in iova_domain struct, to avoid 
the separate (failable) cpu rcache allocation.

Alternatively, we could add NULL checks __iova_rcache_get() et al for 
this allocation failure but that's not preferable as it's fastpath.

Finally so we could pass back an error code from init_iova_rcache() to 
its only caller, init_iova_domain(); but that has multiple callers and 
would need to be fixed up.

Not sure which is best or on other options.

Thanks,
John
