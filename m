Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C22A693E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgKDQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgKDQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:16:20 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:16:20 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 12so15872483qkl.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMu+ZpDCHnLpFB+Y0yMO7W+S8qBAHVafomO84Zlx6mo=;
        b=IK9xHdd6O4nkuBtJTTZmy6o8WBo6b9FleeSn2vxgN12HMyDE1v8bh4HevoOFWoffUf
         gi0BoPVWVmIr+uJ5gKgG4dxlhVtBys3XDchQQ9abMJuNQz5hlLH7VFax85+EpttrnOl/
         3NYz9+leDlSrHCbCoqgCVD27QSDLXkVz5v0C74yh9P3Tt8xlwievCzKI5CqAlmMZcDBK
         DU533CP+ZGDW8SB6us7Dx/oz+b7un90YpPDInbCPthvQPeoWKiWPQ7w1O+kXUPs2ZXip
         kLvxSLtpped6OnMZ9vcnyJnPPHT7qErq2WaV7EpfeV4J8dF6UqUvtPBG9wQcS323alUY
         jifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMu+ZpDCHnLpFB+Y0yMO7W+S8qBAHVafomO84Zlx6mo=;
        b=nCbUWxdJZ5tFiirCiMrkUMr10J2k3Ba44JplJVO6Q0h5y6ZVZBZ9G5kN6T/9v1Le3L
         0iKEXxuYoDYRmSZpkRe8IVw1rGzdE3IBRcgra6gC8PxU4UsEzXPhoQbKrZCRBWioyoOs
         rxyPnANbEHHgDkddAgfbOXK3/Nmy2hekzBbxm8fXX9hPlxU/BOXCwfogQxppsFWuy0um
         Unc7gThOKokcJ1/G9eIq4wQqxYy1P6tMs+RMpp5IYxnEvGs+3wxxY+fbG/cdBRvlzKYq
         qLvQ4Kex9SvlvP8nNLl9FBxwS3Dp1D4loxsyucPLMuGk59hQYLTqOuvAHHVZZG5gigSo
         /yxw==
X-Gm-Message-State: AOAM531UZ5xN//H39DN+q8MZtoBnCXdJ6lUWwMbudqN7EW00aTkPc06v
        DlCVNrf2yaLzGt3k93EWOdIYOQ==
X-Google-Smtp-Source: ABdhPJyuzbHEtB930xHAVmCShKKD/e839v53ULcRdvC8I2Wcp4YPrp4GA/MdLnzQfnbPHKQZTxhBGA==
X-Received: by 2002:ae9:e41a:: with SMTP id q26mr17296299qkc.246.1604506579307;
        Wed, 04 Nov 2020 08:16:19 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 185sm2745672qke.16.2020.11.04.08.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:16:18 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: introduce protocol handles
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-3-cristian.marussi@arm.com>
Message-ID: <ceda764f-6cd9-9e47-edc7-2e915c920301@linaro.org>
Date:   Wed, 4 Nov 2020 11:16:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028202914.43662-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Cristian,

On 10/28/20 4:29 PM, Cristian Marussi wrote:
> Add basic protocol handles definitions and helpers support.
> All protocols initialization code and SCMI drivers probing is still
> performed using the handle based interface.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/common.h | 61 ++++++++++++++++++++++++++++
>   drivers/firmware/arm_scmi/driver.c | 64 ++++++++++++++++++++++++++++++
>   2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index b08a8ddbc22a..f0678be02a09 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -151,6 +151,67 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
>   		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
>   void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
>   			    struct scmi_xfer *xfer);
> +
> +struct scmi_xfer_ops;
> +
> +/**
> + * struct scmi_protocol_handle  - Reference to an initialized protocol instance
> + *
> + * @dev: A reference to the associated SCMI instance device (handle->dev).
> + * @xops: A reference to a struct holding refs to the core xfer operations that
> + *	  can be used by the protocol implementation to generate SCMI messages.
> + * @set_priv: A method to set protocol private data for this instance.
> + * @get_priv: A method to get protocol private data previously set.
> + *
> + * This structure represents a protocol initialized against specific SCMI
> + * instance and it will be used as follows:
> + * - as a parameter fed from the core to the protocol initialization code so
> + *   that it can access the core xfer operations to build and generate SCMI
> + *   messages exclusively for the specific underlying protocol instance.
> + * - as an opaque handle fed by an SCMI driver user when it tries to access
> + *   this protocol through its own protocol operations.
> + *   In this case this handle will be returned as an opaque object together
> + *   with the related protocol operations when the SCMI driver tries to access
> + *   the protocol.
> + */
> +struct scmi_protocol_handle {
> +	struct device *dev;
> +	const struct scmi_xfer_ops *xops;
> +	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
> +	void *(*get_priv)(const struct scmi_protocol_handle *ph);
> +};

So scmi_xfer_ops are the ops that actually talks with the scmi firmware 
on the other end , right ? IIUC, these ops are the same for all the 
protocols of a scmi instance. Imho, this struct is not the right place 
for these ops to reside.You are inadvertently exposing scmi internal 
details to the client drivers. There is no reason why this should be 
part of scmi_handle. The protocols can extract it from the handle during 
protocol_reigster, right?

So, now to the second part, why do you need a scmi_protocol_handle? 
Again IIUC, if you have set_priv and get_priv hooks and get_ops and 
put_ops hooks, there is nothing that scmi_protocol_handle is providing 
extra, right? As mentioned in the comments for last patch any reason all 
of this cannot be rolled into scmi_protocol?

As long as you are not supporting multiple scmi_protocol_instance and 
scmi_protocol_handle for a protocol, I don't think having separate 
structs make sense. And you need to do this only if you think there can 
be multiple versions/instances of a protocol in the same scmi instance.
Or am I missing something here ?

> +
> +/**
> + * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
> + * @version_get: Get this version protocol.
> + * @xfer_get_init: Initialize one struct xfer if any xfer slot is free.
> + * @reset_rx_to_maxsz: Reset rx size to max transport size.
> + * @do_xfer: Do the SCMI transfer.
> + * @do_xfer_with_response: Do the SCMI transfer waiting for a response.
> + * @xfer_put: Free the xfer slot.
> + *
> + * Note that all this operations expect a protocol handle as first parameter;
> + * they then internally use it to infer the underlying protocol number: this
> + * way is not possible for a protocol implementation to forge messages for
> + * another protocol.
> + */
> +struct scmi_xfer_ops {
> +	int (*version_get)(const struct scmi_protocol_handle *ph, u32 *version);
> +	int (*xfer_get_init)(const struct scmi_protocol_handle *ph, u8 msg_id,
> +			     size_t tx_size, size_t rx_size,
> +			     struct scmi_xfer **p);
> +	void (*reset_rx_to_maxsz)(const struct scmi_protocol_handle *ph,
> +				  struct scmi_xfer *xfer);
> +	int (*do_xfer)(const struct scmi_protocol_handle *ph,
> +		       struct scmi_xfer *xfer);
> +	int (*do_xfer_with_response)(const struct scmi_protocol_handle *ph,
> +				     struct scmi_xfer *xfer);
> +	void (*xfer_put)(const struct scmi_protocol_handle *ph,
> +			 struct scmi_xfer *xfer);
> +};
> +
> +struct scmi_revision_info *
> +scmi_get_revision_area(const struct scmi_protocol_handle *ph);
>   int scmi_handle_put(const struct scmi_handle *handle);
>   struct scmi_handle *scmi_handle_get(struct device *dev);
>   void scmi_set_handle(struct scmi_device *scmi_dev);
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index beae8991422d..8ca04acb6abb 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -72,19 +72,28 @@ struct scmi_xfers_info {
>   
>   /**
>    * struct scmi_protocol_instance  - Describe an initialized protocol instance.
> + * @handle: Reference to the SCMI handle associated to this protocol instance.
>    * @proto: A reference to the protocol descriptor.
>    * @gid: A reference for per-protocol devres management.
>    * @users: A refcount to track effective users of this protocol.
> + * @priv: Reference for optional protocol private data.
> + * @ph: An embedded protocol handle that will be passed down to protocol
> + *	initialization code to identify this instance.
>    *
>    * Each protocol is initialized independently once for each SCMI platform in
>    * which is defined by DT and implemented by the SCMI server fw.
>    */
>   struct scmi_protocol_instance {
> +	const struct scmi_handle	*handle;
>   	const struct scmi_protocol	*proto;
>   	void				*gid;
>   	refcount_t			users;
> +	void				*priv;
> +	struct scmi_protocol_handle	ph;
>   };
>   
> +#define ph_to_pi(h)	container_of(h, struct scmi_protocol_instance, ph)
> +
>   /**
>    * struct scmi_info - Structure representing a SCMI instance
>    *
> @@ -543,6 +552,57 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
>   	return ret;
>   }
>   
> +/**
> + * scmi_set_protocol_priv  - Set protocol specific data at init time
> + *
> + * @ph: A reference to the protocol handle.
> + * @priv: The private data to set.
> + *
> + * Return: 0 on Success
> + */
> +static int scmi_set_protocol_priv(const struct scmi_protocol_handle *ph,
> +				  void *priv)
> +{
> +	struct scmi_protocol_instance *pi = ph_to_pi(ph);
> +
> +	pi->priv = priv;
> +
> +	return 0;
> +}
> +
> +/**
> + * scmi_get_protocol_priv  - Set protocol specific data at init time
> + *
> + * @ph: A reference to the protocol handle.
> + *
> + * Return: Protocol private data if any was set.
> + */
> +static void *scmi_get_protocol_priv(const struct scmi_protocol_handle *ph)
> +{
> +	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> +
> +	return pi->priv;
> +}
> +
> +/**
> + * scmi_get_revision_area  - Retrieve version memory area.
> + *
> + * @ph: A reference to the protocol handle.
> + *
> + * A helper to grab the version memory area reference during SCMI Base protocol
> + * initialization.
> + *
> + * Return: A reference to the version memory area associated to the SCMI
> + *	   instance underlying this protocol handle.
> + */
> +struct scmi_revision_info *
> +scmi_get_revision_area(const struct scmi_protocol_handle *ph)
> +{
> +	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> +
> +	return pi->handle->version;
> +}
> +
>   /**
>    * scmi_get_protocol_instance  - Protocol initialization helper.
>    * @handle: A reference to the SCMI platform instance.
> @@ -588,6 +648,10 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
>   
>   		pi->gid = gid;
>   		pi->proto = proto;
> +		pi->handle = handle;
> +		pi->ph.dev = handle->dev;
> +		pi->ph.set_priv = scmi_set_protocol_priv;
> +		pi->ph.get_priv = scmi_get_protocol_priv;
>   		refcount_set(&pi->users, 1);
>   		/* proto->init is assured NON NULL by scmi_protocol_register */
>   		ret = pi->proto->init(handle);
> 

-- 
Warm Regards
Thara
