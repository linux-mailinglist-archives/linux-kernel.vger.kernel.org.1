Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8461A0FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgDGPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 11:11:38 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64224 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728992AbgDGPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:11:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586272297; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=lo5LeBpU88t4FSGojL6rVJm8xZPofQsMUW6HaXesTPQ=; b=K71GmFq22Xz+EfxrOS8J8o27akemOxJ8YhZJT6w9hSPHNkR62v74RMtU7NFK6u1N2fYOcWhy
 xYU3OSeM7pgOCF4rLi4psFc2TOhcSPOUqIPMCqd0gyTfMDLKMiV5Jegl90wPicS8ZYlybGDq
 VkpwaxD0ujMJHRLpW2dDRuJY+Wk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c9828.7f7115275ae8-smtp-out-n02;
 Tue, 07 Apr 2020 15:11:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53711C433D2; Tue,  7 Apr 2020 15:11:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94892C433F2;
        Tue,  7 Apr 2020 15:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94892C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 1/3] bus: mhi: core: Handle syserr during power_up
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1586207077-22361-1-git-send-email-jhugo@codeaurora.org>
 <1586207077-22361-2-git-send-email-jhugo@codeaurora.org>
 <20200407062641.GC2442@Mani-XPS-13-9360>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <f63b0a23-97d3-e690-70ae-a4485d42b28f@codeaurora.org>
Date:   Tue, 7 Apr 2020 09:11:33 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200407062641.GC2442@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2020 12:26 AM, Manivannan Sadhasivam wrote:
> On Mon, Apr 06, 2020 at 03:04:35PM -0600, Jeffrey Hugo wrote:
>> The MHI device may be in the syserr state when we attempt to init it in
>> power_up().  Since we have no local state, the handling is simple -
>> reset the device and wait for it to transition out of the reset state.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   drivers/bus/mhi/core/pm.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
>> index 52690cb..cd6ba23 100644
>> --- a/drivers/bus/mhi/core/pm.c
>> +++ b/drivers/bus/mhi/core/pm.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/dma-direction.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/list.h>
>>   #include <linux/mhi.h>
>>   #include <linux/module.h>
>> @@ -760,6 +761,7 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
>>   
>>   int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>>   {
>> +	enum mhi_state state;
>>   	enum mhi_ee_type current_ee;
>>   	enum dev_st_transition next_state;
>>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>> @@ -829,6 +831,24 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>>   		goto error_bhi_offset;
>>   	}
>>   
>> +	state = mhi_get_mhi_state(mhi_cntrl);
>> +	if (state == MHI_STATE_SYS_ERR) {
>> +		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
>> +		ret = readl_poll_timeout(mhi_cntrl->regs + MHICTRL, val,
>> +					 !(val & MHICTRL_RESET_MASK), 1000,
> 
> Hmm. Do we really need a max 1ms delay between each read? I'd prefer to have
> 100ns to reduce the wait time.


I assume you mean 100us since that's the units of the parameter, and 
usleep_range is the actual delay mechanism.  Please correct me if that 
is a bad assumption.

I chose 1ms to try to avoid flooding the bus, since on one system we 
care about, the round trip time was observed to be ~1ms.  However, that 
is fairly arbitrary, so a factor of 10 reduction don't seem like a 
significant issue.

> 
>> +					 mhi_cntrl->timeout_ms * 1000);
>> +		if (ret) {
>> +			dev_info(dev, "Failed to reset syserr\n");
> 
> dev_info(dev, "Failed to reset MHI due to syserr state\n"); ?
> 

Ah yes, that is clearer.  Thanks

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
