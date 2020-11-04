Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF82A6940
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgKDQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgKDQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:16:34 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643BC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:16:34 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id j31so5834542qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7IXCmg9HoiI9TAtR6Ga7SM/mQcagKwuJn0wdRfAwxlw=;
        b=VlvyOEuonTeG1afq/UKzXSLVccJrnyPFBuuC6qN7OxMGhJkyC96ud2qB45mJl+8MYP
         MNLT3qwmRoN0YmFQdczC8HFW5ljazvNR5RuysLYt0qlFVKio9rgmDEgdVKKlumUgYD94
         P7gY0zZsk+h0xjT/N6VItoY3W3ABLPuzKfoLSwmv3N5t770aagewVms8HN0GjMkqPn/X
         2fzKghyme4wgmizWr4TN7AFQscEPeEm1eNLVyBIcqBO6k/8jKKn6gUGETDXeN7XYvq0A
         YYoj7oEhr7JpuZrBCL23h0T9125Xsos4Nsg1dut5BwXxTShNbe13/ie/YsjuaapD5WxT
         lP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7IXCmg9HoiI9TAtR6Ga7SM/mQcagKwuJn0wdRfAwxlw=;
        b=sXx94/e52L8QPfGOKwrojUyOdJtvI40VgREC2OSsXkyzU0UiPrRuggbqNt19XPS+1J
         XXdr8iKIV/LfNCnU7NzpUhxCaqBeFZSAef1mGVBWUABl9R6BAEtvkciiHb5QaabaOvvX
         dXCwQMOvzU/zx2kpibyuvWShUAKGhPT19HvdFPnIJVG/aEvByBV5gmz/YnX4w04KW/hY
         6h0mffOT4KnafiZh6ytlVsWaVddJwudRsZzOmsp0klSQhuDuWKjO76DyBQPmScwNTpOX
         A+USIJk+8R2IvwvmP5GAWxUeB/cN+ixHObdH8kkl4rPk7JtDgfUW7EzMLDfuflyuIpLv
         saGA==
X-Gm-Message-State: AOAM530p9uzdgF+zfw1fPGNSccu41FSmbqmSvnL14r07IT9lQxtj7UJZ
        QSUu0m9enrU47pMpeLvrkS3/Xg==
X-Google-Smtp-Source: ABdhPJy3MN7qvgRjjUOeoMN3/PA7qo3iiEWxuPZYp4fUjFMSwyPIDYlMn3HaIGEQPaxcC5LHFBqcmw==
X-Received: by 2002:a05:622a:10b:: with SMTP id u11mr20779004qtw.235.1604506593385;
        Wed, 04 Nov 2020 08:16:33 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 137sm2863175qkk.63.2020.11.04.08.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:16:32 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v2 3/8] firmware: arm_scmi: introduce new protocol
 operations support
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-4-cristian.marussi@arm.com>
Message-ID: <2b09a607-6470-ad41-fd19-6a7a248237c5@linaro.org>
Date:   Wed, 4 Nov 2020 11:16:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028202914.43662-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On 10/28/20 4:29 PM, Cristian Marussi wrote:
> Expose a new generic get/put protocols API based on protocol handles;
> provide also a devres managed version also for notifications.

minor nit.. Maybe yous should reword this! Kind of confusing to understand!

Also, if it was me, I will separate the notifications and get/put hooks
into two separate patches. Not an issue though if you want to keep it
in the same patch.

> All SCMI drivers still keep using the old handle based interface.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 126 +++++++++++++++++++++++++++++
>   drivers/firmware/arm_scmi/notify.c | 123 ++++++++++++++++++++++++++++
>   include/linux/scmi_protocol.h      |  34 +++++++-
>   3 files changed, 282 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 8ca04acb6abb..4d86aafbf465 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -15,6 +15,7 @@
>    */
>   
>   #include <linux/bitmap.h>
> +#include <linux/device.h>
>   #include <linux/export.h>
>   #include <linux/idr.h>
>   #include <linux/io.h>
> @@ -728,6 +729,38 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
>   	mutex_unlock(&info->protocols_mtx);
>   }
>   
> +/**
> + * scmi_get_protocol_operations  - Get protocol operations
> + * @handle: A reference to the SCMI platform instance.
> + * @protocol_id: The protocol being requested.
> + * @ph: A pointer reference used to pass back the associated protocol handle.
> + *
> + * Get hold of a protocol accounting for its usage, eventually triggering its
> + * initialization, and returning the protocol specific operations and related
> + * protocol handle which will be used as first argument in most of the protocols
> + * operations methods.
> + *
> + * Return: A reference to the requested protocol operations or error.
> + *	   Must be checked for errors by caller.
> + */
> +static const void __must_check *
> +scmi_get_protocol_operations(struct scmi_handle *handle, u8 protocol_id,
> +			     struct scmi_protocol_handle **ph)
> +{
> +	struct scmi_protocol_instance *pi;
> +
> +	if (!ph)
> +		return ERR_PTR(-EINVAL);
> +
> +	pi = scmi_get_protocol_instance(handle, protocol_id);
> +	if (IS_ERR(pi))
> +		return pi;
> +
> +	*ph = &pi->ph;
> +
> +	return pi->proto->ops;
> +}
> +
>   void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
>   				     u8 *prot_imp)
>   {
> @@ -751,6 +784,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
>   	return false;
>   }
>   
> +struct scmi_protocol_devres {
> +	struct scmi_handle *handle;
> +	u8 protocol_id;
> +};
> +
> +static void scmi_devm_release_protocol(struct device *dev, void *res)
> +{
> +	struct scmi_protocol_devres *dres = res;
> +
> +	scmi_release_protocol(dres->handle, dres->protocol_id);
> +}
> +
> +/**
> + * scmi_devm_get_protocol_ops  - Devres managed get protocol operations
> + * @sdev: A reference to an scmi_device whose embedded struct device is to
> + *	  be used for devres accounting.
> + * @protocol_id: The protocol being requested.
> + * @ph: A pointer reference used to pass back the associated protocol handle.
> + *
> + * Get hold of a protocol accounting for its usage, eventually triggering its
> + * initialization, and returning the protocol specific operations and related
> + * protocol handle which will be used as first argument in most of the
> + * protocols operations methods.
> + * Being a devres based managed method, protocol hold will be automatically
> + * released, and possibly de-initialized on last user, once the SCMI driver
> + * owning the scmi_device is unbound from it.
> + *
> + * Return: A reference to the requested protocol operations or error.
> + *	   Must be checked for errors by caller.
> + */
> +static const void __must_check *
> +scmi_devm_get_protocol_ops(struct scmi_device *sdev, u8 protocol_id,
> +			   struct scmi_protocol_handle **ph)
> +{
> +	struct scmi_protocol_instance *pi;
> +	struct scmi_protocol_devres *dres;
> +	struct scmi_handle *handle = sdev->handle;
> +
> +	if (!ph)
> +		return ERR_PTR(-EINVAL);
> +
> +	dres = devres_alloc(scmi_devm_release_protocol,
> +			    sizeof(*dres), GFP_KERNEL);
> +	if (!dres)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pi = scmi_get_protocol_instance(handle, protocol_id);
> +	if (IS_ERR(pi)) {
> +		devres_free(dres);
> +		return pi;
> +	}
> +
> +	dres->handle = handle;
> +	dres->protocol_id = protocol_id;
> +	devres_add(&sdev->dev, dres);
> +
> +	*ph = &pi->ph;
> +
> +	return pi->proto->ops;
> +}
> +
> +static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
> +{
> +	struct scmi_protocol_devres *dres = res;
> +
> +	if (WARN_ON(!dres || !data))
> +		return 0;
> +
> +	return dres->protocol_id == *((u8 *)data);
> +}
> +
> +/**
> + * scmi_devm_put_protocol_ops  - Devres managed put protocol operations
> + * @sdev: A reference to an scmi_device whose embedded struct device is to
> + *	  be used for devres accounting.
> + * @protocol_id: The protocol being requested.
> + *
> + * Explicitly release a protocol hold previously obtained calling the above
> + * @scmi_devm_get_protocol_ops.
> + */
> +static void scmi_devm_put_protocol_ops(struct scmi_device *sdev, u8 protocol_id)
> +{
> +	int ret;
> +
> +	ret = devres_release(&sdev->dev, scmi_devm_release_protocol,
> +			     scmi_devm_protocol_match, &protocol_id);
> +	WARN_ON(ret);
> +}
> +
>   /**
>    * scmi_handle_get() - Get the SCMI handle for a device
>    *
> @@ -1004,6 +1126,10 @@ static int scmi_probe(struct platform_device *pdev)
>   	handle = &info->handle;
>   	handle->dev = info->dev;
>   	handle->version = &info->version;
> +	handle->devm_get_ops = scmi_devm_get_protocol_ops;
> +	handle->devm_put_ops = scmi_devm_put_protocol_ops;
> +	handle->get_ops = scmi_get_protocol_operations;
> +	handle->put_ops = scmi_release_protocol;

Why do you need a dev_res version and a non dev_res version? I checked
patch 6 where you convert the drivers to use these hooks and all of them
are using the dev res apis.

>   
>   	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
>   	if (ret)
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index eae58b2a92cc..64d43e425644 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1370,6 +1370,127 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
>   	return 0;
>   }
>   
> +struct scmi_notifier_devres {
> +	const struct scmi_handle *handle;
> +	u8 proto_id;
> +	u8 evt_id;
> +	u32 __src_id;
> +	u32 *src_id;

Instead of maintaining two separate pointers for src id,
why not define a bool, something like is_src_id_valid?
Should simply this a bit and also don't have to maintain two 32 bit 
pointers. What do you think?

> +	struct notifier_block *nb;
> +};
> +
> +static void scmi_devm_release_notifier(struct device *dev, void *res)
> +{
> +	struct scmi_notifier_devres *dres = res;
> +
> +	scmi_unregister_notifier(dres->handle, dres->proto_id, dres->evt_id,
> +				 dres->src_id, dres->nb);
> +}
> +
> +/**
> + * scmi_devm_register_notifier()  - Managed registration of a notifier_block
> + * for an event
> + * @sdev: A reference to an scmi_device whose embedded struct device is to
> + *	  be used for devres accounting.
> + * @proto_id: Protocol ID
> + * @evt_id: Event ID
> + * @src_id: Source ID, when NULL register for events coming form ALL possible
> + *	    sources
> + * @nb: A standard notifier block to register for the specified event
> + *
> + * Generic devres managed helper to register a notifier_block against a
> + * protocol event.
> + */
> +static int scmi_devm_register_notifier(struct scmi_device *sdev,
> +				       u8 proto_id, u8 evt_id, u32 *src_id,
> +				       struct notifier_block *nb)
> +{
> +	int ret;
> +	struct scmi_notifier_devres *dres;
> +
> +	dres = devres_alloc(scmi_devm_release_notifier,
> +			    sizeof(*dres), GFP_KERNEL);
> +	if (!dres)
> +		return -ENOMEM;
> +
> +	ret = scmi_register_notifier(sdev->handle, proto_id,
> +				     evt_id, src_id, nb);
> +	if (ret) {
> +		devres_free(dres);
> +		return ret;
> +	}
> +
> +	dres->handle = sdev->handle;
> +	dres->proto_id = proto_id;
> +	dres->evt_id = evt_id;
> +	dres->nb = nb;
> +	if (src_id) {
> +		dres->__src_id = *src_id;
> +		dres->src_id = &dres->__src_id;
> +	} else {
> +		dres->src_id = NULL;
> +	}
> +	devres_add(&sdev->dev, dres);
> +
> +	return ret;
> +}
> +
> +static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
> +{
> +	struct scmi_notifier_devres *dres = res;
> +	struct scmi_notifier_devres *xres = data;
> +
> +	if (WARN_ON(!dres || !xres))
> +		return 0;
> +
> +	return dres->proto_id == xres->proto_id &&
> +		dres->evt_id == xres->evt_id &&
> +		dres->nb == xres->nb &&

Does the nb have to be compared as well ?

> +		((!dres->src_id && !xres->src_id) ||
> +		  (dres->src_id && xres->src_id &&
> +		   dres->__src_id == xres->__src_id));


-- 
Warm Regards
Thara
