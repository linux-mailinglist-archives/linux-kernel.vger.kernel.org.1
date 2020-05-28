Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF41E6215
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390342AbgE1NXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:23:10 -0400
Received: from foss.arm.com ([217.140.110.172]:52640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390252AbgE1NW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:22:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E16D0D6E;
        Thu, 28 May 2020 06:22:58 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 581A63F52E;
        Thu, 28 May 2020 06:22:57 -0700 (PDT)
Subject: Re: [PATCH 08/15] drm/panfrost: move devfreq_init()/fini() in device
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200510165538.19720-1-peron.clem@gmail.com>
 <20200510165538.19720-9-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3ca4dd51-d868-0d6a-d4ca-37af572190bd@arm.com>
Date:   Thu, 28 May 2020 14:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-9-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Later we will introduce devfreq probing regulator if they
> are present. As regulator should be probe only one time we
> need to get this logic in the device_init().
> 
> panfrost_device is already taking care of devfreq_resume()
> and devfreq_suspend(), so it's not totally illogic to move
> the devfreq_init() and devfreq_fini() here.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++--------
>   drivers/gpu/drm/panfrost/panfrost_drv.c    | 15 ++-------
>   2 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 8136babd3ba9..f480127205d6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -212,59 +212,67 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>   		return err;
>   	}
>   
> +	err = panfrost_devfreq_init(pfdev);
> +	if (err) {
> +		dev_err(pfdev->dev, "devfreq init failed %d\n", err);
> +		goto err_out0;
> +	}
> +
>   	err = panfrost_regulator_init(pfdev);
>   	if (err) {
>   		dev_err(pfdev->dev, "regulator init failed %d\n", err);
> -		goto err_out0;
> +		goto err_out1;

NIT: Rather than just renumbering these can we give them sensible names 
so we don't have this sort of refactoring in future?

>   	}
>   
>   	err = panfrost_reset_init(pfdev);
>   	if (err) {
>   		dev_err(pfdev->dev, "reset init failed %d\n", err);
> -		goto err_out1;
> +		goto err_out2;
>   	}
>   
>   	err = panfrost_pm_domain_init(pfdev);
>   	if (err)
> -		goto err_out2;
> +		goto err_out3;
>   
>   	res = platform_get_resource(pfdev->pdev, IORESOURCE_MEM, 0);
>   	pfdev->iomem = devm_ioremap_resource(pfdev->dev, res);
>   	if (IS_ERR(pfdev->iomem)) {
>   		dev_err(pfdev->dev, "failed to ioremap iomem\n");
>   		err = PTR_ERR(pfdev->iomem);
> -		goto err_out3;
> +		goto err_out4;
>   	}
>   
>   	err = panfrost_gpu_init(pfdev);
>   	if (err)
> -		goto err_out3;
> +		goto err_out4;
>   
>   	err = panfrost_mmu_init(pfdev);
>   	if (err)
> -		goto err_out4;
> +		goto err_out5;
>   
>   	err = panfrost_job_init(pfdev);
>   	if (err)
> -		goto err_out5;
> +		goto err_out6;
>   
>   	err = panfrost_perfcnt_init(pfdev);
>   	if (err)
> -		goto err_out6;
> +		goto err_out7;
>   
>   	return 0;
> -err_out6:
> +err_out7:
>   	panfrost_job_fini(pfdev);
> -err_out5:
> +err_out6:
>   	panfrost_mmu_fini(pfdev);
> -err_out4:
> +err_out5:
>   	panfrost_gpu_fini(pfdev);
> -err_out3:
> +err_out4:
>   	panfrost_pm_domain_fini(pfdev);
> -err_out2:
> +err_out3:
>   	panfrost_reset_fini(pfdev);
> -err_out1:
> +err_out2:
>   	panfrost_regulator_fini(pfdev);
> +err_out1:
> +	panfrost_devfreq_fini(pfdev);
>   err_out0:
>   	panfrost_clk_fini(pfdev);
>   	return err;
> @@ -278,6 +286,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
>   	panfrost_gpu_fini(pfdev);
>   	panfrost_pm_domain_fini(pfdev);
>   	panfrost_reset_fini(pfdev);
> +	panfrost_devfreq_fini(pfdev);
>   	panfrost_regulator_fini(pfdev);
>   	panfrost_clk_fini(pfdev);
>   }
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 882fecc33fdb..4dda68689015 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -14,7 +14,6 @@
>   #include <drm/drm_utils.h>
>   
>   #include "panfrost_device.h"
> -#include "panfrost_devfreq.h"
>   #include "panfrost_gem.h"
>   #include "panfrost_mmu.h"
>   #include "panfrost_job.h"
> @@ -606,13 +605,6 @@ static int panfrost_probe(struct platform_device *pdev)
>   		goto err_out0;
>   	}
>   
> -	err = panfrost_devfreq_init(pfdev);
> -	if (err) {
> -		if (err != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Fatal error during devfreq init\n");

You seem to have lost the check for EPROBE_DEFER during the move.

> -		goto err_out1;
> -	}
> -
>   	pm_runtime_set_active(pfdev->dev);
>   	pm_runtime_mark_last_busy(pfdev->dev);
>   	pm_runtime_enable(pfdev->dev);
> @@ -625,16 +617,14 @@ static int panfrost_probe(struct platform_device *pdev)
>   	 */
>   	err = drm_dev_register(ddev, 0);
>   	if (err < 0)
> -		goto err_out2;
> +		goto err_out1;
>   
>   	panfrost_gem_shrinker_init(ddev);
>   
>   	return 0;
>   
> -err_out2:
> -	pm_runtime_disable(pfdev->dev);
> -	panfrost_devfreq_fini(pfdev);
>   err_out1:
> +	pm_runtime_disable(pfdev->dev);
>   	panfrost_device_fini(pfdev);
>   err_out0:
>   	drm_dev_put(ddev);
> @@ -650,7 +640,6 @@ static int panfrost_remove(struct platform_device *pdev)
>   	panfrost_gem_shrinker_cleanup(ddev);
>   
>   	pm_runtime_get_sync(pfdev->dev);
> -	panfrost_devfreq_fini(pfdev);
>   	panfrost_device_fini(pfdev);
>   	pm_runtime_put_sync_suspend(pfdev->dev);
>   	pm_runtime_disable(pfdev->dev);
> 

