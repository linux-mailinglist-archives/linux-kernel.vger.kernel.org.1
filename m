Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9110E2767FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIXEwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:52:01 -0400
Received: from z5.mailgun.us ([104.130.96.5]:41275 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIXEwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:52:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600923120; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=OcuRehvXWjquPfAiTK+K+IF0XIj5WnIhvodV0AT8ZIE=; b=jC5xGFwFa+OOZBLMjrZOsR32YKTHYV/ZT5CEZ7nXzkHVf3M0qZl11V4lgIMX4r+mh9kzpKFz
 gMZmxHAxAX63etgnJwEl6FeWlmg6BxiqWSUhlsdjLJRtoaNtrVn0OR2nOYNrDl4qVcFZ87fJ
 swWyTYAEm7AUd4xe1HCahbuFLi4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f6c25e051ea4325f37a01fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 04:51:44
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3DD3C433C8; Thu, 24 Sep 2020 04:51:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.203.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27279C433CA;
        Thu, 24 Sep 2020 04:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27279C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] iommu: of: skip iommu_device_list traversal in
 of_iommu_xlate()
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1600872826-2254-1-git-send-email-charante@codeaurora.org>
 <8722e4bc-efe0-27c4-2b7d-626188da5bfb@arm.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <352d1518-8191-19e0-b9f3-29dfe91a2ad4@codeaurora.org>
Date:   Thu, 24 Sep 2020 10:21:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8722e4bc-efe0-27c4-2b7d-626188da5bfb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/2020 9:54 PM, Robin Murphy wrote:
> On 2020-09-23 15:53, Charan Teja Reddy wrote:
>> In of_iommu_xlate(), check if iommu device is enabled before traversing
>> the iommu_device_list through iommu_ops_from_fwnode(). It is of no use
>> in traversing the iommu_device_list only to return NO_IOMMU because of
>> iommu device node is disabled.
> 
> Well, the "use" is that it keeps the code that much smaller and simpler
> to have a single path for returning this condition. This whole callstack
> isn't exactly a high-performance code path to begin with, and we've
> always assumed that IOMMUs present but disabled in DT would be a pretty
> rare exception. 

Fine..I thought that it is logical to return when IOMMU DT node is
disabled over code simplicity. And agree that it is not high-performance
path.

> Do you have a system that challenges those assumptions
> and shows any benefit from this change?

No, I don't have a system that challenges these assumptions.

> 
> Robin.
> 
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>>   drivers/iommu/of_iommu.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index e505b91..225598c 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -94,9 +94,10 @@ static int of_iommu_xlate(struct device *dev,
>>       struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
>>       int ret;
>>   +    if (!of_device_is_available(iommu_spec->np))
>> +        return NO_IOMMU;
>>       ops = iommu_ops_from_fwnode(fwnode);
>> -    if ((ops && !ops->of_xlate) ||
>> -        !of_device_is_available(iommu_spec->np))
>> +    if (ops && !ops->of_xlate)
>>           return NO_IOMMU;
>>         ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
>>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
