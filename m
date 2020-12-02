Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF212CBBA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLBLh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:37:28 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:46957 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgLBLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:37:27 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id kQR7kDV9sN7XgkQRBkskIi; Wed, 02 Dec 2020 12:36:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1606909005; bh=lGffukfUD3d0Uu+0eSuN4b5TIi0vxMZrNdT5mrK5mmg=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=D4/Ggb/P18Ll5H09+ZHr/jpKQQ5xexULoCd5DyJNde+UY7Qlc3hp2sOR97kjzD9Qe
         8A3OPNmfQ6JpOl/31vRg2p7aZAdXsgBZO4O/sQlHH9rwZQYigCSBk6EbJeLOOhDHVc
         Coy6dSNN2QRsLerN+qmp9hUz4ZOX978YkDzulBOyoYJdSlnq5obHCKFhUBOu5759Bg
         SUD82xpg/yKaVOopngpzhs/34CtkpS+cS/BXQunWZ7nJMo0JZa/4OK3hVK9Rvq1WJo
         qfxaxAslcG88HJzhy5asmBe+qLxHKmpvC3jd9/YZa3BdBk2FV0NDAHYdcTZDHVYdt4
         6NbvNoZpgGFXA==
Subject: Re: [PATCH v2] media: coda: Convert the driver to DT-only
To:     Fabio Estevam <festevam@gmail.com>, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org
References: <20201202103552.19162-1-festevam@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <3dd8244c-abfe-bcf0-f020-9edbfb8af272@xs4all.nl>
Date:   Wed, 2 Dec 2020 12:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201202103552.19162-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGDUB/3cjCL1Re7p9Qo49RASdi1usnj/XNBQp7mx37ZMA7jdjEdFhtQYhGLsJQ0+VPKzNZg0li1Iu2mrkMZ8mYfx7WB+d5rWCqB5Mapw+sw7+koifXwL
 1wAGBHwrdl05ZSKSpy6oOoEkxVU5Bk+EwbTYDg/Cq4Oggr3rOHf6pKTESSwrYETwyaUs1x1mnQojBZJQReibFmHGN6UXjOvPjUG2gasT4X/QUG34ZnNcNGO9
 0IpcpfOF9gll5VpMFjuE8xTmMXJc2lQd9Q8iFlbthYMR9eD28CM5u3BqpcGlbZDE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 11:35, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
> by removing the unused non-DT support.

You forgot to Cc to linux-media. Please repost so it will end up
in the media patchwork!

Regards,

	Hans

> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Drop include/linux/platform_data/media/coda.h and pdata - Hans
> 
>  drivers/media/platform/coda/coda-common.c | 27 ++---------------------
>  include/linux/platform_data/media/coda.h  | 14 ------------
>  2 files changed, 2 insertions(+), 39 deletions(-)
>  delete mode 100644 include/linux/platform_data/media/coda.h
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index d30eafea701d..995e95272e51 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -25,7 +25,6 @@
>  #include <linux/slab.h>
>  #include <linux/videodev2.h>
>  #include <linux/of.h>
> -#include <linux/platform_data/media/coda.h>
>  #include <linux/ratelimit.h>
>  #include <linux/reset.h>
>  
> @@ -3102,13 +3101,6 @@ static const struct coda_devtype coda_devdata[] = {
>  	},
>  };
>  
> -static const struct platform_device_id coda_platform_ids[] = {
> -	{ .name = "coda-imx27", .driver_data = CODA_IMX27 },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(platform, coda_platform_ids);
> -
> -#ifdef CONFIG_OF
>  static const struct of_device_id coda_dt_ids[] = {
>  	{ .compatible = "fsl,imx27-vpu", .data = &coda_devdata[CODA_IMX27] },
>  	{ .compatible = "fsl,imx51-vpu", .data = &coda_devdata[CODA_IMX51] },
> @@ -3118,14 +3110,9 @@ static const struct of_device_id coda_dt_ids[] = {
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, coda_dt_ids);
> -#endif
>  
>  static int coda_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *of_id =
> -			of_match_device(of_match_ptr(coda_dt_ids), &pdev->dev);
> -	const struct platform_device_id *pdev_id;
> -	struct coda_platform_data *pdata = pdev->dev.platform_data;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct gen_pool *pool;
>  	struct coda_dev *dev;
> @@ -3135,14 +3122,7 @@ static int coda_probe(struct platform_device *pdev)
>  	if (!dev)
>  		return -ENOMEM;
>  
> -	pdev_id = of_id ? of_id->data : platform_get_device_id(pdev);
> -
> -	if (of_id)
> -		dev->devtype = of_id->data;
> -	else if (pdev_id)
> -		dev->devtype = &coda_devdata[pdev_id->driver_data];
> -	else
> -		return -EINVAL;
> +	dev->devtype = of_device_get_match_data(&pdev->dev);
>  
>  	dev->dev = &pdev->dev;
>  	dev->clk_per = devm_clk_get(&pdev->dev, "per");
> @@ -3200,10 +3180,8 @@ static int coda_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/* Get IRAM pool from device tree or platform data */
> +	/* Get IRAM pool from device tree */
>  	pool = of_gen_pool_get(np, "iram", 0);
> -	if (!pool && pdata)
> -		pool = gen_pool_get(pdata->iram_dev, NULL);
>  	if (!pool) {
>  		dev_err(&pdev->dev, "iram pool not available\n");
>  		return -ENOMEM;
> @@ -3342,7 +3320,6 @@ static struct platform_driver coda_driver = {
>  		.of_match_table = of_match_ptr(coda_dt_ids),
>  		.pm	= &coda_pm_ops,
>  	},
> -	.id_table = coda_platform_ids,
>  };
>  
>  module_platform_driver(coda_driver);
> diff --git a/include/linux/platform_data/media/coda.h b/include/linux/platform_data/media/coda.h
> deleted file mode 100644
> index 293b61b60c9d..000000000000
> --- a/include/linux/platform_data/media/coda.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (C) 2013 Philipp Zabel, Pengutronix
> - */
> -#ifndef PLATFORM_CODA_H
> -#define PLATFORM_CODA_H
> -
> -struct device;
> -
> -struct coda_platform_data {
> -	struct device *iram_dev;
> -};
> -
> -#endif
> 

