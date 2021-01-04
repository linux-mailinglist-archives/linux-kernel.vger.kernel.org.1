Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBED2E9DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhADTEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:04:33 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:21741 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:04:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609787053; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QTpavwTCJ+B9YOKn+dKdUJ6I+6zsOo5/3Z8vcqfFijM=; b=rilKWOYZfIiTe8bAg4H343W2Ht06hLboQRAUNoZiEi7rsn90vazk240q5jRVYrOOQ1Ik3/Vq
 FiA5DjrwQrOV1JvZT2n4XH1lHWGApB6nrNeLN9P8z2sDp82G4VMJT36B1EyweZfnpCfoJrg6
 7IIZFfOGA2loVrS/pz0LF12seL8=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ff3668cd3eb3c36b4e0ab10 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Jan 2021 19:03:40
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED0DBC433CA; Mon,  4 Jan 2021 19:03:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.33.65] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6CCBC433C6;
        Mon,  4 Jan 2021 19:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6CCBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH 3/3] usb: gadget: configfs: Add a specific configFS reset
 callback
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peter.chen@nxp.com, balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-4-git-send-email-wcheng@codeaurora.org>
 <X/M4EaLuiuHstHeX@kroah.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <81ae4b83-2dd8-e605-4f7b-e7b63f959d8d@codeaurora.org>
Date:   Mon, 4 Jan 2021 11:03:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/M4EaLuiuHstHeX@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/2021 7:45 AM, Greg KH wrote:
> On Tue, Dec 29, 2020 at 03:03:31PM -0800, Wesley Cheng wrote:
>> In order for configFS based USB gadgets to set the proper charge current
>> for bus reset scenarios, expose a separate reset callback to set the
>> current to 100mA based on the USB battery charging specification.
>>
>> Reviewed-by: Peter Chen <peter.chen@nxp.com>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/gadget/configfs.c | 24 +++++++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
>> index 56051bb97349..80ca7ff2fb97 100644
>> --- a/drivers/usb/gadget/configfs.c
>> +++ b/drivers/usb/gadget/configfs.c
>> @@ -1481,6 +1481,28 @@ static void configfs_composite_disconnect(struct usb_gadget *gadget)
>>  	spin_unlock_irqrestore(&gi->spinlock, flags);
>>  }
>>  
>> +static void configfs_composite_reset(struct usb_gadget *gadget)
>> +{
>> +	struct usb_composite_dev *cdev;
>> +	struct gadget_info *gi;
>> +	unsigned long flags;
>> +
>> +	cdev = get_gadget_data(gadget);
>> +	if (!cdev)
>> +		return;
>> +
>> +	gi = container_of(cdev, struct gadget_info, cdev);
>> +	spin_lock_irqsave(&gi->spinlock, flags);
>> +	cdev = get_gadget_data(gadget);
>> +	if (!cdev || gi->unbind) {
>> +		spin_unlock_irqrestore(&gi->spinlock, flags);
>> +		return;
>> +	}
>> +
>> +	composite_reset(gadget);
>> +	spin_unlock_irqrestore(&gi->spinlock, flags);
>> +}
>> +
>>  static void configfs_composite_suspend(struct usb_gadget *gadget)
>>  {
>>  	struct usb_composite_dev *cdev;
>> @@ -1530,7 +1552,7 @@ static const struct usb_gadget_driver configfs_driver_template = {
>>  	.unbind         = configfs_composite_unbind,
>>  
>>  	.setup          = configfs_composite_setup,
>> -	.reset          = configfs_composite_disconnect,
>> +	.reset          = configfs_composite_reset,
>>  	.disconnect     = configfs_composite_disconnect,
>>  
>>  	.suspend	= configfs_composite_suspend,
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 
> So this changes the existing userspace functionality?  What will break
> because of this now unexpected change?
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

Happy new years!  This wouldn't affect the userspace interaction with
configFS, as this is modifying the reset callback for the UDC core.  The
reset callback is only executed during usb_gadget_udc_reset(), which is
specifically run when vendor UDC drivers (i.e. DWC3 gadget) receive a
USB bus reset interrupt.  This is similar to the composite.c patch,
because for configFS based gadgets, they do not directly register the
USB composite ops and have their own routines.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
