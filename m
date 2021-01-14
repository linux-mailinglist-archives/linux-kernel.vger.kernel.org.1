Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70332F5E89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbhANKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbhANKR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:17:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:17:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a9so1694095wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0WdMbm9V5FGu9d++MuB6LoC20MiGaA2x3HC1DOficN0=;
        b=MKd3ojUnDUCSwYlmJFyvDII9X4pSZ5uBur5+7fbrYVOKdYIOEHbYy+T+rmu47XHNbF
         /XwMrK5Gd2KMqd5oRCKGER8955BXuV/shiw3r8me9/t2G2qlz84AMlQzkkeGKiQKFYpR
         gWLkRtMxOHFw5zP/BjSVUmfdxeGF/XtIIc1l+2BketKeWgY1FFFb37CEpkawET2emEgh
         QXk56jQK91PmHYnzMdr5pZ2qZWrnArST2PY4ZkUkXRIGzifXulOE1+Jo59lxWeQ/r5Pj
         kbG1l0ruaF04yP06a4HBPJy7eQ2Ma5jXgvbYxEHAqPf9zESHqxw+iiYvV4DjPnm/FsnU
         uc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0WdMbm9V5FGu9d++MuB6LoC20MiGaA2x3HC1DOficN0=;
        b=i+WBffwE40nfuaSbLnXXHhl8o3qiMu7nEblXqGCu0yHG79zjoeG9gMH/J6QR4TIn7A
         ZH5c8k63S5Pf3YSgDmAReY8zaMlDBp2f34Rs464HhVOwMOwBa4VXJQu/Tv436gxTRy+n
         0uok8+LKfwUe82A7Iy/5cWFKNFGy30EKEqlL9HaXJegpysm0kxTof2RyHVdXiTuZsm24
         w0hZDXxmRv+rvmbaz07W8YoBn/q/nsLacfWrNbC2k7Ka4qE8Q3Zh4Tcpv9fSUs6HbsUp
         I6S0yy+3fcFqlMA5arh75BfSmhn5fXKdBCRoOBFZjty8XkVPDLX3MziTmJenFlz0eGaB
         Ga0A==
X-Gm-Message-State: AOAM530FScjXyCoHLJaaNGMFDs6v39YZVajF3pUis4fR4rHVwsfnpba5
        HIkvOgnmuMrn37kpGzF3g3pY9A==
X-Google-Smtp-Source: ABdhPJy5r6km4vX4ni5izYXvcEaJZ1ZHLYdlqdHfodbMgRZBtqNZlqciYKfuyV4F69JQe13J+dXT3g==
X-Received: by 2002:adf:df08:: with SMTP id y8mr6968923wrl.278.1610619435414;
        Thu, 14 Jan 2021 02:17:15 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id j15sm9423226wrr.85.2021.01.14.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:17:14 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:17:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mfd: iqs62x: Do not poll during ATI
Message-ID: <20210114101711.GM3975472@dell>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
 <1609707369-11297-6-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609707369-11297-6-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021, Jeff LaBundy wrote:

> After loading firmware, the driver triggers ATI (calibration) with
> the newly loaded register configuration in place. Next, the driver
> polls a register field to ensure ATI completed in a timely fashion
> and that the device is ready to sense.
> 
> However, communicating with the device over I2C while ATI is under-

This doesn't line-up with all of the others! ;)

> way may induce noise in the device and cause ATI to fail. As such,
> the vendor recommends not to poll the device during ATI.
> 
> To solve this problem, let the device naturally signal to the host
> that ATI is complete by way of an interrupt. A completion prevents
> the sub-devices from being registered until this happens.
> 
> The former logic that scaled ATI timeout and filter settling delay
> is not carried forward with the new implementation, as it produces
> overly conservative delays at lower clock rates. Instead, a single
> pair of delays that covers all cases is used.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/mfd/iqs62x.c       | 103 ++++++++++++++++++++++++++++++---------------
>  include/linux/mfd/iqs62x.h |   6 ++-
>  2 files changed, 73 insertions(+), 36 deletions(-)

[...]

> @@ -567,6 +600,12 @@ static void iqs62x_firmware_load(const struct firmware *fw, void *context)
>  		goto err_out;
>  	}
>  
> +	if (!wait_for_completion_timeout(&iqs62x->ati_done,
> +					 msecs_to_jiffies(2000))) {
> +		dev_err(&client->dev, "Failed to complete ATI\n");
> +		goto err_out;
> +	}
> +
>  	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>  				   iqs62x->dev_desc->sub_devs,
>  				   iqs62x->dev_desc->num_sub_devs,
> @@ -763,7 +802,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
>  		.prox_settings	= IQS620_PROX_SETTINGS_4,
>  		.hall_flags	= IQS620_HALL_FLAGS,
>  
> -		.clk_div	= 4,

No unnecessary double-line spacings please.

>  		.fw_name	= "iqs620a.bin",
>  		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
>  	},
> @@ -784,7 +822,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
>  		.prox_settings	= IQS620_PROX_SETTINGS_4,
>  		.hall_flags	= IQS620_HALL_FLAGS,
>  
> -		.clk_div	= 4,

As above.

>  		.fw_name	= "iqs620a.bin",
>  		.event_regs	= &iqs620a_event_regs[IQS62X_UI_PROX],
>  	},
> @@ -808,7 +845,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
>  		.hall_flags	= IQS621_HALL_FLAGS,
>  		.hyst_shift	= 5,
>  
> -		.clk_div	= 2,

As above.

>  		.fw_name	= "iqs621.bin",
>  		.event_regs	= &iqs621_event_regs[IQS62X_UI_PROX],
>  	},
> @@ -830,7 +866,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
>  		.als_flags	= IQS622_ALS_FLAGS,
>  		.hall_flags	= IQS622_HALL_FLAGS,
>  
> -		.clk_div	= 2,

As above.

>  		.fw_name	= "iqs622.bin",
>  		.event_regs	= &iqs622_event_regs[IQS62X_UI_PROX],
>  	},
> @@ -845,7 +880,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
>  		.interval	= IQS624_INTERVAL_NUM,
>  		.interval_div	= 3,
>  
> -		.clk_div	= 2,

As above.

>  		.fw_name	= "iqs624.bin",
>  		.event_regs	= &iqs624_event_regs[IQS62X_UI_PROX],
>  	},
> @@ -860,7 +894,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
>  		.interval	= IQS625_INTERVAL_NUM,
>  		.interval_div	= 10,
>  
> -		.clk_div	= 2,

As above.

>  		.fw_name	= "iqs625.bin",
>  		.event_regs	= &iqs625_event_regs[IQS62X_UI_PROX],
>  	},
> @@ -890,6 +923,8 @@ static int iqs62x_probe(struct i2c_client *client)
>  
>  	BLOCKING_INIT_NOTIFIER_HEAD(&iqs62x->nh);
>  	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
> +
> +	init_completion(&iqs62x->ati_done);
>  	init_completion(&iqs62x->fw_done);
>  
>  	iqs62x->regmap = devm_regmap_init_i2c(client, &iqs62x_regmap_config);
> diff --git a/include/linux/mfd/iqs62x.h b/include/linux/mfd/iqs62x.h
> index 043d3b6..0b71173 100644
> --- a/include/linux/mfd/iqs62x.h
> +++ b/include/linux/mfd/iqs62x.h
> @@ -28,7 +28,7 @@
>  #define IQS620_GLBL_EVENT_MASK_PMU		BIT(6)
>  
>  #define IQS62X_NUM_KEYS				16
> -#define IQS62X_NUM_EVENTS			(IQS62X_NUM_KEYS + 5)
> +#define IQS62X_NUM_EVENTS			(IQS62X_NUM_KEYS + 6)
>  
>  #define IQS62X_EVENT_SIZE			10
>  
> @@ -78,6 +78,7 @@ enum iqs62x_event_flag {
>  
>  	/* everything else */
>  	IQS62X_EVENT_SYS_RESET,
> +	IQS62X_EVENT_SYS_ATI,
>  };
>  
>  struct iqs62x_event_data {
> @@ -119,7 +120,6 @@ struct iqs62x_dev_desc {
>  	u8 interval;
>  	u8 interval_div;
>  
> -	u8 clk_div;

As above.

>  	const char *fw_name;
>  	const enum iqs62x_event_reg (*event_regs)[IQS62X_EVENT_SIZE];
>  };
> @@ -130,8 +130,10 @@ struct iqs62x_core {
>  	struct regmap *regmap;
>  	struct blocking_notifier_head nh;
>  	struct list_head fw_blk_head;
> +	struct completion ati_done;
>  	struct completion fw_done;
>  	enum iqs62x_ui_sel ui_sel;
> +	unsigned long event_cache;
>  };
>  
>  extern const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS];

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
