Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570F7233FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 09:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgGaHBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 03:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbgGaHBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:01:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3816A2067D;
        Fri, 31 Jul 2020 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596178865;
        bh=waSGCZLpLqJudH+BLycSs/9v2ZDJaeAT4KfCWI6/Jvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjESepdU0cbJJG5YD4jBp/1oM4zWebkZpk5JYVTQTed644CZwt1qKILyc05IEKJxw
         6aum4e1WObjV+VC8JHYkFGzfXzJk4xBbpSvxVgfXWgNtBCdnE1A4K8hAMr1kQ1s2LU
         vk4y5W7s1wT0eYa+hbRebImDjEC+yGTvvkuJfeRo=
Date:   Fri, 31 Jul 2020 09:00:53 +0200
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
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
Message-ID: <20200731070053.GC1518178@kroah.com>
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 06:41:36PM -0300, Daniel Gutson wrote:
> This patch exports information about the platform lockdown
> firmware configuration in the sysfs filesystem.
> In this initial patch, I include some configuration attributes
> for the system SPI chip.
> 
> This initial version exports the BIOS Write Enable (bioswe),
> BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> fields of the Bios Control register. The idea is to keep adding more
> flags, not only from the BC but also from other registers in following
> versions.
> 
> The goal is that the attributes are avilable to fwupd when SecureBoot
> is turned on.
> 
> The patch provides a new misc driver, as proposed in the previous patch,
> that provides a registration function for HW Driver devices to register
> class_attributes.
> In this case, the intel SPI flash chip (intel-spi) registers three
> class_attributes corresponding to the fields mentioned above.

Better, but you are abusing sysfs (note, no CAPS) a lot here...


> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---
>  .../ABI/stable/sysfs-class-platform-lockdown  | 23 +++++++
>  MAINTAINERS                                   |  7 +++
>  drivers/misc/Kconfig                          |  9 +++
>  drivers/misc/Makefile                         |  1 +
>  drivers/misc/platform-lockdown-attrs.c        | 57 +++++++++++++++++
>  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
>  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 49 +++++++++++++++
>  drivers/mtd/spi-nor/controllers/intel-spi.c   | 62 +++++++++++++++++++
>  .../platform_data/platform-lockdown-attrs.h   | 19 ++++++
>  9 files changed, 228 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-class-platform-lockdown
>  create mode 100644 drivers/misc/platform-lockdown-attrs.c
>  create mode 100644 include/linux/platform_data/platform-lockdown-attrs.h
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> new file mode 100644
> index 000000000000..6034d6cbefac
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> @@ -0,0 +1,23 @@
> +What:		/sys/class/platform-lockdown/bioswe
> +Date:		July 2020
> +KernelVersion:	5.8.0
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set BIOS Write Enable.
> +		0: writes disabled, 1: writes enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/class/platform-lockdown/ble
> +Date:		July 2020
> +KernelVersion:	5.8.0
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set Bios Lock Enable.
> +		0: SMM lock disabled, 1: SMM lock enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/class/platform-lockdown/smm_bwp
> +Date:		July 2020
> +KernelVersion:	5.8.0
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set SMM Bios Write Protect.
> +		0: writes disabled unless in SMM, 1: writes enabled.
> +Users:		https://github.com/fwupd/fwupd
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0569cf304ca..771ed1693d28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13608,6 +13608,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
>  F:	drivers/iio/chemical/pms7003.c
>  
> +PLATFORM LOCKDOWN ATTRIBUTES MODULE
> +M:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +S:	Supported
> +F:	Documentation/ABI/sysfs-class-platform-lockdown
> +F:	drivers/misc/platform-lockdown-attrs.c
> +F:	include/linux/platform_data/platform-lockdown-attrs.h
> +
>  PLX DMA DRIVER
>  M:	Logan Gunthorpe <logang@deltatee.com>
>  S:	Maintained
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e1b1ba5e2b92..058d4ba3cefd 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -456,6 +456,15 @@ config PVPANIC
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
>  
> +config PLATFORM_LOCKDOWN_ATTRS
> +	tristate "Platform lockdown information in the SYSFS"

"Platform lockdown information for some hardware information displayed
in sysfs" ?

> +	depends on SYSFS
> +	help
> +	  This kernel module is a helper driver to provide information about
> +	  platform lockdown settings and configuration.

Is that what this really is?

> +	  This module is used by other device drivers -such as the intel-spi-
> +	  to publish the information in /sys/class/platform-lockdown.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c7bd01ac6291..e29b45c564f9 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
>  obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> +obj-$(CONFIG_PLATFORM_LOCKDOWN_ATTRS)	+= platform-lockdown-attrs.o
> diff --git a/drivers/misc/platform-lockdown-attrs.c b/drivers/misc/platform-lockdown-attrs.c
> new file mode 100644
> index 000000000000..d08b3d895064
> --- /dev/null
> +++ b/drivers/misc/platform-lockdown-attrs.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Platform lockdown attributes kernel module
> + *
> + * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
> + * Copyright (C) 2020 Eclypsium Inc.
> + */
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/platform_data/platform-lockdown-attrs.h>
> +
> +static struct class platform_lockdown_class = {
> +	.name	= "platform-lockdown",
> +	.owner	= THIS_MODULE,
> +};
> +
> +int register_platform_lockdown_attribute(
> +	struct class_attribute *lockdown_attribute)
> +{
> +	/* attempt to create the file: */
> +	return class_create_file(&platform_lockdown_class,
> +				   lockdown_attribute);
> +}
> +EXPORT_SYMBOL_GPL(register_platform_lockdown_attribute);

nit, global symbols should put the noun first:
	platform_lockdown_attribute_register()

But, this all is not ok.

You are trying to create/remove random sysfs files that end up in a
single class.  What you want to do is create a device that is associated
with this class, and make that device a child of the device you are
registering these attributes for.

Think of this as an input device.  You don't put the random input
attributes all in one place, you create a new device that represents the
input interface and register that.  Then userspace can iterate over all
devices that are of the input class and see the individual attributes of
them.

Make more sense?

So you need something like:
	platform_lockdown_device_create()

that returns a 'struct device' that is associated with the new class
device.

thanks,

greg k-h
