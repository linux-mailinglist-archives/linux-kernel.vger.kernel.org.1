Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3722A2A996F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgKFQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgKFQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:26:46 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:26:46 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so1133872qtp.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BS6hnd+mn2KOb96zjpH6hQK2KHkxoDPNVR2pa7FD2yE=;
        b=PcFL9oHLE7kDCMw4fCngNIyZoVhs9qIObXlFNgPNXVvlp6jZw8Qzs18oA9Jmwv24Lg
         cmcuYmY2lGEUgEzwc7mYN9EEo20fyVLz8qnwsDfKDxxLkynU8tbH4F0ZIISJTqaVKfZQ
         U1piVPmoijhzCKeCW3LrKP4DTwv3D73ZB3fTDOWodEZ4cwtawnOmFy4qQ+1i7Pe70I9m
         rhQMgVgtqASq7AubWErhQWjxPCvqtdLMpmRaRJC5PaRoROOeksmKttOZgX/uHVgGx/jz
         0UwzE3qS0fCE2DQ8SzB2rnJZzXZf692NttfPRqWTV6dFp2gTEQdcs9S5zjTgU88Z+zWu
         Mmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BS6hnd+mn2KOb96zjpH6hQK2KHkxoDPNVR2pa7FD2yE=;
        b=aX8Arcu9BsjFY035h2ts1kCHfVYdRO4CfSN58oZjeDIBFd94G25qU4/VLvFiQhhaef
         OC+HgofgYTeOclrg/cpy7yqq29b+DG5tGrH/XIcUIFVEvC6gHyz2U1cAWHBl4Ysm/V1K
         KZG9rNwBuIeM1r9WWr/qcJTC7mDyXZuopNnI7ZbgIGYgKBxHjYrCUNgJKkOHDwj8nMaI
         B+pMYboVYVt0ZK/pWD1dnupSh8LcA8eHJ3FUb6iqNedEUDQo/LPJtroYTf1voS677Eq6
         54rmFoFHwSeL4OFYokRr7nOs1/BQGHVLmghhCNL0NoSeSpwYVnMbUoKIwK4u5LxRAfVi
         uBoA==
X-Gm-Message-State: AOAM533g4sKGMxFggPwprkErMdhaAz5yKyEBszoGC5ylclaiip0W/jE+
        EzkpJjQHsOBQmNxdOXelbzw+TA==
X-Google-Smtp-Source: ABdhPJyN55QAu4juuLhQCFMe0eug0jiDEy+gUhi5BMg0fU7MFFk/abEed+QXGKQ8P8QjlTwDbFwWKA==
X-Received: by 2002:aed:3048:: with SMTP id 66mr2298658qte.374.1604680005666;
        Fri, 06 Nov 2020 08:26:45 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id u31sm828224qtu.87.2020.11.06.08.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:26:44 -0800 (PST)
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: introduce protocol handles
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-3-cristian.marussi@arm.com>
 <ceda764f-6cd9-9e47-edc7-2e915c920301@linaro.org>
 <20201104174427.GB24640@e120937-lin>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <745d52d0-8578-6a25-c55e-e628d970e9fe@linaro.org>
Date:   Fri, 6 Nov 2020 11:26:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104174427.GB24640@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/20 12:44 PM, Cristian Marussi wrote:
> Hi
> 
> On Wed, Nov 04, 2020 at 11:16:18AM -0500, Thara Gopinath wrote:
>>
>> Hi Cristian,
>>
>> On 10/28/20 4:29 PM, Cristian Marussi wrote:
>>> Add basic protocol handles definitions and helpers support.
>>> All protocols initialization code and SCMI drivers probing is still
>>> performed using the handle based interface.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>    drivers/firmware/arm_scmi/common.h | 61 ++++++++++++++++++++++++++++
>>>    drivers/firmware/arm_scmi/driver.c | 64 ++++++++++++++++++++++++++++++
>>>    2 files changed, 125 insertions(+)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
>>> index b08a8ddbc22a..f0678be02a09 100644
>>> --- a/drivers/firmware/arm_scmi/common.h
>>> +++ b/drivers/firmware/arm_scmi/common.h
>>> @@ -151,6 +151,67 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
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
>>
>> So scmi_xfer_ops are the ops that actually talks with the scmi firmware on
>> the other end , right ? IIUC, these ops are the same for all the protocols
>> of a scmi instance. Imho, this struct is not the right place for these ops
>> to reside.You are inadvertently exposing scmi internal details to the client
>> drivers. There is no reason why this should be part of scmi_handle. The
>> protocols can extract it from the handle during protocol_reigster, right?
>>
>> So, now to the second part, why do you need a scmi_protocol_handle? Again
>> IIUC, if you have set_priv and get_priv hooks and get_ops and put_ops hooks,
>> there is nothing that scmi_protocol_handle is providing extra, right? As
>> mentioned in the comments for last patch any reason all of this cannot be
>> rolled into scmi_protocol?
> 
> The basic idea for protocol_hande existence is that the protocol code
> should be able to access the core xfer ops (without EXPORTing all
> scmi_xfer ops) but protoX should NOT be allowed to mistakenly or
> maliciously build and send protoY messages: since the protocol_handle
> for protoX is embedded in a specific protocol_instance in this way you
> can call from your protocol code something like:
> 
> ph->xops->xfer_get_init(ph, ...)

I am still confused by this one... scmi_protocol_instance has a pointer 
to scmi_handle. So why not handle->xops->xfer_get_init(pi, ....). Here 
also protoX will not be allowed to send protoY messages, right? And then 
again set_priv and get_priv can be moved to scmi_protocol_instance right ?


-- 
Warm Regards
Thara
