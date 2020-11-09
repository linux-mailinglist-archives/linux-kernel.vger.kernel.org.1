Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70A2ABEFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgKIOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbgKIOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:42:50 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447FC0613CF;
        Mon,  9 Nov 2020 06:42:49 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l20so2246125oot.3;
        Mon, 09 Nov 2020 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Qwrq1LSvMb7G5VW3/Pd2Lvzc0jIHM/BqwKNN+CwFsw=;
        b=E7lY5WejIaifOqlckd4TpihwYktWdNS13JDJFfENaUCT3gV6bshRwLXNEhVpd01EbU
         oEVNBOUrhqM+bMYhyzPIYDiKlhjSuH0Ig3FntTSakDF/EqjYzcEoBBe8uzG9S2eLY1/v
         AEjfdvBu8sZI4bbG/Q45CAEHSd1qPThGj+a6xVKQGX/HRpnt6JiFe+oe3SHUf+Fm4Y6h
         T2++edsuCkurDLhuhcehR16QZ3TDAjMutsWVVMD3GGL+bh4DVaiG9S9jKD/zkSda/ARp
         ASWHdasimCddWEAdrSw9qwB5B8rl/UPzUmJPVQVR4ahTUYa2tGPDxGMZp+BS1RlzyP/v
         JCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4Qwrq1LSvMb7G5VW3/Pd2Lvzc0jIHM/BqwKNN+CwFsw=;
        b=hdAtufDTCQOVcCX2UCfEhwxQRcHjIrLeXLgZtpS0bMveEO1A2N9UIm15wyujWjfFwN
         U0eomGygZqFzxUhkbnCmspfD4jrNeFw0dFbGHdtetYPdgKauxx/UP2uS+G4Ji6CvdlT9
         +fmjmyG2y9Dv/LKKikIKL0412/i1hNwzOYsp5xyQLCVJQMUbqdOS/zLpHJtvwxdpWgTG
         riRjP0qD7aV0Hqc1k/eOs8d1lsupzfu078mL/ZdHC7o+Aw5Ccy6Si6uBhizX/eschXh9
         u4ycS3kQaZtqmE+fWJDX0nrFZeg/iKso94EKWWToML5R9Op+FpS29ph9rRWCI/VSYIM6
         PHmg==
X-Gm-Message-State: AOAM5308SFBqIuSCpFi+GqOe4Zi3IKe2ZUSQGG4pBPLfE6L/HY7GrfCs
        cIYYR/GodTaBy3ykIiKJpyc=
X-Google-Smtp-Source: ABdhPJw9aXJc1BgwU7A/n4W9UMX4n8wmw6pG2JdwllLnBo7RKZaD7aZnNiYT+RI9MitaBL2vhzlkLw==
X-Received: by 2002:a4a:2843:: with SMTP id c3mr10157738oof.3.1604932968752;
        Mon, 09 Nov 2020 06:42:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26sm285837oop.18.2020.11.09.06.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:42:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (ltc2945): add support for sense resistor
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        jdelvare@suse.com, Mark.Thoren@analog.com
References: <20201106101825.30960-1-alexandru.ardelean@analog.com>
 <20201106101825.30960-3-alexandru.ardelean@analog.com>
 <20201106131727.GD14837@roeck-us.net>
 <CA+U=DsoQNfYQ2o-wKpcqUJ9Xj9u9U4Nas8xKYhcYusU4HyHx1g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <11250d2d-c8ec-a1dc-2f80-edc531160d3e@roeck-us.net>
Date:   Mon, 9 Nov 2020 06:42:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DsoQNfYQ2o-wKpcqUJ9Xj9u9U4Nas8xKYhcYusU4HyHx1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/20 10:41 PM, Alexandru Ardelean wrote:
> On Fri, Nov 6, 2020 at 3:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Nov 06, 2020 at 12:18:25PM +0200, Alexandru Ardelean wrote:
>>> The sense resistor is a parameter of the board. It should be configured in
>>> the driver via a device-tree / ACPI property, so that the proper current
>>> measurements can be done in the driver.
>>>
>>> It shouldn't be necessary that userspace need to know about the value of
>>> the resistor. It makes things a bit harder to make the application code
>>> portable from one board to another.
>>>
>>> This change implements support for the sense resistor to be configured from
>>> DT/ACPI and used in current calculations.
>>>
>>
>> This will require a matching deevicetree document.
> 
> Ack
> Will create a dt binding schema doc.
> Are you fine with being added as maintainer in the DT doc?
> Seeing as you are the original author of the driver.
> 

Sure.

Guenter

>>
>>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>> ---
>>>  drivers/hwmon/ltc2945.c | 48 ++++++++++++++++++-----------------------
>>>  1 file changed, 21 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
>>> index 75d997d31e01..500401a82c49 100644
>>> --- a/drivers/hwmon/ltc2945.c
>>> +++ b/drivers/hwmon/ltc2945.c
>>> @@ -61,9 +61,11 @@
>>>  /**
>>>   * struct ltc2945_state - driver instance specific data
>>>   * @regmap           regmap object to access device registers
>>> + * @r_sense_uohm     current sense resistor value
>>>   */
>>>  struct ltc2945_state {
>>>       struct regmap           *regmap;
>>> +     u32                     r_sense_uohm;
>>>  };
>>>
>>>  static inline bool is_power_reg(u8 reg)
>>> @@ -101,9 +103,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>>>       case LTC2945_MAX_POWER_THRES_H:
>>>       case LTC2945_MIN_POWER_THRES_H:
>>>               /*
>>> -              * Convert to uW by assuming current is measured with
>>> -              * an 1mOhm sense resistor, similar to current
>>> -              * measurements.
>>> +              * Convert to uW by and scale it with the configured
>>> +              * sense resistor, similar to current measurements.
>>>                * Control register bit 0 selects if voltage at SENSE+/VDD
>>>                * or voltage at ADIN is used to measure power.
>>>                */
>>> @@ -112,10 +113,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>>>                       return ret;
>>>               if (control & CONTROL_MULT_SELECT) {
>>>                       /* 25 mV * 25 uV = 0.625 uV resolution. */
>>> -                     val *= 625LL;
>>> +                     val = DIV_ROUND_CLOSEST_ULL(val * 625LL * 1000, st->r_sense_uohm);
>>>               } else {
>>>                       /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
>>> -                     val = (val * 25LL) >> 1;
>>> +                     val = DIV_ROUND_CLOSEST_ULL(val * 25LL * 1000, st->r_sense_uohm) >> 1;
>>>               }
>>>               break;
>>>       case LTC2945_VIN_H:
>>> @@ -140,13 +141,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>>>       case LTC2945_MAX_SENSE_THRES_H:
>>>       case LTC2945_MIN_SENSE_THRES_H:
>>>               /*
>>> -              * 25 uV resolution. Convert to current as measured with
>>> -              * an 1 mOhm sense resistor, in mA. If a different sense
>>> -              * resistor is installed, calculate the actual current by
>>> -              * dividing the reported current by the sense resistor value
>>> -              * in mOhm.
>>> +              * 25 uV resolution. Convert to current and scale it
>>> +              * with the value of the sense resistor.
>>>                */
>>> -             val *= 25;
>>> +             val = DIV_ROUND_CLOSEST_ULL(val * 25 * 1000, st->r_sense_uohm);
>>>               break;
>>>       default:
>>>               return -EINVAL;
>>> @@ -169,9 +167,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>>>       case LTC2945_MAX_POWER_THRES_H:
>>>       case LTC2945_MIN_POWER_THRES_H:
>>>               /*
>>> -              * Convert to register value by assuming current is measured
>>> -              * with an 1mOhm sense resistor, similar to current
>>> -              * measurements.
>>> +              * Convert to register value, scale it with the configured sense
>>> +              * resistor value, similar to current measurements.
>>>                * Control register bit 0 selects if voltage at SENSE+/VDD
>>>                * or voltage at ADIN is used to measure power, which in turn
>>>                * determines register calculations.
>>> @@ -181,14 +178,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>>>                       return ret;
>>>               if (control & CONTROL_MULT_SELECT) {
>>>                       /* 25 mV * 25 uV = 0.625 uV resolution. */
>>> -                     val = DIV_ROUND_CLOSEST_ULL(val, 625);
>>> +                     val = DIV_ROUND_CLOSEST_ULL(val * 1000, 625 * st->r_sense_uohm);
>>>               } else {
>>> -                     /*
>>> -                      * 0.5 mV * 25 uV = 0.0125 uV resolution.
>>> -                      * Divide first to avoid overflow;
>>> -                      * accept loss of accuracy.
>>> -                      */
>>> -                     val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
>>> +                     /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
>>> +                     val = DIV_ROUND_CLOSEST_ULL(val * 2 * 1000, 25 * st->r_sense_uohm);
>>>               }
>>>               break;
>>>       case LTC2945_VIN_H:
>>> @@ -213,13 +206,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>>>       case LTC2945_MAX_SENSE_THRES_H:
>>>       case LTC2945_MIN_SENSE_THRES_H:
>>>               /*
>>> -              * 25 uV resolution. Convert to current as measured with
>>> -              * an 1 mOhm sense resistor, in mA. If a different sense
>>> -              * resistor is installed, calculate the actual current by
>>> -              * dividing the reported current by the sense resistor value
>>> -              * in mOhm.
>>> +              * 25 uV resolution. Convert to current and scale it
>>> +              * with the value of the sense resistor, in mA.
>>>                */
>>> -             val = DIV_ROUND_CLOSEST_ULL(val, 25);
>>> +             val = DIV_ROUND_CLOSEST_ULL(val * 1000, 25 * st->r_sense_uohm);
>>>               break;
>>>       default:
>>>               return -EINVAL;
>>> @@ -475,6 +465,10 @@ static int ltc2945_probe(struct i2c_client *client)
>>>               return PTR_ERR(regmap);
>>>       }
>>>
>>> +     if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
>>> +                                  &st->r_sense_uohm))
>>> +             st->r_sense_uohm = 1000;
>>> +
>>
>> Devicetree could set shunt-resistor-micro-ohms to 0, which would result
>> in divide by 0 errors.
> 
> Ack
> Will do a check for this.
> 
>>
>> Guenter
>>
>>>       st->regmap = regmap;
>>>
>>>       /* Clear faults */
>>> --
>>> 2.27.0
>>>

