Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A783D27C25E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgI2K2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2K2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:28:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13BE82076A;
        Tue, 29 Sep 2020 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601375295;
        bh=hAuRdHS7G4XeaPtPCZGA7DQorcxil6kp5Umc1clsClQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7umlUhHNVAHNe2opbQ3vNX1/MQGQy5OAt2jYcUmoaWBZBkXDu/V+9Gf2R3HL6wXw
         UY+vrA8J0jKZ4AkFhNxO38LSnHwaNn5xvdrP3bz05+REGZ2UBro7EZj+pr2aRaMizj
         b/OTMQTODy6ld8585Z+J0Quf6+qSNUHvFv5fwZbM=
Date:   Tue, 29 Sep 2020 12:28:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4 02/16] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200929102821.GC951772@kroah.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
 <20200929001209.16393-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929001209.16393-3-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:11:55PM -0700, Scott Branden wrote:
> Add initial version of Broadcom VK driver to enumerate PCI device IDs
> of Valkyrie and Viper device IDs.
> 
> VK based cards provide real-time high performance, high throughput,
> low latency offload compute engine operations.
> They are used for multiple parallel offload tasks as:
> audio, video and image processing and crypto operations.

As we have had this come up for other offload engine devices, we need a
pointer to the userspace code for this as well, so that we can properly
review the whole thing together.  Otherwise this is just one half, the
other is a black-box that is pretty impossible to understand :)


> 
> Further commits add additional features to driver beyond probe/remove.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/misc/Kconfig             |   1 +
>  drivers/misc/Makefile            |   1 +
>  drivers/misc/bcm-vk/Kconfig      |  15 ++++
>  drivers/misc/bcm-vk/Makefile     |   8 ++
>  drivers/misc/bcm-vk/bcm_vk.h     |  29 +++++++
>  drivers/misc/bcm-vk/bcm_vk_dev.c | 137 +++++++++++++++++++++++++++++++
>  6 files changed, 191 insertions(+)
>  create mode 100644 drivers/misc/bcm-vk/Kconfig
>  create mode 100644 drivers/misc/bcm-vk/Makefile
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ce136d685d14..9d42b5def81b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -469,6 +469,7 @@ source "drivers/misc/genwqe/Kconfig"
>  source "drivers/misc/echo/Kconfig"
>  source "drivers/misc/cxl/Kconfig"
>  source "drivers/misc/ocxl/Kconfig"
> +source "drivers/misc/bcm-vk/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c7bd01ac6291..766837e4b961 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_ECHO)		+= echo/
>  obj-$(CONFIG_CXL_BASE)		+= cxl/
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
> +obj-$(CONFIG_BCM_VK)		+= bcm-vk/
>  obj-y				+= cardreader/
>  obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
> new file mode 100644
> index 000000000000..2272e47655ed
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Broadcom VK device
> +#
> +config BCM_VK
> +	tristate "Support for Broadcom VK Accelerators"
> +	depends on PCI_MSI
> +	help
> +	  Select this option to enable support for Broadcom
> +	  VK Accelerators.  VK is used for performing
> +	  specific offload processing.
> +	  This driver enables userspace programs to access these
> +	  accelerators via /dev/bcm-vk.N devices.
> +
> +	  If unsure, say N.
> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
> new file mode 100644
> index 000000000000..f8a7ac4c242f
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for Broadcom VK driver
> +#
> +
> +obj-$(CONFIG_BCM_VK) += bcm_vk.o
> +bcm_vk-objs := \
> +	bcm_vk_dev.o
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> new file mode 100644
> index 000000000000..9152785199ab
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#ifndef BCM_VK_H
> +#define BCM_VK_H
> +
> +#include <linux/pci.h>
> +
> +#define DRV_MODULE_NAME		"bcm-vk"
> +
> +/* VK device supports a maximum of 3 bars */
> +#define MAX_BAR	3
> +
> +enum pci_barno {
> +	BAR_0 = 0,
> +	BAR_1,
> +	BAR_2
> +};
> +
> +#define BCM_VK_NUM_TTY 2
> +
> +struct bcm_vk {
> +	struct pci_dev *pdev;
> +	void __iomem *bar[MAX_BAR];
> +};
> +
> +#endif
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> new file mode 100644
> index 000000000000..bb24efb1b9fb
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +
> +#include "bcm_vk.h"
> +
> +#define PCI_DEVICE_ID_VALKYRIE	0x5e87
> +#define PCI_DEVICE_ID_VIPER	0x5e88
> +
> +/* MSIX usages */
> +#define VK_MSIX_MSGQ_MAX		3
> +#define VK_MSIX_NOTF_MAX		1
> +#define VK_MSIX_TTY_MAX			BCM_VK_NUM_TTY
> +#define VK_MSIX_IRQ_MAX			(VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX + \
> +					 VK_MSIX_TTY_MAX)
> +#define VK_MSIX_IRQ_MIN_REQ             (VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX)
> +
> +/* Number of bits set in DMA mask*/
> +#define BCM_VK_DMA_BITS			64
> +
> +static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	int err;
> +	int i;
> +	int irq;
> +	struct bcm_vk *vk;
> +	struct device *dev = &pdev->dev;
> +
> +	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
> +	if (!vk)
> +		return -ENOMEM;
> +
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "Cannot enable PCI device\n");
> +		return err;

You just leaked memory :(

That was a short review, I didn't get all that far...

> +	}
> +	vk->pdev = pci_dev_get(pdev);
> +
> +	err = pci_request_regions(pdev, DRV_MODULE_NAME);
> +	if (err) {
> +		dev_err(dev, "Cannot obtain PCI resources\n");
> +		goto err_disable_pdev;
> +	}
> +
> +	/* make sure DMA is good */
> +	err = dma_set_mask_and_coherent(&pdev->dev,
> +					DMA_BIT_MASK(BCM_VK_DMA_BITS));
> +	if (err) {
> +		dev_err(dev, "failed to set DMA mask\n");
> +		goto err_disable_pdev;
> +	}
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, vk);
> +
> +	irq = pci_alloc_irq_vectors(pdev,
> +				    1,
> +				    VK_MSIX_IRQ_MAX,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +
> +	if (irq < VK_MSIX_IRQ_MIN_REQ) {
> +		dev_err(dev, "failed to get min %d MSIX interrupts, irq(%d)\n",
> +			VK_MSIX_IRQ_MIN_REQ, irq);
> +		err = (irq >= 0) ? -EINVAL : irq;
> +		goto err_disable_pdev;
> +	}
> +
> +	dev_info(dev, "Number of IRQs %d allocated - requested(%d).\n",
> +		 irq, VK_MSIX_IRQ_MAX);

Drivers are quiet when all works properly.

> +
> +	for (i = 0; i < MAX_BAR; i++) {
> +		/* multiple by 2 for 64 bit BAR mapping */
> +		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
> +		if (!vk->bar[i]) {
> +			dev_err(dev, "failed to remap BAR%d\n", i);
> +			goto err_iounmap;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_iounmap:
> +	for (i = 0; i < MAX_BAR; i++) {
> +		if (vk->bar[i])
> +			pci_iounmap(pdev, vk->bar[i]);
> +	}
> +	pci_release_regions(pdev);
> +
> +err_disable_pdev:
> +	pci_free_irq_vectors(pdev);
> +	pci_disable_device(pdev);
> +	pci_dev_put(pdev);
> +
> +	return err;

Again, memory is leaked :(

thanks,

greg k-h
