Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AA280653
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbgJASNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJASNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:13:04 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320EC0613D0;
        Thu,  1 Oct 2020 11:13:04 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u126so6549737oif.13;
        Thu, 01 Oct 2020 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SzTn2rI/Abg1eZ9zAHO1/DWnogFkdoJUTHuSooKPL2E=;
        b=Qzcadvf6BDIWj2kiq5IHHTykWrHh+PTE1qfxqV53SovX41d7yTx5E9ITGILZrZsFCa
         L0YiDagi6hzWUqlhI7J8n78eMglZdjfK3r2mEX93N6SMOpj2qBe/YE6OWxPdDdUKuzZ4
         GJZ+EmdjbhG8ft28WBwygyX4jDRbICCkXoOaOj2cB9DwmLhzySW5pnHHVyIcCazvc0Y6
         kwLqPHGDUSjB/UOopqarbdPjQQLnH9Y+VLDMMrOZ8jEpk5XYQzKL/0f5MY7fSYOv6+04
         DpMwQ4nVSRLb+TIEic+l8zu6FzSK4fxz+ubJcVj0jSLjNKZICwe/6lwvIk9EAw19wND+
         McDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SzTn2rI/Abg1eZ9zAHO1/DWnogFkdoJUTHuSooKPL2E=;
        b=FOEIYz0s9+8IJmlRI1ZEtb0xwF/8ej2E47d9tLpyFF0nSMDKVG2oyBMZuQQDIyom+4
         RNrKyygEdRSKsJacnZo9Nbn9Y0lFsTFdkqPuWiXNuQMxCIuNCAedCkPAIZ/jS1cZsCWn
         e6Q0kTDmCwKSE5SZ6zl9quJ7qqvmyjSDBvB/ydes45H/MxR0cKWTAdSIyINrvq96Z4gP
         kyP0AKHbCZv003PfEdoStlhrKunjL7ZXH/0dXNTJYBncZ4xOrutssjDeHnXIVqZiNYxx
         J9QqzhDCidJTfysFPzDf1DuqkDeyn+cbLg01YKU4mgrkbqmZpfZDmPcoG/MKO9DXMc/L
         GMIQ==
X-Gm-Message-State: AOAM530EBLfWMuyfy+0IQePNW7It8MdXE9jGuoWxCIDC6enTcBgntZgj
        Rfg+xJUxnXuWqmWbPKVd9chHFoBenXA=
X-Google-Smtp-Source: ABdhPJyxJsZP6Xw8K3zvINh8skVbgJ/emHDMHzj6V8A+FA6UlqbmaepJPNtBu3vDPFDKANe8CC379w==
X-Received: by 2002:aca:4a4d:: with SMTP id x74mr757686oia.6.1601575983764;
        Thu, 01 Oct 2020 11:13:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q81sm1190747oia.46.2020.10.01.11.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 11:13:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 3/3] hwmon: (lm75) Add regulator support
To:     Alban Bedel <alban.bedel@aerq.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201001145738.17326-1-alban.bedel@aerq.com>
 <20201001145738.17326-4-alban.bedel@aerq.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <8bfad666-10e7-e5d7-c4d8-3877c3f7b449@roeck-us.net>
Date:   Thu, 1 Oct 2020 11:13:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001145738.17326-4-alban.bedel@aerq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 7:57 AM, Alban Bedel wrote:
> Add regulator support for boards where the sensor first need to be
> powered up before it can be used.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> ---
> v2: Rely on dummy regulators instead of explicitly handling missing
>     regulator
> v3: Use a devm action to handle disabling the regulator
> ---

Second '---' is not needed.

I can not apply patches 1 and 2 of the series since I don't have an
Ack from a DT maintainer, but this one looks good. Applied.

Guenter


>  drivers/hwmon/lm75.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ba0be48aeadd..e9c1f55b2706 100644
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
> @@ -534,6 +536,13 @@ static const struct regmap_config lm75_regmap_config = {
>  	.use_single_write = true,
>  };
>  
> +static void lm75_disable_regulator(void *data)
> +{
> +	struct lm75_data *lm75 = data;
> +
> +	regulator_disable(lm75->vs);
> +}
> +
>  static void lm75_remove(void *data)
>  {
>  	struct lm75_data *lm75 = data;
> @@ -567,6 +576,10 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	data->client = client;
>  	data->kind = kind;
>  
> +	data->vs = devm_regulator_get(dev, "vs");
> +	if (IS_ERR(data->vs))
> +		return PTR_ERR(data->vs);
> +
>  	data->regmap = devm_regmap_init_i2c(client, &lm75_regmap_config);
>  	if (IS_ERR(data->regmap))
>  		return PTR_ERR(data->regmap);
> @@ -581,6 +594,17 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	data->sample_time = data->params->default_sample_time;
>  	data->resolution = data->params->default_resolution;
>  
> +	/* Enable the power */
> +	err = regulator_enable(data->vs);
> +	if (err) {
> +		dev_err(dev, "failed to enable regulator: %d\n", err);
> +		return err;
> +	}
> +
> +	err = devm_add_action_or_reset(dev, lm75_disable_regulator, data);
> +	if (err)
> +		return err;
> +
>  	/* Cache original configuration */
>  	status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
>  	if (status < 0) {
> 

