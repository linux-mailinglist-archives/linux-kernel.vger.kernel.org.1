Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8903A26AEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgIOUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:54:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33816 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgIOUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:46:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FKdbd2086901;
        Tue, 15 Sep 2020 20:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FmTz2fljRnoXwjllRl7fwASoDuhxx7pfhTKjMnx4SHY=;
 b=jO71LRkJPcAd11zSY1cRJVgUOCkoRNU82iNNWVF9pU6g0CAytZIab8/VDMxp+tis2DdM
 qMzCi8O/YwLIuRHgf0qjVz9sIHoNiSq5DmfkBoPYYBNKX22uzTTEWXEP9WsXzxvXce5S
 kChgRldBjUStVy1cVX3KcWl1BpOx1XssKqyVrx/+hYuw49hMrXgskrSXnebgXoJzRy/7
 C0apyML7V6f+5vYWuyICyHY7m68rYtGQUm+OgvmVWmFDMP0HcIrBliqzU6tp4laz+9nn
 uCC1CyhSuEt4lwQZH4ipGq1KyNNGXsaBB8sEprnBQo0OdlwaTxxp1A/d6qBu5ZbvW30o vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 33gnrqyj1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 20:46:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FKjpkX008110;
        Tue, 15 Sep 2020 20:46:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33hm318bdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 20:46:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FKkIIj019081;
        Tue, 15 Sep 2020 20:46:18 GMT
Received: from [192.168.0.14] (/108.168.44.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 20:46:18 +0000
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
To:     Christoph Hellwig <hch@lst.de>
Cc:     konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
 <20200915140719.GA14831@lst.de>
 <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
 <20200915142624.GA16005@lst.de>
 <da9ec51d-aab5-695d-e388-5ae7c0bb30ea@oracle.com>
 <20200915150929.GA19770@lst.de>
From:   Thomas Tai <thomas.tai@oracle.com>
Message-ID: <5136ed8d-d37d-8144-a6f3-c23f272d8926@oracle.com>
Date:   Tue, 15 Sep 2020 16:46:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915150929.GA19770@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-09-15 11:09 a.m., Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 10:40:39AM -0400, Thomas Tai wrote:
>>> +++ b/include/linux/dma-direct.h
>>> @@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>>>    {
>>>    	dma_addr_t end = addr + size - 1;
>>>    -	if (!dev->dma_mask)
>>> -		return false;
>>> -
>>
>> I am concerned that some drivers may rely on this NULL checking. Would you
>> think we can keep this checking and use the following WARN_ON_ONCE()?
> 
> dma_capable is not a helper for drivers, but just for dma-direct
> and related code.  And this patch adds the checks for the three
> places how we call into the ->map* methods.
> 

Hi Christoph,
I tried out the suggested changes, and it successfully warned the null 
pointer without panic. I notice that there are some places outside the 
dma-direct, which calls dma_capable().

https://elixir.bootlin.com/linux/v5.9-rc5/source/arch/x86/kernel/amd_gart_64.c#L187

https://elixir.bootlin.com/linux/v5.9-rc5/source/drivers/xen/swiotlb-xen.c#L387

Also, if I remove the null checking in dma_capable(), I may run into the 
risk of a null pointer dereference within the function.

@@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, 
dma_addr_t addr, size_t size,
  {
  	dma_addr_t end = addr + size - 1;

-	if (!dev->dma_mask)
-		return false;
-
  	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
  	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
  		return false;
	
	return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
                                     ^
                                     |
                                     ** risk of a null dereference **
}


Given that the WARN_ON_ONCE already did the intended warning, would you 
be ok that I keep the null checking in dma_capable()?

Thank you,
Thomas

