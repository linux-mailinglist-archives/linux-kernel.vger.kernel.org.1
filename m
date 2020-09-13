Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4802267FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMNUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 09:20:20 -0400
Received: from foss.arm.com ([217.140.110.172]:54540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgIMNUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 09:20:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A40A106F;
        Sun, 13 Sep 2020 06:20:16 -0700 (PDT)
Received: from [192.168.0.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22523F68F;
        Sun, 13 Sep 2020 06:20:12 -0700 (PDT)
Subject: Re: [PATCH v10 14/24] coresight: allow funnel driver to be built as
 module
To:     tingwei@codeaurora.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org
Cc:     kim.phillips@arm.com, gregkh@linuxfoundation.org,
        leo.yan@linaro.org, rdunlap@infradead.org, linux@armlinux.org.uk,
        ykaukab@suse.de, tsoni@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, jinlmao@codeaurora.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-15-tingwei@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3d4bf829-abca-3f5f-fa2f-282305a9dc7a@arm.com>
Date:   Sun, 13 Sep 2020 14:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200821034445.967-15-tingwei@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2020 04:44 AM, Tingwei Zhang wrote:
> From: Kim Phillips <kim.phillips@arm.com>
> 
> Allow to build coresight-funnel as module, for ease of development.
> 
> - combine static and dynamic funnel init into single
>    module_init/exit call
> - add funnel_remove functions, for module unload
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Co-developed-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-funnel.c    | 64 ++++++++++++++++++-
>   1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 900690a9f7f0..07bc20391fac 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -274,6 +274,15 @@ static int funnel_probe(struct device *dev, struct resource *res)
>   	return ret;
>   }
>   
> +static int __exit funnel_remove(struct device *dev)
> +{
> +	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_PM
>   static int funnel_runtime_suspend(struct device *dev)
>   {
> @@ -319,20 +328,32 @@ static int static_funnel_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static int __exit static_funnel_remove(struct platform_device *pdev)
> +{
> +	funnel_remove(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
>   static const struct of_device_id static_funnel_match[] = {
>   	{.compatible = "arm,coresight-static-funnel"},
>   	{}
>   };
>   
> +MODULE_DEVICE_TABLE(of, static_funnel_match);
> +
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id static_funnel_ids[] = {
>   	{"ARMHC9FE", 0},
>   	{},
>   };
> +
> +MODULE_DEVICE_TABLE(acpi, static_funnel_ids);
>   #endif
>   
>   static struct platform_driver static_funnel_driver = {
>   	.probe          = static_funnel_probe,
> +	.remove          = static_funnel_remove,
>   	.driver         = {
>   		.name   = "coresight-static-funnel",
>   		.of_match_table = static_funnel_match,

Sorry missed this. Please set the owner field here. With that :

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
