Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D89C26F562
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIRFdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIRFdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:33:42 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A713C06174A;
        Thu, 17 Sep 2020 22:33:42 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id r4so1155631ooq.7;
        Thu, 17 Sep 2020 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n52slrPNh8OTCwL/iY9U8moP4fMc8jACR40qbsOd1Mk=;
        b=e+dvn+NUr4NeVBFx+EQeB5m/hK0pp9xEEAoK74Ca7AbCZ7xiXqRcG29kBtpKQAmDD2
         DdFW+7M3cYSWPrxx9EKBo8SndkbgG/f2Zt4qu2tZDRjD2/VFlF4rCrr/UiH34V7JA9dO
         ZdXyS7LUHZopLJwTnwbWB6NY2wy5sNQEpc4neyJ6Ijn3aYH9Wiw5EbyGmJa+JHb1wljC
         dSSCIFhbuts70ByqDD7BNMDSLvQuj/Ecwwv9s99gAq0QKBKQro4MIGmPZhov68HgSuhj
         bAC+OdRH/HhU7C8nCL8MVUgSpAPkyz+ar7sVnmAhZudncLpEPEolcKVTyd+4bSj33oMj
         DmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n52slrPNh8OTCwL/iY9U8moP4fMc8jACR40qbsOd1Mk=;
        b=KorxMMgFIEeNA4Y9TkdnvjJLsE67vUk1R5rokD+eVNKiwCzDcUJ0J2SZTIJWbyJPcm
         UmOGRMIlss5pGCzBo3v5fo7i22S5DU1J5R0oNYX0ccwVOfe4mST3R3CMb1959o7hAxrg
         XHFdK92IHzKJEISXv3ifFegkVboxbhQtf5Pi4MUaURsctTqcJqShn304WHwL17YHEhY4
         EI3XMNAUho3uFniesuIbCr16HaUE+Ssjs49x6/0LJa7SrVf8fFCBRtjvTE7zTvWJUTqY
         q+tbTbY+vicXPYF1jc9cY/dAaEK0WFCzCHArA6Y4SIu9H0jEHyagp5IQaAbNwgkvtKDL
         PXqA==
X-Gm-Message-State: AOAM532jQF64WpVmHzCFVWvMSfM2Za0L2p72CMcMUIlS4P5VNT+dWppL
        42TGTbekigoyYGcQkiDFxH6tnzRyi8Q=
X-Google-Smtp-Source: ABdhPJzxpIsRy9MZBg/2ecv5PZY42IOnshLWD1vCGd+J7z80XIQtWEgkGjdM2M9xc/4jfy+F+rB0Cw==
X-Received: by 2002:a4a:7055:: with SMTP id b21mr9721960oof.26.1600407220422;
        Thu, 17 Sep 2020 22:33:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4sm1566833otp.75.2020.09.17.22.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 22:33:39 -0700 (PDT)
Subject: Re: [PATCH 3/3] hwmon: (lm75) Add regulator support
To:     Alban Bedel <alban.bedel@aerq.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200917101819.32045-1-alban.bedel@aerq.com>
 <20200917101819.32045-4-alban.bedel@aerq.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7986c014-b826-bad1-f19c-cdda31d20804@roeck-us.net>
Date:   Thu, 17 Sep 2020 22:33:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917101819.32045-4-alban.bedel@aerq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 3:18 AM, Alban Bedel wrote:
> Add regulator support for boards where the sensor first need to be
> powered up before it can be used.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> ---
>  drivers/hwmon/lm75.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ba0be48aeadd..b673f8d2ef20 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/util_macros.h>
> +#include <linux/regulator/consumer.h>
>  #include "lm75.h"
>  
>  /*
> @@ -101,6 +102,7 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
>  struct lm75_data {
>  	struct i2c_client		*client;
>  	struct regmap			*regmap;
> +	struct regulator		*vs;
>  	u8				orig_conf;
>  	u8				current_conf;
>  	u8				resolution;	/* In bits, 9 to 16 */
> @@ -540,6 +542,8 @@ static void lm75_remove(void *data)
>  	struct i2c_client *client = lm75->client;
>  
>  	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
> +	if (lm75->vs)
> +		regulator_disable(lm75->vs);
>  }
>  
>  static int
> @@ -567,6 +571,14 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	data->client = client;
>  	data->kind = kind;
>  
> +	data->vs = devm_regulator_get_optional(dev, "vs");

Looking into the regulator API, it may be better if you use devm_regulator_get().
AFAICS it returns a dummy regulator if there is none, and NULL if the regulator
subsystem is disabled. So
	data->vs = devm_regulator_get(dev, "vs");
	if (IS_ERR(data->vs))
		return PTR_ERR(data->vs);
should work and would be less messy.

> +	if (IS_ERR(data->vs)) {
> +		if (PTR_ERR(data->vs) == -ENODEV)
> +			data->vs = NULL;
> +		else
> +			return PTR_ERR(data->vs);
> +	}
> +
>  	data->regmap = devm_regmap_init_i2c(client, &lm75_regmap_config);
>  	if (IS_ERR(data->regmap))
>  		return PTR_ERR(data->regmap);
> @@ -581,11 +593,21 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	data->sample_time = data->params->default_sample_time;
>  	data->resolution = data->params->default_resolution;
>  
> +	/* Enable the power */
> +	if (data->vs) {
> +		err = regulator_enable(data->vs);
> +		if (err) {
> +			dev_err(dev, "failed to enable regulator: %d\n", err);
> +			return err;
> +		}
> +	}
> +

How about device removal ? Don't you have to call regulator_disable()
there as well ? If so, it might be best to use devm_add_action_or_reset()
to register a disable function.

Thanks,
Guenter

>  	/* Cache original configuration */
>  	status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
>  	if (status < 0) {
>  		dev_dbg(dev, "Can't read config? %d\n", status);
> -		return status;
> +		err = status;
> +		goto disable_regulator;
>  	}
>  	data->orig_conf = status;
>  	data->current_conf = status;
> @@ -593,7 +615,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	err = lm75_write_config(data, data->params->set_mask,
>  				data->params->clr_mask);
>  	if (err)
> -		return err;
> +		goto disable_regulator;
>  
>  	err = devm_add_action_or_reset(dev, lm75_remove, data);
>  	if (err)
> @@ -608,6 +630,11 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
>  
>  	return 0;
> +
> +disable_regulator:
> +	if (data->vs)
> +		regulator_disable(data->vs);
> +	return err;
>  }
>  
>  static const struct i2c_device_id lm75_ids[] = {
> 

