Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC82A589E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbgKCVxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:53:14 -0500
Received: from z5.mailgun.us ([104.130.96.5]:50063 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388295AbgKCVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:53:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604440389; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RAH6NHCZ23WV/V4EE9neHeIyRy1eixbFuGon9dmhq0M=; b=eik7sPaaM8D/dAKZJUSKWLhR8i2PSJok+S4q6IDdD+LH5PL+Ky01G0Y/fgb0jjftSwbbdY8R
 +PQLGcWewY33Y4zY0PcWqgJPhxUkq2uyIeVXo0HvcWExGE6A/v762jJKQq6pJFbJ0w5Evj3j
 MgGRBcXAL2pzK9GClwNt3tkwoIY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fa1d141ca0638c0dcfebe5e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 21:53:05
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9B36C433C8; Tue,  3 Nov 2020 21:53:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.114.182] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C8B3C433C8;
        Tue,  3 Nov 2020 21:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C8B3C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: Allow runtime suspend if UDC
 unbinded
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jackp@codeaurora.org
References: <20201028234311.6464-1-wcheng@codeaurora.org>
 <20201028234311.6464-2-wcheng@codeaurora.org>
 <20201029010748.GA1303156@rowland.harvard.edu>
 <a47d78f3-0a11-9de8-dbea-ad745d496845@codeaurora.org>
 <20201103200716.GA1538425@rowland.harvard.edu>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <57d56507-e2f7-bce8-2445-95820db25fc8@codeaurora.org>
Date:   Tue, 3 Nov 2020 13:53:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103200716.GA1538425@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2020 12:07 PM, Alan Stern wrote:
> On Tue, Nov 03, 2020 at 11:02:25AM -0800, Wesley Cheng wrote:
>>
>>
>> On 10/28/2020 6:07 PM, Alan Stern wrote:
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -1995,6 +1995,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>  	unsigned long		flags;
>>>>  	int			ret;
>>>>  
>>>> +	if (pm_runtime_suspended(dwc->dev)) {
>>>> +		pm_request_resume(dwc->dev);
>>>> +		return 0;
>>>> +	}
>>>
>>> Isn't this racy?  What happens if the controller was active but a 
>>> runtime suspend occurs right here?
>>>
>>> Alan Stern
>>>
>>
>> Hi Alan,
>>
>> Ah, yes you're right.  I was hoping that the PM runtime layer would be
>> utilizing the spinlock when reading out the runtime status, but even
>> then, we wouldn't be able to catch intermediate states with this API
>> (i.e. RPM_RESUMING or RPM_SUSPENDING)
>>
>> Tried a few different approaches, and came up with something like the
>> following:
>>
>> static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>> {
>> ...
>> 	ret = pm_runtime_get_sync(dwc->dev);
>> 	if (!ret) {
>> 		pm_runtime_put(dwc->dev);
>> 		return 0;
>> 	}
>> 	...
>> 	pm_runtime_put(dwc->dev);
>>
>> 	return 0;
>> }
>>
>> I think this should be good to address your concern.  The only way we
>> would be able to ensure that the runtime PM state doesn't enter
>> idle/suspend is if we increment the usage count for the duration we're
>> accessing the DWC3 registers.  With the synchronous PM runtime resume
>> call, we can also ensure that no pending runtime suspends are executing
>> in parallel while running this code.
> 
> That's correct.
> 
>> The check for the zero return value would be for avoiding running the
>> DWC3 run stop sequence for the case where we executed the runtime PM
>> resume, as the DWC3 runtime PM resume routine will set the run stop bit
>> in there.
> 
> If you need to add an explanation of this subtle point in your email 
> message, then you should add a similar explanation as a comment in the 
> code.  And don't forget to check for ret < 0 (i.e., a resume error).
> 

Hi Alan,

Got it, will do.  Yes, I'll include the error conditions as well in the
actual change.  Thanks again!

Thanks

Regards,
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
