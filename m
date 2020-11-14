Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585F32B2E80
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 17:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKNQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 11:41:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35239 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgKNQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 11:41:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id k2so13786204wrx.2;
        Sat, 14 Nov 2020 08:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SpRx3Z/j6jHk5nd0jo6lnZDJH72gLG9Ify1E26wOmjY=;
        b=DlnRZ4zs5PHjA2fm3r645TlmnBs3sK87gq6lvqOsz3ZKs+QEHDVeiAylT77R+iCeEP
         FhIjy/YJah27YYny1sNtNc6P2uuExJ2FvZWuBAzg7I9WHWA49inuA1fqL73dJyP9R0Lt
         OUHqL1N85ci3G7K0M4lGA9VEByFPa3OnOOFASP7D7PPNqc3g41Rts+Kf0E7JN7E5lmOr
         5HynHvYgAj+WkrQrHnJ7J4Rz1Ly23DMEDjaX5ul1Sr6SB2jtN3B36zNvgaD/B+AIJ0oi
         MR2FzJQ1/nbvODaISD2HLj5BqdCCNYW+95rbcnP+A1QOWjZshKxPWBQUwEV5JUEvccx3
         YgQA==
X-Gm-Message-State: AOAM532EBqlk1XFPEv0LU9KgjwPgTrY/oUiL93Kci8JUfQ7hguT+6/RF
        2uk1nO3M3kbq0Bu6e+FpHj8=
X-Google-Smtp-Source: ABdhPJyL14R2ZiuceH6wNj3z0v7yMwHY3AYKtn5uC4XwjXoTIiJeYjfR4KWRbyrAuMK4eFNIZCqWag==
X-Received: by 2002:adf:b358:: with SMTP id k24mr9375362wrd.388.1605372090946;
        Sat, 14 Nov 2020 08:41:30 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c6sm16655400wrh.74.2020.11.14.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 08:41:29 -0800 (PST)
Date:   Sat, 14 Nov 2020 17:41:28 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] soc: imx8m: change to use platform driver
Message-ID: <20201114164128.GD14989@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-4-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113110409.13546-4-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 07:04:09PM +0800, Alice Guo wrote:
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
> Old .dts files can also work.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 89 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 79 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index cc57a384d74d..af2c0dbe8291 100644
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
> +	u32 (*soc_revision)(struct device *dev, int flag);
>  };
> 
>  static u64 soc_uid;
> @@ -50,7 +52,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
>  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
>  #endif
> 
> -static u32 __init imx8mq_soc_revision(void)
> +static u32 __init imx8mq_soc_revision(struct device *dev, int flag)
>  {
>  	struct device_node *np;
>  	void __iomem *ocotp_base;
> @@ -75,9 +77,17 @@ static u32 __init imx8mq_soc_revision(void)
>  			rev = REV_B1;
>  	}
> 
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> -	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +	if (flag) {
> +		int ret = 0;
> +
> +		ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
> +		if (ret)
> +			return ret;
> +	} else {
> +		soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> +		soc_uid <<= 32;
> +		soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +	}
> 
>  	iounmap(ocotp_base);
>  	of_node_put(np);
> @@ -107,7 +117,7 @@ static void __init imx8mm_soc_uid(void)
>  	of_node_put(np);
>  }
> 
> -static u32 __init imx8mm_soc_revision(void)
> +static u32 __init imx8mm_soc_revision(struct device *dev, int flag)
>  {
>  	struct device_node *np;
>  	void __iomem *anatop_base;
> @@ -125,7 +135,15 @@ static u32 __init imx8mm_soc_revision(void)
>  	iounmap(anatop_base);
>  	of_node_put(np);
> 
> -	imx8mm_soc_uid();
> +	if (flag) {
> +		int ret = 0;
> +
> +		ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
> +		if (ret)
> +			return ret;
> +	} else {
> +		imx8mm_soc_uid();
> +	}
> 
>  	return rev;
>  }
> @@ -158,12 +176,21 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
>  	{ }
>  };
> 
> +static __maybe_unused const struct of_device_id imx8m_soc_match[] = {

Could this really be unused?

> +	{ .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
> +	{ .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
> +	{ .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
> +	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, imx8m_soc_match);

You already have "imx8_soc_match" which covers imx8m and now you add
"imx8m_soc_match" which also covers imx8m. Such naming is a pure
confusion.

> +
>  #define imx8_revision(soc_rev) \
>  	soc_rev ? \
>  	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
>  	"unknown"
> 
> -static int __init imx8_soc_init(void)
> +static int imx8_soc_init_flag(struct platform_device *pdev, int flag)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
>  	struct soc_device *soc_dev;
> @@ -182,7 +209,10 @@ static int __init imx8_soc_init(void)
>  	if (ret)
>  		goto free_soc;
> 
> -	id = of_match_node(imx8_soc_match, of_root);
> +	if (flag)
> +		id = of_match_node(imx8m_soc_match, pdev->dev.of_node);
> +	else
> +		id = of_match_node(imx8_soc_match, of_root);
>  	if (!id) {
>  		ret = -ENODEV;
>  		goto free_soc;
> @@ -192,7 +222,13 @@ static int __init imx8_soc_init(void)
>  	if (data) {
>  		soc_dev_attr->soc_id = data->name;
>  		if (data->soc_revision)
> -			soc_rev = data->soc_revision();
> +			soc_rev = data->soc_revision(&pdev->dev, flag);
> +
> +		if (flag) {
> +			ret = soc_rev;
> +			if (ret < 0)
> +				goto free_soc;
> +		}
>  	}
> 
>  	soc_dev_attr->revision = imx8_revision(soc_rev);
> @@ -230,4 +266,37 @@ static int __init imx8_soc_init(void)
>  	kfree(soc_dev_attr);
>  	return ret;
>  }
> +
> +static int __init imx8_soc_init(void)
> +{
> +	int ret = 0, flag = 0;
> +
> +	if (of_find_compatible_node(NULL, NULL, "fsl,imx8mm-soc") ||
> +	    of_find_compatible_node(NULL, NULL, "fsl,imx8mn-soc") ||
> +	    of_find_compatible_node(NULL, NULL, "fsl,imx8mp-soc") ||
> +	    of_find_compatible_node(NULL, NULL, "fsl,imx8mq-soc"))

Missing puts.

Don't duplicate the compatibles, iterate over existing structure... or
see comments below.  Maybe you could simplify it with something like
of_find_matching_node_and_match()... but check comments below.

> +		return 0;
> +
> +	ret = imx8_soc_init_flag(NULL, flag);
> +	return ret;
> +}
>  device_initcall(imx8_soc_init);

Where is the changelog? This was removed previously, now it stays...

After more thoughs, it looks you have kept it for the purpose of
supporting existing DTB, but it is not explained. Neither in the source
code (which after applying this patch looks confusing) nor in commit
message.

In case of old DTB without fsl,imx8mm-soc-like compatibles, it would be
better to still register a platform driver and create a device
(of_platform_device_create())). However still this won't solve the
problem of actually missing device node... so maybe this double entry
point is acceptable, if properly explained.

> +
> +static int imx8_soc_init_probe(struct platform_device *pdev)
> +{
> +	int ret = 0, flag = 1;
> +
> +	ret = imx8_soc_init_flag(pdev, flag);

Never name unspecified booleans like "flag". The same as string
variables should be named "string", integers should not be named
"number".

> +	return ret;
> +}
> +
> +static struct platform_driver imx8_soc_init_driver = {
> +	.probe = imx8_soc_init_probe,
> +	.driver = {
> +		.name = "imx8_soc_init",
> +		.of_match_table = of_match_ptr(imx8m_soc_match),

Can it bind without OF? Why it's a of_match_ptr()?

> +	},
> +};
> +
> +module_platform_driver(imx8_soc_init_driver);

Here and in all other places (including driver name) this is not a SoC
initialization (init) driver. You cannot initialize a SoC. This looks
like a SoC ID driver, so one name could be "imx8_soc_id".

Best regards,
Krzysztof
