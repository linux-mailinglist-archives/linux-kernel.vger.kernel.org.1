Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726C427450D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIVPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgIVPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:14:07 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:14:07 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 185so21385375oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9uF4k6uCwnK75XFrtxZwJl5noaUO/re0k9gK8z1Gzo=;
        b=omfHjSskS7S/E9nvRpu+/pueiBm/3d9N9k1yKKI9NZFaPQuPNRcOWa2t3Pza5pbGSr
         lrqRqs0AsgMNz4MixIMQwyNbrWJ2/PrSxOE1ojfSjRPm2KdFhW5gBBpUKG1arGPS3wKN
         jbhsthmGeBgJ0xLK7pP46o1q5jP4BExtXIFIn2Ek4fbAy9mLvUJ6aQOMr8K9P/jYPVZA
         ekUXdY4sHtryd//I4K04dLk5zxcJJ3cWjsLCyMUXndWd2oITOGBJFK+FmBpiG8Ikzjrl
         X24Kt6WAeMCKR1od0fK0sz3Nbaawxc6icYgEVnW2v2CXd8GUTHnz0iJv+xbhmTfxM+u0
         5o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y9uF4k6uCwnK75XFrtxZwJl5noaUO/re0k9gK8z1Gzo=;
        b=t33MiOaizqOEOxJ8TS8W3gpPzS92kXR5b98zOkBVJcHVtYDH6SxCzuLS31stfXutES
         PPBv/x3zec0z1wESf2BZcabGBk+r9Oxar414w/Qi5i9dhJstzZ0PKBht9ZKoJlidLTCd
         Kn9+m4/o7HzLYM0sOT7L+K9cqhGYmJgG3UAFJ4rS9Jzus9lGATmhimLwplw0qrSkX3j7
         I12vw3E8S30Yd46A69QMkzpfCTjODy14FOfEwKvXV7tC2lapRjmp5RjtkwdsAds4VvN6
         28/X0pPJh32xh0bWBofLxg/EuGOKAX1N46cwbAu4ubQnMF9pYcasXVc3dKBC1KKpoVDT
         K2/Q==
X-Gm-Message-State: AOAM533vh/QqleoOl+F/IfMBwkNqLZjXQp0LynvlCED9DtbbznW28gWn
        5IfEWSdgsOlMObrRT6WgNRtFUtOc67A=
X-Google-Smtp-Source: ABdhPJzFhL8l42951kc4JPP4GOleioEgCKzBKk8YO1XM5Ikcs7j6tKxH5IRTqfK2t6IpenKotvdYvQ==
X-Received: by 2002:aca:dd41:: with SMTP id u62mr2705362oig.118.1600787646072;
        Tue, 22 Sep 2020 08:14:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 187sm7596120oie.42.2020.09.22.08.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:14:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: amd-wdt: Add AMD FCH hw watchdog driver support
To:     Sanjay R Mehta <sanju.mehta@amd.com>, wim@linux-watchdog.org
Cc:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        linux-kernel@vger.kernel.org
References: <1600774822-19890-1-git-send-email-sanju.mehta@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <cf49a48b-6b0a-8fbd-3df0-be92e5cef326@roeck-us.net>
Date:   Tue, 22 Sep 2020 08:14:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600774822-19890-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 4:40 AM, Sanjay R Mehta wrote:
> This driver supports hardware watchdog for AMD SoCs.
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>

Please explain why this isn't / can't be handled by the existing sp5100_tco
driver. That watchdog works quite well with my 3900X, and I don't see an
immediate and/or substantial difference except for the ACPI instead of PCI
match and the timeleft function. Both could easily be added to sp5100_tco
if desired/needed.


Additional comments inline.

Thanks,
Guenter

> ---
>  MAINTAINERS                |   5 +
>  drivers/watchdog/Kconfig   |  14 ++
>  drivers/watchdog/Makefile  |   1 +
>  drivers/watchdog/amd_wdt.c | 361 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 381 insertions(+)
>  create mode 100644 drivers/watchdog/amd_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d0862b19ce5..22058d19cbbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -909,6 +909,11 @@ F:	drivers/gpu/drm/amd/include/v9_structs.h
>  F:	drivers/gpu/drm/amd/include/vi_structs.h
>  F:	include/uapi/linux/kfd_ioctl.h
>  
> +AMD FCH WDT DRIVER
> +M:	Sanjay R Mehta <sanju.mehta@amd.com>
> +S:	Maintained
> +F:	drivers/watchdog/amd_wdt.c
> +
>  AMD SPI DRIVER
>  M:	Sanjay R Mehta <sanju.mehta@amd.com>
>  S:	Maintained
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ab7aad5a1e69..8c4827cbed67 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1226,6 +1226,20 @@ config INTEL_MID_WATCHDOG
>  
>  	  To compile this driver as a module, choose M here.
>  
> +config AMD_FCH_WATCHDOG
> +	tristate "AMD FCH Watchdog timer"
> +	depends on X86 && PCI
> +	select WATCHDOG_CORE
> +	help
> +	  Hardware watchdog driver for the AMD SoC. It is a watchdog
> +	  timer that will reboot/shutdown the machine after its expiration.
> +	  The expiration time can be configured with the "heartbeat" parameter
> +	  and the action on expiration can be configured to reboot/shutdown
> +	  using "action" parameter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called amd_wdt.
> +
>  config ITCO_WDT
>  	tristate "Intel TCO Timer/Watchdog"
>  	depends on (X86 || IA64) && PCI
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 97bed1d3d97c..3bddcdad0815 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -225,3 +225,4 @@ obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
>  obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
> +obj-$(CONFIG_AMD_FCH_WATCHDOG) += amd_wdt.o
> diff --git a/drivers/watchdog/amd_wdt.c b/drivers/watchdog/amd_wdt.c
> new file mode 100644
> index 000000000000..a37cd8a71d7b
> --- /dev/null
> +++ b/drivers/watchdog/amd_wdt.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +//
> +// AMD Watchdog controller driver
> +//
> +// Copyright (c) 2020, Advanced Micro Devices, Inc.
> +//
> +// Author: Sanjay R Mehta <sanju.mehta@amd.com>
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/acpi.h>
> +
Alphabetic order.

> +#define AMD_WDT_CONTROL(base)		((base) + 0x00) /* Watchdog Control */
> +#define AMD_WDT_START_STOP_BIT		BIT(0)
> +#define AMD_WDT_FIRED_BIT		BIT(1)
> +#define AMD_WDT_ACTION_RESET_BIT	BIT(2)
> +/* 6:4 bits Reserved */
> +#define AMD_WDT_TRIGGER_BIT		BIT(7)
> +#define AMD_WDT_COUNT(base)		((base) + 0x04) /* Watchdog Count */
> +#define AMD_WDT_COUNT_MASK		0xFFFF
> +
> +#define AMD_PM_WATCHDOG_EN_REG		0x00
> +#define AMD_PM_WATCHDOG_TIMER_EN	(0x01 << 7)
> +
> +#define AMD_PM_WATCHDOG_CONFIG_REG	0x03
> +#define AMD_PM_WATCHDOG_32USEC_RES	0x0
> +#define AMD_PM_WATCHDOG_10MSEC_RES	0x1
> +#define AMD_PM_WATCHDOG_100MSEC_RES	0x2
> +#define AMD_PM_WATCHDOG_1SEC_RES	0x3
> +#define AMD_PM_WATCHDOG_CONFIG_MASK	0x3
> +
> +/* IO port address for indirect access using ACPI PM registers */
> +#define AMD_IO_PM_INDEX_REG		0xCD6
> +#define AMD_IO_PM_DATA_REG		0xCD7
> +
> +/* Module and version information */
> +#define WDT_MODULE_NAME "AMD watchdog timer"
> +#define WDT_DRIVER_NAME	WDT_MODULE_NAME ", v" WDT_VERSION
> +
> +#define AMD_WDT_DEFAULT_TIMEOUT		60 /* 60 units default heartbeat. */
> +#define AMD_WDT_MIN_TIMEOUT		0x0001	/* minimum timeout value */
> +#define AMD_WDT_MAX_TIMEOUT		0xFFFF	/* maximum timeout value */
> +#define MAX_LENGTH	(8 + 1) /* shutdown has 8 character + NULL character */
> +
> +/* internal variables */
> +static void __iomem *wdtbase;
> +static DEFINE_SPINLOCK(wdt_lock);
> +
> +/* module parameters */
> +static int heartbeat = AMD_WDT_DEFAULT_TIMEOUT;
> +module_param(heartbeat, int, 0);
> +MODULE_PARM_DESC(heartbeat, "WDT timeout in frequency units. (default="
> +				 __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
> +
> +static char frequency[MAX_LENGTH] = "1s";
> +module_param_string(frequency, frequency, MAX_LENGTH, 0);
> +MODULE_PARM_DESC(frequency,
> +		 "WDT frequency units(32us, 10ms, 100ms, 1s). (default=1s)");
> +

This is both pointless and wrong. The watchdog core assumes second
based timeouts, as does userspace. You can not just declare that you want
to use some other unit.

> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "WDT cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static char action[MAX_LENGTH] = "reboot";
> +module_param_string(action, action, MAX_LENGTH, 0);
> +MODULE_PARM_DESC(action, "WDT action (reboot/shutdown).(default=reboot)");
> +

This is quite unusual and would require some discussion of its use case.

> +/*
> + * Watchdog specific functions
> + */
> +static int amd_wdt_set_timeout(struct watchdog_device *wdt_dev, unsigned int t)
> +{
> +	unsigned long flags;
> +
> +	/*
> +	 * In ideal cases the limits will be checked by Watchdog core itself,
> +	 * but there might be cases when we call this function directly from
> +	 * somewhere else. So check the limits here.
> +	 */
> +	if (t < AMD_WDT_MIN_TIMEOUT)
> +		heartbeat = AMD_WDT_MIN_TIMEOUT;
> +	else if (t > AMD_WDT_MAX_TIMEOUT)
> +		heartbeat = AMD_WDT_MAX_TIMEOUT;
> +
Checked by watchdog core.

> +	t = heartbeat;
> +	/* Write new timeout value to watchdog */
> +	spin_lock_irqsave(&wdt_lock, flags);
> +	writel(t, AMD_WDT_COUNT(wdtbase));
> +	spin_unlock_irqrestore(&wdt_lock, flags);
> +

The locking would require some discussion. The watchdog core already ensures
that functions are sequentialized (and the watchdog device can only
be opened once anyway). What is this supposed to protect against ?

> +	wdt_dev->timeout = t;
> +
> +	return 0;
> +}
> +
> +static int amd_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	/* Trigger watchdog */
> +	spin_lock_irqsave(&wdt_lock, flags);
> +
> +	val = readl(AMD_WDT_CONTROL(wdtbase));
> +	val |= AMD_WDT_TRIGGER_BIT;
> +	writel(val, AMD_WDT_CONTROL(wdtbase));
> +
> +	spin_unlock_irqrestore(&wdt_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int amd_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	/* Enable the watchdog timer */
> +	spin_lock_irqsave(&wdt_lock, flags);
> +
> +	val = readl(AMD_WDT_CONTROL(wdtbase));
> +	val |= AMD_WDT_START_STOP_BIT;
> +	writel(val, AMD_WDT_CONTROL(wdtbase));
> +
> +	spin_unlock_irqrestore(&wdt_lock, flags);
> +
> +	/* Trigger the watchdog timer */
> +	amd_wdt_ping(wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int amd_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	/* Disable the watchdog timer */
> +	spin_lock_irqsave(&wdt_lock, flags);
> +
> +	val = readl(AMD_WDT_CONTROL(wdtbase));
> +	val &= ~AMD_WDT_START_STOP_BIT;
> +	writel(val, AMD_WDT_CONTROL(wdtbase));
> +
> +	spin_unlock_irqrestore(&wdt_lock, flags);
> +
> +	return 0;
> +}
> +
> +static unsigned int amd_wdt_get_timeleft(struct watchdog_device *wdt_dev)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdt_lock, flags);
> +	val = readl(AMD_WDT_COUNT(wdtbase));
> +	spin_unlock_irqrestore(&wdt_lock, flags);
> +
> +	/* Mask out the upper 16-bits and return */
> +	return val & AMD_WDT_COUNT_MASK;
> +}
> +
> +static unsigned int amd_wdt_status(struct watchdog_device *wdt_dev)
> +{
> +	return wdt_dev->status;
> +}
> +
> +static struct watchdog_ops amd_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= amd_wdt_start,
> +	.stop		= amd_wdt_stop,
> +	.ping		= amd_wdt_ping,
> +	.status		= amd_wdt_status,
> +	.set_timeout	= amd_wdt_set_timeout,
> +	.get_timeleft	= amd_wdt_get_timeleft,
> +};
> +
> +static struct watchdog_info amd_wdt_info = {
> +	.options		= WDIOF_SETTIMEOUT |
> +				  WDIOF_MAGICCLOSE |
> +				  WDIOF_KEEPALIVEPING,
> +	.firmware_version	= 0,
> +	.identity		= WDT_MODULE_NAME,
> +};
> +
> +static struct watchdog_device amd_wdt_dev = {
> +	.info		= &amd_wdt_info,
> +	.ops		= &amd_wdt_ops,
> +};
> +
> +static unsigned char amd_wdt_setupdevice(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int err = 0;
> +	u32 val;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdtbase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(wdtbase)) {
> +		err = PTR_ERR(wdtbase);
> +		dev_err(&pdev->dev, "error %d ioremap of WDT registers failed\n", err);
> +		return 0;
> +	}
> +	dev_dbg(&pdev->dev, "io_remap_address: %p\n", wdtbase);
> +
> +	/* Enable watchdog timer and decode bit */
> +	outb(AMD_PM_WATCHDOG_EN_REG, AMD_IO_PM_INDEX_REG);
> +	val = inb(AMD_IO_PM_DATA_REG);
> +	val |= AMD_PM_WATCHDOG_TIMER_EN;
> +	outb(val, AMD_IO_PM_DATA_REG);
> +
> +	/* Set the watchdog timer resolution */
> +	outb(AMD_PM_WATCHDOG_CONFIG_REG, AMD_IO_PM_INDEX_REG);
> +	val = inb(AMD_IO_PM_DATA_REG);
> +	/* Clear the previous frequency setting, if any */
> +	val &= ~AMD_PM_WATCHDOG_CONFIG_MASK;
> +
> +	/*
> +	 * Now set the frequency depending on the module load parameter.
> +	 * In case the user passes an invalid argument, we consider the
> +	 * frequency to be of 1 second resolution.
> +	 */
> +	if (strncmp(frequency, "32us", 4) == 0) {
> +		val |= AMD_PM_WATCHDOG_32USEC_RES;
> +	} else if (strncmp(frequency, "10ms", 4) == 0) {
> +		val |= AMD_PM_WATCHDOG_10MSEC_RES;
> +	} else if (strncmp(frequency, "100ms", 5) == 0) {
> +		val |= AMD_PM_WATCHDOG_100MSEC_RES;
> +	} else {
> +		val |= AMD_PM_WATCHDOG_1SEC_RES;
> +		if (strncmp(frequency, "1s", 2) != 0)
> +			strncpy(frequency, "1s", 2);
> +	}
> +
> +	outb(val, AMD_IO_PM_DATA_REG);
> +
> +	/* Set the watchdog action depending on module load parameter. */
> +	val = readl(AMD_WDT_CONTROL(wdtbase));
> +
> +	/*
> +	 * If action is specified anything other than reboot or shutdown,
> +	 * we default it to reboot.
> +	 */
> +	if (strncmp(action, "shutdown", 8) == 0) {
> +		val |= AMD_WDT_ACTION_RESET_BIT;
> +	} else {
> +		val &= ~AMD_WDT_ACTION_RESET_BIT;
> +		/*
> +		 * The statement below is required for when the action
> +		 * is set anything other than reboot.
> +		 */
> +		if (strncmp(action, "reboot", 6) != 0)
> +			strncpy(action, "reboot", 6);
> +	}
> +
> +	/*
> +	 * Since the watchdog fired bit gets cleared if written to, we
> +	 * need to mask it before writing into the Watchdog Control
> +	 * register, to avoid inadvertent side-effect.
> +	 */
> +	val &= ~AMD_WDT_FIRED_BIT;
> +	writel(val, AMD_WDT_CONTROL(wdtbase));
> +
> +	return 1;
> +}
> +
> +static int amd_wdt_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	u32 val;
> +
> +	/* Identify our device and initialize watchdog hardware */
> +	if (!amd_wdt_setupdevice(pdev))
> +		return -ENODEV;
> +
> +	/* Check to see if last reboot was due to watchdog timeout */
> +	val = readl(AMD_WDT_CONTROL(wdtbase));
> +	if (val & AMD_WDT_FIRED_BIT)
> +		amd_wdt_dev.bootstatus |= WDIOF_CARDRESET;
> +	else
> +		amd_wdt_dev.bootstatus &= ~WDIOF_CARDRESET;
> +
> +	pr_info("Watchdog reboot/shutdown %sdetected\n",
> +		(val & AMD_WDT_FIRED_BIT) ? "" : "not ");
> +
> +	/* Clear out the old status */
> +	val |= AMD_WDT_FIRED_BIT;
> +	writel(val, AMD_WDT_CONTROL(wdtbase));
> +
> +	amd_wdt_dev.timeout = heartbeat;
> +	amd_wdt_dev.min_timeout = AMD_WDT_MIN_TIMEOUT;
> +	amd_wdt_dev.max_timeout = AMD_WDT_MAX_TIMEOUT;
> +	watchdog_set_nowayout(&amd_wdt_dev, nowayout);
> +
> +	/* Make sure watchdog is not running */
> +	amd_wdt_stop(&amd_wdt_dev);
> +
> +	/* Set Watchdog timeout */
> +	amd_wdt_set_timeout(&amd_wdt_dev, heartbeat);
> +
> +	ret = watchdog_register_device(&amd_wdt_dev);
> +	if (ret != 0) {
> +		pr_err("watchdog: cannot register wdt device (err=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	pr_info("timeout=%d units, frequency=%s, nowayout=%d, action=%s\n",
> +		heartbeat, frequency, nowayout, action);
> +
> +	return 0;
> +}
> +
> +static int amd_wdt_remove(struct platform_device *dev)
> +{
> +	if (!wdtbase)
> +		return 0;
> +
> +	/* Stop the timer before we leave */
> +	if (!nowayout)
> +		amd_wdt_stop(NULL);
> +

watchdog_stop_on_unregister()

> +	watchdog_unregister_device(&amd_wdt_dev);
> +
> +	return 0;
> +}
> +
> +static void amd_wdt_shutdown(struct platform_device *dev)
> +{
> +	amd_wdt_stop(NULL);

watchdog_stop_on_reboot()

> +}
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id wdt_acpi_match[] = {
> +	{ "AMDI0090", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, wdt_acpi_match);
> +#endif
> +
> +static struct platform_driver amd_wdt_driver = {
> +	.driver = {
> +		.name = "amd_wdt",
> +		.acpi_match_table = ACPI_PTR(wdt_acpi_match),
> +	},
> +	.probe		= amd_wdt_probe,
> +	.remove		= amd_wdt_remove,
> +	.shutdown	= amd_wdt_shutdown,
> +};
> +module_platform_driver(amd_wdt_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Sanjay Mehta <sanju.mehta@amd.com>");
> +MODULE_DESCRIPTION("Watchdog timer driver for AMD chipsets");
> 

