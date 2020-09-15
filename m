Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8226B802
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIPAeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:34:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:54077 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgIONkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:40:43 -0400
IronPort-SDR: rvLm38eT33BJANj7itumgJdLySUFFNAbf/y/Az8d4GTl3tp2KhPD+TbLAcZ0LQXCLEmICfyo1v
 jKjZWMem8jYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156647776"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="156647776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:38:14 -0700
IronPort-SDR: UA5G45UrrFxSjjaOkVhRKjvbwuQAo7vjns7bzlxOA1Dv9YdCEEWDrppQTHv/iu18DRmJSdppJJ
 LwFuPecApS6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="409202978"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 06:38:10 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 16:38:09 +0300
Date:   Tue, 15 Sep 2020 16:38:09 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net, cy_huang@richtek.com,
        gene_chen@richtek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usb typec: mt6360: Add support for mt6360 Type-C
 driver
Message-ID: <20200915133809.GL1139641@kuha.fi.intel.com>
References: <1598928042-22115-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598928042-22115-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 10:40:41AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> It works with Type-C Port Controller Manager to provide USB PD
> and USB Type-C functionalities.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v1 to v2
> 1. Add fix to Prevent the race condition from interrupt and tcpci port
>    unregister during module remove.
> 
> v2 to v3
> 1. Change comment style for the head of source code.
> 2. No need to print error for platform_get_irq_byname.
> 3. Fix tcpci_register_port check from IS_ERR_OR_NULL to IS_ERR.
> 4. Rename driver/Kconfig/Makefile form mt6360 to mt636x.
> 5. Rename DT binding documents from mt6360 to mt636x.
> 
> v3 to v4
> 1. revert v3 item 4 for mt636x patch in driver/Kconfig/Makefile
> 2. revert v3 item 5 for mt636x DT binding document.
> 
> v4 to v5
> All changes are for DT binding document. See patch 2.
> 1. Fix schema style (using spaces instead of tabs)
> 2. move connector into the properties block.
> 3. Add ports node into the binding example refer to USB HS/SS/DPMux.
> 
> ---
>  drivers/usb/typec/tcpm/Kconfig        |   8 ++
>  drivers/usb/typec/tcpm/Makefile       |   1 +
>  drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 ++++++++++++++++++++++++++++++++++
>  3 files changed, 221 insertions(+)
>  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index fa3f393..58a64e1 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -27,6 +27,14 @@ config TYPEC_RT1711H
>  	  Type-C Port Controller Manager to provide USB PD and USB
>  	  Type-C functionalities.
>  
> +config TYPEC_MT6360
> +	tristate "Mediatek MT6360 Type-C driver"
> +	depends on MFD_MT6360
> +	help
> +	  Mediatek MT6360 is a multi-functional IC that includes
> +	  USB Type-C. It works with Type-C Port Controller Manager
> +	  to provide USB PD and USB Type-C functionalities.
> +
>  endif # TYPEC_TCPCI
>  
>  config TYPEC_FUSB302
> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
> index a5ff6c8..7592ccb 100644
> --- a/drivers/usb/typec/tcpm/Makefile
> +++ b/drivers/usb/typec/tcpm/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_WCOVE)	+= typec_wcove.o
>  typec_wcove-y			:= wcove.o
>  obj-$(CONFIG_TYPEC_TCPCI)	+= tcpci.o
>  obj-$(CONFIG_TYPEC_RT1711H)	+= tcpci_rt1711h.o
> +obj-$(CONFIG_TYPEC_MT6360)	+= tcpci_mt6360.o
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> new file mode 100644
> index 00000000..f1bd9e0
> --- /dev/null
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/usb/tcpm.h>
> +
> +#include "tcpci.h"
> +
> +#define MT6360_REG_VCONNCTRL1	0x8C
> +#define MT6360_REG_MODECTRL2	0x8F
> +#define MT6360_REG_SWRESET	0xA0
> +#define MT6360_REG_DEBCTRL1	0xA1
> +#define MT6360_REG_DRPCTRL1	0xA2
> +#define MT6360_REG_DRPCTRL2	0xA3
> +#define MT6360_REG_I2CTORST	0xBF
> +#define MT6360_REG_RXCTRL2	0xCF
> +#define MT6360_REG_CTDCTRL2	0xEC
> +
> +/* MT6360_REG_VCONNCTRL1 */
> +#define MT6360_VCONNCL_ENABLE	BIT(0)
> +/* MT6360_REG_RXCTRL2 */
> +#define MT6360_OPEN40M_ENABLE	BIT(7)
> +/* MT6360_REG_CTDCTRL2 */
> +#define MT6360_RPONESHOT_ENABLE	BIT(6)
> +
> +struct mt6360_tcpc_info {
> +	struct tcpci_data tdata;
> +	struct tcpci *tcpci;
> +	struct device *dev;
> +	int irq;
> +};
> +
> +static inline int mt6360_tcpc_read16(struct regmap *regmap,
> +				     unsigned int reg, u16 *val)
> +{
> +	return regmap_raw_read(regmap, reg, val, sizeof(u16));
> +}
> +
> +static inline int mt6360_tcpc_write16(struct regmap *regmap,
> +				      unsigned int reg, u16 val)
> +{
> +	return regmap_raw_write(regmap, reg, &val, sizeof(u16));
> +}
> +
> +static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *tdata)
> +{
> +	struct regmap *regmap = tdata->regmap;
> +	int ret;
> +
> +	ret = regmap_write(regmap, MT6360_REG_SWRESET, 0x01);
> +	if (ret)
> +		return ret;
> +
> +	/* after reset command, wait 1~2ms to wait IC action */
> +	usleep_range(1000, 2000);
> +
> +	/* write all alert to masked */
> +	ret = mt6360_tcpc_write16(regmap, TCPC_ALERT_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* config I2C timeout reset enable , and timeout to 200ms */
> +	ret = regmap_write(regmap, MT6360_REG_I2CTORST, 0x8F);
> +	if (ret)
> +		return ret;
> +
> +	/* config CC Detect Debounce : 26.7*val us */
> +	ret = regmap_write(regmap, MT6360_REG_DEBCTRL1, 0x10);
> +	if (ret)
> +		return ret;
> +
> +	/* DRP Toggle Cycle : 51.2 + 6.4*val ms */
> +	ret = regmap_write(regmap, MT6360_REG_DRPCTRL1, 4);
> +	if (ret)
> +		return ret;
> +
> +	/* DRP Duyt Ctrl : dcSRC: /1024 */
> +	ret = mt6360_tcpc_write16(regmap, MT6360_REG_DRPCTRL2, 330);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable VCONN Current Limit function */
> +	ret = regmap_update_bits(regmap, MT6360_REG_VCONNCTRL1, MT6360_VCONNCL_ENABLE,
> +				 MT6360_VCONNCL_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable cc open 40ms when pmic send vsysuv signal */
> +	ret = regmap_update_bits(regmap, MT6360_REG_RXCTRL2, MT6360_OPEN40M_ENABLE,
> +				 MT6360_OPEN40M_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable Rpdet oneshot detection */
> +	ret = regmap_update_bits(regmap, MT6360_REG_CTDCTRL2, MT6360_RPONESHOT_ENABLE,
> +				 MT6360_RPONESHOT_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	/* Set shipping mode off, AUTOIDLE on */
> +	return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
> +}
> +
> +static irqreturn_t mt6360_irq(int irq, void *dev_id)
> +{
> +	struct mt6360_tcpc_info *mti = dev_id;
> +
> +	return tcpci_irq(mti->tcpci);
> +}
> +
> +static int mt6360_tcpc_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_tcpc_info *mti;
> +	int ret;
> +
> +	mti = devm_kzalloc(&pdev->dev, sizeof(*mti), GFP_KERNEL);
> +	if (!mti)
> +		return -ENOMEM;
> +
> +	mti->dev = &pdev->dev;
> +
> +	mti->tdata.regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mti->tdata.regmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	mti->irq = platform_get_irq_byname(pdev, "PD_IRQB");
> +	if (mti->irq < 0)
> +		return mti->irq;
> +
> +	mti->tdata.init = mt6360_tcpc_init;
> +	mti->tcpci = tcpci_register_port(&pdev->dev, &mti->tdata);
> +	if (IS_ERR(mti->tcpci)) {
> +		dev_err(&pdev->dev, "Failed to register tcpci port\n");
> +		return PTR_ERR(mti->tcpci);
> +	}
> +
> +	ret = devm_request_threaded_irq(mti->dev, mti->irq, NULL, mt6360_irq, IRQF_ONESHOT,
> +					dev_name(&pdev->dev), mti);
> +	if (ret) {
> +		dev_err(mti->dev, "Failed to register irq\n");
> +		tcpci_unregister_port(mti->tcpci);
> +		return ret;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);
> +	platform_set_drvdata(pdev, mti);
> +
> +	return 0;
> +}
> +
> +static int mt6360_tcpc_remove(struct platform_device *pdev)
> +{
> +	struct mt6360_tcpc_info *mti = platform_get_drvdata(pdev);
> +
> +	disable_irq(mti->irq);
> +	tcpci_unregister_port(mti->tcpci);
> +	return 0;
> +}
> +
> +static int __maybe_unused mt6360_tcpc_suspend(struct device *dev)
> +{
> +	struct mt6360_tcpc_info *mti = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(mti->irq);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mt6360_tcpc_resume(struct device *dev)
> +{
> +	struct mt6360_tcpc_info *mti = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(mti->irq);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mt6360_tcpc_pm_ops, mt6360_tcpc_suspend, mt6360_tcpc_resume);
> +
> +static const struct of_device_id __maybe_unused mt6360_tcpc_of_id[] = {
> +	{ .compatible = "mediatek,mt6360-tcpc", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_tcpc_of_id);
> +
> +static struct platform_driver mt6360_tcpc_driver = {
> +	.driver = {
> +		.name = "mt6360-tcpc",
> +		.pm = &mt6360_tcpc_pm_ops,
> +		.of_match_table = mt6360_tcpc_of_id,
> +	},
> +	.probe = mt6360_tcpc_probe,
> +	.remove = mt6360_tcpc_remove,
> +};
> +module_platform_driver(mt6360_tcpc_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("MT6360 USB Type-C Port Controller Interface Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4

-- 
heikki
