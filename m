Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA501C88BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 13:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGLq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 07:46:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50542 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgEGLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:46:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 047BkEJ6039101;
        Thu, 7 May 2020 06:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588851974;
        bh=sF4wAHusSkrbpestxLREjlXxVqemoRZLzTl02eRiUsI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WSqjti+H11RtJh6UueT5YsVfZi8JbLjUFCY+/sFYKC3zX1URZp1X13zYN86IwaFF0
         Y8g/ZhpelbSoMZGyZz3w1aLj43LlhzNQdaLP8q8Yzcoj66SyfoyxG35WzFwGaWN5tK
         tdZbqHq6Y4aruH02GxXjqkru1GGBkjYhvXMs0Xpo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 047BkENs088197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 May 2020 06:46:14 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 7 May
 2020 06:46:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 7 May 2020 06:46:13 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 047Bk8S6120420;
        Thu, 7 May 2020 06:46:10 -0500
Subject: Re: [PATCH v2 2/2] soc: ti: add k3 platforms chipid module driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <devicetree@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <20200505193417.2112-1-grygorii.strashko@ti.com>
 <20200505193417.2112-3-grygorii.strashko@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <aa46a0f5-8774-d5e4-14f6-16d50a7aa310@ti.com>
Date:   Thu, 7 May 2020 14:46:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200505193417.2112-3-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2020 22:34, Grygorii Strashko wrote:
> The Texas Instruments K3 Multicore SoC platforms have chipid module which
> is represented by CTRLMMR_xxx_JTAGID register and contains information
> about SoC id and revision.
>   Bits:
>    31-28 VARIANT Device variant
>    27-12 PARTNO  Part number
>    11-1  MFG     Indicates TI as manufacturer (0x17)
>    1             Always 1
> 
> This patch adds corresponding driver to identify the TI K3 SoC family and
> revision, and registers this information with the SoC bus. It is available
> under /sys/devices/soc0/ for user space, and can be checked, where needed,
> in Kernel using soc_device_match().
> 
> Identification is done by:
> - checking MFG to be TI ID
>   - retrieving Device variant (revision)
>   - retrieving Part number and convert it to the family
>   - retrieving machine from DT "/model"
> 
> Example J721E:
>    # cat /sys/devices/soc0/{machine,family,revision}
>    Texas Instruments K3 J721E SoC
>    J721E
>    SR1.0
> 
> Example AM65x:
>    # cat /sys/devices/soc0/{machine,family,revision}
>    Texas Instruments AM654 Base Board
>    AM65X
>    SR1.0
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   drivers/soc/ti/Kconfig      |  10 +++
>   drivers/soc/ti/Makefile     |   1 +
>   drivers/soc/ti/k3-socinfo.c | 135 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 146 insertions(+)
>   create mode 100644 drivers/soc/ti/k3-socinfo.c
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 4486e055794c..e192fb788836 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -91,6 +91,16 @@ config TI_K3_RINGACC
>   	  and a consumer. There is one RINGACC module per NAVSS on TI AM65x SoCs
>   	  If unsure, say N.
>   
> +config TI_K3_SOCINFO
> +	bool
> +	depends on ARCH_K3 || COMPILE_TEST
> +	select SOC_BUS
> +	select MFD_SYSCON
> +	help
> +	  Include support for the SoC bus socinfo for the TI K3 Multicore SoC
> +	  platforms to provide information about the SoC family and
> +	  variant to user space.
> +
>   endif # SOC_TI
>   
>   config TI_SCI_INTA_MSI_DOMAIN
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index bec827937a5f..1110e5c98685 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
>   obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
>   obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
>   obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
> +obj-$(CONFIG_TI_K3_SOCINFO)		+= k3-socinfo.o
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> new file mode 100644
> index 000000000000..4c21e099d3c7
> --- /dev/null
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI K3 SoC info driver
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +#define CTRLMMR_WKUP_JTAGID_REG		0
> +/*
> + * Bits:
> + *  31-28 VARIANT	Device variant
> + *  27-12 PARTNO	Part number
> + *  11-1  MFG		Indicates TI as manufacturer (0x17)
> + *  1			Always 1
> + */
> +#define CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT	(28)
> +#define CTRLMMR_WKUP_JTAGID_VARIANT_MASK	GENMASK(31, 28)
> +
> +#define CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT	(12)
> +#define CTRLMMR_WKUP_JTAGID_PARTNO_MASK		GENMASK(27, 12)
> +
> +#define CTRLMMR_WKUP_JTAGID_MFG_SHIFT		(1)
> +#define CTRLMMR_WKUP_JTAGID_MFG_MASK		GENMASK(11, 1)
> +
> +#define CTRLMMR_WKUP_JTAGID_MFG_TI		0x17
> +
> +static const struct k3_soc_id {
> +	unsigned int id;
> +	const char *family_name;
> +} k3_soc_ids[] = {
> +	{ 0xBB5A, "AM65X" },
> +	{ 0xBB64, "J721E" },
> +};
> +
> +static int __init partno_to_names(unsigned int partno,
> +				  struct soc_device_attribute *soc_dev_attr)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(k3_soc_ids); i++)
> +		if (partno == k3_soc_ids[i].id) {
> +			soc_dev_attr->family = k3_soc_ids[i].family_name;
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +static int __init k3_chipinfo_init(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *node;
> +	struct regmap *regmap;
> +	u32 partno_id;
> +	u32 variant;
> +	u32 jtag_id;
> +	u32 mfg;
> +	int ret;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ti,am654-chipid");
> +	if (!node)
> +		return -ENODEV;
> +
> +	regmap = device_node_to_regmap(node);
> +	of_node_put(node);
> +
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_read(regmap, CTRLMMR_WKUP_JTAGID_REG, &jtag_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	mfg = (jtag_id & CTRLMMR_WKUP_JTAGID_MFG_MASK) >>
> +	       CTRLMMR_WKUP_JTAGID_MFG_SHIFT;
> +
> +	if (mfg != CTRLMMR_WKUP_JTAGID_MFG_TI) {
> +		pr_err("Invalid MFG SoC\n");
> +		return -ENODEV;
> +	}
> +
> +	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
> +		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
> +	variant++;
> +
> +	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
> +		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);

kasprintf can fail.

-Tero

> +
> +	ret = partno_to_names(partno_id, soc_dev_attr);
> +	if (ret) {
> +		pr_err("Unknown SoC JTAGID[0x%08X]\n", jtag_id);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	node = of_find_node_by_path("/");
> +	of_property_read_string(node, "model", &soc_dev_attr->machine);
> +	of_node_put(node);
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		ret = PTR_ERR(soc_dev);
> +		goto err;
> +	}
> +
> +	pr_info("Family:%s rev:%s JTAGID[0x%08x] Detected\n",
> +		soc_dev_attr->family,
> +		soc_dev_attr->revision, jtag_id);
> +
> +	return 0;
> +
> +err:
> +	kfree(soc_dev_attr->revision);
> +	kfree(soc_dev_attr);
> +	return ret;
> +}
> +
> +subsys_initcall(k3_chipinfo_init);
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
