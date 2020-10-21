Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD382946A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 04:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411286AbgJUCqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406409AbgJUCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 22:46:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92008C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 19:46:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c15so941130qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DaT10WZRX6KteIBtMDCqd6fl6Au9CrlcF8EDmn1PGZU=;
        b=WcqBOVZtppv0fy6omtekmJppW0LvdxIKkW5u0KbHwpiR47SRA23gL6P8edrh90LcOC
         nsXE1U2FanxfE4Gq15k+dKSkO6vttrIqI6p+P2IrggiQVRqrNhbRTE3JcfBtPs2FNa5Q
         yAt7uZgBe5aHBuyzzqSHfZcYXLWb3EkUqQyGoIpgVSO5kV7CHM+4Glrg4lXr5Wf6jEnb
         BB5VSbVJjEfTjA+cIhMrLUTaKhUM+IXksU7EIFBcOWfKlRhPPBAfuI/3faTBSiGsDT/D
         VBTKSmxWZ6q0WKi3sPusZLZ1UscXEJE3eLb6dPqOongPuCydTSfxEcj3P2onORIwIxqn
         XsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DaT10WZRX6KteIBtMDCqd6fl6Au9CrlcF8EDmn1PGZU=;
        b=XTnvBwTbWdvQME8cMUou9fQ3gRbpjhuUHJbTqoJzeW6ibxbJp6t2H+a/LpT6Fw+lIJ
         6fzIFAYMj7RXbJz7sjKhXcDwFqiBdY3e0d/vcoGIXRt+V8Gw1vI4uLU+5lzOJWQvFx2B
         Vd5VxvbORgE3Xi/2Wnlj1ZZypLi0i+o7iYgFeGwevotCynolop9JoBMqDO/FfkarOMxP
         ga4jgBEmykyPSzD9U6cM/mH4zFx/wI8N3w1+GRkyCKj2/T1MUTaS57VIlgXSB1Vppsua
         X7rQhq+2mM/uE3bjx+0qzMKiewAg8QBInuTvEnUzSDPgx5IvZ8tW47qjib9vT5mqRXf+
         ATew==
X-Gm-Message-State: AOAM533rhUscSwR8sTydPrAVej+68QVapUIkVg0lfaiouDTdBRdg4TM7
        Nek9F4NOGCvPKL6zroOebWANKg==
X-Google-Smtp-Source: ABdhPJyxE59r3kwPRRUV2rKJPfibYkeOOhcUKwJD55nzmg+xX95sKMU/OXKw1AEbt7a0MSyGliTDsw==
X-Received: by 2002:ac8:5387:: with SMTP id x7mr1147143qtp.130.1603248407652;
        Tue, 20 Oct 2020 19:46:47 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id n57sm439451qtf.52.2020.10.20.19.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 19:46:47 -0700 (PDT)
Subject: Re: [PATCH 01/11] firmware: arm_scmi: review protocol registration
 interface
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-2-cristian.marussi@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <70179e01-5157-5531-1ed1-12dcbe6aced4@linaro.org>
Date:   Tue, 20 Oct 2020 22:46:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014150545.44807-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

Thanks for this series!

On 10/14/20 11:05 AM, Cristian Marussi wrote:
> Extend common protocol registration routines and provide some new generic
> protocols' init/deinit helpers that tracks protocols' users and automatically
> perform the proper initialization/de-initialization on demand.
> 
> Convert all protocols to use new registration schema while modifying only Base
> protocol to use also the new initialization helpers.
> 
> All other standard protocols' initialization is still umodified and bound to
> SCMI devices probing.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
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
>   12 files changed, 298 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index 017e5d8bd869..f19e08ed4369 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -318,7 +318,7 @@ static const struct scmi_event_ops base_event_ops = {
>   	.fill_custom_report = scmi_base_fill_custom_report,
>   };
>   
> -int scmi_base_protocol_init(struct scmi_handle *h)
> +static int scmi_base_protocol_init(struct scmi_handle *h)
>   {
>   	int id, ret;
>   	u8 *prot_imp;
> @@ -365,3 +365,11 @@ int scmi_base_protocol_init(struct scmi_handle *h)
>   
>   	return 0;
>   }
> +
> +static struct scmi_protocol scmi_base = {
> +	.id = SCMI_PROTOCOL_BASE,
> +	.init = &scmi_base_protocol_init,
> +	.ops = NULL,
> +};
> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index 1377ec76a45d..afa2e4818a2b 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -16,7 +16,7 @@
>   #include "common.h"
>   
>   static DEFINE_IDA(scmi_bus_id);
> -static DEFINE_IDR(scmi_protocols);
> +static DEFINE_IDR(scmi_available_protocols);
>   static DEFINE_SPINLOCK(protocol_lock);
>   
>   static const struct scmi_device_id *
> @@ -51,13 +51,29 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
>   	return 0;
>   }
>   
> +const struct scmi_protocol *scmi_get_protocol(int protocol_id)
> +{
> +	const struct scmi_protocol *proto;
> +
> +	proto = idr_find(&scmi_available_protocols, protocol_id);
> +	if (!proto) {
> +		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
> +		return NULL;
> +	}
> +
> +	pr_debug("GOT SCMI Protocol 0x%x\n", protocol_id);
> +
> +	return proto;
> +}
> +
>   static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
>   {
> -	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
> +	const struct scmi_protocol *proto;
>   
> -	if (unlikely(!fn))
> +	proto = idr_find(&scmi_available_protocols, protocol_id);
> +	if (!proto)
>   		return -EINVAL;


Any reason not to use the above scmi_get_protocol here ?

> -	return fn(handle);
> +	return proto->init(handle);
>   }
>   
>   static int scmi_protocol_dummy_init(struct scmi_handle *handle)
> @@ -84,7 +100,7 @@ static int scmi_dev_probe(struct device *dev)
>   		return ret;
>   
>   	/* Skip protocol initialisation for additional devices */
> -	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
> +	idr_replace(&scmi_available_protocols, &scmi_protocol_dummy_init,
>   		    scmi_dev->protocol_id);
>   
>   	return scmi_drv->probe(scmi_dev);
> @@ -194,26 +210,45 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
>   	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
>   }
>   
> -int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
> +int scmi_protocol_register(struct scmi_protocol *proto)
>   {
>   	int ret;
>   
> +	if (!proto) {
> +		pr_err("invalid protocol\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!proto->init) {
> +		pr_err("missing .init() for protocol 0x%x\n", proto->id);
> +		return -EINVAL;
> +	}
> +
>   	spin_lock(&protocol_lock);
> -	ret = idr_alloc(&scmi_protocols, fn, protocol_id, protocol_id + 1,
> -			GFP_ATOMIC);
> +	ret = idr_alloc(&scmi_available_protocols, proto,
> +			proto->id, proto->id + 1, GFP_ATOMIC);
>   	spin_unlock(&protocol_lock);
> -	if (ret != protocol_id)
> -		pr_err("unable to allocate SCMI idr slot, err %d\n", ret);
> +	if (ret != proto->id) {
> +		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
> +		       proto->id, ret);
> +		return ret;
> +	}
> +
> +	pr_debug("Registered SCMI Protocol 0x%x\n", proto->id);
>   
> -	return ret;
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(scmi_protocol_register);
>   
> -void scmi_protocol_unregister(int protocol_id)
> +void scmi_protocol_unregister(const struct scmi_protocol *proto)
>   {
>   	spin_lock(&protocol_lock);
> -	idr_remove(&scmi_protocols, protocol_id);
> +	idr_remove(&scmi_available_protocols, proto->id);
>   	spin_unlock(&protocol_lock);
> +
> +	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);
> +
> +	return;
>   }
>   EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
>   

[...]

> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 3dfd8b6a0ebf..7de994e49884 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -23,6 +23,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/processor.h>
> +#include <linux/refcount.h>
>   #include <linux/slab.h>
>   
>   #include "common.h"
> @@ -68,6 +69,21 @@ struct scmi_xfers_info {
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
> +
>   /**
>    * struct scmi_info - Structure representing a SCMI instance
>    *
> @@ -80,6 +96,10 @@ struct scmi_xfers_info {
>    * @rx_minfo: Universal Receive Message management info
>    * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>    * @rx_idr: IDR object to map protocol id to Rx channel info pointer
> + * @protocols: An array of protocols' instance descriptors initialized for
> + *	       this SCMI instance: populated on protocol's first attempted
> + *	       usage.
> + * @protocols_mtx: A mutex to protect protocols instances initialization.
>    * @protocols_imp: List of protocols implemented, currently maximum of
>    *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
>    * @node: List head
> @@ -94,6 +114,9 @@ struct scmi_info {
>   	struct scmi_xfers_info rx_minfo;
>   	struct idr tx_idr;
>   	struct idr rx_idr;
> +	struct scmi_protocol_instance *protocols[SCMI_MAX_PROTO];
> +	/* Ensure mutual exclusive access to protocols instance array */
> +	struct mutex protocols_mtx;
>   	u8 *protocols_imp;
>   	struct list_head node;
>   	int users;
> @@ -519,6 +542,132 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
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
> +	/* Ensure protocols has been updated */
> +	smp_rmb();
> +	pi = info->protocols[protocol_id];
> +
> +	if (!pi) {
> +		const struct scmi_protocol *proto;
> +
> +		/* Fail if protocol not registered on bus */
> +		proto = scmi_get_protocol(protocol_id);
> +		if (!proto) {
> +			ret = -EINVAL;
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

Isnt this already done in scmi_protocol_init? Or rather the init should 
remain here and there is no need for it to be called from 
scmi_protocol_init?



-- 
Warm Regards
Thara
