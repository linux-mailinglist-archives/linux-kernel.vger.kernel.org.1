Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8272BA7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgKTKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:46:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33827 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKTKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:46:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id a15so9056574edy.1;
        Fri, 20 Nov 2020 02:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+alvQqPRpEXNo5K8hmtaWs8T2gO2NWZjynTiYpa5is=;
        b=IOghUvR4FyH7Vp+NRGDJbEQT9p0WjUdkym7NyH6avfnIgAn7nYtrIeUtv/YcfwzMDH
         JmzK4TrXs4sFg1yNQe4xW3enPNmJ50yTXepQa9d2eJ3LkVeuwyUScU9krFts49AiMMSQ
         sTGE9KNGsjOs0HoI6knj9b3+sd+ry7GPJNUqLEpl2lqypDF1ipnOMfMYcpeQF8S2EPBt
         K2lenaEYuY+TvAXbgJZcB4eVhbmbdK9RzWBwEqcHyEdsbiBAwygN8wWBhv0AYUhClnrv
         LMqNjr3BGm/bxfX6bc0mcrlAfJWm1BYaoAhA15yMjcwEHI+UTGVPR1UzAB8vlOM656Aq
         hyDA==
X-Gm-Message-State: AOAM530X9bARND/HDXDFFav36DVnvzhKmuAIoy5l1lDJwW/qwchnKMHQ
        MmKJsTuGqcXmMwwU4lmrxCQ=
X-Google-Smtp-Source: ABdhPJxQq/nv0kVNS1au9CletCJc5yc7WapghyHIAMGlmYqS0dIETtjAk82KJ7S5b0x62rQ/s9uR6g==
X-Received: by 2002:a50:a40c:: with SMTP id u12mr21996264edb.337.1605869164578;
        Fri, 20 Nov 2020 02:46:04 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k2sm973070ejp.6.2020.11.20.02.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:46:03 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:46:02 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] soc: imx8m: change to use platform driver
Message-ID: <20201120104602.GA15052@kozik-lap>
References: <20201120101112.31819-1-alice.guo@nxp.com>
 <20201120101112.31819-4-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120101112.31819-4-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 06:11:12PM +0800, Alice Guo wrote:
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
> v2: remove the subject prefix "LF-2571-4"
> v3: Keep the original way which uses device_initcall to read soc unique
>     ID, and add the other way which uses module_platform_driver and
>     nvmem API, so that it will not break the old version DTBs.
> v4: delete "__maybe_unused"
>     delete MODULE_DEVICE_TABLE(of, imx8m_soc_match);
>     rename match table, "fsl,imx8mm/n/q/p" is actually a machine
> compabile and "fsl,imx8mm/n/q/p-soc" is a compabile of soc@0
>     delete "flag" and change to determine whether the pointer is NULL
>     ues of_find_matching_node_and_match()
>     delete of_match_ptr()

Put all the patch version changelogs after --- separator, so they will
not go to the commit.

> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 85 +++++++++++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index cc57a384d74d..1b0a34e545ae 100644
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
> @@ -50,7 +52,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
>  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
>  #endif
> 
> -static u32 __init imx8mq_soc_revision(void)
> +static u32 __init imx8mq_soc_revision(struct device *dev)
>  {
>  	struct device_node *np;
>  	void __iomem *ocotp_base;
> @@ -75,9 +77,19 @@ static u32 __init imx8mq_soc_revision(void)
>  			rev = REV_B1;
>  	}
> 
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> -	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +	if (dev) {
> +		int ret = 0;
> +
> +		ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
> +		if (ret) {
> +			iounmap(ocotp_base);

What about other cleanup parts? of_node_put?

> +			return ret;
> +		}
> +	} else {
> +		soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> +		soc_uid <<= 32;
> +		soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +	}
> 
>  	iounmap(ocotp_base);
>  	of_node_put(np);
> @@ -107,7 +119,7 @@ static void __init imx8mm_soc_uid(void)
>  	of_node_put(np);
>  }
> 
> -static u32 __init imx8mm_soc_revision(void)
> +static u32 __init imx8mm_soc_revision(struct device *dev)
>  {
>  	struct device_node *np;
>  	void __iomem *anatop_base;
> @@ -125,7 +137,15 @@ static u32 __init imx8mm_soc_revision(void)
>  	iounmap(anatop_base);
>  	of_node_put(np);
> 
> -	imx8mm_soc_uid();
> +	if (dev) {
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
> @@ -150,7 +170,7 @@ static const struct imx8_soc_data imx8mp_soc_data = {
>  	.soc_revision = imx8mm_soc_revision,
>  };
> 
> -static __maybe_unused const struct of_device_id imx8_soc_match[] = {
> +static const struct of_device_id imx8_machine_match[] = {
>  	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
>  	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
>  	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
> @@ -158,12 +178,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
>  	{ }
>  };
> 
> +static const struct of_device_id imx8_soc_match[] = {
> +	{ .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
> +	{ .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
> +	{ .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
> +	{ .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
> +	{ }
> +};
> +
>  #define imx8_revision(soc_rev) \
>  	soc_rev ? \
>  	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
>  	"unknown"
> 
> -static int __init imx8_soc_init(void)
> +static int imx8_soc_info(struct platform_device *pdev)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
>  	struct soc_device *soc_dev;
> @@ -182,7 +210,10 @@ static int __init imx8_soc_init(void)
>  	if (ret)
>  		goto free_soc;
> 
> -	id = of_match_node(imx8_soc_match, of_root);
> +	if (pdev)
> +		id = of_match_node(imx8_soc_match, pdev->dev.of_node);
> +	else
> +		id = of_match_node(imx8_machine_match, of_root);
>  	if (!id) {
>  		ret = -ENODEV;
>  		goto free_soc;
> @@ -191,8 +222,16 @@ static int __init imx8_soc_init(void)
>  	data = id->data;
>  	if (data) {
>  		soc_dev_attr->soc_id = data->name;
> -		if (data->soc_revision)
> -			soc_rev = data->soc_revision();
> +		if (data->soc_revision) {
> +			if (pdev) {
> +				soc_rev = data->soc_revision(&pdev->dev);
> +				ret = soc_rev;
> +				if (ret < 0)
> +					goto free_soc;
> +			} else {
> +				soc_rev = data->soc_revision(NULL);
> +			}
> +		}
>  	}
> 
>  	soc_dev_attr->revision = imx8_revision(soc_rev);
> @@ -230,4 +269,26 @@ static int __init imx8_soc_init(void)
>  	kfree(soc_dev_attr);
>  	return ret;
>  }
> +
> +static int __init imx8_soc_init(void)
> +{
> +	int ret = 0;

Skip the initialization.

You need to document why the initcal is still there. Please write that
it is purely for backward compatibility.

Best regards,
Krzysztof
