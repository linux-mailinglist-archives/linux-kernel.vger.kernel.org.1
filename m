Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8928E6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbgJNTDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgJNTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:03:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C144C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:03:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c20so357747pfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ny4lv7GFtFpjVN4P6z51b5A+pa661gcA71exXEjNpGU=;
        b=Fx+TMJv8Xg8f0lay0zCXMF8h1vhtlTU+CHYsMYZ7Qz0RxXNwNgjjr3QfTICMRQ1b1L
         wbxe8penGzwpGo1J/EXcqgXCH4llINfDkiWHv4GGUhHjiEassh3g0m/coLTsMeDrSC2z
         u47xyfOQBigaI94IQS2HMfA14Lli6Ymxg+7PATc6nY3GvaH5KFR9ycxvvxek5/0shu/N
         Vt7Hmo8nusiiQtvYfxr6jbzVsD4sGZcFvtGuS1TwYB6/W8IIHyhrq90xd2LnwlrsrT8K
         xqFSV5ITG+coFi2q0ZDLz263B2DWtQNvj6GnnD32uYJCZlM51AwwNWMilb1zYowzQOBD
         P7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ny4lv7GFtFpjVN4P6z51b5A+pa661gcA71exXEjNpGU=;
        b=A82gj4cNciBbH9uUpWajn5SEYUVSOBSNYF9XCeBwwGv+o+UkuO1Ec57VMfBLQzgq4V
         xNlimc5kAdARPNqlwImORYVd4IIUvAmHlSsOcvqeFoWwR6Bpn3OdKn/of7+HU2I9IX/f
         y8VclFa3C8wz2ASzoZs0AXK4JMV8Kmpj3Q2CRVv7fKagtSDL2Z5nOufi2s6DPuhIadjV
         pfH2/9fokZxrn1B/NP4wVjePH5LNl5Bk4ttn3X9GFYjmhrK0I9iVGEQQrWHTFDhN2YgT
         HbAFm8tWK9Fj8uU3sLYHrt98/rQite0C8MPW2GPF/dSajtwRa17Mvzw2Mvl+lgCOJjvi
         Lriw==
X-Gm-Message-State: AOAM530Of8AriEEp3O8e0BM9x3D/laHFAR8OJEPJScZOA+oBa9HFSB1p
        yz+ltNgMAK7kcvP0ekGv48w=
X-Google-Smtp-Source: ABdhPJwJwdl9C/7/pmaJBT3Mmwp1OpPMKa6E0/EQJIVOEUoO75e5v0e9DhJ/ZHtQhToS6JF4u60mWw==
X-Received: by 2002:a65:53cc:: with SMTP id z12mr317181pgr.333.1602702227764;
        Wed, 14 Oct 2020 12:03:47 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w19sm337037pfn.174.2020.10.14.12.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 12:03:47 -0700 (PDT)
Subject: Re: [PATCH 01/11] firmware: arm_scmi: review protocol registration
 interface
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-2-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <1b461304-2c25-3206-5799-b561ac6e0bd2@gmail.com>
Date:   Wed, 14 Oct 2020 12:03:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014150545.44807-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 8:05 AM, Cristian Marussi wrote:
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

[snip]

> +static struct scmi_protocol scmi_base = {
> +	.id = SCMI_PROTOCOL_BASE,
> +	.init = &scmi_base_protocol_init,
> +	.ops = NULL,
> +};

This could be const I believe.

> +
> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index 1377ec76a45d..afa2e4818a2b 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -16,7 +16,7 @@
>  #include "common.h"
>  
>  static DEFINE_IDA(scmi_bus_id);
> -static DEFINE_IDR(scmi_protocols);
> +static DEFINE_IDR(scmi_available_protocols);
>  static DEFINE_SPINLOCK(protocol_lock);
>  
>  static const struct scmi_device_id *
> @@ -51,13 +51,29 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
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
>  static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
>  {
> -	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
> +	const struct scmi_protocol *proto;
>  
> -	if (unlikely(!fn))
> +	proto = idr_find(&scmi_available_protocols, protocol_id);
> +	if (!proto)
>  		return -EINVAL;
> -	return fn(handle);
> +	return proto->init(handle);
>  }
>  
>  static int scmi_protocol_dummy_init(struct scmi_handle *handle)
> @@ -84,7 +100,7 @@ static int scmi_dev_probe(struct device *dev)
>  		return ret;
>  
>  	/* Skip protocol initialisation for additional devices */
> -	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
> +	idr_replace(&scmi_available_protocols, &scmi_protocol_dummy_init,
>  		    scmi_dev->protocol_id);
>  
>  	return scmi_drv->probe(scmi_dev);
> @@ -194,26 +210,45 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
>  	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
>  }
>  
> -int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
> +int scmi_protocol_register(struct scmi_protocol *proto)

And this could probably take a const struct scmi_protocol here too as
you do not appear to be modifying proto, idr_alloc() may complain.

[snip]

>  
> -DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_CLOCK, clock)
> +static struct scmi_protocol scmi_clock = {

static const here too and throughout your submission.

[snip]

> +	struct scmi_protocol_instance *protocols[SCMI_MAX_PROTO];

Humm that would be 2048 bytes on a 64-bit platform and 1024 bytes on a
32-bit platform, this is not so bad, but it is a bit wasteful given that
6-7 standard protocols are typically found, and most often no
proprietary protocols are registered. Not necessarily to be addressed
right now.

> +	/* Ensure mutual exclusive access to protocols instance array */
> +	struct mutex protocols_mtx;
>  	u8 *protocols_imp;
>  	struct list_head node;
>  	int users;
> @@ -519,6 +542,132 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
>  	return ret;
>  }
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

You could return -ENODEV here and propagate that error code for
scmi_probe() to use as -is.

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
> +		if (ret)
> +			goto clean;
> +
> +		info->protocols[protocol_id] = pi;
> +		/* Ensure initialized protocol is visible */
> +		smp_wmb();
> +
> +		devres_close_group(handle->dev, pi->gid);
> +		dev_dbg(handle->dev, "Initialized protocol: 0x%X\n",
> +			protocol_id);
> +	} else {
> +		refcount_inc(&pi->users);
> +	}

You may be able to re-arrange the indentation and do:

	if (pi) {
		refcount_inc(&pi->users);
		mutex_unlock(&info->protocols_mtx);
		return pi;
	}

to reduce the indentation level, and this would also have the fast path
tested first.

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
> +	return IS_ERR(scmi_get_protocol_instance(handle, protocol_id));
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
> +	/* Ensure protocols has been updated */
> +	smp_rmb();
> +	pi = info->protocols[protocol_id];
> +	if (WARN_ON(!pi)) {
> +		mutex_unlock(&info->protocols_mtx);
> +		return;

Maybe define an "out" label just to avoid the repetition?

> +	}
> +
> +	if (refcount_dec_and_test(&pi->users)) {
> +		void *gid = pi->gid;
> +
> +		if (pi->proto->deinit)
> +			pi->proto->deinit(handle);
> +
> +		info->protocols[protocol_id] = NULL;
> +		/* Ensure deinitialized protocol is visible */
> +		smp_wmb();
> +
> +		devres_release_group(handle->dev, gid);
> +		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
> +			protocol_id);
> +	}
> +	mutex_unlock(&info->protocols_mtx);
> +}
> +
>  void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
>  				     u8 *prot_imp)
>  {
> @@ -785,6 +934,7 @@ static int scmi_probe(struct platform_device *pdev)
>  	info->dev = dev;
>  	info->desc = desc;
>  	INIT_LIST_HEAD(&info->node);
> +	mutex_init(&info->protocols_mtx);
>  
>  	platform_set_drvdata(pdev, info);
>  	idr_init(&info->tx_idr);
> @@ -805,10 +955,14 @@ static int scmi_probe(struct platform_device *pdev)
>  	if (scmi_notification_init(handle))
>  		dev_err(dev, "SCMI Notifications NOT available.\n");
>  
> -	ret = scmi_base_protocol_init(handle);
> -	if (ret) {
> -		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> -		return ret;
> +	/*
> +	 * Trigger SCMI Base protocol initialization.
> +	 * It's mandatory and won't be ever released/deinit until the
> +	 * SCMI stack is shutdown/unloaded as a whole.
> +	 */
> +	if (scmi_acquire_protocol(handle, SCMI_PROTOCOL_BASE)) {
> +		dev_err(dev, "unable to communicate with SCMI\n");
> +		return -ENODEV;

and you could do:

ret = scmi_acquire_protocol(.., ...);
if (ret) {
	dev_err(dev, "unable to communicate with SCMI\n");
	return ret;
}

Everything else looked good to me, thanks!
-- 
Florian
