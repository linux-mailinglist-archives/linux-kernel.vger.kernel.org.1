Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B92ED37B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAGP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbhAGP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:26:22 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB51C0612F4;
        Thu,  7 Jan 2021 07:25:41 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id j21so1638438oou.11;
        Thu, 07 Jan 2021 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHozb/E6JfCKzfGCGapqQNL16pfKAvjUhqi2FLGmly8=;
        b=RoocLYvV6QiLFocPwQhISy0TqKPPs1bP2GCBu8ThmDcox0VpNTAgEe/cqXTIXKau9F
         a8DYGbmI3OAJ0JXbLdEuHTX1hRzMDkyMdWxeRmF+2/2yb0Kg4JUgwWo0py9kZyc7QZ84
         SempakJXEwdWPPgl2KoCEt+G/kwxLNLarlbDRh56D/qZenIlWnI7yERGYnAAVJWTUY9O
         WYiR7PuU7u8r4h7SELkPFZMp//i539XNCQ8+FhmK2n90D7h3jMJ1TZqg8BZixRGWv/N3
         7u4R08062BrIFRSxR5EuNedw/OK4LMM18zmktDvwOo9p03ddTXwz8f71PVVkLqjyHl0f
         nCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHozb/E6JfCKzfGCGapqQNL16pfKAvjUhqi2FLGmly8=;
        b=Y5cqCJ1qG/FHxzAlq6QQ6s24qgACmFrxak2AF9O6x5bY0ty5/8CcyVq7BllLRqxvUF
         CQln42K1l5iDqYFk3VdoFUMVyFS5dZ4kStP+xKEN6FDLSYfy/9YV5iw18qSaIsd9XF+m
         a0zNiAyY7tKMVVChSgmw0I82UXob0K/76t/xiyx3Y++vntksspchP9qzhJw1ZB5lssdy
         UeYb2Co89HitX8CIVUdSfATzY9vis2jB6n1CQz/6WmRJfmu1VNOAWpCV+Rex8E3P0OFS
         DysAUV4Dv4/wbJY7ES3Vhn4Okczaa/h7gpl4jRQjMCtRmCjFFZLTGu0ZAzOgd2k34KPV
         NkqQ==
X-Gm-Message-State: AOAM531zUcJuHjYxjLc50uNDd6aOYKeIlpYzpkfE5fSW6ostnLXa29/v
        C+DJ3CzlXMU6qkGoaZHDOdk=
X-Google-Smtp-Source: ABdhPJx9krEQiazaM+tHfpYNLxESgrKuMlHKWjtEeQ52NOZ4uss+miKLLxvahhoV5IL5Kn060GAgYA==
X-Received: by 2002:a4a:e687:: with SMTP id u7mr1467255oot.20.1610033141202;
        Thu, 07 Jan 2021 07:25:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24sm1351752oij.20.2021.01.07.07.25.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jan 2021 07:25:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 7 Jan 2021 07:25:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        jdelvare@suse.com, mark.thoren@analog.com, ardeleanalex@gmail.com
Subject: Re: [PATCH v3 3/4] hwmon: (ltc2945): add support for sense resistor
Message-ID: <20210107152538.GC13040@roeck-us.net>
References: <20210107103417.16010-1-alexandru.ardelean@analog.com>
 <20210107103417.16010-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107103417.16010-4-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:34:16PM +0200, Alexandru Ardelean wrote:
> The sense resistor is a parameter of the board. It should be configured in
> the driver via a device-tree / ACPI property, so that the proper current
> measurements can be done in the driver.
> 
> It shouldn't be necessary that userspace need to know about the value of
> the resistor. It makes things a bit harder to make the application code
> portable from one board to another.
> 
> This change implements support for the sense resistor to be configured from
> DT/ACPI and used in current calculations.
> Also, the maximum power and current that can be represented by the driver
> are scaled with the value of the sense resistor.
> 

In a way you are correct, but that applies to all hwmon
drivers, not just to this one. A solution which only applies
to a single driver doesn't solve the underlying problem,
which would be the desire or need to provide kernel-based
scaling for hwmon drivers. As such, I am not inclined to accept
this patch. We should think about a generic solution instead.

Note that this patch doesn't compile on 32-bit targets.

Thanks,
Guenter

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/hwmon/ltc2945.c | 60 ++++++++++++++++++++++++++---------------
>  1 file changed, 39 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 41df2c8b7673..e60b15832b0e 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -70,9 +70,15 @@
>  /**
>   * struct ltc2945_state - driver instance specific data
>   * @regmap:		regmap object to access device registers
> + * @max_power_uw:	maximum power that can be represented based on sense resistor
> + * @max_current_ma:	maximum current that can be represented based on sense resistor
> + * @r_sense_mohm:	current sense resistor value
>   */
>  struct ltc2945_state {
>  	struct regmap		*regmap;
> +	u32			max_power_uw;
> +	u32			max_current_ma;
> +	u32			r_sense_mohm;
>  };
>  
>  static inline bool is_power_reg(u8 reg)
> @@ -110,9 +116,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  	case LTC2945_MAX_POWER_THRES_H:
>  	case LTC2945_MIN_POWER_THRES_H:
>  		/*
> -		 * Convert to uW by assuming current is measured with
> -		 * an 1mOhm sense resistor, similar to current
> -		 * measurements.
> +		 * Convert to uW by and scale it with the configured
> +		 * sense resistor, similar to current measurements.
>  		 * Control register bit 0 selects if voltage at SENSE+/VDD
>  		 * or voltage at ADIN is used to measure power.
>  		 */
> @@ -126,6 +131,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
>  			val = (val * 25LL) >> 1;
>  		}
> +		val /= st->r_sense_mohm;
>  		break;
>  	case LTC2945_VIN_H:
>  	case LTC2945_MAX_VIN_H:
> @@ -149,13 +155,11 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  	case LTC2945_MAX_SENSE_THRES_H:
>  	case LTC2945_MIN_SENSE_THRES_H:
>  		/*
> -		 * 25 uV resolution. Convert to current as measured with
> -		 * an 1 mOhm sense resistor, in mA. If a different sense
> -		 * resistor is installed, calculate the actual current by
> -		 * dividing the reported current by the sense resistor value
> -		 * in mOhm.
> +		 * 25 uV resolution. Convert to current and scale it
> +		 * with the value of the sense resistor.
>  		 */
>  		val *= 25;
> +		val /= st->r_sense_mohm;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -163,7 +167,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  	return val;
>  }
>  
> -static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
> +static unsigned long ltc2945_val_clamp(struct ltc2945_state *st, u8 reg,
> +				       unsigned long val)
>  {
>  	switch (reg) {
>  	case LTC2945_POWER_H:
> @@ -171,8 +176,7 @@ static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
>  	case LTC2945_MIN_POWER_H:
>  	case LTC2945_MAX_POWER_THRES_H:
>  	case LTC2945_MIN_POWER_THRES_H:
> -		/* No sense in clamping now, LTC2945_POWER_FULL_SCALE_UW is larger than UINT32_MAX */
> -		return val;
> +		return clamp_val(val, 0, st->max_power_uw);
>  	case LTC2945_VIN_H:
>  	case LTC2945_MAX_VIN_H:
>  	case LTC2945_MIN_VIN_H:
> @@ -190,7 +194,7 @@ static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
>  	case LTC2945_MIN_SENSE_H:
>  	case LTC2945_MAX_SENSE_THRES_H:
>  	case LTC2945_MIN_SENSE_THRES_H:
> -		return clamp_val(val, 0, LTC2945_SENSE_FULL_SCALE_MA);
> +		return clamp_val(val, 0, st->max_current_ma);
>  	default:
>  		/*
>  		 * This is unlikely to happen, and if it does, it should
> @@ -215,9 +219,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MAX_POWER_THRES_H:
>  	case LTC2945_MIN_POWER_THRES_H:
>  		/*
> -		 * Convert to register value by assuming current is measured
> -		 * with an 1mOhm sense resistor, similar to current
> -		 * measurements.
> +		 * Convert to register value, scale it with the configured sense
> +		 * resistor value, similar to current measurements.
>  		 * Control register bit 0 selects if voltage at SENSE+/VDD
>  		 * or voltage at ADIN is used to measure power, which in turn
>  		 * determines register calculations.
> @@ -236,6 +239,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  			 */
>  			val = DIV_ROUND_CLOSEST(val, 25) * 2;
>  		}
> +		val *= st->r_sense_mohm;
>  		break;
>  	case LTC2945_VIN_H:
>  	case LTC2945_MAX_VIN_H:
> @@ -259,12 +263,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MAX_SENSE_THRES_H:
>  	case LTC2945_MIN_SENSE_THRES_H:
>  		/*
> -		 * 25 uV resolution. Convert to current as measured with
> -		 * an 1 mOhm sense resistor, in mA. If a different sense
> -		 * resistor is installed, calculate the actual current by
> -		 * dividing the reported current by the sense resistor value
> -		 * in mOhm.
> +		 * 25 uV resolution. Convert to current and scale it
> +		 * with the value of the sense resistor, in mA.
>  		 */
> +		val *= st->r_sense_mohm;
>  		val = DIV_ROUND_CLOSEST(val, 25);
>  		break;
>  	default:
> @@ -303,7 +305,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	val = ltc2945_val_clamp(reg, val);
> +	val = ltc2945_val_clamp(st, reg, val);
>  
>  	/* convert to register value, then clamp and write result */
>  	regval = ltc2945_val_to_reg(dev, reg, val);
> @@ -512,6 +514,7 @@ static int ltc2945_probe(struct i2c_client *client)
>  	struct ltc2945_state *st;
>  	struct device *hwmon_dev;
>  	struct regmap *regmap;
> +	u64 val64;
>  
>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>  	if (!st)
> @@ -523,7 +526,22 @@ static int ltc2945_probe(struct i2c_client *client)
>  		return PTR_ERR(regmap);
>  	}
>  
> +	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				     &st->r_sense_mohm))
> +		st->r_sense_mohm = 1000;
> +
> +	if (st->r_sense_mohm < 1000) {
> +		dev_err(dev, "Value too small for sense resistor, minimum 1000\n");
> +		return -EINVAL;
> +	}
> +	st->r_sense_mohm /= 1000;
> +
>  	st->regmap = regmap;
> +	val64 = LTC2945_POWER_FULL_SCALE_UW / st->r_sense_mohm;
> +	/* clamp power to ULONG_MAX, since we represent it on 32 bits */
> +	st->max_power_uw = clamp_val(val64, 0, ULONG_MAX);
> +
> +	st->max_current_ma = LTC2945_SENSE_FULL_SCALE_MA / st->r_sense_mohm;
>  
>  	/* Clear faults */
>  	regmap_write(regmap, LTC2945_FAULT, 0x00);
> -- 
> 2.17.1
> 
