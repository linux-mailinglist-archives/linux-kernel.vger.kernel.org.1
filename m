Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6792A693D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgKDQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgKDQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:16:09 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:16:08 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 12so15871680qkl.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IlTAb4BQFKLR3Tp2hVVjxVAiIHililKzH5OOJDZzwxc=;
        b=QOr8wzrOvSlBhZ2KeMtFcbmJEhtHgIaT6+6g88ZBDvljUOSxxEwVe5zPghnzfdSkgr
         9cjGuWrwaEQcnIbUxY4PFPnLedMUsHGfEv/tmMYRvMTrro4owFbK7oSIoPScj0k0PXpi
         fheanQ/c6UCG3EHEPDKfhEZ3EbWMQCOPmBHGJFcKjBm3pSBNkNSo7tRD4jbt85uFDyji
         rFtL2DGQsPwJENXzwRqrLBHokB0oTyftZY7d3uJYuyDnIDlknN0tkwmgRHBY5wGdBsAz
         WCPWfs+YetVLsE2UDVQRme14fbKVnVLaeQOpiubIVGUhw74nQVdmtmh6IcLhSdSlXyk9
         wYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IlTAb4BQFKLR3Tp2hVVjxVAiIHililKzH5OOJDZzwxc=;
        b=Cj7Sh8p0Cc3cmTdKKMsbztHMya6GSLMTakgqTxOMdWTqhniNdgBCBfrz1CBEO3IGjP
         bna1T2tld12eSYc8j/iHL/IEQBQ3Q/JBVoOttA5/Huip1Jvza66cOtZIIC7DtW/evfqb
         /msX22CJDUn6YgCGqEY3RXYNY7mxa53Mh9bqo2/0/cDcUvSdqrDjkFJtSsPLFJC5EqJ+
         z1ZHzohCDqDrga1zkq36VzQ5GO96pAR+fBqg8Bbmx54LwngGuX2j5pfkTJ5WZ5xM/CPO
         y4bnQwHTHBW0f2lHdIN664FBv7AD5PiB0FvfPAeyMcj1jy+55+YnYFD1tQxmmahcGStI
         7Idw==
X-Gm-Message-State: AOAM532i3je28ewZdTY1LCKZC7MxK05ZbUdkv4UnRYgSEMqlHDMTi7/n
        bunR8XltbwN1VqlTEw15bVIx2A==
X-Google-Smtp-Source: ABdhPJwCPsL0biegx2jXavgl6FstsvZSJZYZFXvWTOeFm1W9KodCIvCfGi1jcZnKVCiIFSCBZ4BvFw==
X-Received: by 2002:a05:620a:20c5:: with SMTP id f5mr2332163qka.69.1604506567074;
        Wed, 04 Nov 2020 08:16:07 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id u31sm465634qtu.87.2020.11.04.08.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:16:06 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v2 1/8] firmware: arm_scmi: review protocol registration
 interface
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-2-cristian.marussi@arm.com>
Message-ID: <5bc2f96e-bb66-c816-d856-56a18456dcf5@linaro.org>
Date:   Wed, 4 Nov 2020 11:16:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028202914.43662-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On 10/28/20 4:29 PM, Cristian Marussi wrote:
> Extend common protocol registration routines and provide some new generic
> protocols' init/deinit helpers that tracks protocols' users and automatically
> perform the proper initialization/de-initialization on demand.
> 
> Convert all protocols to use new registration schema while modifying only Base
> protocol to use also the new initialization helpers.
> 
> All other standard protocols' initialization is still umodified and bound to
> SCMI devices probing.

minor nit : umodified->unmodified.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - made all scmi_protocol refs const
> - introduced IDR to handle protocols instead of static array
> - refactored code around fast path
> ---
>   drivers/firmware/arm_scmi/base.c    |  10 +-
>   drivers/firmware/arm_scmi/bus.c     |  61 +++++++---
>   drivers/firmware/arm_scmi/clock.c   |  10 +-
>   drivers/firmware/arm_scmi/common.h  |  31 ++++-
>   drivers/firmware/arm_scmi/driver.c  | 168 +++++++++++++++++++++++++++-
>   drivers/firmware/arm_scmi/notify.c  |   3 +-
>   drivers/firmware/arm_scmi/perf.c    |  10 +-
>   drivers/firmware/arm_scmi/power.c   |  10 +-
>   drivers/firmware/arm_scmi/reset.c   |  10 +-
>   drivers/firmware/arm_scmi/sensors.c |  10 +-
>   drivers/firmware/arm_scmi/system.c  |   8 +-
>   include/linux/scmi_protocol.h       |   6 +-
>   12 files changed, 299 insertions(+), 38 deletions(-)
> 

[...]


> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 3dfd8b6a0ebf..beae8991422d 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -11,11 +11,12 @@
>    * various power domain DVFS including the core/cluster, certain system
>    * clocks configuration, thermal sensors and many others.
>    *
> - * Copyright (C) 2018 ARM Ltd.
> + * Copyright (C) 2018-2020 ARM Ltd.
>    */
>   
>   #include <linux/bitmap.h>
>   #include <linux/export.h>
> +#include <linux/idr.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/ktime.h>
> @@ -23,6 +24,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/processor.h>
> +#include <linux/refcount.h>
>   #include <linux/slab.h>
>   
>   #include "common.h"
> @@ -68,6 +70,21 @@ struct scmi_xfers_info {
>   	spinlock_t xfer_lock;
>   };
>   
> +/**
> + * struct scmi_protocol_instance  - Describe an initialized protocol instance.
> + * @proto: A reference to the protocol descriptor.
> + * @gid: A reference for per-protocol devres management.
> + * @users: A refcount to track effective users of this protocol.
> + *
> + * Each protocol is initialized independently once for each SCMI platform in
> + * which is defined by DT and implemented by the SCMI server fw.
> + */
> +struct scmi_protocol_instance {
> +	const struct scmi_protocol	*proto;
> +	void				*gid;
> +	refcount_t			users;
> +};

Why do you need a separate protocol_instance? Will there be two 
instances of the same protocol for a single scmi device/instance?
Else everything that has been defined in this struct in this patch the
following ones can be rolled into scmi_protocol struct, right ?

> +
>   /**
>    * struct scmi_info - Structure representing a SCMI instance
>    *
> @@ -80,6 +97,10 @@ struct scmi_xfers_info {
>    * @rx_minfo: Universal Receive Message management info
>    * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>    * @rx_idr: IDR object to map protocol id to Rx channel info pointer
> + * @protocols: IDR for protocols' instance descriptors initialized for
> + *	       this SCMI instance: populated on protocol's first attempted
> + *	       usage.
> + * @protocols_mtx: A mutex to protect protocols instances initialization.
>    * @protocols_imp: List of protocols implemented, currently maximum of
>    *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
>    * @node: List head
> @@ -94,6 +115,9 @@ struct scmi_info {
>   	struct scmi_xfers_info rx_minfo;
>   	struct idr tx_idr;
>   	struct idr rx_idr;
> +	struct idr protocols;
> +	/* Ensure mutual exclusive access to protocols instance array */
> +	struct mutex protocols_mtx;
>   	u8 *protocols_imp;
>   	struct list_head node;
>   	int users;
> @@ -519,6 +543,127 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
>   	return ret;
>   }
>   
> +/**
> + * scmi_get_protocol_instance  - Protocol initialization helper.
> + * @handle: A reference to the SCMI platform instance.
> + * @protocol_id: The protocol being requested.
> + *
> + * In case the required protocol has never been requested before for this
> + * instance, allocate and initialize all the needed structures while handling
> + * resource allocation with a dedicated per-protocol devres subgroup.
> + *
> + * Return: A reference to an initialized protocol instance or error on failure.
> + */
> +static struct scmi_protocol_instance * __must_check
> +scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> +{
> +	int ret = -ENOMEM;
> +	void *gid;
> +	struct scmi_protocol_instance *pi;
> +	struct scmi_info *info = handle_to_scmi_info(handle);
> +
> +	mutex_lock(&info->protocols_mtx);
> +	pi = idr_find(&info->protocols, protocol_id);
> +
> +	if (pi) {
> +		refcount_inc(&pi->users);
> +	} else {
> +		const struct scmi_protocol *proto;
> +
> +		/* Fail if protocol not registered on bus */
> +		proto = scmi_get_protocol(protocol_id);
> +		if (!proto) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +
> +		/* Protocol specific devres group */
> +		gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
> +		if (!gid)
> +			goto out;
> +
> +		pi = devm_kzalloc(handle->dev, sizeof(*pi), GFP_KERNEL);
> +		if (!pi)
> +			goto clean;
> +
> +		pi->gid = gid;
> +		pi->proto = proto;
> +		refcount_set(&pi->users, 1);
> +		/* proto->init is assured NON NULL by scmi_protocol_register */
> +		ret = pi->proto->init(handle);

So init for a protocol will be called twice. Is this intentional ? Once 
during the device probe via scmi_dev_probe and scmi_protocol_init. And
once via scmi_get_protocol_instance which gets called in get_ops apis 
defined and used in the later patches.

> +		if (ret)
> +			goto clean;
> +
> +		ret = idr_alloc(&info->protocols, pi,
> +				protocol_id, protocol_id + 1, GFP_KERNEL);
> +		if (ret != protocol_id)
> +			goto clean;
> +
> +		devres_close_group(handle->dev, pi->gid);
> +		dev_dbg(handle->dev, "Initialized protocol: 0x%X\n",
> +			protocol_id);
> +	}
> +	mutex_unlock(&info->protocols_mtx);
> +
> +	return pi;
> +
> +clean:
> +	devres_release_group(handle->dev, gid);
> +out:
> +	mutex_unlock(&info->protocols_mtx);
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * scmi_acquire_protocol  - Protocol acquire
> + * @handle: A reference to the SCMI platform instance.
> + * @protocol_id: The protocol being requested.
> + *
> + * Register a new user for the requested protocol on the specified SCMI
> + * platform instance, possibly triggering its initialization on first user.
> + *
> + * Return: 0 if protocol was acquired successfully.
> + */
> +int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
> +{
> +	return PTR_ERR_OR_ZERO(scmi_get_protocol_instance(handle, protocol_id));
> +}
> +
> +/**
> + * scmi_release_protocol  - Protocol de-initialization helper.
> + * @handle: A reference to the SCMI platform instance.
> + * @protocol_id: The protocol being requested.
> + *
> + * Remove one user for the specified protocol and triggers de-initialization
> + * and resources de-allocation once the last user has gone.
> + */
> +void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
> +{
> +	struct scmi_info *info = handle_to_scmi_info(handle);
> +	struct scmi_protocol_instance *pi;
> +
> +	mutex_lock(&info->protocols_mtx);
> +	pi = idr_find(&info->protocols, protocol_id);
> +	if (WARN_ON(!pi))
> +		goto out;
> +
> +	if (refcount_dec_and_test(&pi->users)) {
> +		void *gid = pi->gid;
> +
> +		if (pi->proto->deinit)
> +			pi->proto->deinit(handle);
> +
> +		idr_remove(&info->protocols, protocol_id);
> +
> +		devres_release_group(handle->dev, gid);
> +		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
> +			protocol_id);
> +	}
> +
> +out:
> +	mutex_unlock(&info->protocols_mtx);
> +}
> +
>   void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
>   				     u8 *prot_imp)
>   {
> @@ -785,6 +930,8 @@ static int scmi_probe(struct platform_device *pdev)
>   	info->dev = dev;
>   	info->desc = desc;
>   	INIT_LIST_HEAD(&info->node);
> +	idr_init(&info->protocols);
> +	mutex_init(&info->protocols_mtx);
>   
>   	platform_set_drvdata(pdev, info);
>   	idr_init(&info->tx_idr);
> @@ -805,9 +952,14 @@ static int scmi_probe(struct platform_device *pdev)
>   	if (scmi_notification_init(handle))
>   		dev_err(dev, "SCMI Notifications NOT available.\n");
>   
> -	ret = scmi_base_protocol_init(handle);
> +	/*
> +	 * Trigger SCMI Base protocol initialization.
> +	 * It's mandatory and won't be ever released/deinit until the
> +	 * SCMI stack is shutdown/unloaded as a whole.
> +	 */
> +	ret = scmi_acquire_protocol(handle, SCMI_PROTOCOL_BASE);
>   	if (ret) {
> -		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> +		dev_err(dev, "unable to communicate with SCMI\n");
>   		return ret;
>   	}
>   
> @@ -859,6 +1011,10 @@ static int scmi_remove(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	mutex_lock(&info->protocols_mtx);
> +	idr_destroy(&info->protocols);
> +	mutex_unlock(&info->protocols_mtx);
> +
>   	/* Safe to free channels since no more users */
>   	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>   	idr_destroy(&info->tx_idr);
> @@ -941,6 +1097,8 @@ static int __init scmi_driver_init(void)
>   {
>   	scmi_bus_init();
>   
> +	scmi_base_register();
> +

minor nit. extra line addeed ?

-- 
Warm Regards
Thara
