Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D822ED221
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbhAGOaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbhAGOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:30:01 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E9BC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 06:29:20 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id r9so6306710ioo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dh6XC7U+zjWbk3Fom9ifE298WJtCaF5athPrOwXpfuA=;
        b=m0kLNGqgL76RGdbTenkvHSskS+cxFzZ9sS/gfnJcyrNApixnReCUg6zYGwfPofNFWA
         UsQRSYPj4EJCNy/0pBn8a34hKB+Xghk0NTyMHUjfOixZFGD4CfFVwrIwTt4oNeEdUCYe
         XcW4en/R+6RQcNQj8PPJwz1YuYIYap2D6fbsEXVeiF6w/AGuBzNsvlb4IDZxqsx6qovV
         o9a8j1Vg9Eb+zfWC/kAOgFZUbzm7KZqt8sfZAsftYaAZepYTfXDpVB0xxDORBJqlBxwL
         M7JvogpYmvYAMnJjk+JVJTqQOJCZ8c+AcdOAg9w1OBGjEYJCglqAn0ST0rZTyO6kia5Q
         nshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dh6XC7U+zjWbk3Fom9ifE298WJtCaF5athPrOwXpfuA=;
        b=D99t413DOpUNNDf7GTfL3sLcwznNOIuVM4DmBZYKLVXSu3ZwW6GV2rmYfZylCIcAiu
         gPCw2+FupzLRP6Tuslfyz6dCqz+NFhGUzr6uHf2GX3dvRbotnRomoXtMmw1PNDooMnBD
         hdaxPLiWu2UW1hmLfTh6i1XJ+L4SOsHNrLCi5YakI+Y/MOQQVbeGLBDgbgJn9nidV1gY
         gLPPSzGKJKASGlNEvKNtjAr5H9GXNY7F+BVH6s3xpvYBNrqjugf9F/L7CQGXEB47nRZA
         sa1CxCXkm6b5tNVSBSsoizSenJaf5r0gu8IkvHlMnibPdCRP8upIEACzsIoM44LWsUiy
         Ja2g==
X-Gm-Message-State: AOAM533WQu9dLmo5ChBbHGjxspNhQPnbXIUYvr9Y0EuA3KIDAD6ZZTPH
        vG4ZQljhq51aCIe0ZCDrj+Wmzg==
X-Google-Smtp-Source: ABdhPJwV3sVAP4CHc+ge/KPWtZKvx7xe9DUUXEZ5m1vUcF32gQt4Ir6N4i//fAhubW38+bnuzlb9wg==
X-Received: by 2002:a05:6602:93:: with SMTP id h19mr1486360iob.59.1610029759589;
        Thu, 07 Jan 2021 06:29:19 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 143sm5117710ila.4.2021.01.07.06.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:29:19 -0800 (PST)
Subject: Re: [PATCH v4 02/37] firmware: arm_scmi: introduce protocol handle
 definitions
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-3-cristian.marussi@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <19054e89-c117-ef85-444e-8e126a8a9efb@linaro.org>
Date:   Thu, 7 Jan 2021 09:29:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106201610.26538-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/21 3:15 PM, Cristian Marussi wrote:
> Add basic protocol handles definitions and private data helpers support.
> 
> A protocol handle identifies a protocol instance initialized against a
> specific handle; it embeds all the references to the core SCMI xfer methods
> that will be needed by a protocol implementation to build and send its own
> protocol specific messages using common core methods.
> 
> As such, in the interface, a protocol handle will be passed down from the
> core to the protocol specific initialization callback at init time.
> 
> Anyway at this point only definitions are introduced, all protocols
> initialization code and SCMI drivers probing is still based on the old
> interface, so no functional change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/common.h | 59 ++++++++++++++++++++++++++++++
>   drivers/firmware/arm_scmi/driver.c | 45 +++++++++++++++++++++++
>   2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index e052507dc918..977e31224efe 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -149,6 +149,65 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
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

Maybe move the definition above struct scmi_protocol_handle to avoid a 
declaration ?


-- 
Warm Regards
Thara
