Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080FF2CBA28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbgLBKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbgLBKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:06:15 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C856C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 02:05:29 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so5524483wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SDFtnRN6FEskyo3h0LoTIhkArTtZvpeIQSQ7/DJT7Ys=;
        b=ZhQSAsig3KMFt0qx5PU6eRPXM0k444fAf3MSKMZKOTvSCWhSrbWgQhANdPevMtz8eg
         TycmK8dGTl9+ti8aB+K/RR77gxQK2J9Wc4vvzM1uzA/vUTQsN1BfwqKLyp6OPDTCFq7N
         3RPc+qxFpywToK9TFttmW3VGSb0nsYx2O1jO0x+/60CHzjCgS2SzyHfQLgCAN7XTPeBq
         O1NEj6VhYHNCW4Uk8wAzjYgVegStjvMA28A8x9m1qcJ4IWHDUvVomAUm2RsYiLdZNbm1
         iGDMSQwmWBAptAUlgUfgr5pxKaFCKh7TM5xMho9jUwRA5/92foWQcJ9fbvCxywBtJbqK
         Cy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDFtnRN6FEskyo3h0LoTIhkArTtZvpeIQSQ7/DJT7Ys=;
        b=nMOPdQUamLCK5H1zlsN9Sja5/zSe/hiqC3bD34U7/b/6oC9c98mlGEwAX5Wph+Jg3L
         k6hdXYj7pPgYu+0vmUEIVZmkjMa/CtnP83S1xBrG2XCKSnnE2QoCy+PPHeMBwShm9Ds0
         N3EF12dqP4eWqmZG8ses03CiRVxkNYiZM72Hp4EpYQPcT7sjoKSnihcufvkLcERmOtJ+
         O+Ihd6+Tz4oxbnUuPCKhwQbaOO1d1pfZHTrsHkzR4vsiZovnq+RTTh1ppvG7Xq2Jw0l9
         hK6q9sV9UBUdI41NEO0c+fMMOcTPPO8txE9I9w5Hpg5PKArBmNUO0lVKmy/21+rTb9Y7
         Bx4g==
X-Gm-Message-State: AOAM531LPkxc2aU0RQY3lfJ4RCfRTBXqKmP3xTggbyk55Xny29uI6z1q
        lwIv0E9+SU2jy3FrqsIKq8hqOi4968ZexJkE
X-Google-Smtp-Source: ABdhPJzXEMn0R6VoOGkEgzMTjmkpTQQ0jn2MPMELBpWMHZUMHtvnqC4XyUUUPMstS35w31V7GH3RFQ==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr2237378wme.99.1606903527385;
        Wed, 02 Dec 2020 02:05:27 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id b83sm1347175wmd.48.2020.12.02.02.05.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 02:05:26 -0800 (PST)
Subject: Re: [PATCH v5 2/2] pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver
To:     Alex Elder <elder@ieee.org>, linus.walleij@linaro.org,
        bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201201142830.13152-1-srinivas.kandagatla@linaro.org>
 <20201201142830.13152-3-srinivas.kandagatla@linaro.org>
 <bf18cc63-77b2-7929-625a-1ea3d108916e@ieee.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a3653c84-8d2d-40d5-00b1-8d13bf44f141@linaro.org>
Date:   Wed, 2 Dec 2020 10:05:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bf18cc63-77b2-7929-625a-1ea3d108916e@ieee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alex for the comments,

On 01/12/2020 20:21, Alex Elder wrote:
> On 12/1/20 8:28 AM, Srinivas Kandagatla wrote:
>> Add initial pinctrl driver to support pin configuration for
>> LPASS (Low Power Audio SubSystem) LPI (Low Power Island) pinctrl
>> on SM8250.
>>
>> This IP is an additional pin control block for Audio Pins on top the
>> existing SoC Top level pin-controller.
>> Hardware setup looks like:
>>
>> TLMM GPIO[146 - 159] --> LPASS LPI GPIO [0 - 13]
>>
>> This pin controller has some similarities compared to Top level
>> msm SoC Pin controller like 'each pin belongs to a single group'
>> and so on. However this one is intended to control only audio
>> pins in particular, which can not be configured/touched by the
>> Top level SoC pin controller except setting them as gpios.
>> Apart from this, slew rate is also available in this block for
>> certain pins which are connected to SLIMbus or SoundWire Bus.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Bjorn called my attention to a comment he made on this patch.
> I'm not giving it a full review right now, but I have a
> general suggestion below.
> 
>> ---
>>   drivers/pinctrl/qcom/Kconfig             |   8 +
>>   drivers/pinctrl/qcom/Makefile            |   1 +
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 727 +++++++++++++++++++++++
>>   3 files changed, 736 insertions(+)
>>   create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index 5fe7b8aaf69d..d3e4e89c2810 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -236,4 +236,12 @@ config PINCTRL_SM8250
>>         Qualcomm Technologies Inc TLMM block found on the Qualcomm
>>         Technologies Inc SM8250 platform.
>> +config PINCTRL_LPASS_LPI
>> +    tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
>> +    depends on GPIOLIB
>> +    help
>> +      This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> +      Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>> +      (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
>> +
>>   endif
>> diff --git a/drivers/pinctrl/qcom/Makefile 
>> b/drivers/pinctrl/qcom/Makefile
>> index 9e3d9c91a444..c8520155fb1b 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -28,3 +28,4 @@ obj-$(CONFIG_PINCTRL_SDM660)   += pinctrl-sdm660.o
>>   obj-$(CONFIG_PINCTRL_SDM845) += pinctrl-sdm845.o
>>   obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
>>   obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>> +obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c 
>> b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> new file mode 100644
>> index 000000000000..96c63a33fc99
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> @@ -0,0 +1,727 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2020 Linaro Ltd.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of.h>
>> +#include <linux/pinctrl/pinconf-generic.h>
>> +#include <linux/pinctrl/pinconf.h>
>> +#include <linux/pinctrl/pinmux.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +#include "../core.h"
>> +#include "../pinctrl-utils.h"
>> +
>> +#define LPI_GPIO_CFG_REG        0x00
>> +#define LPI_GPIO_VALUE_REG        0x04
>> +#define LPI_SLEW_RATE_CTL_REG        0xa000
>> +#define LPI_SLEW_RATE_MAX        0x03
>> +#define LPI_SLEW_BITS_SIZE        0x02
>> +#define LPI_GPIO_PULL_SHIFT        0x0
>> +#define LPI_GPIO_PULL_MASK        GENMASK(1, 0)
> 
> . . .
> 
> If you have a mask like this, you do not need the shift.
> The mask alone encodes both the position and the width
> of the field you are describing.  It is better to use
> just the one (mask) value and avoid even the possibility
> of the mask and shift being inconsistent.  You halve the
> number of symbols you need to describe fields too.

I did realize that while I was doing replace bits ,but did not go 
further in possibility of removing the redundant macros!


> 
> For the macros and functions in <linux/bitfield.h> the
> mask values must be constant at compile time, but you
> have that here.
> 
> For the LPI_GPIO_PULL, you use it below this way:
>      pull = (ctl_reg & LPI_GPIO_PULL_MASK) >> LPI_GPIO_PULL_SHIFT;
> Instead, use:
>      pull = u32_get_bits(ctl_reg, LPI_GPIO_PULL_MASK);
> 
> I see you're using u32_replace_bits(), and what I see
> looks good.  But you can use u32_encode_bits() as well.
> For example, instead of:
>      lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG,
>                     value << LPI_GPIO_DIR_SHIFT);
> Use:
>      val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_DIR_MASK);
>      lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
> (This one-bit mask might not be a great example.)
> 
> In addition to getting rid of extra symbols, using these
> functions typically results in simpler-looking code.

Many thanks for the examples,  Will convert to either using FIELD_* 
macros or u32_encode/get apis and remove redundant SHIFT macros!

--srini

> 
>                      -Alex
