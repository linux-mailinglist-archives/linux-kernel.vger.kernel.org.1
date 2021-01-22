Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10D2FFB20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAVDde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:33:34 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:30085 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbhAVDdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:33:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611286378; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Yo6hdkp/knS7f7SvcKF1u2WZQ3qjT6GjvT7DGNBizLw=; b=VHXGcw8moq3E1SbEIytElGWz1z+JHCMFvLZQScOIxZqNMExymuCYwlu8f4LpIfYa7taynTr/
 L/SFYT1OdvYc3tNBGQzq1BEVLhQDopiYLq9MW309p90z6Zn7kKSyypzeFV+pnLWPVeczpAUE
 etZ1kLr0u2qvpVdmaW5WGMLTw10=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 600a4740ad4c9e395b979989 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Jan 2021 03:32:16
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82EDBC433CA; Fri, 22 Jan 2021 03:32:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.7.112] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EECCC433C6;
        Fri, 22 Jan 2021 03:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EECCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
To:     eg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "supporter:USB SUBSYSTEM open list:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
 <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
 <fbde7781-8eef-ab3a-a339-8a2f61ca83be@synopsys.com>
 <20210121064956.GA69382@ubuntu>
 <6c6429da-5d27-2d6a-9bcf-3606810e71a6@codeaurora.org>
 <20210121081333.GA2977@ubuntu>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <c8e2d476-e7a2-64ba-2fcd-eb94b32691ac@codeaurora.org>
Date:   Thu, 21 Jan 2021 19:32:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121081333.GA2977@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2021 12:13 AM, Jung Daehwan wrote:
> On Wed, Jan 20, 2021 at 11:44:05PM -0800, Wesley Cheng wrote:
>>
>>
>> On 1/20/2021 10:49 PM, Jung Daehwan wrote:
>>> Hi,
>>>
>>> On Thu, Jan 21, 2021 at 01:00:32AM +0000, Thinh Nguyen wrote:
>>>> Hi,
>>>>
>>>> Daehwan Jung wrote:
>>>>> Sometimes dwc3_gadget_pullup and dwc3_gadget_set_speed are called after
>>>>> entering suspend. That's why it needs to check whether suspend
>>>>>
>>>>> 1. dwc3 sends disconnect uevent and turn off. (suspend)
>>>>> 2. Platform side causes pullup or set_speed(e.g., adbd closes ffs node)
>>>>> 3. It causes unexpected behavior like ITMON error.
>>>>>
>>>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>>>> ---
>>>>>  drivers/usb/dwc3/gadget.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>> index ee44321..d7d4202 100644
>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>> @@ -2093,6 +2093,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>>  	unsigned long		flags;
>>>>>  	int			ret;
>>>>>  
>>>>> +	if (pm_runtime_suspended(dwc->dev))
>>>>> +		return 0;
>>>>> +
>>>>>  	is_on = !!is_on;
>>>>>  
>>>>>  	/*
>>>>> @@ -2403,6 +2406,9 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
>>>>>  	unsigned long		flags;
>>>>>  	u32			reg;
>>>>>  
>>>>> +	if (pm_runtime_suspended(dwc->dev))
>>>>> +		return;
>>>>> +
>>>>>  	spin_lock_irqsave(&dwc->lock, flags);
>>>>>  	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
>>>>>  	reg &= ~(DWC3_DCFG_SPEED_MASK);
>>>>
>>>> This is already addressed in Wesley Cheng's patches. Can you try the
>>>> latest changes of DWC3 in Greg's usb-next branch?
>>>>
>>>> Thanks,
>>>> Thinh
>>>
>>> I checked Wesly Cheng's pathces but it's not same.
>>> What I want to do for this patch is to avoid pullup from platform side.
>>> (android in my case)
>>>
>>> It's possible that platform side tries to pullup by UDC_Store after usb is already disconnected.
>>> It can finally run controller and enable irq.
>>>
>>> I think we have to avoid it and other possible things related to platform side.
>>>
>>>
>>
>> Hi Daehwan,
>>
>> I think what you're trying to do is to avoid the unnecessary runtime
>> resume if the cable is disconnected and userspace attempts to
>> bind/unbind the UDC.
>>
>> I'm not exactly sure what patches you've pulled in, but assuming you
>> didn't pull in any of the recent suspend changes:
>>
>> usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
>> usb: dwc3: gadget: Preserve UDC max speed setting
>>
>> Please consider the following scenario:
>> 1.  USB connected
>> 2.  UDC unbinded
>> 3.  DWC3 will continue to stay in runtime active, since dwc->connected =
>> true
>>
>> In this scenario, we should allow the DWC3 to enter runtime suspend,
>> since runstop has been disabled.
>>
>> If you have pulled in the above changes, and adding your changes on top
>> of it, then consider the following:
>> 1.  USB connected
>> 2.  UDC unbinded
>> 3.  DWC enters runtime suspend (due to the above changes)
>> 4.  UDC binded
>>
>> The check for pm_runtime_suspended() will block step#4 from re-enabling
>> the runstop bit even if the USB cable is connected.
>>
>> Thanks
>> Wesley Cheng
>>
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 
> Hi Wesley
> 
> The check for runtime_suspended() will block re-enabling the runstop bit as
> you said after pulling your patches in.
> 
> UDC is contolled by userspace and it's possible UDC can be binded
> unexpectedly. That's why I think it needs to handle it even if the
> problem is from userspace.
> 
> Below is an example in my environment.
> 
> 1. USB disconnected
> 2. UDC unbinded
> 3. DWC enters runtime suspend
> 4. UDC binded unexpectedly
> 5. Gadget start and enable irq
> 
Hi Daehwan,

If this is an unexpected event where userspace initiates the UDC bind
sequence, then after the above sequence occurs, the DWC3 device should
still be able to re-enter runtime suspend after the autosuspend timer
expires.  Since the cable is disconnected, the dwc->connected flag would
still be false.  Is this not happening in your situation?

I'm just trying to understand what issue you're seeing other than the
momentary transition from runtime suspend (due to cable disconnect)
-->runtime resume (due to unexpected UDC bind) --> runtime  suspend (due
to nothing connected).

Thanks
Wesley Cheng

> 
> Line 9823: [   36.024428][ T2889] dwc3 10e00000.dwc3: Turn off gadget dwc3-gadget
> Line 9827: [   36.024572][ T2889] __dwc3_gadget_stop called
> Line 9828: [   36.025083][ T2603] android_work: sent uevent USB_STATE=DISCONNECTED
> Line 9842: [   36.200896][  T554] usb_gadget_disconnect
> Line 9843: [   36.200916][  T554] dwc3_gadget_pullup : 0
> Line 9844: [   36.201165][  T554] dwc3_gadget_pullup: get_sync fail
> Line 9845: [   36.201197][  T554] dwc3_gadget_stop called
> Line 9846: [   36.201250][  T451] android_work: did not send uevent (0 0 0000000000000000)
> Line 9849: [   36.202343][    T1] init: processing action (sys.usb.config=adb && sys.usb.configfs=1..
> Line 9851: [   36.203622][    T1] dwc3_gadget_start called
> Line 9852: [   36.204079][    T1] usb_gadget_connect
> Line 9853: [   36.204086][    T1] dwc3_gadget_pullup : 1
> Line 9854: [   36.204091][    T1] __dwc3_gadget_start called
> 
> Best Regrars,
> Jung Daehwan
> 
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
