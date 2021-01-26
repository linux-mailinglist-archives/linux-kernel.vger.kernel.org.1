Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87447303A12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbhAZKTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:19:52 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:60454 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387450AbhAZBY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:24:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611624241; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=VQEIbhrLU9m+11s5BHDp50s8B60S1267RkQ7GGN1GuI=; b=w3KnckIWMZH+UjkPFjMnxLtbSZ4FAfJclbvLrdHzbbDL9x7ysnLeDCVTXcuAhZXgdehUY7AK
 fj32FgZ4LsYN/6vZ5Dg3lIhexv+TTDh0oPA9WA62Ug0LctQoZ4K7Wgxnzy3qAPUyU7pkSr+9
 PsVc+3KUUODi8uZ5/IhGvA1btMY=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 600f69fd5677aca7bd4031da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 01:01:49
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F15D3C43462; Tue, 26 Jan 2021 01:01:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.78.65] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85303C433ED;
        Tue, 26 Jan 2021 01:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85303C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v6 1/4] usb: gadget: udc: core: Introduce check_config to
 verify USB configuration
To:     Jack Pham <jackp@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.chen@nxp.com
References: <1611288100-31118-1-git-send-email-wcheng@codeaurora.org>
 <1611288100-31118-2-git-send-email-wcheng@codeaurora.org>
 <20210122051743.GE31406@jackp-linux.qualcomm.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <f5d04121-fd8c-9644-59c0-0ee8aa132de0@codeaurora.org>
Date:   Mon, 25 Jan 2021 17:01:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122051743.GE31406@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2021 9:17 PM, Jack Pham wrote:
> Hi Wesley,
> 
> On Thu, Jan 21, 2021 at 08:01:37PM -0800, Wesley Cheng wrote:
>> Some UDCs may have constraints on how many high bandwidth endpoints it can
>> support in a certain configuration.  This API allows for the composite
>> driver to pass down the total number of endpoints to the UDC so it can verify
>> it has the required resources to support the configuration.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/gadget/udc/core.c | 9 +++++++++
>>  include/linux/usb/gadget.h    | 2 ++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index 4173acd..469962f 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -1003,6 +1003,15 @@ int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
>>  }
>>  EXPORT_SYMBOL_GPL(usb_gadget_ep_match_desc);
>>  
>> +int usb_gadget_check_config(struct usb_gadget *gadget, unsigned long ep_map)
> 
> You should probably add a kernel-doc for this function.
> 
> Jack
> 
Hi Jack,

Sure, I'll update a bit more about how this API can be used.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
