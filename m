Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D815028145F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbgJBNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBNnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:43:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D84A206CA;
        Fri,  2 Oct 2020 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601646212;
        bh=ztJ79iu751NzFNs1C+Y906mgA/xV0xzf9l84gu1qG6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydYjizua5HHKMPw1y3vHC3z/Aj+G49Pb/0OdzRNaE0+Jmj/C+HC96w102hxzsKTo0
         hz0bz0EiwzhuCnnxloiOMTa9WKlYz/U9kr/Q98rJgL+Fw5M0OqRyUUJDV/wlw6LwWA
         s+9rzsRp9RkP+5XM8uGael6MtHFydliSPWzv41FU=
Date:   Fri, 2 Oct 2020 15:43:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] Platform integrity information in sysfs (version 9)
Message-ID: <20201002134331.GA3418160@kroah.com>
References: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
 <20200930163714.12879-3-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930163714.12879-3-daniel.gutson@eclypsium.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:37:14PM -0300, Daniel Gutson wrote:
> This patch exports the BIOS Write Enable (bioswe), BIOS
> Lock Enable (biosle), and the SMM BIOS Write Protect (SMM_BIOSWP) fields of
> the BIOS Control register using the platform-integrity misc kernel module.
> The idea is to keep adding more flags, not only from the BC but also from
> other registers in following versions.
> 
> The goal is that the attributes are avilable to fwupd when SecureBoot
> is turned on.
> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>

The subject line doesn't match what this patch does, please fix that up.

But there are more core issues in this patch:

> 
> ---
>  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
>  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 75 ++++++++++++++-
>  .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
>  drivers/mtd/spi-nor/controllers/intel-spi.c   | 91 ++++++++++++++++++-
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  9 +-
>  5 files changed, 171 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> index 5c0e0ec2e6d1..e7eaef506fc2 100644
> --- a/drivers/mtd/spi-nor/controllers/Kconfig
> +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> @@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
>  
>  config SPI_INTEL_SPI
>  	tristate
> +	depends on PLATFORM_INTEGRITY_DATA
>  
>  config SPI_INTEL_SPI_PCI
>  	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> index c72aa1ab71ad..644b1a6091dc 100644
> --- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> +++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> @@ -10,11 +10,19 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform-integrity.h>
>  
>  #include "intel-spi.h"
>  
>  #define BCR		0xdc
>  #define BCR_WPD		BIT(0)
> +#define BCR_BLE		BIT(1)
> +#define BCR_SMM_BWP	BIT(5)
> +
> +struct cnl_spi_attr {
> +	struct device_attribute dev_attr;
> +	u32 mask;
> +};
>  
>  static const struct intel_spi_boardinfo bxt_info = {
>  	.type = INTEL_SPI_BXT,
> @@ -24,6 +32,70 @@ static const struct intel_spi_boardinfo cnl_info = {
>  	.type = INTEL_SPI_CNL,
>  };
>  
> +#ifdef CONFIG_PLATFORM_INTEGRITY_DATA
> +static ssize_t intel_spi_cnl_spi_attr_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf, u32 mask)
> +{
> +	u32 bcr;
> +
> +	if (dev->parent == NULL)
> +		return -EIO;
> +
> +	if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
> +				  BCR, &bcr) != PCIBIOS_SUCCESSFUL)
> +		return -EIO;
> +
> +	return sprintf(buf, "%d\n", (int)!!(bcr & mask));
> +}
> +
> +static ssize_t bioswe_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_WPD);
> +}
> +static DEVICE_ATTR_RO(bioswe);
> +
> +static ssize_t biosle_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_BLE);
> +}
> +static DEVICE_ATTR_RO(biosle);
> +
> +static ssize_t smm_bioswp_show(struct device *dev, struct device_attribute *attr,
> +			       char *buf)
> +{
> +	return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_SMM_BWP);
> +}
> +static DEVICE_ATTR_RO(smm_bioswp);
> +
> +static struct attribute *cnl_attrs[] = {
> +	&dev_attr_bioswe.attr,
> +	&dev_attr_biosle.attr,
> +	&dev_attr_smm_bioswp.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(cnl);

If you are forcing the driver to create the groups, then you are forcing
us to audit each driver and verify that the files are the same name and
such.  Put the files in the "common" code please, and if you really need
a way to get the data out, make that a callback or something.

Also, this name "platform integrity" is really really generic, while in
reality you are describing something very specific.  Are you sure you
want that?

thanks,

greg k-h
