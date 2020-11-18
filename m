Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6B2B7559
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKREUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKREUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:20:37 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18368C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:20:37 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id n11so522580ota.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Wvxu8t2+2ioygEU2T4ArcOLVAxHUsdhIF9PdXDAJM4=;
        b=W76esqTsZ86EDM1lwch0e8uC4aT1RtvVouxGvKObeDHmB3bZMoC5oHjC2nJz9cteck
         8koiNfwuE4Z3/i5L4VnIDUfcdNiXZbW+Fr9jjzKkS1Kx+5LYisyTaMeOs3gfmR83xPBt
         mGiuQpNmNtzFg2Rm+4dtyxgp3aEI2suOJTus+WjaZ1z4n4XNxPlWrXY6pj4Yf/lK64jx
         4z8KLPyY/MdVNqTLwUaJLg4hTzTdzNuano/+1SdaiLuv+rcSyQQ5ozNgfgE/iJkGQSrM
         Si2u1p24qNr3vp49zz4qq7CydjH5Si4OSL49NNKvlLZ8lzlcUAy+tvHSdps+7yL+hhV6
         e50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Wvxu8t2+2ioygEU2T4ArcOLVAxHUsdhIF9PdXDAJM4=;
        b=IEc7NQ+v2KzLVp0U5vM28bg4IcUp8XhoJCHLGEqpp5fqGfOyKHPmx7XYlmninCP9Gf
         yVKKxfBJPL5fzwv0w2sxQ/unYFRxLnNhy0BknVlMnC6uRiunKEUpvEt8KHqA4m/O92+x
         LljLTt0egqphAcIcUtFIxBQCC8+A5Ogp4Yar/VZNb4iHIPHvZ0VDlu/0DAdqa5GY2/TN
         /cgNmRRwfWdriGn06Dc9Ia9yCtOXNZKl+AXOgg4W9+KVsP/JAjO6qS8nG8rLGgXmAjaZ
         BWKgAy5a+NRR2kaEDYYBm+UnrjxKoHLvShGkdzeUqrBZefgtuRlImmJIZcOE/AsU1wz8
         FiLw==
X-Gm-Message-State: AOAM5304gHy7Ng7MH12QFED05u9E8O6CJdtrLnWcoPNyO0V4qK2nGUYa
        IXBd4c3GM+VSzVG+W+7Y0oYimw==
X-Google-Smtp-Source: ABdhPJwqlVmYvFehmr/fzkq8uhhNTcWyQ3lNwNUQ3Bom+EBGXSfkQub4UHEpAO+oVi/uB5L0kvpjtg==
X-Received: by 2002:a9d:6847:: with SMTP id c7mr5260354oto.134.1605673236210;
        Tue, 17 Nov 2020 20:20:36 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a4sm6459055otj.29.2020.11.17.20.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 20:20:35 -0800 (PST)
Date:   Tue, 17 Nov 2020 22:20:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mtd: parsers: Add Qcom SMEM parser
Message-ID: <20201118042033.GH8532@builder.lan>
References: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org>
 <20201117174845.28684-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117174845.28684-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17 Nov 11:48 CST 2020, Manivannan Sadhasivam wrote:

> NAND based Qualcomm platforms have the partition table populated in the
> Shared Memory (SMEM). Hence, add a parser for parsing the partitions
> from it.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/mtd/parsers/Kconfig        |   8 ++
>  drivers/mtd/parsers/Makefile       |   1 +
>  drivers/mtd/parsers/qcomsmempart.c | 169 +++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 drivers/mtd/parsers/qcomsmempart.c
> 
> diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
> index e72354322f62..d90c30229052 100644
> --- a/drivers/mtd/parsers/Kconfig
> +++ b/drivers/mtd/parsers/Kconfig
> @@ -160,3 +160,11 @@ config MTD_REDBOOT_PARTS_READONLY
>  	  'FIS directory' images, enable this option.
>  
>  endif # MTD_REDBOOT_PARTS
> +
> +config MTD_QCOMSMEM_PARTS
> +	tristate "Qualcomm SMEM NAND flash partition parser"
> +	depends on MTD_NAND_QCOM || COMPILE_TEST
> +	depends on QCOM_SMEM
> +	help
> +	  This provides support for parsing partitions from Shared Memory (SMEM)
> +	  for NAND flash on Qualcomm platforms.
> diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
> index b0c5f62f9e85..50eb0b0a2210 100644
> --- a/drivers/mtd/parsers/Makefile
> +++ b/drivers/mtd/parsers/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_MTD_AFS_PARTS)		+= afs.o
>  obj-$(CONFIG_MTD_PARSER_TRX)		+= parser_trx.o
>  obj-$(CONFIG_MTD_SHARPSL_PARTS)		+= sharpslpart.o
>  obj-$(CONFIG_MTD_REDBOOT_PARTS)		+= redboot.o
> +obj-$(CONFIG_MTD_QCOMSMEM_PARTS)	+= qcomsmempart.o
> diff --git a/drivers/mtd/parsers/qcomsmempart.c b/drivers/mtd/parsers/qcomsmempart.c
> new file mode 100644
> index 000000000000..d8c2a3fa4dfe
> --- /dev/null
> +++ b/drivers/mtd/parsers/qcomsmempart.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm SMEM NAND flash partition parser
> + *
> + * Copyright (C) 2020, Linaro Ltd.
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/smem.h>
> +
> +#define SMEM_AARM_PARTITION_TABLE	9
> +#define SMEM_APPS			0
> +
> +#define SMEM_FLASH_PART_MAGIC1		0x55ee73aa
> +#define SMEM_FLASH_PART_MAGIC2		0xe35ebddb
> +#define SMEM_FLASH_PTABLE_V3		3
> +#define SMEM_FLASH_PTABLE_V4		4
> +#define SMEM_FLASH_PTABLE_MAX_PARTS_V3	16
> +#define SMEM_FLASH_PTABLE_MAX_PARTS_V4	48
> +#define SMEM_FLASH_PTABLE_HDR_LEN	(4 * sizeof(u32))
> +#define SMEM_FLASH_PTABLE_NAME_SIZE	16
> +
> +/**
> + * struct smem_flash_pentry - SMEM Flash partition entry
> + * @name: Name of the partition
> + * @offset: Offset in blocks
> + * @length: Length of the partition in blocks
> + * @attr: Flags for this partition
> + */
> +struct smem_flash_pentry {
> +	char name[SMEM_FLASH_PTABLE_NAME_SIZE];
> +	u32 offset;

It would be nice if you noted that these are little endian (using
__le32) and used le32_to_cpu() below.


Apart from that I think this looks really good.

> +	u32 length;
> +	u8 attr;
> +} __packed __aligned(4);
> +
> +/**
> + * struct smem_flash_ptable - SMEM Flash partition table
> + * @magic1: Partition table Magic 1
> + * @magic2: Partition table Magic 2
> + * @version: Partition table version
> + * @numparts: Number of partitions in this ptable
> + * @pentry: Flash partition entries belonging to this ptable
> + */
> +struct smem_flash_ptable {
> +	u32 magic1;
> +	u32 magic2;
> +	u32 version;
> +	u32 numparts;
> +	struct smem_flash_pentry pentry[SMEM_FLASH_PTABLE_MAX_PARTS_V4];
> +} __packed __aligned(4);
> +
> +static int parse_qcomsmem_part(struct mtd_info *mtd,
> +			       const struct mtd_partition **pparts,
> +			       struct mtd_part_parser_data *data)
> +{
> +	struct smem_flash_pentry *pentry;
> +	struct smem_flash_ptable *ptable;
> +	size_t len = SMEM_FLASH_PTABLE_HDR_LEN;
> +	struct mtd_partition *parts;
> +	char *name, *c;
> +	int ret, i;
> +
> +	pr_debug("Parsing partition table info from SMEM\n");
> +	ptable = qcom_smem_get(SMEM_APPS, SMEM_AARM_PARTITION_TABLE, &len);
> +	if (IS_ERR(ptable)) {
> +		pr_err("Error reading partition table header\n");
> +		return PTR_ERR(ptable);
> +	}
> +
> +	/* Verify ptable magic */
> +	if (ptable->magic1 != SMEM_FLASH_PART_MAGIC1 ||
> +	    ptable->magic2 != SMEM_FLASH_PART_MAGIC2) {
> +		pr_err("Partition table magic verification failed\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Ensure that # of partitions is less than the max we have allocated */
> +	if (ptable->numparts > SMEM_FLASH_PTABLE_MAX_PARTS_V4) {
> +		pr_err("Partition numbers exceed the max limit\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Find out length of partition data based on table version */
> +	if (ptable->version <= SMEM_FLASH_PTABLE_V3) {
> +		len = SMEM_FLASH_PTABLE_HDR_LEN + SMEM_FLASH_PTABLE_MAX_PARTS_V3 *
> +			sizeof(struct smem_flash_pentry);
> +	} else if (ptable->version == SMEM_FLASH_PTABLE_V4) {
> +		len = SMEM_FLASH_PTABLE_HDR_LEN + SMEM_FLASH_PTABLE_MAX_PARTS_V4 *
> +			sizeof(struct smem_flash_pentry);
> +	} else {
> +		pr_err("Unknown ptable version (%d)", ptable->version);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Now that the partition table header has been parsed, verified
> +	 * and the length of the partition table calculated, read the
> +	 * complete partition table
> +	 */
> +	ptable = qcom_smem_get(SMEM_APPS, SMEM_AARM_PARTITION_TABLE, &len);
> +	if (IS_ERR_OR_NULL(ptable)) {
> +		pr_err("Error reading partition table\n");
> +		return PTR_ERR(ptable);
> +	}
> +
> +	parts = kcalloc(ptable->numparts, sizeof(*parts), GFP_KERNEL);
> +	if (!parts)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ptable->numparts; i++) {
> +		pentry = &ptable->pentry[i];
> +		if (pentry->name[0] == '\0')
> +			continue;
> +
> +		name = kstrdup(pentry->name, GFP_KERNEL);
> +		if (!name) {
> +			ret = -ENOMEM;
> +			goto out_free_parts;
> +		}
> +
> +		/* Convert name to lower case */
> +		for (c = name; *c != '\0'; c++)
> +			*c = tolower(*c);
> +
> +		parts[i].name = name;
> +		parts[i].offset = pentry->offset * mtd->erasesize;
> +		parts[i].mask_flags = pentry->attr;
> +		parts[i].size = pentry->length * mtd->erasesize;
> +		pr_debug("%d: %s offs=0x%08x size=0x%08x attr:0x%08x\n",
> +			 i, pentry->name, pentry->offset, pentry->length,
> +			 pentry->attr);
> +	}
> +
> +	pr_debug("SMEM partition table found: ver: %d len: %d\n",
> +		 ptable->version, ptable->numparts);
> +	*pparts = parts;
> +
> +	return i;

Had to check a few times, but afaict this is just ptable->numparts in
disguise... So how about just writing that instead?

Regards,
Bjorn

> +
> +out_free_parts:
> +	while (--i >= 0)
> +		kfree(parts[i].name);
> +	kfree(parts);
> +	*pparts = NULL;
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id qcomsmem_of_match_table[] = {
> +	{ .compatible = "qcom,smem-part" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, qcomsmem_of_match_table);
> +
> +static struct mtd_part_parser mtd_parser_qcomsmem = {
> +	.parse_fn = parse_qcomsmem_part,
> +	.name = "qcomsmem",
> +	.of_match_table = qcomsmem_of_match_table,
> +};
> +module_mtd_part_parser(mtd_parser_qcomsmem);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm SMEM NAND flash partition parser");
> -- 
> 2.17.1
> 
