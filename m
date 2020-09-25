Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7C2791C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIYUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:12:45 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:24813 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgIYUKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:10:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601064632; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=g+9rhQIvr1fpY91HSg3TCT9sEG1QB73VLn80CsYZKxw=; b=CzYImcKcBUCQ8FxNOMxWmaAt41R5MCjwb/S8WLn9lT97VNjdAhnqcY/jk+FRFpgTGngnhiz8
 HDfnek9zHUZK4GyZJ1rg/u1vjSgyRZ/JiUfWQxGX70T2wlZ24wJMnADPPthSSNTfLKIhTV66
 mvURgI+g0idOp4gaFJQ3cADWjL4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f6e45ffebb17452ba5fd194 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 19:33:19
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 414E3C433CB; Fri, 25 Sep 2020 19:33:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.7.221] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3B42C433CA;
        Fri, 25 Sep 2020 19:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3B42C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
To:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
References: <20200903210954.24504-1-wcheng@codeaurora.org>
 <87o8mi151l.fsf@kernel.org>
 <010101746fab2ee1-91b46c27-fef0-4266-94cb-14dea5ca350e-000000@us-west-2.amazonses.com>
 <877dsjei8j.fsf@kernel.org> <20200924155005.GB1337044@rowland.harvard.edu>
 <87mu1ecruw.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <41e8c184-1e14-6d4b-3945-48e3d6b54523@codeaurora.org>
Date:   Fri, 25 Sep 2020 12:33:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87mu1ecruw.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2020 11:06 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Alan Stern <stern@rowland.harvard.edu> writes:
>>>> Hence, the reason if there was already a pending IRQ triggered, the
>>>> dwc3_gadget_disable_irq() won't ensure the IRQ is handled.  We can do
>>>> something like:
>>>> if (!is_on)
>>>> 	dwc3_gadget_disable_irq()
>>>> synchronize_irq()
>>>> spin_lock_irqsave()
>>>> if(!is_on) {
>>>> ...
>>>>
>>>> But the logic to only apply this on the pullup removal case is a little
>>>> messy.  Also, from my understanding, the spin_lock_irqsave() will only
>>>> disable the local CPU IRQs, but not the interrupt line on the GIC, which
>>>> means other CPUs can handle it, unless we explicitly set the IRQ
>>>> affinity to CPUX.
>>>
>>> Yeah, the way I understand this can't really happen. But I'm open to
>>> being educated. Maybe Alan can explain if this is really possibility?
>>

Hi Felipe/Alan,

Thanks for the detailed explanations and inputs.  Useful information to
have!

>> It depends on the details of the hardware, but yes, it is possible in
>> general for an interrupt handler to run after you have turned off the
>> device's interrupt-request line.  For example:
>>
>> 	CPU A				CPU B
>> 	---------------------------	----------------------
>> 	Gets an IRQ from the device
>> 	Calls handler routine		spin_lock_irq
>> 	  spin_lock_irq			Turns off the IRQ line
>> 	  ...spins...			spin_unlock_irq
>> 	  Rest of handler runs
>> 	  spin_unlock_irq
>>
>> That's why we have synchronize_irq().  The usual pattern is something
>> like this:
>>
>> 	spin_lock_irq(&priv->lock);
>> 	priv->disconnected = true;
>> 	my_disable_irq(priv);
>> 	spin_unlock_irq(&priv->lock);
>> 	synchronize_irq(priv->irq);
>>
>> And of course this has to be done in a context that can sleep.
>>
>> Does this answer your question?
> 
> It does, thank you Alan. It seems like we don't need a call to
> disable_irq(), only synchronize_irq() is enough, however it should be
> called with spinlocks released, not held.
> 

I mean...I'm not against using the synchronize_irq() +
dwc3_gadget_disable_irq() route, since that will address the concern as
well.  It was just with the disable/enable IRQ route, I didn't need to
explicitly check the is_on flag again, since I didn't need to worry
about overwriting the DEVTEN reg (for the pullup enable case).  Will
include this on the next version.

Thanks
Wesley Cheng

> Thanks
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
