Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AEA2A96DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgKFNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKFNR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:17:29 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9C2C0613CF;
        Fri,  6 Nov 2020 05:17:29 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m17so1284436oie.4;
        Fri, 06 Nov 2020 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cl/ycZxtnI9EC0QYhyMPuP34JYCjCitMnzolMq2mMYg=;
        b=igwT2yX+dPROCTZS0VYU32dwBZ6KOKqxzQZfUPK8/8zY6LJO27gznweVXzPTDclqdE
         lTT7BV3vWljwZ5JiRYSasGJCSq75Dbyw5yTLl0scXLVFnBt0nVNJQxX3fgrCqrRjyWoy
         8I18aYYx4gOYgeUw2//FuxG3B3IrYFDXZ+WEZ09hXWLH9u7sAa2CykwR8ryw9a70AvFF
         Ovqx9k3yB+s5ZChoWdkZbfcELA5bieIjNjO+zZIFAPrIeC1UFRq2vQcJKAls4642br+E
         oBXbLGf+ZFd6japLzWcZRGdD5546IKtHHIZrLUMe/EpN3YhuE0zcqbSGkDRmnSJpNBgJ
         qUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cl/ycZxtnI9EC0QYhyMPuP34JYCjCitMnzolMq2mMYg=;
        b=DpkCXWaH6a6gkKPASQbaWbyapY7iCacKV3yeq/wvHPyYJVaQ5HNc4wHPnFUT4dB8c6
         AlYLkPo8o2P4/0CcJL2T1WVoUESzSKKHRc2+r6ZsN/koDoPP5ct02JmCEdAMrXF8HtfV
         Vu2rlayMruqsJRlWefM3ZuRcD3kSOnc7FN+fIUAELxg8aK+Ae1ztmj0jF3Rh3WGnPHQP
         Mpl+9IpkG5rb2xaDuc0zmiCB6GYfq66NrSlOLcDYEGWaH6LdVnutu77aaLzlUtdwHOxX
         bRjLAhVDhJmwQQRGx+vPhXzf6xF0Od3SE9sfO2I9tEKG6La4HOH9K55y2/6t5G1lSDxx
         yTbg==
X-Gm-Message-State: AOAM5302OvrelioNfU+TkkV4x0YBRr7Mn074BfM0JVW97XSWgi35Q2p/
        gfjFQSu7OAvLGwfKfIvLutc=
X-Google-Smtp-Source: ABdhPJyE961wLos4Gmwzl5WTb6Fjh4d9g/34rIDrgJs1XAOJ18jf4WbzkbrZPsmRpbJcmTp0uBthdw==
X-Received: by 2002:aca:4306:: with SMTP id q6mr985911oia.169.1604668648506;
        Fri, 06 Nov 2020 05:17:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm246503oij.40.2020.11.06.05.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 05:17:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 6 Nov 2020 05:17:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, ardeleanalex@gmail.com, Mark.Thoren@analog.com
Subject: Re: [PATCH 3/3] hwmon: (ltc2945): add support for sense resistor
Message-ID: <20201106131727.GD14837@roeck-us.net>
References: <20201106101825.30960-1-alexandru.ardelean@analog.com>
 <20201106101825.30960-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106101825.30960-3-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:18:25PM +0200, Alexandru Ardelean wrote:
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
> 

This will require a matching deevicetree document.

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/hwmon/ltc2945.c | 48 ++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 75d997d31e01..500401a82c49 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -61,9 +61,11 @@
>  /**
>   * struct ltc2945_state - driver instance specific data
>   * @regmap		regmap object to access device registers
> + * @r_sense_uohm	current sense resistor value
>   */
>  struct ltc2945_state {
>  	struct regmap		*regmap;
> +	u32			r_sense_uohm;
>  };
>  
>  static inline bool is_power_reg(u8 reg)
> @@ -101,9 +103,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
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
> @@ -112,10 +113,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  			return ret;
>  		if (control & CONTROL_MULT_SELECT) {
>  			/* 25 mV * 25 uV = 0.625 uV resolution. */
> -			val *= 625LL;
> +			val = DIV_ROUND_CLOSEST_ULL(val * 625LL * 1000, st->r_sense_uohm);
>  		} else {
>  			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> -			val = (val * 25LL) >> 1;
> +			val = DIV_ROUND_CLOSEST_ULL(val * 25LL * 1000, st->r_sense_uohm) >> 1;
>  		}
>  		break;
>  	case LTC2945_VIN_H:
> @@ -140,13 +141,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
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
> -		val *= 25;
> +		val = DIV_ROUND_CLOSEST_ULL(val * 25 * 1000, st->r_sense_uohm);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -169,9 +167,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
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
> @@ -181,14 +178,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  			return ret;
>  		if (control & CONTROL_MULT_SELECT) {
>  			/* 25 mV * 25 uV = 0.625 uV resolution. */
> -			val = DIV_ROUND_CLOSEST_ULL(val, 625);
> +			val = DIV_ROUND_CLOSEST_ULL(val * 1000, 625 * st->r_sense_uohm);
>  		} else {
> -			/*
> -			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
> -			 * Divide first to avoid overflow;
> -			 * accept loss of accuracy.
> -			 */
> -			val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
> +			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> +			val = DIV_ROUND_CLOSEST_ULL(val * 2 * 1000, 25 * st->r_sense_uohm);
>  		}
>  		break;
>  	case LTC2945_VIN_H:
> @@ -213,13 +206,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
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
> -		val = DIV_ROUND_CLOSEST_ULL(val, 25);
> +		val = DIV_ROUND_CLOSEST_ULL(val * 1000, 25 * st->r_sense_uohm);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -475,6 +465,10 @@ static int ltc2945_probe(struct i2c_client *client)
>  		return PTR_ERR(regmap);
>  	}
>  
> +	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				     &st->r_sense_uohm))
> +		st->r_sense_uohm = 1000;
> +

Devicetree could set shunt-resistor-micro-ohms to 0, which would result
in divide by 0 errors.

Guenter

>  	st->regmap = regmap;
>  
>  	/* Clear faults */
> -- 
> 2.27.0
> 
