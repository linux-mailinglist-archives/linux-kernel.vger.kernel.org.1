Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328D26A928
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgIOPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:55:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgIOPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:13:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FF4Ntu149991;
        Tue, 15 Sep 2020 15:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OomBHSXo/Y1LDw5jEcMC2p6v5dx4Welq368VU3lWhic=;
 b=Ykc5JfKyNgOplXd5wkSLoaADDe/tMn1SYfFz4YSf7ed6O8hFwndcrvjriyILS/3kg5Ie
 100v0AJRpvaEAkF217udpkPwP78ZQfwAYlD2aWChql3wpcIoCtMROIzbSci4zq6KcoLt
 LcUaSG81M5YmQ6CBnEDCX8FqFjulaaYAabAr2pvT7esZxX5Gh/UIwOLmTN/J6eS18/KN
 KzBRaTlP829nGzL4vpoI7pyG7Zt0vHl/ZTYZI9IDbGb1c6XeJxOARPaiF/bCOOaz4fHV
 xxSj7vjBTDt9LJzZ06/V7WRxzWLI/7GziCkY92xFuH8Q6UGxYILYYuxt09ogDeGCQvyY dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33j91dfa98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 15:12:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FF4hWO188266;
        Tue, 15 Sep 2020 15:12:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33h88yg466-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 15:12:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FFCRU5009088;
        Tue, 15 Sep 2020 15:12:27 GMT
Received: from [10.39.253.102] (/10.39.253.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 15:12:27 +0000
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
Message-ID: <9a819530-365b-9982-c9c9-ad20d6c8149e@oracle.com>
Date:   Tue, 15 Sep 2020 11:12:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915150929.GA19770@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150127
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

Ok. That sounds good to me. I will make the suggested changes and run 
some tests before sending out the V2 patch.

Thank you,
Thomas
