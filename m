Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07070267F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgIMNMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 09:12:31 -0400
Received: from foss.arm.com ([217.140.110.172]:54422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgIMNMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 09:12:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E573106F;
        Sun, 13 Sep 2020 06:12:29 -0700 (PDT)
Received: from [192.168.0.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93AB43F68F;
        Sun, 13 Sep 2020 06:12:25 -0700 (PDT)
Subject: Re: [PATCH v10 09/24] coresight: etm3x: allow etm3x to be built as a
 module
To:     tingwei@codeaurora.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org
Cc:     kim.phillips@arm.com, gregkh@linuxfoundation.org,
        leo.yan@linaro.org, rdunlap@infradead.org, linux@armlinux.org.uk,
        ykaukab@suse.de, tsoni@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, jinlmao@codeaurora.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-10-tingwei@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0c2abd02-4fe6-5eaa-e9d3-41811f062ac1@arm.com>
Date:   Sun, 13 Sep 2020 14:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200821034445.967-10-tingwei@codeaurora.org>
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
> Allow to build coresight-etm3x as a module, for ease of development.
> 
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>    be called coresight-etm3x by the Makefile
> - add an etm_remove function, for module unload
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>


> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> similarity index 97%
> rename from drivers/hwtracing/coresight/coresight-etm3x.c
> rename to drivers/hwtracing/coresight/coresight-etm3x-core.c
> index bf22dcfd3327..ba9c86497acb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -895,6 +895,23 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>   	return ret;
>   }
>   
> +static int __exit etm_remove(struct amba_device *adev)
> +{
> +	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	etm_perf_symlink(drvdata->csdev, false);
> +
> +	if (--etm_count == 0) {
> +		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
> +		if (hp_online)
> +			cpuhp_remove_state_nocalls(hp_online);
> +	}
> +
> +	coresight_unregister(drvdata->csdev);
> +
> +	return 0;
> +}
> +

Don't we need to fix the races like we did for ETMv4 ?

Suzuki
