Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752BF2ED220
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbhAGO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbhAGO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:29:20 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C41C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 06:28:40 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p187so6301736iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 06:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AS955oV0sNNxmymQ9S2gFLRD6YA392eHboBTXK85YcU=;
        b=gcL7pNIOj/1nqlQvwP3SnVetZ+no2EJIGasfSLkk1iESsiEOfjzZqq0mxjFG8L5JUh
         7eJt0+w7Cqa9iZyx7AMwLlGldWIHKCwCbBVkyT+9l4X3C3aN1fCnHWqD9z3ZyJFzfk/z
         j2iikI4OofqL7EQalt/fpjloqsxGazsZlrjsHr3Pokdm3c/UfRJ3stsZch718YeoY7wH
         xR9Xhw6MHYLT7jNoHyitprskDxI8yVhHOTN2jQ6TT/p9c5cW769I0PVLTKHzTK1EXRBn
         V3BdK4iFgKl9rIOq6/iXAVYqXSoiFyuCK5TIz+PBSK3cfFNSimybHlQ2awupIWNEvIzN
         hc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AS955oV0sNNxmymQ9S2gFLRD6YA392eHboBTXK85YcU=;
        b=JKWDmTdYhI8RzAny65LpYQR20wC5vF97eTihiEunxfLQD+x7eJ86ooSdMYA0FnmhPr
         yhfWXJ0orqT2Yjv296kiyGcKwc+1zU75RGrfKx61+/cUgWyu0Lw09grwJ0RXBCqNmB5q
         01T6USHJc0gNNN+NqsXv7Wu2So3Bl03tSCeICH9FttiuYIaDZ+mCUmTfVm+RbHvVaAFi
         i7VHlwzJi8jCtCfPA0q2oMnX99FJyG/leRzq6WORlXv9YuuPG26MzhC2xn6fAsTNTnCl
         1d4FXpX4l1LUEwDhfKzUf4wpmhUlNEGZYuTy9sW1FsnmgqqxBv+6fexT3h/aortdbgCE
         Ri6Q==
X-Gm-Message-State: AOAM532rIEfBZmdZ89vzm2ne1oYS7UNINAn8WVtl2e7u2GpMv1Bh8AWc
        Cve0wVl08CVf13k+aijfjHYQTA==
X-Google-Smtp-Source: ABdhPJwtQ6aJYJWUYyk8YyIOUF0sRew3HbW5wqApB9UoXF7UZWCaflM3ZEqr0A//V1q/DSN+nRSVJw==
X-Received: by 2002:a6b:7704:: with SMTP id n4mr1475491iom.159.1610029719886;
        Thu, 07 Jan 2021 06:28:39 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id f3sm4523162ilu.74.2021.01.07.06.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:28:39 -0800 (PST)
Subject: Re: [PATCH v4 03/37] firmware: arm_scmi: introduce devres get/put
 protocols operations
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-4-cristian.marussi@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <e817b8a6-6e67-9f1e-8541-5e0b15d7a562@linaro.org>
Date:   Thu, 7 Jan 2021 09:28:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106201610.26538-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/21 3:15 PM, Cristian Marussi wrote:
> Expose to the SCMI drivers a new devres managed common protocols API based
> on generic get/put methods and protocol handles.
> 
> All drivers still keep using the old API, no functional change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 92 ++++++++++++++++++++++++++++++
>   include/linux/scmi_protocol.h      | 11 ++++
>   2 files changed, 103 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 10fe9aacae1b..fbc3ba1b69f6 100644
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
> @@ -732,6 +733,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
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
> @@ -986,6 +1076,8 @@ static int scmi_probe(struct platform_device *pdev)
>   	handle = &info->handle;
>   	handle->dev = info->dev;
>   	handle->version = &info->version;
> +	handle->devm_get_ops = scmi_devm_get_protocol_ops;
> +	handle->devm_put_ops = scmi_devm_put_protocol_ops;
>   
>   	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
>   	if (ret)
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 757a826e3cef..2fd2fffb4024 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -57,6 +57,8 @@ struct scmi_clock_info {
>   };
>   
>   struct scmi_handle;
> +struct scmi_device;
> +struct scmi_protocol_handle;
>   
>   /**
>    * struct scmi_clk_ops - represents the various operations provided
> @@ -593,6 +595,9 @@ struct scmi_notify_ops {
>    * @sensor_ops: pointer to set of sensor protocol operations
>    * @reset_ops: pointer to set of reset protocol operations
>    * @voltage_ops: pointer to set of voltage protocol operations
> + * @devm_get_ops: devres managed method to acquire a protocol and get specific
> + *		  operations and a dedicated protocol handler
> + * @devm_put_ops: devres managed method to release a protocol
>    * @notify_ops: pointer to set of notifications related operations
>    * @perf_priv: pointer to private data structure specific to performance
>    *	protocol(for internal use only)
> @@ -618,6 +623,12 @@ struct scmi_handle {
>   	const struct scmi_sensor_ops *sensor_ops;
>   	const struct scmi_reset_ops *reset_ops;
>   	const struct scmi_voltage_ops *voltage_ops;
> +
> +	const void __must_check *
> +		(*devm_get_ops)(struct scmi_device *sdev, u8 proto,
> +				struct scmi_protocol_handle **ph);
> +	void (*devm_put_ops)(struct scmi_device *sdev, u8 proto);

These names are misleading. The devm_get_ops does two things. One 
populate the scmi_protocol_handle, second return the protocol ops. 
Either split this into two separate functions or rename it into 
something like devm_get_protocol (or something better). Similar comment 
for devm_put_ops as there is no releasing of ops happening here per say.
Also I am still not convinced that protocol_instance should be hidden 
from the client drivers. But if everyone else is aligned towards this 
approach, I am fine.

> +
>   	const struct scmi_notify_ops *notify_ops;
>   	/* for protocol internal use */
>   	void *perf_priv;
> 

-- 
Warm Regards
Thara
