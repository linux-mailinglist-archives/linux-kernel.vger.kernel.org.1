Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138E928D806
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgJNBhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:37:12 -0400
Received: from z5.mailgun.us ([104.130.96.5]:29522 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbgJNBhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:37:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602639431; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=zZR8VSgMqBaFL9C1zIJLtQgD3Gs14v/MrR9tD4SppCA=;
 b=mhrOKIm0hwEUm4AY67Nfy4IhK6mTKQ37TEcXvVLKlMF+2JdU9DPFoz+/8ae52S35cEchCh+y
 YxzKGUlQ7jd49kTAVRsXo17G5g5JhXrY+mZFoO+87RgPikaqcLz3QQPJwswBravR0W0uT09O
 dhD86C9kEfo9dRQIZZT7iMLzWCc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f865646ef891f1ee2b4772b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Oct 2020 01:37:10
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0296CC433FF; Wed, 14 Oct 2020 01:37:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 697FDC433C9;
        Wed, 14 Oct 2020 01:37:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Oct 2020 18:37:09 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/10] bus: mhi: core: Move to an error state on any
 firmware load failure
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <20201009164235.GI4810@Mani-XPS-13-9360>
References: <1600480955-16827-1-git-send-email-bbhatt@codeaurora.org>
 <1600480955-16827-9-git-send-email-bbhatt@codeaurora.org>
 <20201009164235.GI4810@Mani-XPS-13-9360>
Message-ID: <690515d16d21eec14b527982630968e3@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-09 09:42, Manivannan Sadhasivam wrote:
> On Fri, Sep 18, 2020 at 07:02:33PM -0700, Bhaumik Bhatt wrote:
>> Move MHI to a firmware download error state for a failure to find
>> the firmware files or to load SBL or EBL image using BHI/BHIe. This
>> helps detect an error state sooner and shortens the wait for a
>> synchronous power up timeout.
>> 
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
>>  drivers/bus/mhi/core/boot.c | 43 
>> +++++++++++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 18 deletions(-)
>> 
>> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
>> index 92b8dd3..fcc71f2 100644
>> --- a/drivers/bus/mhi/core/boot.c
>> +++ b/drivers/bus/mhi/core/boot.c
> 
> [...]
> 
>> -error_read:
>> +error_ready_state:
>>  	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
>>  	mhi_cntrl->fbc_image = NULL;
>> 
>> -error_alloc_fw_table:
>> -	release_firmware(firmware);
>> +error_fw_load:
>> +	write_lock_irq(&mhi_cntrl->pm_lock);
>> +	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
>> +	wake_up_all(&mhi_cntrl->state_event);
> 
> Do you really need pm_lock for this?
> 
> Thanks,
> Mani
> 
Not really, the underlying usage does not matter if this lock is used or
not. We just want to error out so removing it.
>> +	write_unlock_irq(&mhi_cntrl->pm_lock);
>>  }
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
