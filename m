Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC822A7A09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgKEJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:06:35 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43287 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbgKEJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:06:33 -0500
Received: by mail-ej1-f65.google.com with SMTP id k3so1497340ejj.10;
        Thu, 05 Nov 2020 01:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lCX5AAyN3xhJT1Mr0weeEfFOOHXZuEKis1CZnrJO9rI=;
        b=gzVI+lJBp+1PYTl6FSPtPB4kdBM0bnmuuMxA5TmTBgUW5AqAiyFSgciVT1IVBgJoMZ
         p7SHTtaC7yqLIesHlMnoOCP/6YiVdstJ+ZtkPXeBBR61xKHQme02YhuuLTNJxeEzIvNW
         givIyxjCw0sLLqHsAdGQlaZK0lG8t8J2cE61L9PbcDLc7RW04qq2ByArDQcRE3SmvcaN
         8pZBIYvxWrUyQ2UfLO9NBIjSK1iHHrqHl3FkIxKqHaWbM9tqCKjrYU40jf7CnftMs4JJ
         SNhz2PIETkDSJcwZNyZURli7/XZhrbHAOsRwnyeM9fVAGROFxl7TvHmE+ZcJynV2ukyT
         VLrQ==
X-Gm-Message-State: AOAM532SYzn9rKeoIdRx7DNY7mK13h/3GW7GpA6BJOfNswkzahZvs68c
        mxrHlJ7oyV5ZSvMMKWXp+FI8XCWceYU=
X-Google-Smtp-Source: ABdhPJyS7GhTRIIR+ep4Z1RpRHO87lQULzwSQcQOBkejlGZQzAIlIBeJvP9ELE21n1RyT7cZnU4fow==
X-Received: by 2002:a17:906:7016:: with SMTP id n22mr1408325ejj.402.1604567190736;
        Thu, 05 Nov 2020 01:06:30 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h8sm498072eds.51.2020.11.05.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 01:06:29 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:06:28 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] soc: imx8m: change to use platform driver
Message-ID: <20201105090628.GA75895@kozik-lap>
References: <20201105072629.24175-1-alice.guo@nxp.com>
 <20201105072629.24175-4-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201105072629.24175-4-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 03:26:29PM +0800, Alice Guo wrote:
> Directly reading ocotp register depends on that bootloader enables ocotp
> clk, which is not always effective, so change to use nvmem API. Using
> nvmem API requires to support driver defer probe and thus change
> soc-imx8m.c to use platform driver.
> 
> The other reason is that directly reading ocotp register causes kexec
> kernel hang because the 1st kernel running will disable unused clks
> after kernel boots up, and then ocotp clk will be disabled even if
> bootloader enables it. When kexec kernel, ocotp clk needs to be enabled
> before reading ocotp registers, and nvmem API with platform driver
> supported can accomplish this.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 75 +++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index cc57a384d74d..83f3297509be 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -5,6 +5,8 @@
> 
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
> @@ -29,7 +31,7 @@
> 
>  struct imx8_soc_data {
>  	char *name;
> -	u32 (*soc_revision)(void);
> +	u32 (*soc_revision)(struct device *dev);
>  };
> 
>  static u64 soc_uid;
> @@ -50,12 +52,15 @@ static u32 imx8mq_soc_revision_from_atf(void)
>  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
>  #endif
> 
> -static u32 __init imx8mq_soc_revision(void)
> +static u32 __init imx8mm_soc_uid(struct device *dev);
> +
> +static u32 __init imx8mq_soc_revision(struct device *dev)
>  {
>  	struct device_node *np;
>  	void __iomem *ocotp_base;
>  	u32 magic;
>  	u32 rev;
> +	int ret = 0;
> 
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
>  	if (!np)
> @@ -75,9 +80,9 @@ static u32 __init imx8mq_soc_revision(void)
>  			rev = REV_B1;
>  	}
> 
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> -	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +	ret = imx8mm_soc_uid(dev);
> +	if (ret)
> +		return ret;
> 
>  	iounmap(ocotp_base);
>  	of_node_put(np);
> @@ -85,33 +90,20 @@ static u32 __init imx8mq_soc_revision(void)
>  	return rev;
>  }
> 
> -static void __init imx8mm_soc_uid(void)
> +static u32 __init imx8mm_soc_uid(struct device *dev)
>  {
> -	void __iomem *ocotp_base;
> -	struct device_node *np;
> -	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
> -		     IMX8MP_OCOTP_UID_OFFSET : 0;
> -
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
> -	if (!np)
> -		return;
> -
> -	ocotp_base = of_iomap(np, 0);
> -	WARN_ON(!ocotp_base);
> -
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
> -	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
> +	int ret = 0;
> 
> -	iounmap(ocotp_base);
> -	of_node_put(np);
> +	ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
> +	return ret;
>  }
> 
> -static u32 __init imx8mm_soc_revision(void)
> +static u32 __init imx8mm_soc_revision(struct device *dev)
>  {
>  	struct device_node *np;
>  	void __iomem *anatop_base;
>  	u32 rev;
> +	int ret;
> 
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
>  	if (!np)
> @@ -125,7 +117,9 @@ static u32 __init imx8mm_soc_revision(void)
>  	iounmap(anatop_base);
>  	of_node_put(np);
> 
> -	imx8mm_soc_uid();
> +	ret = imx8mm_soc_uid(dev);
> +	if (ret)
> +		return ret;

I think this breaks old existing DTBs. If applied on separate branch
than DTS patches, it will cause bisect regressions. Regardless of it,
all out-of-tree (customer DTBs) will start failing here as well.

Best regards,
Krzysztof


> 
>  	return rev;
>  }
> @@ -151,19 +145,20 @@ static const struct imx8_soc_data imx8mp_soc_data = {
>  };
> 
>  static __maybe_unused const struct of_device_id imx8_soc_match[] = {
> -	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
> -	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
> -	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
> -	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
> +	{ .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
> +	{ .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
> +	{ .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
> +	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, imx8_soc_match);
> 
>  #define imx8_revision(soc_rev) \
>  	soc_rev ? \
>  	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
>  	"unknown"
> 
> -static int __init imx8_soc_init(void)
> +static int imx8_soc_init_probe(struct platform_device *pdev)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
>  	struct soc_device *soc_dev;
> @@ -182,7 +177,7 @@ static int __init imx8_soc_init(void)
>  	if (ret)
>  		goto free_soc;
> 
> -	id = of_match_node(imx8_soc_match, of_root);
> +	id = of_match_node(imx8_soc_match, pdev->dev.of_node);
>  	if (!id) {
>  		ret = -ENODEV;
>  		goto free_soc;
> @@ -192,7 +187,11 @@ static int __init imx8_soc_init(void)
>  	if (data) {
>  		soc_dev_attr->soc_id = data->name;
>  		if (data->soc_revision)
> -			soc_rev = data->soc_revision();
> +			soc_rev = data->soc_revision(&pdev->dev);
> +
> +		ret = soc_rev;
> +		if (ret < 0)
> +			goto free_soc;
>  	}
> 
>  	soc_dev_attr->revision = imx8_revision(soc_rev);
> @@ -230,4 +229,14 @@ static int __init imx8_soc_init(void)
>  	kfree(soc_dev_attr);
>  	return ret;
>  }
> -device_initcall(imx8_soc_init);
> +
> +static struct platform_driver imx8_soc_init_driver = {
> +	.probe = imx8_soc_init_probe,
> +	.driver = {
> +		.name = "imx8_soc_init",
> +		.of_match_table = of_match_ptr(imx8_soc_match),
> +	},
> +};
> +
> +module_platform_driver(imx8_soc_init_driver);
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.1
> 
