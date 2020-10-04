Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29480282B80
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgJDPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 11:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgJDPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 11:43:48 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC2EC0613CE;
        Sun,  4 Oct 2020 08:43:48 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s66so6243639otb.2;
        Sun, 04 Oct 2020 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qi/VID7y2SIwzNo6dbcXrRRFn4NPp8vANshNlUq5tjo=;
        b=VtNTfV/Iil1s0ncK/AIaMq0CZUfgkksUFTrZmoopKJqeydiAfRh1LxRy3mU9AvdwyB
         SwR4I1yYJFHbCKdAmoA3s+b7WLhXSGYmpFVm86Q018c6ukf4CFRh+MOGo+t6OnYo2njW
         waq4ClyvivyjTQiwu/5OwmRLlpo+sDZqiL5/2h0yTUJf3nUSd//EoThMISKR6IZstLhQ
         /vUg3QlD3tqRapIuQzatP4qMSkc87tGdCIX05rOvmpDI061xPNUBgmLI0hTmnZJLrO5P
         aR8w4xnJT6fSQYbiP1aF2ICGwejbvNQ7Gjk4v8syV43o4sgk9kmSUiMtgiq4JtaNSKnv
         /i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qi/VID7y2SIwzNo6dbcXrRRFn4NPp8vANshNlUq5tjo=;
        b=ZNVBIIDQfnADy7zsx9VTNZW+VESqwjBIHv1A3uCMSUTS+jWMwew2WY/QoNo+8ehIx4
         41Go9JEfGmSTXicrrtoKd6jPW82vmyJNcK6eBAEYKLLZ9/5XSA06UAlf7wYY4NKJa64G
         1j+Kp0KuuJZD7O1f+5Z63vq97KMuxMGpkVXgFbJoo/7O+Peg5qXv00jO4DUgLH0dfR69
         1uoJKiV0l6+CftgQzic4P8pF34q4YDVSqPjFQuidyLnUzOgB29QphbhvWofcw2aPQQrx
         xPRtGf1O0qH25hh7OWdW2EfONqOIqvQ+axjG+OIZKRU+0uKtUpd7AQz2NriXlR/6gB2I
         WP3Q==
X-Gm-Message-State: AOAM532SGfmVJxLHafQdxcsANFcAZvHMfwyrZG0uOynfnmmuV83OMAEw
        cjLHyjWr6RFY7NMFb3ezi5ZTAFT9vBU=
X-Google-Smtp-Source: ABdhPJzx3okC9Z9OkNWFurYFJS2tGuZYCIBr3zBqB1AEawXdWvHzkzaeEpxSorZ1sNZihSNqrrGXVQ==
X-Received: by 2002:a05:6830:45b:: with SMTP id d27mr1816297otc.15.1601826227366;
        Sun, 04 Oct 2020 08:43:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15sm2083262otg.78.2020.10.04.08.43.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Oct 2020 08:43:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Oct 2020 08:43:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: pmbus: max20730: adjust the vout reading
 given voltage divider
Message-ID: <20201004154345.GA110630@roeck-us.net>
References: <20201004031445.2321090-1-linchuyuan@google.com>
 <20201004031445.2321090-3-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004031445.2321090-3-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 03:14:45AM +0000, Chu Lin wrote:
> Problem:
> We use voltage dividers so that the voltage presented at the voltage
> sense pins is confusing. We might need to convert these readings to more
> meaningful readings given the voltage divider.
> 
> Solution:
> Read the voltage divider resistance from dts and convert the voltage
> reading to a more meaningful reading.
> 
> Testing:
> max20730 with voltage divider
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
> ChangeLog v1 -> v2
>   hwmon: pmbus: max20730:
>   - Don't do anything to the ret if an error is returned from pmbus_read_word
>   - avoid overflow when doing multiplication
> 
> ChangeLog v2 -> v3
>   dt-bindings: hwmon: max20730:
>   - Provide the binding documentation in yaml format
>   hwmon: pmbus: max20730:
>   - No change
> 
> ChangeLog v3 -> v4
>   dt-bindings: hwmon: max20730:
>   - Fix highefficiency to high efficiency in description
>   - Fix presents to present in vout-voltage-divider
>   - Add additionalProperties: false
>   hwmon: pmbus: max20730:
>   - No change

You claim that there have been no changes since v2 of this patch,
yet you dropped my Reviewed-by: tag. Any reason ?

Guenter

> 
>  drivers/hwmon/pmbus/max20730.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index a151a2b588a5..fbf2f1e6c969 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -31,6 +31,7 @@ struct max20730_data {
>  	struct pmbus_driver_info info;
>  	struct mutex lock;	/* Used to protect against parallel writes */
>  	u16 mfr_devset1;
> +	u32 vout_voltage_divider[2];
>  };
>  
>  #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
> @@ -114,6 +115,14 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
>  		max_c = max_current[data->id][(data->mfr_devset1 >> 5) & 0x3];
>  		ret = val_to_direct(max_c, PSC_CURRENT_OUT, info);
>  		break;
> +	case PMBUS_READ_VOUT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret > 0 && data->vout_voltage_divider[0] && data->vout_voltage_divider[1]) {
> +			u64 temp = DIV_ROUND_CLOSEST_ULL((u64)ret * data->vout_voltage_divider[1],
> +							 data->vout_voltage_divider[0]);
> +			ret = clamp_val(temp, 0, 0xffff);
> +		}
> +		break;
>  	default:
>  		ret = -ENODATA;
>  		break;
> @@ -364,6 +373,15 @@ static int max20730_probe(struct i2c_client *client,
>  	data->id = chip_id;
>  	mutex_init(&data->lock);
>  	memcpy(&data->info, &max20730_info[chip_id], sizeof(data->info));
> +	if (of_property_read_u32_array(client->dev.of_node, "vout-voltage-divider",
> +				       data->vout_voltage_divider,
> +				       ARRAY_SIZE(data->vout_voltage_divider)) != 0)
> +		memset(data->vout_voltage_divider, 0, sizeof(data->vout_voltage_divider));
> +	if (data->vout_voltage_divider[1] < data->vout_voltage_divider[0]) {
> +		dev_err(dev,
> +			"The total resistance of voltage divider is less than output resistance\n");
> +		return -ENODEV;
> +	}
>  
>  	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET1);
>  	if (ret < 0)
> -- 
> 2.28.0.806.g8561365e88-goog
> 
