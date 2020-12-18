Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4181C2DE522
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgLROu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgLROu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:50:57 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C563DC0617A7;
        Fri, 18 Dec 2020 06:50:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 15so3026568oix.8;
        Fri, 18 Dec 2020 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PDhh2QYxhqf/NjkdLJAa1X6Anzc6tIJP/VpTb7TEtrc=;
        b=B5oFWXOqrmW3a8kinnktYYuRy0yuWBVMFXX6hzCF/A0q5JYK0gKniKmqI/PCFHG/DF
         SjrWM658GI5kUJOVWgnGHW8N2bikE0553xXIn/rJoxxGy7Wk1FZlJNUfKBz5ulxK5ncL
         4i2xjv20K3lVc28SxYqA413qzBLsUs70HGiB0SXIzTy5ZW7eNKUYvm2B+4+bhmVl6gj6
         z4A3p7v63ZbwwHMBYUJLFF6z+0Wvai5xTpytuLOi7j5DxHOPFOzPsXmOYEa72rhGI/X8
         UYVrXl1hsZuTTQcAV3fQOao7dCIDj6JCrALVyYqfT9H0efLyp+oW7lXg8OUg46nyZwGr
         2K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PDhh2QYxhqf/NjkdLJAa1X6Anzc6tIJP/VpTb7TEtrc=;
        b=pG1pY/mQCYVOr7mA78HF6Imhfe3YQIE6d4/KYWjSYeW4W9+BZfKNvaAEifzMAtdqOM
         WWJ/bO4bwRca6nQXWmM1EAe57o7rTm6wrINXMUbsvdTNmgcn3xBNZQ19h5/2n8hpsGO7
         rjUY7LA7Dm4k+jsV70X99WSw0IwhhF6eo+mAtnRuShEtOFqoYJNd+qLt4w8brFYRryfA
         6mKMPkdcReV3d5ryP+ZIm4I0FnX02EoxQUAq4GmvVcU46Blq6eOb9QAmqivTuKYdgoaq
         k2Gw/WghKmkqbW5Mwe4mu+xPNXqsdvj1Cxa/Hu8LE3K6ypSDj1nzvm+GnCUU28mf6sC2
         ZH1Q==
X-Gm-Message-State: AOAM531nDNiSMocu+1xsiW9ktUjG20PWZ39C0owZvuJ5CQ4lXGxajODi
        sjUINXJwTkTuCrlDFzwoxLxBsbA83NM=
X-Google-Smtp-Source: ABdhPJwSCfNLbSznicVtf6AY+lJSTORoGEfuFwwrZksbjsBw1aKEXT7BjTctlRm2qpWTCzO9AWXXog==
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2835832oib.69.1608303016265;
        Fri, 18 Dec 2020 06:50:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12sm1037271oig.35.2020.12.18.06.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 06:50:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/3] hwmon: add Texas Instruments TPS23861 driver
To:     Robert Marko <robert.marko@sartura.hr>, jdelvare@suse.com,
        robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>
References: <20201218130329.258254-1-robert.marko@sartura.hr>
 <20201218130329.258254-2-robert.marko@sartura.hr>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9dd93c41-aa11-ebfb-7f72-0ee188268976@roeck-us.net>
Date:   Fri, 18 Dec 2020 06:50:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218130329.258254-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/20 5:03 AM, Robert Marko wrote:
> Add basic monitoring support as well as port on/off control for Texas
> Instruments TPS23861 PoE PSE IC.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
>  drivers/hwmon/Kconfig    |  11 ++
>  drivers/hwmon/Makefile   |   1 +
>  drivers/hwmon/tps23861.c | 398 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 410 insertions(+)
>  create mode 100644 drivers/hwmon/tps23861.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a850e4f0e0bd..3368ecfa7a9c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1102,6 +1102,17 @@ config SENSORS_TC654
>  	  This driver can also be built as a module. If so, the module
>  	  will be called tc654.
>  
> +config SENSORS_TPS23861
> +	tristate "Texas Instruments TPS23861 PoE PSE"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments
> +	  TPS23861 802.3at PoE PSE chips.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tps23861.
> +
>  config SENSORS_MENF21BMC_HWMON
>  	tristate "MEN 14F021P00 BMC Hardware Monitoring"
>  	depends on MFD_MENF21BMC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 9db2903b61e5..7493e9d5dc43 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>  obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
>  obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
> +obj-$(CONFIG_SENSORS_TPS23861)	+= tps23861.o
>  obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
>  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
>  obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> new file mode 100644
> index 000000000000..e8b614267084
> --- /dev/null
> +++ b/drivers/hwmon/tps23861.c
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for the TI TPS23861 PoE PSE.
> + *
> + * Author: Robert Marko <robert.marko@sartura.hr>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>

Alphabetic include file order, please.

[ ... ]

> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> +							   data, tps23861_groups);

Please rework to use devm_hwmon_device_register_with_info().

Thanks,
Guenter
