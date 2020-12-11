Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE62D7813
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404585AbgLKOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:41:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48663 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391315AbgLKOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:41:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1DFE55C00EB;
        Fri, 11 Dec 2020 09:40:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 11 Dec 2020 09:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=b
        SBWvKPxWH74mzz28HLIKITXKtOXmW4PeIHSc+xPSic=; b=bZsmJjvZkibIM3W0u
        uCvgyQ8jwvvGRT/65IpsCPjXqe/dknj5BuZhxtrKI7OqLsE0/Bg5cqDe4L0vdc0a
        m/hyH3oQ3cwM+pZgnwrcBpXVV6qUb7O0vf5td1XtKiB+5xXvgdstUplh4zlAi71T
        KVT3LoDyg9AlmkamRAmyKJoGDz7pBsRR0zejgOWl4sT3Ghuj2jB8zs1CF4rT0Avh
        tHEsDWdfo8WIrp3V7X+eO7UFgCclnTyVeYWl7Z2ARVsMHjW7mhN2LlBw2J3JTjdJ
        WsCIu/heli7xpCYCZI7e5D212gfTAcquVGbVJ+ODCb+o/glnXH2o37VS+7pIUV34
        ATmeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=bSBWvKPxWH74mzz28HLIKITXKtOXmW4PeIHSc+xPS
        ic=; b=OpPH+Vz9HLS0INfPVu/+7ZjFrRoJvLdl6TlPCQ6sFQr/f/iR2rePzNh9D
        2iiYHpsv1Fsidhhv+bAH5r8g0Zr4alH8HOOzXXri97d6ZEMUGBqQK3WKOPtPADb4
        aXCQlQwGgzg/KXc+Z4iCYpyURSnSX0ufBFWrpz9yUCJXRbviCf0FHmGC9ozpjn0z
        H2Cn1OIdy05iKwNNiXZtV6/Cp6fhwk23trjIZnKUVe/4ZURIlKbKJkqTtgHQ1JMj
        3O59akC+DXGDR5u2DYBtRsK+FyLIsIzzM46VyfC6yp4hX6tcn1vyC6tN2hkkZAf6
        IZY2Kl1NuyJmL4tBvUx3QWyUvJPNA==
X-ME-Sender: <xms:84TTX-UBZxKIDWPKLwtdtZIvNrCWymkOFAKQQqlCzq8O2v01OAYOKw>
    <xme:84TTX6moof4VaM8QfrPCQt-MxvJByWm0xpirYbho-2UFT_PyJKBgwtavpQ9ydAsOA
    oLPeeVDRsSxG9eldQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefheenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheejgefhudeffeetleeigefgheetveeiteeuffehhfffkeeuvdff
    veffveetudefnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:84TTXyb-iKluJaktxsAr2L22TaKi0tqpR8IrRwtNi3PwxKSwrgZM2w>
    <xmx:84TTX1XGlceNgxMBbonqJsB8PU--D8VphtdaY-pqqjhxsDk8vRPqEA>
    <xmx:84TTX4mUlVNQ-1MzYFkvhhwDdndAxrZTI6PuQM3-iFqm8to9lPfKVg>
    <xmx:94TTX2aqXOFm-BV0VuATDhbsXSdFLsI0_1jlU_hVvmR_FK2nN_-zlQ>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4C5B71080059;
        Fri, 11 Dec 2020 09:40:51 -0500 (EST)
To:     Maxime Ripard <maxime@cerno.tech>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
 <e374bc4212fa316a68b88bd17f5722387f88f332.1607674518.git.wilken.gottwalt@posteo.net>
 <20201211090312.6vo74loepi2avmy7@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 2/2] hwspinlock: add sun8i hardware spinlock support
Message-ID: <7bdbcec0-3e62-c36e-f5cb-44685967b34d@sholland.org>
Date:   Fri, 11 Dec 2020 08:40:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201211090312.6vo74loepi2avmy7@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 3:03 AM, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Dec 11, 2020 at 09:24:15AM +0100, Wilken Gottwalt wrote:
>> Adds the sun8i_hwspinlock driver for the hardware spinlock unit found in
>> most of the sun8i compatible SoCs.
>>
>> This unit provides at least 32 spinlocks in hardware. The implementation
>> supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
>> reading a register and released by writing a 0 to it. This driver
>> supports all 4 spinlock setups, but for now only the first setup (32
>> locks) seem to exist in available devices. This spinlock unit is shared
>> between all ARM cores and the embedded OpenRisc AR100 core. All of them
>> can take/release a lock with a single cycle operation. It can be used to
>> sync access to devices shared by the ARM cores and the OpenRisc core.
>>
>> There are two ways to check if a lock is taken. The first way is to read
>> a lock. If a 0 is returned, the lock was free and is taken now. If an 1
>> is returned, the caller has to try again. Which means the lock is taken.
>> The second way is to read a 32bit wide status register where every bit
>> represents one of the 32 first locks. According to the datasheets this
>> status register supports only the 32 first locks. This is the reason the
>> first way (lock read/write) approach is used to be able to cover all 256
>> locks in future devices. The driver also reports the amount of supported
>> locks via debugfs.
>>
>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>> ---
>> Changes in v4:
>>   - further simplified driver
>>   - fixed an add_action_and_reset_ function issue
>>   - changed bindings from sun8i-hwspinlock to sun8i-a33-hwspinlock
>>
>> Changes in v3:
>>   - moved test description to cover letter
>>   - changed name and symbols from sunxi to sun8i
>>   - improved driver description
>>   - further simplified driver
>>   - fully switched to devm_* and devm_add_action_* functions
>>
>> Changes in v2:
>>   - added suggestions from Bjorn Andersson and Maxime Ripard
>>   - provided better driver and test description
>> ---
>>  MAINTAINERS                           |   6 +
>>  drivers/hwspinlock/Kconfig            |   9 ++
>>  drivers/hwspinlock/Makefile           |   1 +
>>  drivers/hwspinlock/sun8i_hwspinlock.c | 197 ++++++++++++++++++++++++++
>>  4 files changed, 213 insertions(+)
>>  create mode 100644 drivers/hwspinlock/sun8i_hwspinlock.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ebe4829cdd4d..46846113f1eb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -722,6 +722,12 @@ L:	linux-crypto@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/crypto/allwinner/
>>  
>> +ALLWINNER HARDWARE SPINLOCK SUPPORT
>> +M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
>> +F:	drivers/hwspinlock/sun8i_hwspinlock.c
>> +
>>  ALLWINNER THERMAL DRIVER
>>  M:	Vasily Khoruzhick <anarsoul@gmail.com>
>>  M:	Yangtao Li <tiny.windzz@gmail.com>
>> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
>> index 32cd26352f38..b03fd99aab32 100644
>> --- a/drivers/hwspinlock/Kconfig
>> +++ b/drivers/hwspinlock/Kconfig
>> @@ -55,6 +55,15 @@ config HWSPINLOCK_STM32
>>  
>>  	  If unsure, say N.
>>  
>> +config HWSPINLOCK_SUN8I
>> +	tristate "SUN8I Hardware Spinlock device"
>> +	depends on ARCH_SUNXI || COMPILE_TEST
>> +	help
>> +	  Say y here to support the SUN8I Hardware Spinlock device which can be
>> +	  found in most of the sun8i compatible Allwinner SoCs.
>> +
>> +	  If unsure, say N.
>> +
>>  config HSEM_U8500
>>  	tristate "STE Hardware Semaphore functionality"
>>  	depends on ARCH_U8500 || COMPILE_TEST
>> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
>> index ed053e3f02be..3496648d9257 100644
>> --- a/drivers/hwspinlock/Makefile
>> +++ b/drivers/hwspinlock/Makefile
>> @@ -9,4 +9,5 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
>>  obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
>>  obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
>>  obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
>> +obj-$(CONFIG_HWSPINLOCK_SUN8I)		+= sun8i_hwspinlock.o
>>  obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
>> diff --git a/drivers/hwspinlock/sun8i_hwspinlock.c b/drivers/hwspinlock/sun8i_hwspinlock.c
>> new file mode 100644
>> index 000000000000..878dae6f1763
>> --- /dev/null
>> +++ b/drivers/hwspinlock/sun8i_hwspinlock.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * sun8i_hwspinlock.c - hardware spinlock driver for sun8i compatible Allwinner SoCs
>> + * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@posteo.net>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/errno.h>
>> +#include <linux/hwspinlock.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +
>> +#include "hwspinlock_internal.h"
>> +
>> +#define DRIVER_NAME		"sun8i_hwspinlock"
>> +
>> +#define SPINLOCK_BASE_ID	0 /* there is only one hwspinlock device per SoC */
>> +#define SPINLOCK_SYSSTATUS_REG	0x0000
>> +#define SPINLOCK_LOCK_REGN	0x0100
>> +#define SPINLOCK_NOTTAKEN	0
>> +
>> +struct sun8i_hwspinlock_data {
>> +	struct hwspinlock_device *bank;
>> +	struct reset_control *reset;
>> +	struct clk *ahb_clk;
>> +	struct dentry *debugfs;
>> +	int nlocks;
>> +};
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +static int hwlocks_supported_show(struct seq_file *seqf, void *unused)
>> +{
>> +	struct sun8i_hwspinlock_data *priv = seqf->private;
>> +
>> +	seq_printf(seqf, "%d\n", priv->nlocks);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(hwlocks_supported);
>> +
>> +static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *priv)
>> +{
>> +	priv->debugfs = debugfs_create_dir(DRIVER_NAME, NULL);
> 
> debugfs_create_dir can return an error pointer, you should check that
> and return the error code if it does
> 
>> +	debugfs_create_file("supported", 0444, priv->debugfs, priv, &hwlocks_supported_fops);
> 
> And debugfs_create_file can fail as well

My understanding was that you're not supposed to check the return values
of debugfs_create_* functions, because debugfs is just for debugging and
shouldn't prevent the driver from loading.

>> +}
>> +
>> +#else
>> +
>> +static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *priv)
>> +{
>> +}
>> +
>> +#endif
>> +
>> +static int sun8i_hwspinlock_trylock(struct hwspinlock *lock)
>> +{
>> +	void __iomem *lock_addr = lock->priv;
>> +
>> +	return (readl(lock_addr) == SPINLOCK_NOTTAKEN);
>> +}
>> +
>> +static void sun8i_hwspinlock_unlock(struct hwspinlock *lock)
>> +{
>> +	void __iomem *lock_addr = lock->priv;
>> +
>> +	writel(SPINLOCK_NOTTAKEN, lock_addr);
>> +}
>> +
>> +static const struct hwspinlock_ops sun8i_hwspinlock_ops = {
>> +	.trylock	= sun8i_hwspinlock_trylock,
>> +	.unlock		= sun8i_hwspinlock_unlock,
>> +};
>> +
>> +static void sun8i_hwspinlock_disable(void *data)
>> +{
>> +	struct sun8i_hwspinlock_data *priv = data;
>> +
>> +	debugfs_remove_recursive(priv->debugfs);
>> +	reset_control_assert(priv->reset);
>> +	clk_disable_unprepare(priv->ahb_clk);
>> +}
>> +
>> +static int sun8i_hwspinlock_probe(struct platform_device *pdev)
>> +{
>> +	struct sun8i_hwspinlock_data *priv;
>> +	struct hwspinlock *hwlock;
>> +	void __iomem *io_base;
>> +	u32 num_banks;
>> +	int err, i;
>> +
>> +	io_base = devm_platform_ioremap_resource(pdev, SPINLOCK_BASE_ID);
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->ahb_clk = devm_clk_get(&pdev->dev, "ahb");
>> +	if (IS_ERR(priv->ahb_clk)) {
>> +		err = PTR_ERR(priv->ahb_clk);
>> +		dev_err(&pdev->dev, "unable to get AHB clock (%d)\n", err);
>> +		return err;
>> +	}
>> +
>> +	priv->reset = devm_reset_control_get(&pdev->dev, "ahb");
>> +	if (IS_ERR(priv->reset))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset),
>> +				     "unable to get reset control\n");
>> +
>> +	err = reset_control_deassert(priv->reset);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "deassert reset control failure (%d)\n", err);
>> +		return err;
>> +	}
>> +
>> +	err = clk_prepare_enable(priv->ahb_clk);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "unable to prepare AHB clk (%d)\n", err);
>> +		return err;
>> +	}
>> +
>> +	sun8i_hwspinlock_debugfs_init(priv);
>> +
>> +	err = devm_add_action_or_reset(&pdev->dev, sun8i_hwspinlock_disable, priv);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "unable to add disable action\n");
>> +		return err;
>> +	}
> 
> That part still doesn't really work: if clk_prepare_enable fails, you'll
> end up removing the debugfs files that haven't been added yet, and
> you'll disable the clock that hasn't been enabled.
> 
> I'm not sure you need to be that smart: just add a label and a goto to
> the proper cleaning stuff

I would also suggest implementing the driver's .remove callback instead
of allocating additional memory for a devm action.

Samuel

> Maxime
> 

