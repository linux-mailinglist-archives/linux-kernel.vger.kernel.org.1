Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0C28DB34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgJNIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgJNITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA4FC05111F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:43:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e17so2489359wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZgy/avQrARbPHnmM1gwEInAIYc/CCT9PzE1R/a8ERg=;
        b=TDGXnwMdeujj1JtXBRMlnmyHNKLx9zjJlB73+939f5R2RoDhvGCxtxWOyIFNJR+21g
         UzYeoIO+OTnkD+pGTnp31fuIGY5CCDVfAzc29GgcFY1h5RM/GCF1hVC+tnYHaY1g1zyQ
         lB44jzW1gl18NKKNE11qkGdLsJwq37I6GqhFR+xBZyFNqJGgu7X+YHW+Aya9z9Bsyrjx
         0QNcBLiSvdn58A1ktt4uCmc6vl4zAe0+4hvPJiOJPzYW6Js+T51KHv0s/33mFTJxh2pc
         u9LnqL7vzzsrlxudml3IqHXo8vMK8+2xY8b78Xw2UwGm3DVwprFm+r2krvszoUVsT0EX
         vU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BZgy/avQrARbPHnmM1gwEInAIYc/CCT9PzE1R/a8ERg=;
        b=eZOwk0OL3kBCBI5G9D8jxDD5639KgVnSVBU2Bke6N5MOUzIRxQWug+LDC97uT3V36n
         qlzDagkS3Zvq36dzZX6tonSR8B7uOJ/t6ewrT+8Hlwb5w9N59Je9dp8Q5pgm0q1SdoLP
         PwXcgy7VC7S9MlwV3kPjv9+Y11VtvBEqooPE3lf9jSn/AqGCypSgl7liwYHMA0nqoND0
         JRtg1wnQg81Z5gfgyPp0JHD5okoByDCEaqrCopZNnT3JhPBlKtHtVrCWeOw4NkH0rVqa
         GXJeJhH7LvzWOoeyHJMctC0I8F7/UxCdl/qEWDKi7cKqTzzaQkhJNFrMlRTJArbqiEyx
         eRow==
X-Gm-Message-State: AOAM530IWDjPBy2GQYwGz4+zoixAMV7+yf94CfRAW+kt05/lgF3IZQpp
        HvRi1yaVLtMTZ6CJLK2sXSHahg==
X-Google-Smtp-Source: ABdhPJxnhEiMGiz4qwPtOPQjANqQ+7cIivNFchbn7Cus0y2Lpq/Oy2kNCUaNMBz0+FUPJPxDdDgFag==
X-Received: by 2002:a05:6000:c5:: with SMTP id q5mr4147031wrx.175.1602661384109;
        Wed, 14 Oct 2020 00:43:04 -0700 (PDT)
Received: from [10.1.3.24] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m14sm3390913wro.43.2020.10.14.00.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 00:43:03 -0700 (PDT)
Subject: Re: [PATCH] reset: meson: make it possible to build as a module
To:     Robin Murphy <robin.murphy@arm.com>, p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201013133943.412119-1-narmstrong@baylibre.com>
 <f8c0feba-c235-e22f-2ea5-61e54fe97c0f@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ce6c0961-7582-8b03-127f-88e4e1e84b78@baylibre.com>
Date:   Wed, 14 Oct 2020 09:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f8c0feba-c235-e22f-2ea5-61e54fe97c0f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2020 16:57, Robin Murphy wrote:
> On 2020-10-13 14:39, Neil Armstrong wrote:
>> In order to reduce the kernel Image size on multi-platform distributions,
>> make it possible to build the reset controller driver as a module.
>>
>> This partially reverts 8290924e ("reset: meson: make it explicitly non-modular")
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/reset/Kconfig       | 4 ++--
>>   drivers/reset/reset-meson.c | 7 ++++++-
>>   2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index d9efbfd29646..ab315617565f 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -94,8 +94,8 @@ config RESET_LPC18XX
>>         This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
>>     config RESET_MESON
>> -    bool "Meson Reset Driver" if COMPILE_TEST
>> -    default ARCH_MESON
>> +    tristate "Meson Reset Driver"
>> +    default ARCH_MESON || COMPILE_TEST
> 
> How about an actual dependency like:
> 
>     depends on ARCH_MESON || COMPILE_TEST
>     default ARCH_MESON
> ?
> 
> That way the option won't be presented to users where it's completely irrelevant, e.g. running "make oldconfig" with an x86 distro config. It always bugs me when I rebase a branch and have to manually confirm that indeed I don't want to build random drivers specific to x86/RISC-V/etc. SoCs for my arm64 config... ;)

You're right, thanks for pointing me this.

Neil

> 
> Robin.
> 
>>       help
>>         This enables the reset driver for Amlogic Meson SoCs.
>>   diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
>> index 94d7ba88d7d2..434d5c0f877e 100644
>> --- a/drivers/reset/reset-meson.c
>> +++ b/drivers/reset/reset-meson.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>>   #include <linux/of.h>
>> +#include <linux/module.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/slab.h>
>> @@ -142,4 +143,8 @@ static struct platform_driver meson_reset_driver = {
>>           .of_match_table    = meson_reset_dt_ids,
>>       },
>>   };
>> -builtin_platform_driver(meson_reset_driver);
>> +module_platform_driver(meson_reset_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_LICENSE("Dual BSD/GPL");
>>

