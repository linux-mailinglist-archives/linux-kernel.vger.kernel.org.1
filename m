Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CBC2ECC86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbhAGJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:15:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2299 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:15:39 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DBL6S2gcbz67Y31;
        Thu,  7 Jan 2021 17:10:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 7 Jan 2021 10:14:57 +0100
Received: from [10.47.3.231] (10.47.3.231) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 7 Jan 2021
 09:14:51 +0000
Subject: Re: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
 <1609940111-28563-7-git-send-email-john.garry@huawei.com>
 <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b31e8a41-3918-6b69-05af-45084e08bb7f@huawei.com>
Date:   Thu, 7 Jan 2021 09:13:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.3.231]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2021 01:18, Lu Baolu wrote:
> On 1/6/21 9:35 PM, John Garry wrote:
>> Function iommu_dev_has_feature() has never been referenced in the tree,
>> and there does not appear to be anything coming soon to use it, so delete
>> it.
> 

Hi baolu,

> It will be used by the device driver which want to support the aux-
> domain capability, for example, below series is under discussion.
> 
> https://lore.kernel.org/linux-pci/160408357912.912050.17005584526266191420.stgit@djiang5-desk3.ch.intel.com/ 
> 

So I did check linux-iommu lore for recent references, above, but did 
not see this one - that really should have cc'ed linux-iommu list (which 
it didn't).

> 
> The typical use case is
> 
>          if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
>                  rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_AUX);
>                  if (rc < 0) {
>                          dev_warn(dev, "Failed to enable aux-domain: 
> %d\n", rc);
>                          return rc;
>                  }
>          }
> 
> So please don't remove it.
> 

ok, fine. It also seems that this API has not had a user since it was 
introduced in v5.2.

Thanks,
John

Ps. I suppose a v3 series is not needed ATM - this patch can just be 
dropped.
