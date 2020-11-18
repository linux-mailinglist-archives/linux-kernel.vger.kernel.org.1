Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106A52B8451
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKRTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:01:52 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:35583 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgKRTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:01:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605726110; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=dp59ll0cwi4fKbOjXmQC9h9P16VEfYIK+g8aTYDxuP0=; b=TfSkdfYjWUBB+P38HAHO30NKBH5JEHOk7JBjKBD8rh193zkkYFbLLe+RN4vhhA9VBpwgtEbi
 MrACZ2QtNhVrF6csWiKY6rsjk+wXqu39+D4GYd3nSz4yuhpephBcq1WVxM61PKNJuez0fB9Y
 OIXwc0z+J3iXUAxcblpXrH4yKLQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fb56f78a5c560669c81d8eb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Nov 2020 19:01:12
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D959BC43460; Wed, 18 Nov 2020 19:01:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.117.159] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E1B7C43463;
        Wed, 18 Nov 2020 19:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E1B7C43463
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v4] usb: dwc3: Stop active transfers before halting the
 controller
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, thinhn@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
References: <20200929002059.26714-1-wcheng@codeaurora.org>
 <20201118101430.GC23024@pengutronix.de>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <db9df635-ac72-c5f1-387e-694fcad77385@codeaurora.org>
Date:   Wed, 18 Nov 2020 11:01:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201118101430.GC23024@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/2020 2:14 AM, Michael Tretter wrote:
> Hello,
> 
> On Mon, 28 Sep 2020 17:20:59 -0700, Wesley Cheng wrote:
>> In the DWC3 databook, for a device initiated disconnect or bus reset, the
>> driver is required to send dependxfer commands for any pending transfers.
>> In addition, before the controller can move to the halted state, the SW
>> needs to acknowledge any pending events.  If the controller is not halted
>> properly, there is a chance the controller will continue accessing stale or
>> freed TRBs and buffers.
> 
> This patch causes a regression when using the uvc gadget with the dwc3 gadget
> driver, which causes host to not be able to enumerate the USB device.
> 
> The regression can be reproduced as follows:
> 
> Configure the uvc gadget via configfs, which in the end binds to the driver
> and calls dwc3_gadget_start. Start the uvc-gadget user space application,
> which activates the function and the gadget and calls pullup enable. The UVC
> Device is now detected by a USB host.
> 
> Stop the uvc gadget application, which deactivates the gadget, calls pullup
> disable and, thus, stops the dwc3 gadget.
> 
Hi Michael,

Thanks for the analysis.  I think specifically, the f_uvc will use the
usb_function_deactivate() API to disable the pullup (w/o calling
udc_stop()) and using usb_function_activate() to do the opposite.  These
are triggered when an application opens/closes the V4L2 device. (your
application)

> Restart the uvc gadget application; the gadget is activated and pullup enable
> is called, but the dwc3 gadget is not started.
> 

Seems like the deactivate/activate calls avoid any UDC start stop
operations, and only use the pullup executions to issue a soft disconnect.

> The USB Host shows the following error messages and the USB device cannot be
> enumerated.
> 
> 	usb 3-1.1: Device not responding to setup address.
> 	usb 3-1.1: Device not responding to setup address.
> 	usb 3-1.1: device not accepting address 10, error -71
> 	usb 3-1.1: Device not responding to setup address.
> 	usb 3-1.1: Device not responding to setup address.
> 	usb 3-1.1: device not accepting address 11, error -71
> 	usb 3-1-port1: unable to enumerate USB device
> 
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
>>
>> ---
>> Changes in v4:
>>  - Updated comments to reference DWC3 databook sections and added direct
>>    quotes.
>>  - Changed the stop active transfer EP loop to use dwc->num_eps.
>>  - Moved to using dwc3_gadget_disable_irq/synchronize_irq instead of
>>    enable_irq/disable_irq for ensuring the interrupt handler is not pending.
>>
>> Changes in v3:
>>  - Removed DWC3_EP_ENABLED check from dwc3_gadget_stop_active_transfers()
>>    as dwc3_stop_active_transfer() has a check already in place.
>>  - Calling __dwc3_gadget_stop() which ensures that DWC3 interrupt events
>>    are cleared, and ep0 eps are cleared for the pullup disabled case.  Not
>>    required to call __dwc3_gadget_start() on pullup enable, as the
>>    composite driver will execute udc_start() before calling pullup().
> 
> This change seems to be related to the regression. Maybe it is required to
> call __dwc3_gadget_start() on pullup enable, but I am not sure, how this
> should be handled.
> 
> Michael
> 

Definitely, in this situation, we would not call the udc_start()
callback, which will affect the functionality after re-enabling the
device.  I wonder why the deactivate/activate routines don't explicitly
need to start/stop the UDC?

Thanks
Wesley Cheng

>>
>> Changes in v2:
>>  - Moved cleanup code to the pullup() API to differentiate between device
>>    disconnect and hibernation.
>>  - Added cleanup code to the bus reset case as well.
>>  - Verified the move to pullup() did not reproduce the problen using the
>>    same test sequence.
>>
>> Verified fix by adding a check for ETIMEDOUT during the run stop call.
>> Shell script writing to the configfs UDC file to trigger disconnect and
>> connect.  Batch script to have PC execute data transfers over adb (ie adb
>> push)  After a few iterations, we'd run into a scenario where the
>> controller wasn't halted.  With the following change, no failed halts after
>> many iterations.
>> ---
>>  drivers/usb/dwc3/ep0.c    |  2 +-
>>  drivers/usb/dwc3/gadget.c | 66 ++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 59f2e8c31bd1..456aa87e8778 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>  	int				ret;
>>  
>>  	spin_lock_irqsave(&dwc->lock, flags);
>> -	if (!dep->endpoint.desc) {
>> +	if (!dep->endpoint.desc || !dwc->pullups_connected) {
>>  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>>  				dep->name);
>>  		ret = -ESHUTDOWN;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 3ab6f118c508..5d879b7606d5 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1516,7 +1516,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>>  {
>>  	struct dwc3		*dwc = dep->dwc;
>>  
>> -	if (!dep->endpoint.desc) {
>> +	if (!dep->endpoint.desc || !dwc->pullups_connected) {
>>  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>>  				dep->name);
>>  		return -ESHUTDOWN;
>> @@ -1926,6 +1926,21 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
>>  	return 0;
>>  }
>>  
>> +static void dwc3_stop_active_transfers(struct dwc3 *dwc)
>> +{
>> +	u32 epnum;
>> +
>> +	for (epnum = 2; epnum < dwc->num_eps; epnum++) {
>> +		struct dwc3_ep *dep;
>> +
>> +		dep = dwc->eps[epnum];
>> +		if (!dep)
>> +			continue;
>> +
>> +		dwc3_remove_requests(dwc, dep);
>> +	}
>> +}
>> +
>>  static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>>  {
>>  	u32			reg;
>> @@ -1971,6 +1986,9 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>>  	return 0;
>>  }
>>  
>> +static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
>> +static void __dwc3_gadget_stop(struct dwc3 *dwc);
>> +
>>  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  {
>>  	struct dwc3		*dwc = gadget_to_dwc(g);
>> @@ -1994,7 +2012,46 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * Synchronize any pending event handling before executing the controller
>> +	 * halt routine.
>> +	 */
>> +	if (!is_on) {
>> +		dwc3_gadget_disable_irq(dwc);
>> +		synchronize_irq(dwc->irq_gadget);
>> +	}
>> +
>>  	spin_lock_irqsave(&dwc->lock, flags);
>> +
>> +	if (!is_on) {
>> +		u32 count;
>> +
>> +		/*
>> +		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
>> +		 * Section 4.1.8 Table 4-7, it states that for a device-initiated
>> +		 * disconnect, the SW needs to ensure that it sends "a DEPENDXFER
>> +		 * command for any active transfers" before clearing the RunStop
>> +		 * bit.
>> +		 */
>> +		dwc3_stop_active_transfers(dwc);
>> +		__dwc3_gadget_stop(dwc);
>> +
>> +		/*
>> +		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
>> +		 * Section 1.3.4, it mentions that for the DEVCTRLHLT bit, the
>> +		 * "software needs to acknowledge the events that are generated
>> +		 * (by writing to GEVNTCOUNTn) while it is waiting for this bit
>> +		 * to be set to '1'."
>> +		 */
>> +		count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>> +		count &= DWC3_GEVNTCOUNT_MASK;
>> +		if (count > 0) {
>> +			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>> +			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
>> +						dwc->ev_buf->length;
>> +		}
>> +	}
>> +
>>  	ret = dwc3_gadget_run_stop(dwc, is_on, false);
>>  	spin_unlock_irqrestore(&dwc->lock, flags);
>>  
>> @@ -3100,6 +3157,13 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>  	}
>>  
>>  	dwc3_reset_gadget(dwc);
>> +	/*
>> +	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
>> +	 * Section 4.1.2 Table 4-2, it states that during a USB reset, the SW
>> +	 * needs to ensure that it sends "a DEPENDXFER command for any active
>> +	 * transfers."
>> +	 */
>> +	dwc3_stop_active_transfers(dwc);
>>  
>>  	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>>  	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
