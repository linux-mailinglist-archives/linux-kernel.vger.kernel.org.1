Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97D2B7FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgKROnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKROnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:43:20 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45204C0613D4;
        Wed, 18 Nov 2020 06:43:19 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id t13so2204868ilp.2;
        Wed, 18 Nov 2020 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgVSIg8t9/+FM9rTxwtZKlIcvlhnQQH654LclswFZHo=;
        b=Mli9DBt2KISGsoDx0uXNKa6mWxqtzl26nVXiKIoFSaGdXiVyvkwOJ25sCP6d7sZRmc
         MK1RPWhY8eprSjrO2DvvF7OgLiZFGd1jNJzayZDWAVe0vynoe94K+hBee6uVHVi9ZRuE
         eiKV3Izo1L4t1c6V0ZZui6rOw04c/fpN9F7sCgI7oQuEkA3Gkld33CrLWQVMeKQ2vukh
         vM+K3I99mUQaKod1KlPUKxKgqZfSO+nvbel2YwVjkeUmDmqf0VtvEcmpytKe0vsiez8u
         1NqhJ1JoU6bZgoiWZ7AIXajkDo4VlhDeQ1Ew4ji8JqkrMg5pLQmV5iiWaniqiH1767wC
         qbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgVSIg8t9/+FM9rTxwtZKlIcvlhnQQH654LclswFZHo=;
        b=sDZCyQbLMB/mM5nXHXmzy0/SyUnRpnIJqBWM1SQtO97wcAlK3s5dYZvEjmxIYgqWmI
         yzbvf/dci06skRXd9NL0RLPSHHcKenUp/kI9rE0kaHldIYOEp6W+gFqXutWfV/TNBf72
         ukkDRmshoAU0NmQhL4wBvvxx1+ccV+OPxIJWvvtmmu8R3sCZ3JuEpmKZSwsHy7t6SEwl
         T3wLeuhVGKC/wO6jffvKosYHb09BFqk7YkTsREbxrImHUZ4+n9A4e07LqBWfJokW/lG8
         S3JX2iCMzBinlCQBa7ERh/CScFb11zcnRfAsAsIG49dTkzBwh53k4WSlGJi4fBtSkNCM
         YTpg==
X-Gm-Message-State: AOAM530QNWZmYrAlYuJe9bgqD2JkoLZEy1Exm1udZGeScX+lsXAeu8B6
        jK6Kd3ik4XwRgsIGYLISiD38c50xxfd7diO98JM=
X-Google-Smtp-Source: ABdhPJzI9KZsh5cYa1z3LoS4AewXMJXxwbVEAIO4qmVvtPNMIGF9H2MWMxsvY+ZfrqW6/RXLGgegg1dl9b4lDQwIExA=
X-Received: by 2002:a92:c844:: with SMTP id b4mr16902080ilq.292.1605710598675;
 Wed, 18 Nov 2020 06:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20201111091259.46773-1-alexandru.ardelean@analog.com> <20201111091259.46773-4-alexandru.ardelean@analog.com>
In-Reply-To: <20201111091259.46773-4-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 18 Nov 2020 16:43:07 +0200
Message-ID: <CA+U=Dsqh1MDGjWfULdnmw5+2tTD4dutiodqr+uCdPhsFMbs=iQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hwmon: (ltc2945): add support for sense resistor
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        "Thoren, Mark" <mark.thoren@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:08 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
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
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/hwmon/ltc2945.c | 53 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 6d4569a25471..909dd92a7a20 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -61,9 +61,11 @@
>  /**
>   * struct ltc2945_state - driver instance specific data
>   * @regmap             regmap object to access device registers
> + * @r_sense_uohm       current sense resistor value
>   */
>  struct ltc2945_state {
>         struct regmap           *regmap;
> +       u32                     r_sense_uohm;
>  };
>
>  static inline bool is_power_reg(u8 reg)
> @@ -101,9 +103,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>         case LTC2945_MAX_POWER_THRES_H:
>         case LTC2945_MIN_POWER_THRES_H:
>                 /*
> -                * Convert to uW by assuming current is measured with
> -                * an 1mOhm sense resistor, similar to current
> -                * measurements.
> +                * Convert to uW by and scale it with the configured
> +                * sense resistor, similar to current measurements.
>                  * Control register bit 0 selects if voltage at SENSE+/VDD
>                  * or voltage at ADIN is used to measure power.
>                  */
> @@ -112,10 +113,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>                         return ret;
>                 if (control & CONTROL_MULT_SELECT) {
>                         /* 25 mV * 25 uV = 0.625 uV resolution. */
> -                       val *= 625LL;
> +                       val = DIV_ROUND_CLOSEST_ULL(val * 625LL * 1000, st->r_sense_uohm);
>                 } else {
>                         /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> -                       val = (val * 25LL) >> 1;
> +                       val = DIV_ROUND_CLOSEST_ULL(val * 25LL * 1000, st->r_sense_uohm) >> 1;
>                 }
>                 break;
>         case LTC2945_VIN_H:
> @@ -140,13 +141,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>         case LTC2945_MAX_SENSE_THRES_H:
>         case LTC2945_MIN_SENSE_THRES_H:
>                 /*
> -                * 25 uV resolution. Convert to current as measured with
> -                * an 1 mOhm sense resistor, in mA. If a different sense
> -                * resistor is installed, calculate the actual current by
> -                * dividing the reported current by the sense resistor value
> -                * in mOhm.
> +                * 25 uV resolution. Convert to current and scale it
> +                * with the value of the sense resistor.
>                  */
> -               val *= 25;
> +               val = DIV_ROUND_CLOSEST_ULL(val * 25 * 1000, st->r_sense_uohm);
>                 break;
>         default:
>                 return -EINVAL;
> @@ -169,9 +167,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>         case LTC2945_MAX_POWER_THRES_H:
>         case LTC2945_MIN_POWER_THRES_H:
>                 /*
> -                * Convert to register value by assuming current is measured
> -                * with an 1mOhm sense resistor, similar to current
> -                * measurements.
> +                * Convert to register value, scale it with the configured sense
> +                * resistor value, similar to current measurements.
>                  * Control register bit 0 selects if voltage at SENSE+/VDD
>                  * or voltage at ADIN is used to measure power, which in turn
>                  * determines register calculations.
> @@ -181,14 +178,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>                         return ret;
>                 if (control & CONTROL_MULT_SELECT) {
>                         /* 25 mV * 25 uV = 0.625 uV resolution. */
> -                       val = DIV_ROUND_CLOSEST_ULL(val, 625);
> +                       val = DIV_ROUND_CLOSEST_ULL(val * 1000, 625 * st->r_sense_uohm);

I think that in this ltc2945_val_to_reg(), I should do the math the
other way around.
i.e.    val = DIV_ROUND_CLOSEST_ULL(val * st->r_sense_uohm, 625000);

I got confused initially and did it wrong.

>                 } else {
> -                       /*
> -                        * 0.5 mV * 25 uV = 0.0125 uV resolution.
> -                        * Divide first to avoid overflow;
> -                        * accept loss of accuracy.
> -                        */
> -                       val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
> +                       /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> +                       val = DIV_ROUND_CLOSEST_ULL(val * 2 * 1000, 25 * st->r_sense_uohm);
>                 }
>                 break;
>         case LTC2945_VIN_H:
> @@ -213,13 +206,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>         case LTC2945_MAX_SENSE_THRES_H:
>         case LTC2945_MIN_SENSE_THRES_H:
>                 /*
> -                * 25 uV resolution. Convert to current as measured with
> -                * an 1 mOhm sense resistor, in mA. If a different sense
> -                * resistor is installed, calculate the actual current by
> -                * dividing the reported current by the sense resistor value
> -                * in mOhm.
> +                * 25 uV resolution. Convert to current and scale it
> +                * with the value of the sense resistor, in mA.
>                  */
> -               val = DIV_ROUND_CLOSEST_ULL(val, 25);
> +               val = DIV_ROUND_CLOSEST_ULL(val * 1000, 25 * st->r_sense_uohm);
>                 break;
>         default:
>                 return -EINVAL;
> @@ -475,6 +465,15 @@ static int ltc2945_probe(struct i2c_client *client)
>                 return PTR_ERR(regmap);
>         }
>
> +       if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +                                    &st->r_sense_uohm))
> +               st->r_sense_uohm = 1000;
> +
> +       if (st->r_sense_uohm == 0) {
> +               dev_err(dev, "Zero value provided for sense resistor in DT");
> +               return -EINVAL;
> +       }
> +
>         st->regmap = regmap;
>
>         /* Clear faults */
> --
> 2.17.1
>
