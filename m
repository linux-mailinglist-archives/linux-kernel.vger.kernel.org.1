Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE2285D18
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgJGKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGKog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:44:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDCC061755;
        Wed,  7 Oct 2020 03:44:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so1790273wmj.5;
        Wed, 07 Oct 2020 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cK/7KKg3LMRLJqngGOT4//Qph/7CsuKSEUe0I2xQ0J0=;
        b=XvyNypdAGm/e/or1Zzz6Q0oTSrZtOgYRxIkbW+kGQZx1+/faQQCqN8wZI9T5k/rMdL
         AdiCf7ktooeT0UvfnZOe8OZhWdd3qaSWNS2hs09uDU9KjJpybl+HjpSoyWGe0rbYPbnu
         KZb12QbjLQuIKN145yxp4fNpZpoXNor3NWQ4qUuv+3adSgoYpPhd0knpzc5MqxMitiou
         GcLdTHSrExPGf6vLo6saedkrGX+ZiMf4gQlmx4etrzt2Z3DnJhE4A86OEI7kjifV8iZJ
         nltGoCNJxBOMeSoJ0uqGZbbTtYcZxPzVedQrdFW/TI2AMHi4kNJV2JAAnPEvVTeV04G3
         kAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cK/7KKg3LMRLJqngGOT4//Qph/7CsuKSEUe0I2xQ0J0=;
        b=oUFqxfzh28fh2aJ9STQGzmKfwiIFjPDgOIRSDpyl6LPWwtlKB0P15o30zZS2uScP1s
         dUXxzqcSCoaYuYM7h5gZj6zttFNLjxCrXE5QdHdeaSuDlRe+pBgU/WongDSWK6Nfhmk6
         GgpbwRQ8S3ELgLLfVuuDH57jlXYWfWK85PcMAQq3Cr+ip2IA2yy1kJDLRj5WWotDHq4e
         CIhpNb8DIosKEml9TIQh6EdolDMdHhcGyqVVEwHw+DX9zbP9rZH5sJP1Trag5GBWU6xF
         HSLjjFEvALXJ7J8ygnAnz88muQgQnbu8+Ii8cgGvqIyUkQDSu3BuA3awvBrymVss0dSx
         EzOw==
X-Gm-Message-State: AOAM532/PRTFp5yDdh5cQV7ptnwaAiV6oXl2T73UmLYoJbpMXLNAOBTs
        D1XtD4extyR+1U0sQ3wIA+4=
X-Google-Smtp-Source: ABdhPJzkwikVrg3KNBchgYEO0PjzOoiSixKtQCEZcj3e4/u8fKunkxK7W6bDddpEl4BVFK39fdd2ZQ==
X-Received: by 2002:a1c:4943:: with SMTP id w64mr2683472wma.165.1602067474706;
        Wed, 07 Oct 2020 03:44:34 -0700 (PDT)
Received: from ziggy.stardust ([37.223.143.170])
        by smtp.gmail.com with ESMTPSA id z13sm2243306wro.97.2020.10.07.03.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 03:44:33 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
 <1598497593-15781-3-git-send-email-neal.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c41ec664-73a0-3c63-a31c-48c89028dfac@gmail.com>
Date:   Wed, 7 Oct 2020 12:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1598497593-15781-3-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/08/2020 05:06, Neal Liu wrote:
> MediaTek bus fabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violation is logged and sent to the processor for
> further analysis or countermeasures.
> 
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by mtk-devapc driver. The violation
> information is printed in order to find the murderer.

"The violation information is printed in order to find the responsible component."

Nobody got actually killed, right :)

> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig      |    9 ++
>   drivers/soc/mediatek/Makefile     |    1 +
>   drivers/soc/mediatek/mtk-devapc.c |  305 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 315 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-devapc.c
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 59a56cd..1177c98 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -17,6 +17,15 @@ config MTK_CMDQ
>   	  time limitation, such as updating display configuration during the
>   	  vblank.
>   
> +config MTK_DEVAPC
> +	tristate "Mediatek Device APC Support"
> +	help
> +	  Say yes here to enable support for Mediatek Device APC driver.
> +	  This driver is mainly used to handle the violation which catches
> +	  unexpected transaction.
> +	  The violation information is logged for further analysis or
> +	  countermeasures.
> +
>   config MTK_INFRACFG
>   	bool "MediaTek INFRACFG Support"
>   	select REGMAP
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 01f9f87..abfd4ba 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> +obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> new file mode 100644
> index 0000000..0ba61d7
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +
> +#define VIO_MOD_TO_REG_IND(m)	((m) / 32)
> +#define VIO_MOD_TO_REG_OFF(m)	((m) % 32)
> +
> +struct mtk_devapc_vio_dbgs {
> +	union {
> +		u32 vio_dbg0;
> +		struct {
> +			u32 mstid:16;
> +			u32 dmnid:6;
> +			u32 vio_w:1;
> +			u32 vio_r:1;
> +			u32 addr_h:4;
> +			u32 resv:4;
> +		} dbg0_bits;
> +	};
> +
> +	u32 vio_dbg1;
> +};
> +
> +struct mtk_devapc_data {
> +	u32 vio_idx_num;
> +	u32 vio_mask_offset;
> +	u32 vio_sta_offset;
> +	u32 vio_dbg0_offset;
> +	u32 vio_dbg1_offset;
> +	u32 apc_con_offset;
> +	u32 vio_shift_sta_offset;
> +	u32 vio_shift_sel_offset;
> +	u32 vio_shift_con_offset;
> +};

Please describe the fields of the struct, that will make it easier to understand 
the driver.

> +
> +struct mtk_devapc_context {
> +	struct device *dev;
> +	void __iomem *infra_base;
> +	struct clk *infra_clk;
> +	const struct mtk_devapc_data *data;
> +};
> +
> +static void clear_vio_status(struct mtk_devapc_context *ctx)
> +{
> +	void __iomem *reg;
> +	int i;
> +
> +	reg = ctx->infra_base + ctx->data->vio_sta_offset;
> +
> +	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num - 1); i++)
> +		writel(GENMASK(31, 0), reg + 4 * i);
> +
> +	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num - 1), 0),
> +	       reg + 4 * i);
> +}
> +
> +static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +	int i;
> +
> +	reg = ctx->infra_base + ctx->data->vio_mask_offset;
> +
> +	if (mask)
> +		val = GENMASK(31, 0);
> +	else
> +		val = 0;
> +
> +	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num - 1); i++)

Do I get that right? We have a number of virtual IO identifier. Their 
correspondending interrupt are grouped in 32 bit registers. And we want to 
enable/disable them by writing 0 or 1. We have to take care of the last 
registers as it could be the case that vio_idx_num is not a multiple of 32, correct?

In this case we should traverse VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1 
registers, which is (vio_idx_num / 32) - 1 and not (vio_idx_num - 1) / 32.

> +		writel(val, reg + 4 * i);
> +
> +	val = readl(reg + 4 * i);
> +	if (mask)
> +		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num - 1),
> +			       0);

We have 511 IRQs, which gives us 31 bits in the last register to set/unset. 
Thats 510..0 bits, so from what I understand, once again we want
GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1, 0)
which is (vio_idx_num % 32) - 1

Correct or do I understand something wrong?
If so, same applies to clear_vio_status().


> +	else
> +		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num - 1),
> +				0);
> +
> +	writel(val, reg + 4 * i);
> +}
> +
> +#define PHY_DEVAPC_TIMEOUT	0x10000
> +
> +/*
> + * devapc_sync_vio_dbg - do "shift" mechansim" to get full violation information.
> + *                       shift mechanism is depends on devapc hardware design.
> + *                       Mediatek devapc set multiple slaves as a group.
> + *                       When violation is triggered, violation info is kept
> + *                       inside devapc hardware.
> + *                       Driver should do shift mechansim to sync full violation
> + *                       info to VIO_DBGs registers.
> + *
> + */
> +static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
> +{
> +	void __iomem *pd_vio_shift_sta_reg;
> +	void __iomem *pd_vio_shift_sel_reg;
> +	void __iomem *pd_vio_shift_con_reg;
> +	int min_shift_group;
> +	int ret;
> +	u32 val;
> +
> +	pd_vio_shift_sta_reg = ctx->infra_base +
> +			       ctx->data->vio_shift_sta_offset;
> +	pd_vio_shift_sel_reg = ctx->infra_base +
> +			       ctx->data->vio_shift_sel_offset;
> +	pd_vio_shift_con_reg = ctx->infra_base +
> +			       ctx->data->vio_shift_con_offset;
> +
> +	/* Find the minimum shift group which has violation */
> +	val = readl(pd_vio_shift_sta_reg);
> +	if (!val)
> +		return false;

So bit 0 of selection register (pd_vio_shift_sel_reg) does not represent a 
violation group?
I don't know how the HW works, but is seems odd to me. In case that's bit 0 
actually doesn't represent anything: how can an interrupt be triggered without 
any debug information present (means val == 0)?

> +
> +	min_shift_group = __ffs(val);
> +
> +	/* Assign the group to sync */
> +	writel(0x1 << min_shift_group, pd_vio_shift_sel_reg);
> +
> +	/* Start syncing */
> +	writel(0x1, pd_vio_shift_con_reg);
> +
> +	ret = readl_poll_timeout(pd_vio_shift_con_reg, val, val == 0x3, 0,
> +				 PHY_DEVAPC_TIMEOUT);
> +	if (ret) {
> +		dev_err(ctx->dev, "%s: Shift violation info failed\n", __func__);

In which case this can happen? I'm asking, because we are calling 
devapc_sync_vio_dbg() in a while loop that could make the kernel hang here.

Do I understand correctly, that we are using the while loop, because there can 
be more then one violation group which got triggered (read, more then one bit is 
set in pd_vio_shift_sta_reg)? Would it make more sense then to read the register 
once and do all the shift operation for all groups which bit set to 1 in the 
shift status register?

> +		return false;
> +	}
> +
> +	/* Stop syncing */
> +	writel(0x0, pd_vio_shift_con_reg);
> +
> +	/* Write clear */
> +	writel(0x1 << min_shift_group, pd_vio_shift_sta_reg);
> +
> +	return true;
> +}
> +
> +/*
> + * devapc_extract_vio_dbg - extract full violation information after doing
> + *                          shift mechanism.
> + */
> +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
> +{
> +	struct mtk_devapc_vio_dbgs vio_dbgs;
> +	void __iomem *vio_dbg0_reg;
> +	void __iomem *vio_dbg1_reg;
> +
> +	vio_dbg0_reg = ctx->infra_base + ctx->data->vio_dbg0_offset;
> +	vio_dbg1_reg = ctx->infra_base + ctx->data->vio_dbg1_offset;
> +
> +	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
> +	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
> +
> +	/* Print violation information */
> +	if (vio_dbgs.dbg0_bits.vio_w)
> +		dev_info(ctx->dev, "Write Violation\n");
> +	else if (vio_dbgs.dbg0_bits.vio_r)
> +		dev_info(ctx->dev, "Read Violation\n");
> +
> +	dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n",
> +		 vio_dbgs.dbg0_bits.mstid, vio_dbgs.dbg0_bits.dmnid,
> +		 vio_dbgs.vio_dbg1);
> +}
> +
> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) will dump
> + *                        violation information including which master violates
> + *                        access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number,
> +					struct mtk_devapc_context *ctx)

static irqreturn_t devapc_violation_irq(int irq_number, void *data)
{
	struct mtk_devapc_context *ctx = data;

> +{
> +	while (devapc_sync_vio_dbg(ctx))
> +		devapc_extract_vio_dbg(ctx);
> +
> +	clear_vio_status(ctx);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * start_devapc - unmask slave's irq to start receiving devapc violation.
> + */
> +static void start_devapc(struct mtk_devapc_context *ctx)
> +{
> +	writel(BIT(31), ctx->infra_base + ctx->data->apc_con_offset);
> +
> +	mask_module_irq(ctx, false);
> +}
> +
> +/*
> + * stop_devapc - mask slave's irq to stop service.
> + */
> +static void stop_devapc(struct mtk_devapc_context *ctx)
> +{
> +	mask_module_irq(ctx, true);
> +
> +	writel(BIT(2), ctx->infra_base + ctx->data->apc_con_offset);
> +}
> +
> +static const struct mtk_devapc_data devapc_mt6779 = {
> +	.vio_idx_num = 511,
> +	.vio_mask_offset = 0x0,
> +	.vio_sta_offset = 0x400,
> +	.vio_dbg0_offset = 0x900,
> +	.vio_dbg1_offset = 0x904,
> +	.apc_con_offset = 0xF00,
> +	.vio_shift_sta_offset = 0xF10,
> +	.vio_shift_sel_offset = 0xF14,
> +	.vio_shift_con_offset = 0xF20,
> +};
> +
> +static const struct of_device_id mtk_devapc_dt_match[] = {
> +	{
> +		.compatible = "mediatek,mt6779-devapc",
> +		.data = &devapc_mt6779,
> +	}, {
> +	},
> +};
> +
> +static int mtk_devapc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct mtk_devapc_context *ctx;
> +	u32 devapc_irq;
> +	int ret;
> +
> +	if (IS_ERR(node))
> +		return -ENODEV;
> +
> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->data = of_device_get_match_data(&pdev->dev);
> +	ctx->dev = &pdev->dev;
> +
> +	ctx->infra_base = of_iomap(node, 0);

Does this mean the device is part of the infracfg block?
I wasn't able to find any information about it.

> +	if (!ctx->infra_base)
> +		return -EINVAL;
> +
> +	devapc_irq = irq_of_parse_and_map(node, 0);
> +	if (!devapc_irq)
> +		return -EINVAL;
> +
> +	ctx->infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
> +	if (IS_ERR(ctx->infra_clk))
> +		return -EINVAL;
> +
> +	if (clk_prepare_enable(ctx->infra_clk))
> +		return -EINVAL;
> +
> +	ret = devm_request_irq(&pdev->dev, devapc_irq,
> +			       (irq_handler_t)devapc_violation_irq,

No cast should be needed.

> +			       IRQF_TRIGGER_NONE, "devapc", ctx);
> +	if (ret) {
> +		clk_disable_unprepare(ctx->infra_clk);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, ctx);
> +
> +	start_devapc(ctx);
> +
> +	return 0;
> +}
> +
> +static int mtk_devapc_remove(struct platform_device *pdev)
> +{
> +	struct mtk_devapc_context *ctx = platform_get_drvdata(pdev);
> +
> +	stop_devapc(ctx);
> +
> +	clk_disable_unprepare(ctx->infra_clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mtk_devapc_driver = {
> +	.probe = mtk_devapc_probe,
> +	.remove = mtk_devapc_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,

.name = "mtk-devapc",

Regards,
Matthias
