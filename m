Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56A2EF526
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbhAHPva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbhAHPv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:51:29 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E663C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 07:50:49 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d14so8724502qkc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RShwhxNNB7mro1W41lgbOt7kTFWawL/XQey3OhJ8rLo=;
        b=Z9jvN3z9WiHgage3vqrtjvqjTwV14DMiBrcq3ZM+31dAB0LJiTY4ZF+vRnW1v1aV1+
         42LWbUjDlwn+2ryHkqUT5tH154aaoHbyf9Qx8N9J8fYmJZE6furU/aIlSGMhUEAi9qBU
         Ik6oUo+GUH2wlraskoNex7BWmv7EpTWa0A/MiuW2S/2d25LYlvyocsdRvEspm+EzzPd3
         xL1S3WRZ0hefZ9GFUtE79U2CTFCyz3JNTxRh2zR1hAxX4ws8NQnxczSzYffYYXKybB71
         1yyPlSXg0vXk/0Nv3aW1/ZGoc1HCiqtlc6M/6yo3yR4wZRTtzAbwUQ2uHaeEndD10Ipa
         bMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RShwhxNNB7mro1W41lgbOt7kTFWawL/XQey3OhJ8rLo=;
        b=QyJxTUuNKO9GMXVPSlozrGQUQy5n52OXgGbluGNduYKiOREiXrEqykpPdaRGLmPkSx
         eMyhavl4npW08fUJRQiaUJ/spzrXBip5GFZZla4tW4tYohFM9kmaIejndR84UKcU6HkX
         l1P6ZBmG7cZKZWAjtp3Q96OkFjbEXecnO6SymRRNkTN0EuXk762BcaCj8eoacB7wD68M
         gjfZILsg4/zcqp1qXURSfa+ntEMPEEveDIZy3dg93YXbQ0BQNTK6F6+54JgQbqxEouLg
         a9VB0llBFVv23SDDmgYLpP4YYoFtdNiD3VfEr8YDZLV9IHMyfe9Bllvx40nBQZTsdvdm
         Y7Cw==
X-Gm-Message-State: AOAM531fUsNgfpUyJ71KjSBqvlpykSDThd/7ZCTIgUT154V3+W20hglY
        JI8atCyt7ittlXIfDS3A3RQErA==
X-Google-Smtp-Source: ABdhPJxoRaafjN0BywXFHIou7azxrRb5ptwJjUlO3JQzCTrfYfKYEWe7dCoYwBHwSiFV90ia0fmNSA==
X-Received: by 2002:a37:495:: with SMTP id 143mr4359412qke.37.1610121048261;
        Fri, 08 Jan 2021 07:50:48 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id k64sm4970961qkc.110.2021.01.08.07.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:50:47 -0800 (PST)
Subject: Re: [PATCH v4 02/37] firmware: arm_scmi: introduce protocol handle
 definitions
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-3-cristian.marussi@arm.com>
 <19054e89-c117-ef85-444e-8e126a8a9efb@linaro.org>
 <20210108120428.GB9138@e120937-lin>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <3b688bdf-46c4-5263-66c9-60f9b3b26588@linaro.org>
Date:   Fri, 8 Jan 2021 10:50:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108120428.GB9138@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/21 7:04 AM, Cristian Marussi wrote:
> Hi Thara
> 
> thanks for reviewing.
> 
> On Thu, Jan 07, 2021 at 09:29:17AM -0500, Thara Gopinath wrote:
>>
>>
>> On 1/6/21 3:15 PM, Cristian Marussi wrote:
>>> Add basic protocol handles definitions and private data helpers support.
>>>
>>> A protocol handle identifies a protocol instance initialized against a
>>> specific handle; it embeds all the references to the core SCMI xfer methods
>>> that will be needed by a protocol implementation to build and send its own
>>> protocol specific messages using common core methods.
>>>
>>> As such, in the interface, a protocol handle will be passed down from the
>>> core to the protocol specific initialization callback at init time.
>>>
>>> Anyway at this point only definitions are introduced, all protocols
>>> initialization code and SCMI drivers probing is still based on the old
>>> interface, so no functional change.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>    drivers/firmware/arm_scmi/common.h | 59 ++++++++++++++++++++++++++++++
>>>    drivers/firmware/arm_scmi/driver.c | 45 +++++++++++++++++++++++
>>>    2 files changed, 104 insertions(+)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
>>> index e052507dc918..977e31224efe 100644
>>> --- a/drivers/firmware/arm_scmi/common.h
>>> +++ b/drivers/firmware/arm_scmi/common.h
>>> @@ -149,6 +149,65 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
>>>    		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
>>>    void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
>>>    			    struct scmi_xfer *xfer);
>>> +
>>> +struct scmi_xfer_ops;
>>> +
>>> +/**
>>> + * struct scmi_protocol_handle  - Reference to an initialized protocol instance
>>> + *
>>> + * @dev: A reference to the associated SCMI instance device (handle->dev).
>>> + * @xops: A reference to a struct holding refs to the core xfer operations that
>>> + *	  can be used by the protocol implementation to generate SCMI messages.
>>> + * @set_priv: A method to set protocol private data for this instance.
>>> + * @get_priv: A method to get protocol private data previously set.
>>> + *
>>> + * This structure represents a protocol initialized against specific SCMI
>>> + * instance and it will be used as follows:
>>> + * - as a parameter fed from the core to the protocol initialization code so
>>> + *   that it can access the core xfer operations to build and generate SCMI
>>> + *   messages exclusively for the specific underlying protocol instance.
>>> + * - as an opaque handle fed by an SCMI driver user when it tries to access
>>> + *   this protocol through its own protocol operations.
>>> + *   In this case this handle will be returned as an opaque object together
>>> + *   with the related protocol operations when the SCMI driver tries to access
>>> + *   the protocol.
>>> + */
>>> +struct scmi_protocol_handle {
>>> +	struct device *dev;
>>> +	const struct scmi_xfer_ops *xops;
>>> +	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
>>> +	void *(*get_priv)(const struct scmi_protocol_handle *ph);
>>> +};
>>> +
>>> +/**
>>> + * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
>>> + * @version_get: Get this version protocol.
>>> + * @xfer_get_init: Initialize one struct xfer if any xfer slot is free.
>>> + * @reset_rx_to_maxsz: Reset rx size to max transport size.
>>> + * @do_xfer: Do the SCMI transfer.
>>> + * @do_xfer_with_response: Do the SCMI transfer waiting for a response.
>>> + * @xfer_put: Free the xfer slot.
>>> + *
>>> + * Note that all this operations expect a protocol handle as first parameter;
>>> + * they then internally use it to infer the underlying protocol number: this
>>> + * way is not possible for a protocol implementation to forge messages for
>>> + * another protocol.
>>> + */
>>> +struct scmi_xfer_ops {
>>
>> Maybe move the definition above struct scmi_protocol_handle to avoid a
>> declaration ?
>>
> 
> But all the ops defined inside scmi_xfer_ops refers then to a param
> struct scmi_protocol_handle, so I'd need anyway a similar declaration
> the other way around.
> 
> If not:
> 
> linux/drivers/firmware/arm_scmi/common.h:178:32: warning: ‘struct scmi_protocol_handle’ declared inside parameter list will not be visible outside of this definition or declaration

Ya. got it. I had not realized this.
> 
> Thanks
> 
> Cristian
>>
>> -- 
>> Warm Regards
>> Thara

-- 
Warm Regards
Thara
