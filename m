Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB272921B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgJSEVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 00:21:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:62985 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgJSEVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 00:21:21 -0400
IronPort-SDR: l0ADPkkzMAm2Cb+nAHn7G423Sm060KYV8xAXAqpzjleJVGC8mTdVqAQ2pLrLR0pB+Ft32hLEKV
 HiSOTHP0Edgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167038080"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="167038080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 21:21:19 -0700
IronPort-SDR: gZLkU2VUp1jBbjZhH4QJ12xpaJjHzib55aLfLKcfFaLhdc9xj+++0/QhAP4qWBEVWSrgkkXoRy
 ZK0H2Ml5w0UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="320135635"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2020 21:21:17 -0700
Date:   Mon, 19 Oct 2020 12:16:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 2/2] fpga: dfl: add the userspace I/O device support for
  DFL devices
Message-ID: <20201019041609.GB16172@yilunxu-OptiPlex-7050>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-3-git-send-email-yilun.xu@intel.com>
 <cba18e8f-009b-0732-c91e-88bd58445271@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba18e8f-009b-0732-c91e-88bd58445271@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 09:36:00AM -0700, Tom Rix wrote:
> 
> On 10/15/20 11:02 PM, Xu Yilun wrote:
> > This patch supports the DFL drivers be written in userspace. This is
> > realized by exposing the userspace I/O device interfaces. The driver
> > leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq platform
> > device with the DFL device's resources, and let the generic UIO platform
> > device driver provide support to userspace access to kernel interrupts
> > and memory locations.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  drivers/fpga/Kconfig        | 10 ++++++
> >  drivers/fpga/Makefile       |  1 +
> >  drivers/fpga/dfl-uio-pdev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 94 insertions(+)
> >  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 5d7f0ae..e054722 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> >  	  the card. It also instantiates the SPI master (spi-altera) for
> >  	  the card's BMC (Board Management Controller).
> >  
> > +config FPGA_DFL_UIO_PDEV
> > +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
> > +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
> > +	help
> > +	  Enable this to allow some DFL drivers be written in userspace. It
> > +	  adds the uio_pdrv_genirq platform device with the DFL device's
> > +	  resources, and let the generic UIO platform device driver provide
> 'and lets the'

Yes.

> > +	  support to userspace access to kernel interrupts and memory
> > +	  locations.
> > +
> >  config FPGA_DFL_PCI
> >  	tristate "FPGA DFL PCIe Device Driver"
> >  	depends on PCI && FPGA_DFL
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 18dc9885..e07b3d5 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
> >  dfl-afu-objs += dfl-afu-error.o
> >  
> >  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> > +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)	+= dfl-uio-pdev.o
> >  
> >  # Drivers for FPGAs which implement DFL
> >  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> > diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
> > new file mode 100644
> > index 0000000..d35b846
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-uio-pdev.c
> > @@ -0,0 +1,83 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DFL driver for Userspace I/O platform devices
> > + *
> > + * Copyright (C) 2020 Intel Corporation, Inc.
> > + */
> > +#include <linux/dfl.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/uio_driver.h>
> > +
> > +#define DRIVER_NAME "dfl-uio-pdev"
> > +
> > +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> > +{
> > +	struct device *dev = &ddev->dev;
> > +	struct platform_device_info pdevinfo = { 0 };
> > +	struct uio_info uio_pdata = { 0 };
> > +	struct platform_device *uio_pdev;
> > +	struct resource *res;
> > +	int i, idx = 0;
> 
> idx is not needed.

I could remove the idx. But I think I could ++res during the resource
filling.

Thanks,
Yilun

> 
> > +
> > +	pdevinfo.name = "uio_pdrv_genirq";
> > +
> > +	res = kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	res[idx].parent = &ddev->mmio_res;
> res[0].parent =
> > +	res[idx].flags = IORESOURCE_MEM;
> > +	res[idx].start = ddev->mmio_res.start;
> > +	res[idx].end = ddev->mmio_res.end;
> > +	++idx;
> > +
> > +	/* then add irq resource */
> > +	for (i = 0; i < ddev->num_irqs; i++) {
> > +		res[idx].flags = IORESOURCE_IRQ;
> 
> res[i+1].flags =
> 
> Tom
> 
> > +		res[idx].start = ddev->irqs[i];
> > +		res[idx].end = ddev->irqs[i];
> > +		++idx;
> > +	}
> > +
> > +	uio_pdata.name = DRIVER_NAME;
> > +	uio_pdata.version = "0";
> > +
> > +	pdevinfo.res = res;
> > +	pdevinfo.num_res = idx;
> > +	pdevinfo.parent = &ddev->dev;
> > +	pdevinfo.id = PLATFORM_DEVID_AUTO;
> > +	pdevinfo.data = &uio_pdata;
> > +	pdevinfo.size_data = sizeof(uio_pdata);
> > +
> > +	uio_pdev = platform_device_register_full(&pdevinfo);
> > +	if (!IS_ERR(uio_pdev))
> > +		dev_set_drvdata(dev, uio_pdev);
> > +
> > +	kfree(res);
> > +
> > +	return PTR_ERR_OR_ZERO(uio_pdev);
> > +}
> > +
> > +static void dfl_uio_pdev_remove(struct dfl_device *ddev)
> > +{
> > +	struct platform_device *uio_pdev = dev_get_drvdata(&ddev->dev);
> > +
> > +	platform_device_unregister(uio_pdev);
> > +}
> > +
> > +static struct dfl_driver dfl_uio_pdev_driver = {
> > +	.drv	= {
> > +		.name       = DRIVER_NAME,
> > +	},
> > +	.probe	= dfl_uio_pdev_probe,
> > +	.remove	= dfl_uio_pdev_remove,
> > +};
> > +module_dfl_driver(dfl_uio_pdev_driver);
> > +
> > +MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
> > +MODULE_AUTHOR("Intel Corporation");
> > +MODULE_LICENSE("GPL v2");
