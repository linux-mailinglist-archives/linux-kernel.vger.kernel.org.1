Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4C72D9D41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502104AbgLNRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502090AbgLNRHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:07:08 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C70C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:06:28 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id j8so4097797oon.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cLd7JKlqOIogXmVScWfCxcJZW8EK2XuWUyasshfHsQI=;
        b=ONIvQdcYylTHwyuH/GaiZELOubW1mxNjyHXnsZL69LAoZW1G+XRqmJmiZys5qQ707+
         7XjyhOMH/SdK5LrrZwQ0UZKzsOIX1vkK//eZ1SK4caYdhX0qqIgnwF3kyyq2A6N20gSc
         hskoR8JlOyAfo/WWoNyFvx87AjyVzqDjjdzryOxbj8OdN5TLzFOKzjBc2PAd60HJiHSA
         YkZk600PTvTHVUSxKrjkjBCpJhyW5+wMxxRiQ3xstGqZhHOOQXMulrycV0Yr7MAylav9
         LMFKdlQWXt0ovQH/mFHGS5oLEYnMubSHPvM4eWDLrzyGgE5Eh+4vVhbTWc6+pYF3tJp+
         6Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cLd7JKlqOIogXmVScWfCxcJZW8EK2XuWUyasshfHsQI=;
        b=En7jzrvxrcc3+GhMY95X18Zt4g7bmOQn0QAqlXZMlaY6UB3Ustv1NB+xjS4lkHMN7m
         hm3smMpo6pm2vKtKQ28VM0g4r3zhwfJpy7+ha1sDDb2LQaB/TvsECcQZXAj+xEVpCkVf
         P8YxXg3W1GKSYOptJAUDeFYGu2IcKWB9YdDda9vXjwSNVB5c69N1ap5Oqm3vmTOIgMxq
         rBzldVJSC8YhTq6824XRqvvR7tmrEsWG2PKJ8mehqmwzFUAvj5bxagF+VITOwg0n1oZp
         6oSQcRW1NyJI10+vwpANnt8HIjsdtA052NMKVQ4RqvnUjuwwvzG+LuN/fFoXVVBVmOOY
         a8bQ==
X-Gm-Message-State: AOAM532HJQnJ+vV1aIq1dbbwBYhHmDje2OOCxvbEqpg7zqG4kdzRu0l9
        Zgs+ritZ+gqCOD/Nu4hVsJj1yQ==
X-Google-Smtp-Source: ABdhPJwDgdRPOQBJB7O1rwLsR8pOw7ek8SaJUKDMQRJdrUSHauuntdxaUOCCstFxx5uslMB54HBVEQ==
X-Received: by 2002:a4a:3e42:: with SMTP id t63mr19711894oot.32.1607965587141;
        Mon, 14 Dec 2020 09:06:27 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f67sm4433535otb.60.2020.12.14.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:06:26 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:06:24 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v4 2/2] hwspinlock: add sun8i hardware spinlock support
Message-ID: <X9ebkPbvhthrlTHI@builder.lan>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
 <e374bc4212fa316a68b88bd17f5722387f88f332.1607674518.git.wilken.gottwalt@posteo.net>
 <20201211090312.6vo74loepi2avmy7@gilmour>
 <7bdbcec0-3e62-c36e-f5cb-44685967b34d@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bdbcec0-3e62-c36e-f5cb-44685967b34d@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Dec 08:40 CST 2020, Samuel Holland wrote:

> On 12/11/20 3:03 AM, Maxime Ripard wrote:
> > Hi,
> > 
> > On Fri, Dec 11, 2020 at 09:24:15AM +0100, Wilken Gottwalt wrote:
> >> Adds the sun8i_hwspinlock driver for the hardware spinlock unit found in
> >> most of the sun8i compatible SoCs.
> >>
> >> This unit provides at least 32 spinlocks in hardware. The implementation
> >> supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> >> reading a register and released by writing a 0 to it. This driver
> >> supports all 4 spinlock setups, but for now only the first setup (32
> >> locks) seem to exist in available devices. This spinlock unit is shared
> >> between all ARM cores and the embedded OpenRisc AR100 core. All of them
> >> can take/release a lock with a single cycle operation. It can be used to
> >> sync access to devices shared by the ARM cores and the OpenRisc core.
> >>
> >> There are two ways to check if a lock is taken. The first way is to read
> >> a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> >> is returned, the caller has to try again. Which means the lock is taken.
> >> The second way is to read a 32bit wide status register where every bit
> >> represents one of the 32 first locks. According to the datasheets this
> >> status register supports only the 32 first locks. This is the reason the
> >> first way (lock read/write) approach is used to be able to cover all 256
> >> locks in future devices. The driver also reports the amount of supported
> >> locks via debugfs.
> >>
> >> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >> ---
> >> Changes in v4:
> >>   - further simplified driver
> >>   - fixed an add_action_and_reset_ function issue
> >>   - changed bindings from sun8i-hwspinlock to sun8i-a33-hwspinlock
> >>
> >> Changes in v3:
> >>   - moved test description to cover letter
> >>   - changed name and symbols from sunxi to sun8i
> >>   - improved driver description
> >>   - further simplified driver
> >>   - fully switched to devm_* and devm_add_action_* functions
> >>
> >> Changes in v2:
> >>   - added suggestions from Bjorn Andersson and Maxime Ripard
> >>   - provided better driver and test description
> >> ---
> >>  MAINTAINERS                           |   6 +
> >>  drivers/hwspinlock/Kconfig            |   9 ++
> >>  drivers/hwspinlock/Makefile           |   1 +
> >>  drivers/hwspinlock/sun8i_hwspinlock.c | 197 ++++++++++++++++++++++++++
> >>  4 files changed, 213 insertions(+)
> >>  create mode 100644 drivers/hwspinlock/sun8i_hwspinlock.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index ebe4829cdd4d..46846113f1eb 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -722,6 +722,12 @@ L:	linux-crypto@vger.kernel.org
> >>  S:	Maintained
> >>  F:	drivers/crypto/allwinner/
> >>  
> >> +ALLWINNER HARDWARE SPINLOCK SUPPORT
> >> +M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >> +S:	Maintained
> >> +F:	Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> >> +F:	drivers/hwspinlock/sun8i_hwspinlock.c
> >> +
> >>  ALLWINNER THERMAL DRIVER
> >>  M:	Vasily Khoruzhick <anarsoul@gmail.com>
> >>  M:	Yangtao Li <tiny.windzz@gmail.com>
> >> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> >> index 32cd26352f38..b03fd99aab32 100644
> >> --- a/drivers/hwspinlock/Kconfig
> >> +++ b/drivers/hwspinlock/Kconfig
> >> @@ -55,6 +55,15 @@ config HWSPINLOCK_STM32
> >>  
> >>  	  If unsure, say N.
> >>  
> >> +config HWSPINLOCK_SUN8I
> >> +	tristate "SUN8I Hardware Spinlock device"
> >> +	depends on ARCH_SUNXI || COMPILE_TEST
> >> +	help
> >> +	  Say y here to support the SUN8I Hardware Spinlock device which can be
> >> +	  found in most of the sun8i compatible Allwinner SoCs.
> >> +
> >> +	  If unsure, say N.
> >> +
> >>  config HSEM_U8500
> >>  	tristate "STE Hardware Semaphore functionality"
> >>  	depends on ARCH_U8500 || COMPILE_TEST
> >> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
> >> index ed053e3f02be..3496648d9257 100644
> >> --- a/drivers/hwspinlock/Makefile
> >> +++ b/drivers/hwspinlock/Makefile
> >> @@ -9,4 +9,5 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
> >>  obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
> >>  obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
> >>  obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
> >> +obj-$(CONFIG_HWSPINLOCK_SUN8I)		+= sun8i_hwspinlock.o
> >>  obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
> >> diff --git a/drivers/hwspinlock/sun8i_hwspinlock.c b/drivers/hwspinlock/sun8i_hwspinlock.c
> >> new file mode 100644
> >> index 000000000000..878dae6f1763
> >> --- /dev/null
> >> +++ b/drivers/hwspinlock/sun8i_hwspinlock.c
> >> @@ -0,0 +1,197 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * sun8i_hwspinlock.c - hardware spinlock driver for sun8i compatible Allwinner SoCs
> >> + * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/debugfs.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/hwspinlock.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/reset.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/spinlock.h>
> >> +#include <linux/types.h>
> >> +
> >> +#include "hwspinlock_internal.h"
> >> +
> >> +#define DRIVER_NAME		"sun8i_hwspinlock"
> >> +
> >> +#define SPINLOCK_BASE_ID	0 /* there is only one hwspinlock device per SoC */
> >> +#define SPINLOCK_SYSSTATUS_REG	0x0000
> >> +#define SPINLOCK_LOCK_REGN	0x0100
> >> +#define SPINLOCK_NOTTAKEN	0
> >> +
> >> +struct sun8i_hwspinlock_data {
> >> +	struct hwspinlock_device *bank;
> >> +	struct reset_control *reset;
> >> +	struct clk *ahb_clk;
> >> +	struct dentry *debugfs;
> >> +	int nlocks;
> >> +};
> >> +
> >> +#ifdef CONFIG_DEBUG_FS
> >> +
> >> +static int hwlocks_supported_show(struct seq_file *seqf, void *unused)
> >> +{
> >> +	struct sun8i_hwspinlock_data *priv = seqf->private;
> >> +
> >> +	seq_printf(seqf, "%d\n", priv->nlocks);
> >> +
> >> +	return 0;
> >> +}
> >> +DEFINE_SHOW_ATTRIBUTE(hwlocks_supported);
> >> +
> >> +static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *priv)
> >> +{
> >> +	priv->debugfs = debugfs_create_dir(DRIVER_NAME, NULL);
> > 
> > debugfs_create_dir can return an error pointer, you should check that
> > and return the error code if it does
> > 
> >> +	debugfs_create_file("supported", 0444, priv->debugfs, priv, &hwlocks_supported_fops);
> > 
> > And debugfs_create_file can fail as well
> 
> My understanding was that you're not supposed to check the return values
> of debugfs_create_* functions, because debugfs is just for debugging and
> shouldn't prevent the driver from loading.
> 

That is correct, the debugfs api is written with the expectation that
you shouldn't do error handling.

> >> +}
> >> +
> >> +#else
> >> +
> >> +static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *priv)
> >> +{
> >> +}
> >> +
> >> +#endif
> >> +
> >> +static int sun8i_hwspinlock_trylock(struct hwspinlock *lock)
> >> +{
> >> +	void __iomem *lock_addr = lock->priv;
> >> +
> >> +	return (readl(lock_addr) == SPINLOCK_NOTTAKEN);
> >> +}
> >> +
> >> +static void sun8i_hwspinlock_unlock(struct hwspinlock *lock)
> >> +{
> >> +	void __iomem *lock_addr = lock->priv;
> >> +
> >> +	writel(SPINLOCK_NOTTAKEN, lock_addr);
> >> +}
> >> +
> >> +static const struct hwspinlock_ops sun8i_hwspinlock_ops = {
> >> +	.trylock	= sun8i_hwspinlock_trylock,
> >> +	.unlock		= sun8i_hwspinlock_unlock,
> >> +};
> >> +
> >> +static void sun8i_hwspinlock_disable(void *data)
> >> +{
> >> +	struct sun8i_hwspinlock_data *priv = data;
> >> +
> >> +	debugfs_remove_recursive(priv->debugfs);
> >> +	reset_control_assert(priv->reset);
> >> +	clk_disable_unprepare(priv->ahb_clk);
> >> +}
> >> +
> >> +static int sun8i_hwspinlock_probe(struct platform_device *pdev)
> >> +{
> >> +	struct sun8i_hwspinlock_data *priv;
> >> +	struct hwspinlock *hwlock;
> >> +	void __iomem *io_base;
> >> +	u32 num_banks;
> >> +	int err, i;
> >> +
> >> +	io_base = devm_platform_ioremap_resource(pdev, SPINLOCK_BASE_ID);
> >> +	if (IS_ERR(io_base))
> >> +		return PTR_ERR(io_base);
> >> +
> >> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return -ENOMEM;
> >> +
> >> +	priv->ahb_clk = devm_clk_get(&pdev->dev, "ahb");
> >> +	if (IS_ERR(priv->ahb_clk)) {
> >> +		err = PTR_ERR(priv->ahb_clk);
> >> +		dev_err(&pdev->dev, "unable to get AHB clock (%d)\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	priv->reset = devm_reset_control_get(&pdev->dev, "ahb");
> >> +	if (IS_ERR(priv->reset))
> >> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset),
> >> +				     "unable to get reset control\n");
> >> +
> >> +	err = reset_control_deassert(priv->reset);
> >> +	if (err) {
> >> +		dev_err(&pdev->dev, "deassert reset control failure (%d)\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	err = clk_prepare_enable(priv->ahb_clk);
> >> +	if (err) {
> >> +		dev_err(&pdev->dev, "unable to prepare AHB clk (%d)\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	sun8i_hwspinlock_debugfs_init(priv);
> >> +
> >> +	err = devm_add_action_or_reset(&pdev->dev, sun8i_hwspinlock_disable, priv);
> >> +	if (err) {
> >> +		dev_err(&pdev->dev, "unable to add disable action\n");
> >> +		return err;
> >> +	}
> > 
> > That part still doesn't really work: if clk_prepare_enable fails, you'll
> > end up removing the debugfs files that haven't been added yet, and
> > you'll disable the clock that hasn't been enabled.
> > 
> > I'm not sure you need to be that smart: just add a label and a goto to
> > the proper cleaning stuff
> 
> I would also suggest implementing the driver's .remove callback instead
> of allocating additional memory for a devm action.
> 

I have a feeling that I might have asked for the use of devm helpers.
But afaict we still need a remove function to remove the debugfs stuff.

So I agree with your ask.

Regards,
Bjorn
