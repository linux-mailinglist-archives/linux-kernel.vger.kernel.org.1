Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B511AC025
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506660AbgDPLtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:49:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64875 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506661AbgDPLtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:49:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 492yDl5Lkcz9tylt;
        Thu, 16 Apr 2020 13:49:11 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=p/C50Mqy; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eTocy9pa4yBm; Thu, 16 Apr 2020 13:49:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 492yDl422lz9tyls;
        Thu, 16 Apr 2020 13:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587037751; bh=7q+zozMeephcGFHZ1fFO0nN3uQx2WfNcxoZsYISBC/k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p/C50Mqyd8FuINA3IAXANWlxjFvfRcB1bjjZo/qbCNbXDZUDsQr0idImzFrGVGy9s
         Mu2ASeb2bi5SwlvGtpBAM1Oi2v3MRGBen3qloIOotXVrzk+AWGsII+NX2BtIK0t5u2
         luCl/wq+5kJyYC40iDBMMB6Vxa6TEaI1ae6ygpuI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C1AA78BC07;
        Thu, 16 Apr 2020 13:49:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RV3xYndJTuvU; Thu, 16 Apr 2020 13:49:12 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6C558BC06;
        Thu, 16 Apr 2020 13:49:11 +0200 (CEST)
Subject: Re: [PATCH RESEND,v3,4/4] drivers: uio: new driver for
 fsl_85xx_cache_sram
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20200416111609.4191-1-wenhu.wang@vivo.com>
 <20200416111609.4191-5-wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6173e4ce-bc26-b87c-e679-65329e8336cc@c-s.fr>
Date:   Thu, 16 Apr 2020 13:49:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416111609.4191-5-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/04/2020 à 13:16, Wang Wenhu a écrit :
> A driver for freescale 85xx platforms to access the Cache-Sram form
> user level. This is extremely helpful for some user-space applications
> that require high performance memory accesses.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changes since v1:
>   * Addressed comments from Greg K-H
>   * Moved kfree(info->name) into uio_info_free_internal()
> Changes since v2:
>   * Addressed comments from Greg, Scott and Christophe
>   * Use "uiomem->internal_addr" as if condition for sram memory free,
>     and memset the uiomem entry
>   * Modified of_match_table make the driver apart from Cache-Sram HW info
>     which belong to the HW level driver fsl_85xx_cache_sram to match
>   * Use roundup_pow_of_two for align calculation
>   * Remove useless clear block of uiomem entries.
>   * Use UIO_INFO_VER micro for info->version, and define it as
>     "devicetree,pseudo", meaning this is pseudo device and probed from
>     device tree configuration
>   * Select FSL_85XX_CACHE_SRAM rather than depends on it
> ---
>   drivers/uio/Kconfig                   |   9 ++
>   drivers/uio/Makefile                  |   1 +
>   drivers/uio/uio_fsl_85xx_cache_sram.c | 158 ++++++++++++++++++++++++++
>   3 files changed, 168 insertions(+)
>   create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81cfc2b..9c3b47461b71 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -105,6 +105,15 @@ config UIO_NETX
>   	  To compile this driver as a module, choose M here; the module
>   	  will be called uio_netx.
>   
> +config UIO_FSL_85XX_CACHE_SRAM
> +	tristate "Freescale 85xx Cache-Sram driver"
> +	depends on FSL_SOC_BOOKE && PPC32
> +	select FSL_85XX_CACHE_SRAM
> +	help
> +	  Generic driver for accessing the Cache-Sram form user level. This
> +	  is extremely helpful for some user-space applications that require
> +	  high performance memory accesses.
> +
>   config UIO_FSL_ELBC_GPCM
>   	tristate "eLBC/GPCM driver"
>   	depends on FSL_LBC
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2a4539..be2056cffc21 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -10,4 +10,5 @@ obj-$(CONFIG_UIO_NETX)	+= uio_netx.o
>   obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>   obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>   obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
> +obj-$(CONFIG_UIO_FSL_85XX_CACHE_SRAM)	+= uio_fsl_85xx_cache_sram.o
>   obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> diff --git a/drivers/uio/uio_fsl_85xx_cache_sram.c b/drivers/uio/uio_fsl_85xx_cache_sram.c
> new file mode 100644
> index 000000000000..8701df695307
> --- /dev/null
> +++ b/drivers/uio/uio_fsl_85xx_cache_sram.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/uio_driver.h>
> +#include <linux/stringify.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <asm/fsl_85xx_cache_sram.h>
> +
> +#define DRIVER_NAME	"uio_fsl_85xx_cache_sram"
> +#define UIO_INFO_VER	"devicetree,pseudo"
> +#define UIO_NAME	"uio_cache_sram"
> +
> +static void uio_info_free_internal(struct uio_info *info)
> +{
> +	struct uio_mem *uiomem = info->mem;
> +
> +	while (uiomem < &info->mem[MAX_UIO_MAPS]) {

As suggested by Scott, maybe it would be better to use a loop with an 
index, something like

	for (i = 0; i < MAX_UIO_MAPS; i++, uiomem++) {
		struct uio_mem *uiomem = info->mem[i];

> +		if (uiomem->internal_addr) {
> +			mpc85xx_cache_sram_free(uiomem->internal_addr);
> +			kfree(uiomem->name);

Unneeded when using devm_kstrdup(), see in the probe function.

> +			memset(uiomem, 0, sizeof(*uiomem));
> +		}
> +		uiomem++;
> +	}
> +
> +	kfree(info->name);

That's a bit unbalanced. This function is handy for the things allocated 
inside the loop, but for the info->name allocated outside the loop, it 
should be released outside this function.

At the end if you use devm_kstrdup(), it will void anyway.

> +}
> +
> +static int uio_fsl_85xx_cache_sram_probe(struct platform_device *pdev)
> +{
> +	struct device_node *parent = pdev->dev.of_node;
> +	struct device_node *node = NULL;
> +	struct uio_info *info;
> +	struct uio_mem *uiomem;
> +	const char *dt_name;
> +	u32 mem_size;
> +	int ret;
> +
> +	/* alloc uio_info for one device */
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);

Maybe use devm_kzalloc(). That way, it will be automatically freed when 
the driver is released, both a normal release and on probe failure.

> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* get optional uio name */
> +	if (of_property_read_string(parent, "uio_name", &dt_name))
> +		dt_name = UIO_NAME;
> +
> +	info->name = kstrdup(dt_name, GFP_KERNEL);

Can use devm_kstrdup()

> +	if (!info->name) {
> +		ret = -ENOMEM;

If using devm_kzalloc(), you can then directly do return -ENOMEM, and 
the release will be automatic.

> +		goto err_info_free;
> +	}
> +
> +	uiomem = info->mem;
> +	for_each_child_of_node(parent, node) {
> +		void *virt;
> +		phys_addr_t phys;
> +
> +		ret = of_property_read_u32(node, "cache-mem-size", &mem_size);
> +		if (ret) {
> +			ret = -EINVAL;
> +			goto err_info_free_internal;
> +		}
> +
> +		if (mem_size == 0) {
> +			dev_err(&pdev->dev, "cache-mem-size should not be 0\n");
> +			ret = -EINVAL;
> +			goto err_info_free_internal;
> +		}
> +
> +		virt = mpc85xx_cache_sram_alloc(mem_size,
> +						&phys,

I think &phys can fit on first line.

> +						roundup_pow_of_two(mem_size));
> +		if (!virt) {
> +			/* mpc85xx_cache_sram_alloc to define the real cause */
> +			ret = -ENOMEM;
> +			goto err_info_free_internal;
> +		}
> +
> +		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->addr = phys;
> +		uiomem->size = mem_size;
> +		uiomem->name = kstrdup(node->name, GFP_KERNEL);;

Use devm_kstrdup()

> +		uiomem->internal_addr = virt;
> +		uiomem++;
> +
> +		if (uiomem >= &info->mem[MAX_UIO_MAPS]) {
> +			dev_warn(&pdev->dev, "more than %d uio-maps for device.\n",
> +				 MAX_UIO_MAPS);
> +			break;
> +		}
> +	}
> +
> +	if (uiomem == info->mem) {
> +		dev_err(&pdev->dev, "error no valid uio-map configured\n");
> +		ret = -EINVAL;
> +		goto err_info_free_internal;

Is there anything to free up if nothing has been allocated ?

> +	}
> +
> +	info->version = UIO_INFO_VER;
> +
> +	/* register uio device */
> +	if (uio_register_device(&pdev->dev, info)) {
> +		dev_err(&pdev->dev, "uio registration failed\n");
> +		ret = -ENODEV;
> +		goto err_info_free_internal;
> +	}
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	return 0;
> +err_info_free_internal:
> +	uio_info_free_internal(info);
> +err_info_free:
> +	kfree(info);

Shouldn't be needed when using devm_kzalloc().

> +	return ret;
> +}
> +
> +static int uio_fsl_85xx_cache_sram_remove(struct platform_device *pdev)
> +{
> +	struct uio_info *info = platform_get_drvdata(pdev);
> +
> +	uio_unregister_device(info);
> +
> +	uio_info_free_internal(info);
> +
> +	kfree(info);

Not needed when using dev_kzalloc()

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> +	{	.compatible = "uio,mpc85xx-cache-sram",	},
> +	{},
> +};
> +
> +static struct platform_driver uio_fsl_85xx_cache_sram = {
> +	.probe = uio_fsl_85xx_cache_sram_probe,
> +	.remove = uio_fsl_85xx_cache_sram_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table	= uio_mpc85xx_l2ctlr_of_match,
> +	},
> +};
> +
> +module_platform_driver(uio_fsl_85xx_cache_sram);
> +
> +MODULE_AUTHOR("Wang Wenhu <wenhu.wang@vivo.com>");
> +MODULE_DESCRIPTION("Freescale MPC85xx Cache-Sram UIO Platform Driver");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_LICENSE("GPL v2");
> 

Christophe
