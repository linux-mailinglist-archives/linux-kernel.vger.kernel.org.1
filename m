Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E103D2A995F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKFQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:22:36 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:22:35 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so1569655qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=edoNJWygxeJVHDOmP1MncEg4eow8KJzkuE0Kv/Smc4U=;
        b=t73VP5rE0deQuI3gJuzRlqrZmh5Cr8eJKYVrO3vGIU+gfeWeKpQRv7XtZUnZsHc+xC
         qNEGrgy4pFuHX2lQ4vyav6aCa/Qk1bbUOV40qjegrkLZfbOnGyfInDUixYsW3Os7xWUT
         fyl3Dujb+8IdOWkgUmNB9ghg59jrI5YOAkQxLN44eZd9CGrbvE51P+taF7wKrs7wSwYU
         tWNSnLkDbDWSvZITcURT8ynkzPargyqGI4ex43yIo8iX63owRn3pZUgHOphilXJSX2MQ
         VdXMflq9riNSO1UAwiNJbPT6DXXFegMw4ns/RN8WBYa4V1dZv2BuacLir7ePYKfG6MXr
         JcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=edoNJWygxeJVHDOmP1MncEg4eow8KJzkuE0Kv/Smc4U=;
        b=PTtE4wWFisps9yaAoOWAGzX9cXVATaSdDA31wyxnfOuQXfKGkEGx+0cSfS2xipJABe
         nR7OoyCWLg2swBGytk71byOu3jfIXtk9bFIzgvF3jSWEuiybsn2zb36HysuEyOy7YmiX
         c/0Ipu4bSt2LKnuiNqoAyozwZwklDvOdwtSiItxwnkSYEfTlj6A5j7Ux5Fa7332htBrj
         VIBRLhBX/KaDz15Fl7eEcc3E0twuUjScSRfnulZKuca27sZbrvd9CpPwmL8UlJzL4cCn
         tMN5tPcWFknejBFQ/rR4B65aiqPQN58I3eCzYBgj1qXWxdNuM8NhCkNWRagqmQNVmO2u
         ujnw==
X-Gm-Message-State: AOAM533Fr+z+SbSsbXW7wcqDBncHZp+vtTc5ZAdBoXPanBykyXnsz5Ck
        KealVEZcaMhv2gHAG6YhbeDesA==
X-Google-Smtp-Source: ABdhPJzp7Y8YgWnzXGsmflj61UETkWHFxQLGQsNV5XJh5lWMxRMEpHQpqB3AeIQWP+on3Jbhl6rptA==
X-Received: by 2002:a37:de17:: with SMTP id h23mr2245938qkj.267.1604679754479;
        Fri, 06 Nov 2020 08:22:34 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id q20sm816112qtl.69.2020.11.06.08.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:22:33 -0800 (PST)
Subject: Re: [PATCH v2 1/8] firmware: arm_scmi: review protocol registration
 interface
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-2-cristian.marussi@arm.com>
 <5bc2f96e-bb66-c816-d856-56a18456dcf5@linaro.org>
 <20201104165659.GA24640@e120937-lin>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <99d4a36e-f5c7-a28d-8539-45f9ca780981@linaro.org>
Date:   Fri, 6 Nov 2020 11:22:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104165659.GA24640@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/20 11:56 AM, Cristian Marussi wrote:
> Hi Thara,
> 
> thanks for reviewing.
> 
> On Wed, Nov 04, 2020 at 11:16:06AM -0500, Thara Gopinath wrote:
>> Hi Cristian,
>>
>> On 10/28/20 4:29 PM, Cristian Marussi wrote:
>>> Extend common protocol registration routines and provide some new generic
>>> protocols' init/deinit helpers that tracks protocols' users and automatically
>>> perform the proper initialization/de-initialization on demand.
>>>
>>> Convert all protocols to use new registration schema while modifying only Base
>>> protocol to use also the new initialization helpers.
>>>
>>> All other standard protocols' initialization is still umodified and bound to
>>> SCMI devices probing.
>>
>> minor nit : umodified->unmodified.
>>>
> 
> Right.
> 
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>> v1 --> v2
>>> - made all scmi_protocol refs const
>>> - introduced IDR to handle protocols instead of static array
>>> - refactored code around fast path
>>> ---
>>>    drivers/firmware/arm_scmi/base.c    |  10 +-
>>>    drivers/firmware/arm_scmi/bus.c     |  61 +++++++---
>>>    drivers/firmware/arm_scmi/clock.c   |  10 +-
>>>    drivers/firmware/arm_scmi/common.h  |  31 ++++-
>>>    drivers/firmware/arm_scmi/driver.c  | 168 +++++++++++++++++++++++++++-
>>>    drivers/firmware/arm_scmi/notify.c  |   3 +-
>>>    drivers/firmware/arm_scmi/perf.c    |  10 +-
>>>    drivers/firmware/arm_scmi/power.c   |  10 +-
>>>    drivers/firmware/arm_scmi/reset.c   |  10 +-
>>>    drivers/firmware/arm_scmi/sensors.c |  10 +-
>>>    drivers/firmware/arm_scmi/system.c  |   8 +-
>>>    include/linux/scmi_protocol.h       |   6 +-
>>>    12 files changed, 299 insertions(+), 38 deletions(-)
>>>
>>
>> [...]
>>
>>
>>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>>> index 3dfd8b6a0ebf..beae8991422d 100644
>>> --- a/drivers/firmware/arm_scmi/driver.c
>>> +++ b/drivers/firmware/arm_scmi/driver.c
>>> @@ -11,11 +11,12 @@
>>>     * various power domain DVFS including the core/cluster, certain system
>>>     * clocks configuration, thermal sensors and many others.
>>>     *
>>> - * Copyright (C) 2018 ARM Ltd.
>>> + * Copyright (C) 2018-2020 ARM Ltd.
>>>     */
>>>    #include <linux/bitmap.h>
>>>    #include <linux/export.h>
>>> +#include <linux/idr.h>
>>>    #include <linux/io.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/ktime.h>
>>> @@ -23,6 +24,7 @@
>>>    #include <linux/of_address.h>
>>>    #include <linux/of_device.h>
>>>    #include <linux/processor.h>
>>> +#include <linux/refcount.h>
>>>    #include <linux/slab.h>
>>>    #include "common.h"
>>> @@ -68,6 +70,21 @@ struct scmi_xfers_info {
>>>    	spinlock_t xfer_lock;
>>>    };
>>> +/**
>>> + * struct scmi_protocol_instance  - Describe an initialized protocol instance.
>>> + * @proto: A reference to the protocol descriptor.
>>> + * @gid: A reference for per-protocol devres management.
>>> + * @users: A refcount to track effective users of this protocol.
>>> + *
>>> + * Each protocol is initialized independently once for each SCMI platform in
>>> + * which is defined by DT and implemented by the SCMI server fw.
>>> + */
>>> +struct scmi_protocol_instance {
>>> +	const struct scmi_protocol	*proto;
>>> +	void				*gid;
>>> +	refcount_t			users;
>>> +};
>>
>> Why do you need a separate protocol_instance? Will there be two instances of
>> the same protocol for a single scmi device/instance?
>> Else everything that has been defined in this struct in this patch the
>> following ones can be rolled into scmi_protocol struct, right ?
>>
> 
> Basically scm_protocol represents generically a protocol with all its ops,
> events and stuff, and it is registered during core init or protocol module
> loading with the core so that it appears into the available protocols IDR.
> 
> Each protocol then, if available, is later initialized only on its first usage
> after a get/ops or notify reg by an SCMI driver; now, this SCMI driver operates
> on an handle which represents in fact an SCMI instance (server) and you could
> have more than one instance in theory on the system (multiple SCMI servers
> identified by multiple DT nodes).
> 
> As an example you could have two distinct MCU handling two different set of
> sensors, so you'd have two distinct DT nodes representing each of these SCMI
> servers (with distinct transport channels of course) and you'll endup with two
> instances of the core SCMI platform driver (so 2 distinct handles), creating 2
> distinct devices each for the sensor protocol, so ending up at the end with two
> different running instances of the SCMI Sensor driver (hwmon) using a distinct
> handle to communicate with the correspondent sensors: as a consequence I
> initialize a distinct protocol instance structure for each handle, and keep
> distinct resource accounting (gid an users) while keeping a single reference
> (proto) to the same undelrying protocol descriptor; you could see as the
> scmi_protocol representing a class and the scmi_protocol_instance being an
> instantiated object (for a specific SCMI handle) in our poor C-Based OO world :D
> 
> In this way the two possible SCMI instances stacks are completely separated from
> the lower transport channels up to the SCMI driver users, including the
> intermediate protocols implementation.

Thanks for the explanation. I understand that this is to maintain two 
separate SCMI instances with the same underlying protocol ops. I think 
the confusing part here is why this struct does not have pointer to 
scmi_handle and I see that you have added it as part of patch 2. May be 
you can move that up here to indicate that same protocol can be used by 
two separate scmi server instances.

> 
> 
>>> +
>>>    /**
>>>     * struct scmi_info - Structure representing a SCMI instance
>>>     *
>>> @@ -80,6 +97,10 @@ struct scmi_xfers_info {
>>>     * @rx_minfo: Universal Receive Message management info
>>>     * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>>>     * @rx_idr: IDR object to map protocol id to Rx channel info pointer
>>> + * @protocols: IDR for protocols' instance descriptors initialized for
>>> + *	       this SCMI instance: populated on protocol's first attempted
>>> + *	       usage.
>>> + * @protocols_mtx: A mutex to protect protocols instances initialization.
>>>     * @protocols_imp: List of protocols implemented, currently maximum of
>>>     *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
>>>     * @node: List head
>>> @@ -94,6 +115,9 @@ struct scmi_info {
>>>    	struct scmi_xfers_info rx_minfo;
>>>    	struct idr tx_idr;
>>>    	struct idr rx_idr;
>>> +	struct idr protocols;
>>> +	/* Ensure mutual exclusive access to protocols instance array */
>>> +	struct mutex protocols_mtx;
>>>    	u8 *protocols_imp;
>>>    	struct list_head node;
>>>    	int users;
>>> @@ -519,6 +543,127 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
>>>    	return ret;
>>>    }
>>> +/**
>>> + * scmi_get_protocol_instance  - Protocol initialization helper.
>>> + * @handle: A reference to the SCMI platform instance.
>>> + * @protocol_id: The protocol being requested.
>>> + *
>>> + * In case the required protocol has never been requested before for this
>>> + * instance, allocate and initialize all the needed structures while handling
>>> + * resource allocation with a dedicated per-protocol devres subgroup.
>>> + *
>>> + * Return: A reference to an initialized protocol instance or error on failure.
>>> + */
>>> +static struct scmi_protocol_instance * __must_check
>>> +scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
>>> +{
>>> +	int ret = -ENOMEM;
>>> +	void *gid;
>>> +	struct scmi_protocol_instance *pi;
>>> +	struct scmi_info *info = handle_to_scmi_info(handle);
>>> +
>>> +	mutex_lock(&info->protocols_mtx);
>>> +	pi = idr_find(&info->protocols, protocol_id);
>>> +
>>> +	if (pi) {
>>> +		refcount_inc(&pi->users);
>>> +	} else {
>>> +		const struct scmi_protocol *proto;
>>> +
>>> +		/* Fail if protocol not registered on bus */
>>> +		proto = scmi_get_protocol(protocol_id);
>>> +		if (!proto) {
>>> +			ret = -ENODEV;
>>> +			goto out;
>>> +		}
>>> +
>>> +		/* Protocol specific devres group */
>>> +		gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
>>> +		if (!gid)
>>> +			goto out;
>>> +
>>> +		pi = devm_kzalloc(handle->dev, sizeof(*pi), GFP_KERNEL);
>>> +		if (!pi)
>>> +			goto clean;
>>> +
>>> +		pi->gid = gid;
>>> +		pi->proto = proto;
>>> +		refcount_set(&pi->users, 1);
>>> +		/* proto->init is assured NON NULL by scmi_protocol_register */
>>> +		ret = pi->proto->init(handle);
>>
>> So init for a protocol will be called twice. Is this intentional ? Once
>> during the device probe via scmi_dev_probe and scmi_protocol_init. And
>> once via scmi_get_protocol_instance which gets called in get_ops apis
>> defined and used in the later patches.
>>
> 
> This is part of the desperate attempt to split this series as much as
> possible :D ... so that in this patch I introduce this code path for
> initialization (and all the related helpers) but I'm using it only for
> the Base protocol (via acquire) ... all the other standard protocols here
> still reliy on the probe based legacy initialization, then later in the
> series I drop all the init@probe code and rely only on this path for
> init and also events registrations.

Ok.. I did not closely check this part in patch 6. If you are removing 
the double init, It should be ok.



-- 
Warm Regards
Thara
