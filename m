Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E302ED21E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbhAGO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbhAGO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:28:50 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB55C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 06:28:09 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u12so6885536ilv.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 06:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EE6w3AuO9Q5DdDEsKJsefaa+Y3hE+KAyib/x3tsZfSY=;
        b=ugAb8czjOTWziVNg3ceJ79t+TpgzIYQ7zZMsaf9uXqr6ZEKBM8ZJiyKdz4NRIz1jyo
         kndR7TqgII+oHjkFyh75odOqNtpFLyJ8TQ5S/mKyZ0vvz3GYR4ve+v1L45Ey/ukCztGX
         nczGIL5kdwwDzHLSpEaQdqEq7J8Mx2SCyYzoJLsgUgaH86c+VMQxFWzUW4r2u803w1YA
         V9wrW7+QuUiDwG4VtOpvECWVtKuymRJ40Ak4b4PToQxV9kLEOAsmA7ccDEyFxaualMld
         dG+XeUnq7YBk+3sap0pIs6OJsYsvxK1h6yXQNcYh4W6itycbaCE6BB2Iluw+c5Lk+i/a
         E7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EE6w3AuO9Q5DdDEsKJsefaa+Y3hE+KAyib/x3tsZfSY=;
        b=C5bJ/+lpdS0RbcWFPeVsqbe46LEwPaLUfXjpPeb3s4M3xSSQ6URC1YU6kw5ufpSOQX
         6z9bokPyTCvT8tLBeYWqVuFpGR8csPRTh0UdX0/e6vPpp5sRuVlOLliNDRuwjGB/FTTJ
         FyHpc2urxY0VVFUnXRxxb27zxGNQrM1suBEZh5+Y5TbpAWcrSrkBzLekxw7rSb7WuTE6
         Ja1IJlVsEOY2Q9FcvZZ2cQUVlpGpDg/dea6aFxcgG0KUdSWpSVV8uf1v3YVP3SlpsZsN
         /rfeFuXpaXrkwYwg37KoueifgQzmv6Z69M0XORaJdJFKRrVCFdnVN72LLFevRUkchzE+
         8FAA==
X-Gm-Message-State: AOAM5317T3NlR2SRoCvEUk020MdU0ZyNCpfJeTqDKF6FyFpUAyj4ZsqN
        f5QNRZaBHOOl6RvdvKTyXY5gKQ==
X-Google-Smtp-Source: ABdhPJxxIZR97qv2b/mWYtH/zkIITpXZ3J8s9lmvfMKkW3Y5G7uADanyCbzJjs1TvI62wpfvDXfQTw==
X-Received: by 2002:a92:ba55:: with SMTP id o82mr2372256ili.202.1610029689186;
        Thu, 07 Jan 2021 06:28:09 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id o18sm3505496ioa.39.2021.01.07.06.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:28:08 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v4 37/37] firmware: arm_scmi: add dynamic scmi devices
 creation
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-38-cristian.marussi@arm.com>
Message-ID: <50434a02-0fe0-50f3-1529-51ab8a0cc1f3@linaro.org>
Date:   Thu, 7 Jan 2021 09:28:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106201610.26538-38-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 1/6/21 3:16 PM, Cristian Marussi wrote:
> Having added the support for SCMI protocols as modules in order to let
> vendors extend the SCMI core with their own additions it seems odd to
> then force SCMI drivers built on top to use a static device table to
> declare their devices since this way any new SCMI drivers addition
> would need the core SCMI device table to be updated too.
> 
> Remove the static core device table and let SCMI drivers to simply declare
> which device/protocol pair they need at initialization time: the core will
> then take care to generate such devices dynamically during platform
> initialization or at module loading time, as long as the requested
> underlying protocol is defined in the DT.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
	
[snip]

>   
> -static inline void
> -scmi_create_protocol_devices(struct device_node *np, struct scmi_info *info,
> -			     int prot_id)
> +	for (; rdev; rdev = rdev->next)
> +		scmi_create_protocol_device(np, info, prot_id,
> +					    rdev->id_table->name);
> +}
> +
> +/**
> + * scmi_request_protocol_device  - Helper to request a device
> + *
> + * @id_table: A protocol/name pair descriptor for the device to be created.
> + *
> + * This helper let an SCMI driver request specific devices identified by the
> + * @id_table to be created for each active SCMI instance.
> + *
> + * The requested device name MUST NOT be already existent for any protocol;
> + * at first the freshly requested @id_table is annotated in the IDR table
> + * @scmi_requested_devices, then a matching device is created for each already
> + * active SCMI instance. (if any)
> + *
> + * This way the requested device is created straight-away for all the already
> + * initialized(probed) SCMI instances (handles) but it remains instead pending
> + * for creation if the requesting SCMI driver is loaded before some instance
> + * and related transports was available: when such late SCMI instance is probed
> + * it will take care to scan the list of pending requested devices and create
> + * those on its own (see @scmi_create_protocol_devices and its enclosing loop)
> + *
> + * Return: 0 on Success
> + */
> +int scmi_request_protocol_device(const struct scmi_device_id *id_table)
>   {
> -	int loop, cnt;
> +	int ret = 0;
> +	unsigned int id = 0;
> +	struct scmi_requested_dev *rdev, *proto_rdev = NULL;
> +	struct scmi_info *info;
>   
> -	for (loop = 0; loop < ARRAY_SIZE(devnames); loop++) {
> -		if (devnames[loop].protocol_id != prot_id)
> -			continue;
> +	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
> +		 id_table->name, id_table->protocol_id);
>   
> -		for (cnt = 0; cnt < ARRAY_SIZE(devnames[loop].names); cnt++) {
> -			const char *name = devnames[loop].names[cnt];
> +	/*
> +	 * Search for the matching protocol rdev list and then search
> +	 * of any existent equally named device...fails if any duplicate found.
> +	 */
> +	mutex_lock(&scmi_requested_devices_mutex);
> +	idr_for_each_entry(&scmi_requested_devices, rdev, id) {
> +		if (rdev->id_table->protocol_id == id_table->protocol_id)
> +			proto_rdev = rdev;
> +		for (; rdev; rdev = rdev->next) {
> +			if (!strcmp(rdev->id_table->name, id_table->name)) {
> +				pr_err("Ignoring duplicate request [%d] %s\n",
> +				       rdev->id_table->protocol_id,
> +				       rdev->id_table->name);
> +				ret = -EINVAL;
> +				goto out;
> +			}
	Shouldn't there be proto_rdev = rdev here as well ?

> +		}
> +	}
> +
> +	/*
> +	 * No duplicate found for requested id_table, so let's create a new
> +	 * requested device entry for this new valid request.
> +	 */
> +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	rdev->id_table = id_table;
> +
> +	/*
> +	 * Append the new requested device table descriptor to the head of the
> +	 * related protocol chain, eventually creating such chain if not already
> +	 * there.
> +	 */
> +	if (!proto_rdev) {
> +		ret = idr_alloc(&scmi_requested_devices, (void *)rdev,
> +				rdev->id_table->protocol_id,
> +				rdev->id_table->protocol_id + 1, GFP_KERNEL);
> +		if (ret != rdev->id_table->protocol_id) {
> +			pr_err("Failed to save SCMI device - ret:%d\n", ret);
> +			kfree(rdev);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		ret = 0;
> +	} else {
> +		proto_rdev->next = rdev;
> +	}
> +
> +	/*
> +	 * Now effectively create and initialize the requested device for every
> +	 * already initialized SCMI instance which has registered the requested
> +	 * protocol as a valid active one: i.e. defined in DT and supported by
> +	 * current platform FW.
> +	 */
> +	mutex_lock(&scmi_list_mutex);
> +	list_for_each_entry(info, &scmi_list, node) {
> +		struct device_node *child;
> +
> +		child = idr_find(&info->active_protocols,
> +				 id_table->protocol_id);
> +		if (child) {
> +			struct scmi_device *sdev;
> +
> +			sdev = scmi_get_protocol_device(child, info,
> +							id_table->protocol_id,
> +							id_table->name);
> +			/* Set handle if not already set (device existed) */
> +			if (sdev && !sdev->handle)
> +				sdev->handle = scmi_handle_get_from_info(info);
> +		} else {
> +			dev_err(info->dev,
> +				"Failed. SCMI protocol %d not active.\n",
> +				id_table->protocol_id);
> +		}
> +	}
> +	mutex_unlock(&scmi_list_mutex);
> +
> +out:
> +	mutex_unlock(&scmi_requested_devices_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * scmi_unrequest_protocol_device  - Helper to unrequest a device
> + *
> + * @id_table: A protocol/name pair descriptor for the device to be unrequested.
> + *
> + * An helper to let an SCMI driver release its request about devices; note that
> + * devices are created and initialized once the first SCMI driver request them
> + * but they destroyed only on SCMI core unloading/unbinding.
> + *
> + * The current SCMI transport layer uses such devices as internal references and
> + * as such they could be shared as same transport between multiple drivers so
> + * that cannot be safely destroyed till the whole SCMI stack is removed.
> + * (unless adding further burden of refcounting.)
> + */
> +void scmi_unrequest_protocol_device(const struct scmi_device_id *id_table)
> +{
> +	struct scmi_requested_dev *victim, *prev, *head;
> +
> +	pr_debug("Unrequesting SCMI device (%s) for protocol %x\n",
> +		 id_table->name, id_table->protocol_id);
>   
> -			if (name)
> -				scmi_create_protocol_device(np, info, prot_id,
> -							    name);
> +	head = idr_find(&scmi_requested_devices, id_table->protocol_id);
> +	if (!head)
> +		return;
> +
> +	/*
> +	 * Scan the protocol list of requested device name searching
> +	 * for the victim.
> +	 */
> +	victim = head;
> +	for (prev = victim; victim; prev = victim, victim = victim->next)

	The initial assignment for the for loop is wrong. With this when you 
break prev will be equal to victim. You want prev to be the one pointing 
to the victim. Or am I missing something?


-- 
Warm Regards
Thara
