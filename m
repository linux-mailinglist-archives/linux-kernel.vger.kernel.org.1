Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7112AF426
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgKKOyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgKKOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:54:07 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9580C0613D1;
        Wed, 11 Nov 2020 06:54:06 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id r11so489671oos.12;
        Wed, 11 Nov 2020 06:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iPERwSfkiAfW2rNgM+azYwXtllH9KvpuMQt9Lr5C0OU=;
        b=R88LHs6ArvHBp0HWcyjA41gfq8z5QDKUQeBgF0AVib/Ft0koiNzcgdcYKxacDFofY+
         gYAnOJv9NRCWZOwKYXQx8eODNWfg1iRgnT3fpXFG6UdNU39z1j3MDjIcekTc3dTklHRJ
         Lguldj2MA7pB3uFo0EfJptawTrq2lizbyZMjru7FAnOWm6PVqVcxKBY/POLGw94erfIo
         ThUR/PAuLn+0n8ylUylQ9Rqo7kvRAIxqLs7v16ztDuzsZt6N9uoVszEeWQ3hH27CbJTr
         Xoi0zcvnI9a/CSC2mafewOMo28Dm9iNlA5l531CsTXoY/l+27Nwszji85eNsVpOzoISN
         zvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iPERwSfkiAfW2rNgM+azYwXtllH9KvpuMQt9Lr5C0OU=;
        b=JPFGTCoR4/9KIb+ZwUNgSd3IWukYyGFxRFvLLByAHrgF+PfYJmHo9R4YPONEcr16et
         B4BDaKYwCEKTHm/Rbk+DuwmjNNHrMSa8U7scNWVm70vgLjXmjOjhjkaTPeF3sYtc12Zf
         eGt9RHRNDCMm0SFhpkAQRZG29sqc+Jh5N1z0dxMTqQAKCfg8C3ex13/sBcdso0jLzQVA
         OXQxko7fBIEni+KgDiggM+dEFOIYWvfJp9c22UmnKtcdyzntfcB1c3AJqmcrbQ/2MS0D
         XZrF1u+WB/Ot1mELZpNauHurj3XZCadSV6Htx3unY65juN+MIMurhyYRDCG+TH9bB8FF
         Oqow==
X-Gm-Message-State: AOAM530+31h41gz6nuyxaawdPQA8cRzhyIsdqII9oKabiGLx1HxHPfpj
        xOw19SzpG87c5vInF8aPqWqyh/9M8P0=
X-Google-Smtp-Source: ABdhPJyo0AOePW5EvSrzVFnWRRMENbxhWiZm20PjGIAHogLw2j5LotGnIf/xqT2LiTWCJ55CAdnl5w==
X-Received: by 2002:a4a:8f98:: with SMTP id c24mr7926307ooj.27.1605106445992;
        Wed, 11 Nov 2020 06:54:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6sm532013ota.49.2020.11.11.06.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 06:54:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/4] docs: hwmon: (ltc2945): change type of val to ULL
 in ltc2945_val_to_reg()
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, jdelvare@suse.com, mark.thoren@analog.com,
        ardeleanalex@gmail.com
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
 <20201111091259.46773-3-alexandru.ardelean@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <41f86559-9165-40f9-e7f3-3e7f5eca7315@roeck-us.net>
Date:   Wed, 11 Nov 2020 06:54:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111091259.46773-3-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 1:12 AM, Alexandru Ardelean wrote:
> In order to account for any potential overflows that could occur.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Thinking about it, this can only really happen if the user provides
excessive values for limit attributes. Those are currently clamped
later, after the conversion. I think it would be better to modify
the code to apply a clamp _before_ the conversion as well instead
of trying to solve the overflow problem with unsigned long long.

Either case, can you send me a register dump for this chip ?
I'd like to write a module test script to actually check if there
are any over/underflows or other problems.

Thanks,
Guenter

> ---
>  drivers/hwmon/ltc2945.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 1cea710df668..6d4569a25471 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -155,7 +155,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  }
>  
>  static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> -			      unsigned long val)
> +			      unsigned long long val)
>  {
>  	struct ltc2945_state *st = dev_get_drvdata(dev);
>  	struct regmap *regmap = st->regmap;
> @@ -181,14 +181,14 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  			return ret;
>  		if (control & CONTROL_MULT_SELECT) {
>  			/* 25 mV * 25 uV = 0.625 uV resolution. */
> -			val = DIV_ROUND_CLOSEST(val, 625);
> +			val = DIV_ROUND_CLOSEST_ULL(val, 625);
>  		} else {
>  			/*
>  			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
>  			 * Divide first to avoid overflow;
>  			 * accept loss of accuracy.
>  			 */
> -			val = DIV_ROUND_CLOSEST(val, 25) * 2;
> +			val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
>  		}
>  		break;
>  	case LTC2945_VIN_H:
> @@ -197,7 +197,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MAX_VIN_THRES_H:
>  	case LTC2945_MIN_VIN_THRES_H:
>  		/* 25 mV resolution. */
> -		val /= 25;
> +		val = div_u64(val, 25);
>  		break;
>  	case LTC2945_ADIN_H:
>  	case LTC2945_MAX_ADIN_H:
> @@ -219,7 +219,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  		 * dividing the reported current by the sense resistor value
>  		 * in mOhm.
>  		 */
> -		val = DIV_ROUND_CLOSEST(val, 25);
> +		val = DIV_ROUND_CLOSEST_ULL(val, 25);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -247,7 +247,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
>  	struct ltc2945_state *st = dev_get_drvdata(dev);
>  	struct regmap *regmap = st->regmap;
>  	u8 reg = attr->index;
> -	unsigned long val;
> +	unsigned long long val;
>  	u8 regbuf[3];
>  	int num_regs;
>  	int regval;
> 

