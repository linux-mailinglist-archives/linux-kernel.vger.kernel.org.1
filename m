Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBF26A856
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgIOPHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:07:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59620 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgIOOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:41:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FEduQ2150785;
        Tue, 15 Sep 2020 14:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ob0tiNJJ2VTB74z1m5YoBvbdwfodTrserhVba6hRRVA=;
 b=Vt67dayvJ1CvcEjVXjDDNI5aiebMMgRTZ+Dn0mmB0GYmPHxMq86FGGwhHOdq33uwb3Ip
 WQ48SLXqtcmtSGzjHt74Qs/fh1b3UtsCi8Hae1P4BQAIBhfThupREHYmsEpkizByfySo
 cHv3PEg+CPF3K4H231lfBoH9VFOROPwVR9mzVi5sTYXfCHjDMPmmd234Sy9e5CyWUUwx
 tptRdXw381UFl/eUZeO6bKEqZI4KSuwYeocSLitWAwX9iCjdoHn8/+W8h0K2+lPZojCT
 U6a1jIQHhHsdB1qlJ6LiI3D6M7wWYEJP0R7d+0n7TeK0Oc5xSzuE0obnSTxiTeJRBWh9 qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33gnrqwg95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 14:40:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FEeiYi095980;
        Tue, 15 Sep 2020 14:40:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33h88ye624-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 14:40:44 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FEeckQ019070;
        Tue, 15 Sep 2020 14:40:38 GMT
Received: from [10.39.253.102] (/10.39.253.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 14:40:38 +0000
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
To:     Christoph Hellwig <hch@lst.de>
Cc:     konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
 <20200915140719.GA14831@lst.de>
 <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
 <20200915142624.GA16005@lst.de>
From:   Thomas Tai <thomas.tai@oracle.com>
Message-ID: <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
Date:   Tue, 15 Sep 2020 10:40:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915142624.GA16005@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-09-15 10:26 a.m., Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 10:11:51AM -0400, Thomas Tai wrote:
>>
>>
>> On 2020-09-15 10:07 a.m., Christoph Hellwig wrote:
>>> On Tue, Sep 15, 2020 at 08:03:14AM -0600, Thomas Tai wrote:
>>>> When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
>>>> printing a warning message in swiotlb_map(). It is because dev->dma_mask
>>>> can potentially be a null pointer. Using the dma_get_mask() macro can
>>>> avoid the NULL pointer dereference.
>>>
>>> dma_mask must not be zero.  This means drm is calling DMA API functions
>>> on something weird.  This needs to be fixed in the caller.
>>>
>>
>> Thanks, Christoph for your comment. The caller already fixed the null
>> pointer in the latest v5.9-rc5. I am thinking that if we had used the
>> dma_get_mask(), the kernel couldn't panic and could properly print out the
>> warning message.
> 
> If we want to solve this something like this patch is probably the
> right way:
> 
> 
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 6e87225600ae35..064870844f06c1 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>   {
>   	dma_addr_t end = addr + size - 1;
>   
> -	if (!dev->dma_mask)
> -		return false;
> -

I am concerned that some drivers may rely on this NULL checking. Would 
you think we can keep this checking and use the following WARN_ON_ONCE()?

>   	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
>   	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
>   		return false;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 0d129421e75fc8..2b01d8f7baf160 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -144,6 +144,10 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>   	dma_addr_t addr;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> +
> +	if (WARN_ON_ONCE(!dev->dma_mask))
> +		return DMA_MAPPING_ERROR;
> +
>   	if (dma_map_direct(dev, ops))
>   		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>   	else
> @@ -179,6 +183,10 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   	int ents;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> +
> +	if (WARN_ON_ONCE(!dev->dma_mask))
> +		return 0;
> +
>   	if (dma_map_direct(dev, ops))
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
> @@ -217,6 +225,9 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>   	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>   		return DMA_MAPPING_ERROR;
>   
> +	if (WARN_ON_ONCE(!dev->dma_mask))
> +		return DMA_MAPPING_ERROR;
> +
>   	if (dma_map_direct(dev, ops))
>   		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
>   	else if (ops->map_resource)
> 
