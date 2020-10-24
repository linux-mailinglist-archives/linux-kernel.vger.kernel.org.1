Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C027B297DB2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762515AbgJXRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762508AbgJXRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 13:12:47 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA1C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 10:12:47 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m128so5980886oig.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FieExmC7SiJsM1irBpl90iG182t3MOWS0aoYHFgfZ4g=;
        b=oVRXX/xFX8R9ar6+UV1zGLGrU4Y4pl2RW9dykNkw26CecL45EraAuzSvVKXzomTza7
         APji6rmnpOd0QGaPn4KrCYTHagyUBKlUZ2wTFlWegLTvJvHGOSIx5Z9+0x16+EYI8Z+U
         RW4yyo9flq6SPqJ/9DDez6L8zIK9pGa6ptra4yvZUHqmtyQTLJhnCpnhW1Z/oaV2XFcr
         ouwmoftnl03GeOPycKCe4weq9ntAbeoC/qblNM4aucFtxVxucmK/6QsZsMCAObsBrFtx
         rUZuHLg5rzjPQhgbVdtr5TV1GYCT+bUoIuxDLhiJa5vEFg4B6v/XUT0d/uM1JrhIbJxt
         ZQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FieExmC7SiJsM1irBpl90iG182t3MOWS0aoYHFgfZ4g=;
        b=uWCLbzxsOb1iSp9STUi7GaBv6dWUuvxyuTdNrSpdZNxj/X6DVs6GegDfVXfzf8ns/V
         Xj2Oa1CvUxZeb4wLuFAjRXFikVAdMiRAEQJuZ5cFK69vxXe0K7PjxyQoNwsiFHafBAoP
         +LRy5pHZeQ6QcQ9DGp4vZI6ZM9JPuBe/7hzHN/MRzDTb9UnyzaHvZPGBDclsIGeJV1r2
         Jw7zmq7UbLHGNhGT8vH8Vu2W6bbCpTd7es2QhNzzDCuhjx2RqEz1LvHymKZfSn9IRmFJ
         CRdnedYLQaQKoxbvQ2JlI1Ayvp7RzuwGrnZxFGVf7dOgN+00juhYOZMWuzxCdcsv1XgK
         Vv0g==
X-Gm-Message-State: AOAM531fud4E59xnN75PBJ9YniNhzy2ipwVGqo9Mn5LG5J55Z2B02+Im
        gvm1AG6IO788m8sRoruAcWU=
X-Google-Smtp-Source: ABdhPJwXz0lFhrgya8uQhZN3SpTVFD9stJalQ7BNOzdmWyKfE9l0eJZrxCVGrMO7zQO6taRlyrJAdg==
X-Received: by 2002:aca:ad92:: with SMTP id w140mr5402809oie.7.1603559566361;
        Sat, 24 Oct 2020 10:12:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98sm1143915otm.54.2020.10.24.10.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Oct 2020 10:12:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 24 Oct 2020 10:12:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     zhanggyb@gmail.com
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        -linux-pc@lenovo.com
Subject: Re: [PATCH] watchdog: Add Nuvoton NCT668x watchdog driver
Message-ID: <20201024171244.GA114620@roeck-us.net>
References: <20201023151550.15264-1-zhanggyb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201023151550.15264-1-zhanggyb@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 11:15:50PM +0800, zhanggyb@gmail.com wrote:
> From: Freeman Zhang <zhanggyb@gmail.com>
> 
> Add the watchdog driver for Nuvoton NCT668x series. So far this driver only
> supports NCT6688DL and customized chip used in Lenovo ThinkCentre M90n Nano.
> 
> Signed-off-by: Freeman Zhang <zhanggyb@gmail.com>
> ---
>  drivers/watchdog/Kconfig       |  11 +
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/nct668x_wdt.c | 504 +++++++++++++++++++++++++++++++++
>  3 files changed, 516 insertions(+)
>  create mode 100644 drivers/watchdog/nct668x_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 21865e27499a..be66e2f6e1a6 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1640,6 +1640,17 @@ config NIC7018_WDT
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called nic7018_wdt.
>  
> +config NUVOTON_NCT668X_WDT
> +	tristate "Nuvoton NCT668x watchdog"
> +	depends on X86
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog the Nuvoton’s NCT6686DL eSIO device. When the
> +	  watchdog triggers the system will be reset.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called nct668x-wdt.
> +

Please name the driver after the chip it supports. No wildcards. It supports
NCT6686DL, and that is what it should be named after. W don't want to end up
with NUVOTON_NCT668X_WDT _and_, say, NUVOTON_NCT6683_WDT.

Also, "NUVOTON" and "NCT" are redundant. NCT6688_WDT or NCT6686DL_WDT should
be sufficient for the config name.

>  # M68K Architecture
>  
>  config M54xx_WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 071a2e50be98..89b0f03aeb11 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -146,6 +146,7 @@ obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>  obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>  obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>  obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
> +obj-$(CONFIG_NUVOTON_NCT668X_WDT) += nct668x_wdt.o
>  
>  # M68K Architecture
>  obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
> diff --git a/drivers/watchdog/nct668x_wdt.c b/drivers/watchdog/nct668x_wdt.c
> new file mode 100644
> index 000000000000..e513a0b33341
> --- /dev/null
> +++ b/drivers/watchdog/nct668x_wdt.c
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * nct668x_wdt.c - Customized Nuvoton NCT668x WDT driver.
> + *
> + * (c) Copyright 2020 Sheng-Yuan Huang <syhuang3@nuvoton.com> (Nuvoton)
> + *
> + *   1. Modified it for customized nct668x WDT only. (lenovo nano)
> + *

All the following should be marked as "derived from", and most of it is
pointless. Just add a single reference indicating where the driver is derived
from. Keep the copyright lines if you like, but not the change logs.

> + * (c) Copyright 2018 Sheng-Yuan Huang (Nuvoton) 
> + *
> + *   1. Add support to NCT6796 and NCT6116.
> + *   2. Modify code for convenient testing. 
> + *   3. Fix some potential problems.
> + *   4. Change file name for telling the differece between this one and the
> + *      built-in driver.
> + *
> + * (c) Copyright 2013 Guenter Roeck
> + *
> + *   converted to watchdog infrastructure
> + *
> + * (c) Copyright 2007 Vlad Drukker <vlad@storewiz.com>
> + *
> + *   added support for W83627THF.
> + *
> + * (c) Copyright 2003,2007 Pádraig Brady <P@draigBrady.com>
> + *
> + *   Based on advantechwdt.c which is based on wdt.c.
> + *
> + * Original copyright messages:
> + *
> + * (c) Copyright 2000-2001 Marek Michalkiewicz <marekm@linux.org.pl>
> + * (c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>, All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License as published by the Free Software
> + * Foundation; either version 2 of the License, or (at your option) any later
> + * version.
> + *

The above is covered by SPDX-License-Identifier and does not need to e repeated.

> + * Neither Alan Cox nor CymruNet Ltd. admit liability nor provide warranty for
> + * any of this software. This material is provided "AS-IS" and at no charge.
> + *

I don't think this carries along across all the changes. There is hardly
anytjing left from the original code.

> + * (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/dmi.h>
> +
> +#include <linux/string.h>

Alphabetic order of include files, please.

> +
> +#define WATCHDOG_NAME "nct6686"
> +#define ECSPACE_MUTEX "nct6686EC"

Tis isn't a mutex. It is the name of a muxed region.

> +#define WATCHDOG_TIMEOUT 60 /* 60 sec default timeout */

tabs, please, before 60

> +#define WATCHDOG_WDT_SEL 1

Unused

> +
> +static int wdt_io;
> +static int ec_base;					/* EC base address */
> +static int wdt_cfg_enter = 0x87;	/* key to unlock configuration space */
> +static int wdt_cfg_leave = 0xAA;	/* key to lock configuration space */

The above can and should be defines.

> +static int is_lenovo = 0;			/* If this system is Lenovo's by checking DMI info */

bool

> +

Local variables should be kept in a local data structure and passed along
as needed.

> +enum chips { nct6686dl, nct6686dl_nano };
> +
> +static int timeout; /* in seconds */
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout,
> +		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
> +				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int early_disable = 0;
> +module_param(early_disable, int, 0);
> +MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
> +

Does ths still make sense ? The driver could inform the watchdog core that
the watchdog is running, and let the watchdog core ping it until it is
opened.

> +#define QUIET 	0	/* Default */
> +#define VERBOSE 1
> +#define DEBUG 	2
> +static int debug = 0;
> +module_param(debug, int, 0);
> +MODULE_PARM_DESC(debug, "Debug level: 0=Quiet, 1=Verbose, 2=Debug (default=0)");

Please use standard messaging flags (pr_debug, pr_info, etc).

> +
> +static int skip_chk_fwver = 0;
> +module_param(skip_chk_fwver, int, 0);
> +MODULE_PARM_DESC(skip_chk_fwver, "Skip checking firmware version (default=0)");
> +

This parameter to be explained. Why is it needed, and why is it turned off
by default ?

> +/*
> + * Kernel methods.
> + */
> +
> +#define WDT_EFER (wdt_io + 0) /* Extended Function Enable Registers */
> +#define WDT_EFIR (wdt_io + 0) /* Extended Function Index Register
> +                                 (same as EFER) */
> +#define WDT_EFDR (WDT_EFIR + 1) /* Extended Function Data Register */
> +
> +#define PAGE_REG_OFFSET 0
> +#define ADDR_REG_OFFSET 1
> +#define DATA_REG_OFFSET 2
> +
> +#define NCT6686_LD_ECSPACE 0x0B
> +
> +#define CHIPID_MASK 0xFFF0
> +#define NCT6686DL_ID 0xD440
> +
> +#define NCT6686_CUS_WDT_CFG 0x828
> +#define NCT6686_CUS_WDT_CNT 0x829
> +#define NCT6686_CUS_WDT_STS 0x82A
> +#define NCT6686_CUS_WDT_STS_EVT_POS (0)
> +#define NCT6686_CUS_WDT_STS_EVT_MSK (0x3 << NCT6686_CUS_WDT_STS_EVT_POS)
> +#define NCT6686_CUS_FWVER_BASE 0x618 //Page 6 18~1f
> +

Tabs, please, and only use C style comments throughout.

> +#ifndef BIT
> +#define BIT(nr) (1UL << (nr))
> +#endif

No. Include the necessary files and don't re-invent the wheel.

> +
> +static void superio_outb(int reg, int val)
> +{
> +	outb(reg, WDT_EFER);
> +	outb(val, WDT_EFDR);
> +}
> +
> +static inline int superio_inb(int reg)
> +{
> +	outb(reg, WDT_EFER);
> +	return inb(WDT_EFDR);
> +}
> +
> +static int superio_enter(void)
> +{
> +	if (!request_muxed_region(wdt_io, 2, WATCHDOG_NAME)) {
> +		pr_warn("nuv:request IO base fail(wdt_io=%X)\n", wdt_io);
> +		return -EBUSY;
> +	}
> +	outb_p(wdt_cfg_enter, WDT_EFER); /* Enter extended function mode */
> +	outb_p(wdt_cfg_enter, WDT_EFER); /* Again according to manual */
> +
> +	return 0;
> +}
> +
> +static void superio_select(int ld)
> +{
> +	superio_outb(0x07, ld);
> +}
> +
> +static void superio_exit(void)
> +{
> +	outb_p(wdt_cfg_leave, WDT_EFER); /* Leave extended function mode */
> +	release_region(wdt_io, 2);
> +}
> +
> +static inline void __nct6686_set_bank(int base_addr, u16 reg)
> +{
> +	outb_p(0xFF, base_addr + PAGE_REG_OFFSET);
> +	outb_p(reg >> 8, base_addr + PAGE_REG_OFFSET);
> +}
> +
> +/* Not strictly necessary, but play it safe for now */
> +static inline void __nct6686_reset_bank(int base_addr, u16 reg)
> +{
> +	if (reg & 0xff00)
> +		outb_p(0xFF, base_addr + PAGE_REG_OFFSET);

This sets the page register to 0xff if the addressed page is not 0.
Not sure if I would call that "reset".

> +}
> +
> +static u8 nct6686_read_value(int base_addr, u16 fullreg)
> +{
> +	u8 volatile res;
> +
> +	if (!request_muxed_region(base_addr, 3, ECSPACE_MUTEX)) {
> +		pr_warn("nuv:request ECSpace fail(base_addr=%X)\n", base_addr);

I think this driver is way too noisy. Please consider removing messages like
this. We don't want to fill up the kernel log just because some other driver
reserves the same memory space and doesn't release it.

> +		return -EBUSY;
> +	}
> +
> +	__nct6686_set_bank(base_addr, fullreg);
> +	outb_p(fullreg & 0xff, base_addr + ADDR_REG_OFFSET);
> +	res = inb_p(base_addr + DATA_REG_OFFSET);
> +
> +	__nct6686_reset_bank(base_addr, fullreg);
> +
> +	release_region(base_addr, 3);
> +
> +	return res;
> +}
> +
> +static int nct6686_write_value(int base_addr, u16 fullreg, u8 value)
> +{
> +	if (!request_muxed_region(base_addr, 3, ECSPACE_MUTEX)) {
> +		pr_warn("nuv:request ECSpace fail(base_addr=%X)\n", base_addr);
> +		return -EBUSY;
> +	}
> +
> +	__nct6686_set_bank(base_addr, fullreg);
> +	outb_p(fullreg & 0xff, base_addr + ADDR_REG_OFFSET);
> +
> +	outb_p(value & 0xff, base_addr + DATA_REG_OFFSET);
> +	__nct6686_reset_bank(base_addr, fullreg);
> +
> +	release_region(base_addr, 3);
> +	return 0;
> +}
> +
> +static int nct6686_init(struct watchdog_device *wdog, enum chips chip)
> +{
> +	volatile unsigned char t, cfg, reg;
> +
> +	t = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CNT);
> +	cfg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CFG);
> +
> +	if (cfg & BIT(0)) {
> +		if (early_disable) {
> +			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
> +
> +			// Disable WDT:
> +			nct6686_write_value(ec_base, NCT6686_CUS_WDT_CFG,
> +					    cfg & (~BIT(0)));
> +
> +			// Clear CNT:
> +			nct6686_write_value(ec_base, NCT6686_CUS_WDT_CNT, 0);
> +		} else {
> +			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
> +				wdog->timeout);
> +
> +			nct6686_write_value(ec_base, NCT6686_CUS_WDT_CNT,
> +					    wdog->timeout);
> +		}
> +	}
> +
> +	/* reset trigger status */
> +	reg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_STS);
> +	nct6686_write_value(ec_base, NCT6686_CUS_WDT_STS,
> +			    reg & ~NCT6686_CUS_WDT_STS_EVT_MSK);
> +
> +	return 0;
> +}
> +
> +static int wdt_enable(bool en)
> +{
> +	unsigned char volatile reg;
> +
> +	reg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CFG);
> +
> +	if (en)
> +		nct6686_write_value(ec_base, NCT6686_CUS_WDT_CFG, reg | 0x3);
> +	else
> +		nct6686_write_value(ec_base, NCT6686_CUS_WDT_CFG,
> +				    reg & ~BIT(0));
> +
> +	return 0;
> +}
> +
> +static int wdt_set_time(unsigned int timeout)
> +{
> +	if (debug >= DEBUG)
> +		pr_debug("nuv:wdt_set_time(0x%x)\n", timeout);
> +
> +	nct6686_write_value(ec_base, NCT6686_CUS_WDT_CNT, timeout);
> +
> +	if (timeout != 0)
> +		wdt_enable(true);
> +	else
> +		wdt_enable(false);
> +
> +	return 0;
> +}
> +
> +static int wdt_start(struct watchdog_device *wdog)
> +{
> +	unsigned char reg;
> +
> +	if (debug >= DEBUG)
> +		pr_debug("nuv:wdt_start()\n");
> +
> +	wdt_set_time(wdog->timeout);
> +
> +	/* reset trigger status */
> +	reg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_STS);
> +	nct6686_write_value(ec_base, NCT6686_CUS_WDT_STS,
> +			    reg & ~NCT6686_CUS_WDT_STS_EVT_MSK);
> +
> +	return 0;
> +}
> +
> +static int wdt_stop(struct watchdog_device *wdog)
> +{
> +	if (debug >= DEBUG)
> +		pr_debug("nuv:wdt_stop()\n");
> +
> +	return wdt_set_time(0);
> +}
> +
> +static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
> +{
> +	if (debug >= DEBUG)
> +		pr_debug("nuv:wdt_set_timeout()\n");
> +
> +	wdog->timeout = timeout;
> +
> +	return 0;
> +}
> +
> +static unsigned int wdt_get_time(struct watchdog_device *wdog)
> +{
> +	unsigned int timeleft;
> +
> +	if (debug >= DEBUG)
> +		pr_debug("nuv:wdt_get_time()\n");
> +
> +	timeleft = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CNT);
> +
> +	return timeleft;
> +}
> +
> +/*
> + * Kernel Interfaces
> + */
> +
> +static const struct watchdog_info wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "NUVOTON Watchdog",
> +};
> +
> +static const struct watchdog_ops wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = wdt_start,
> +	.stop = wdt_stop,
> +	.set_timeout = wdt_set_timeout,
> +	.get_timeleft = wdt_get_time,
> +};
> +
> +static struct watchdog_device wdt_dev = {
> +	.info = &wdt_info,
> +	.ops = &wdt_ops,
> +	.timeout = WATCHDOG_TIMEOUT,
> +	.min_timeout = 1,
> +	.max_timeout = 255,
> +};
> +
> +/*
> + * The WDT needs to learn about soft shutdowns in order to turn the timebomb
> + * registers off.
> + */
> +static int wdt_find(int addr)
> +{
> +	u16 val;
> +	int ret;
> +	int i;
> +	u8 fw_ver[9] = { 0 }; //[8] is for end of string('\0')
> +
> +	ret = superio_enter();
> +	if (ret)
> +		return ret;
> +
> +	if (debug >= DEBUG)
> +		pr_debug("Search port %X... ", wdt_io);
> +
> +	val = superio_inb(0x20);
> +	val = ((val << 8) | (superio_inb(0x21) & 0xFF)) & CHIPID_MASK;
> +
> +	switch (val) {
> +	case NCT6686DL_ID:
> +		ret = nct6686dl;
> +		if (debug >= VERBOSE)
> +			pr_info("Chip found: ChipID=%X (with ID mask)\n", val);
> +		break;
> +	default:
> +		ret = -ENODEV;
> +		if (debug >= VERBOSE)
> +			pr_info("Unsupported chip ID: 0x%X\n", val);

This can be any Super-IO chip. It is inappropriate to complain about
that (we would fill the kernel log with similar messages otherwise).

> +		superio_exit();
> +		return ret;
> +	}
> +
> +	superio_select(NCT6686_LD_ECSPACE);
> +	ec_base = superio_inb(0x60) & 0xFF;
> +	ec_base = (ec_base << 8) | (superio_inb(0x61) & 0xFF);
> +	if ((ec_base == 0xFFFF) || (ec_base == 0)) {

Unnecessary inner ()

> +		pr_err("Wrong address for EC Space: CR60/61=0x%X\n", ec_base);
> +		ret = -ENODEV;
> +	}
> +
> +	superio_exit();
> +
> +	//Check FW Ver (default)
> +	if (skip_chk_fwver == 0) {
> +		for (i = 0; i < 8; i++) {
> +			fw_ver[i] = nct6686_read_value(
> +				ec_base, NCT6686_CUS_FWVER_BASE + i);
> +		}
> +		fw_ver[8] = 0;
> +
> +		switch (ret) {
> +		case nct6686dl:
> +			//check for lenovo nano
> +			if (strncmp(fw_ver, "M2ACT", 5) == 0) {
> +				ret = nct6686dl_nano;
> +			} else {
> +				ret = -ENODEV;
> +				pr_err("Unsupported FW Ver: 0x%s\n", fw_ver);
> +			}
> +			break;
> +		default:
> +			ret = -ENODEV;
> +			pr_err("Unsupported FW Ver: 0x%s\n", fw_ver);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int __init wdt_check_platform(const struct dmi_system_id *d)
> +{
> +	is_lenovo = 1;
> +	if (debug >= DEBUG)
> +		pr_debug("Found Lenovo system!\n");
> +	return 0;
> +}
> +
> +static const struct dmi_system_id wdt_dmi_table[] __initconst = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			// DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CTS"),

No commented out code, please. Either it is needed or it isn't.

> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "314D"),
> +		},
> +		.callback = wdt_check_platform,
> +	},
> +	{}
> +};
> +
> +static int __init wdt_init(void)
> +{
> +	int ret;
> +	int chip;
> +	static const char *const chip_name[] = {
> +		"NUC6686D_NANO",
> +	};
> +
> +	if (debug >= DEBUG)
> +		pr_debug("WDT driver init...\n");
> +
> +	dmi_check_system(wdt_dmi_table);

Why all that complexity with is_lenovo and not just the following ?

	is_lenovo = dmi_check_system(wdt_dmi_table);
> +
> +	wdt_io = 0x4e;
> +	chip = wdt_find(wdt_io);
> +	if (chip < 0) {
> +		wdt_io = 0x2e;
> +		chip = wdt_find(wdt_io);
> +		if (chip < 0)
> +			return chip;
> +	}
> +
> +	if (debug >= VERBOSE)
> +		pr_info("WDT driver for %s(port:0x%X Super I/O chip initialising, ec_base=%X)\n",
> +			chip_name[chip], wdt_io, ec_base);
> +
> +	if (0 == is_lenovo)

No Yoda programming please.

> +		pr_info("Warning! This driver was only verified on Lenovo ThinkCentre Nano!\n");

... and should not be instantiated otherwise, unless there is a good reason
to do otherwise.

> +
> +	watchdog_init_timeout(&wdt_dev, timeout, NULL);
> +	watchdog_set_nowayout(&wdt_dev, nowayout);
> +	watchdog_stop_on_reboot(&wdt_dev);
> +
> +	ret = nct6686_init(&wdt_dev, chip);
> +	if (ret) {
> +		pr_err("failed to initialize watchdog (err=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = watchdog_register_device(&wdt_dev);

Please use devm_watchdog_register_device().

> +	if (ret)
> +		return ret;
> +
> +	pr_info("initialized. timeout=%d sec (nowayout=%d)\n",
> +		wdt_dev.timeout, nowayout);
> +
> +	return ret;
> +}
> +
> +static void __exit wdt_exit(void)
> +{
> +	if (debug >= DEBUG)
> +		pr_info("nuv:wdt_exit()\n");
> +
> +	watchdog_unregister_device(&wdt_dev);
> +}
> +
> +module_init(wdt_init);
> +module_exit(wdt_exit);

Please model as platform driver, and only instantiate it if there is a DMI
match.

> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sheng-Yuan Huang<syhuang3@nuvoton.com>");

This doesn't match the Signed-off-by: tag.

> +MODULE_DESCRIPTION("nct668x WDT driver");
> -- 
> 2.28.0
> 
