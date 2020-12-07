Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7852D091C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgLGCJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:09:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9122 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGCJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:09:04 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cq6CV6t3mz15Tmr;
        Mon,  7 Dec 2020 10:07:50 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Dec 2020
 10:08:14 +0800
Subject: Re: [PATCH v5] coresight: etm4x: Modify core-commit of cpu to avoid
 the overflow of HiSilicon ETM
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1606397670-15657-1-git-send-email-liuqi115@huawei.com>
 <20201204185551.GB1424711@xps15>
CC:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <448eb009-da3e-b918-984d-cf563a64f31d@huawei.com>
Date:   Mon, 7 Dec 2020 10:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201204185551.GB1424711@xps15>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 2020/12/5 2:55, Mathieu Poirier wrote:
> On Thu, Nov 26, 2020 at 09:34:30PM +0800, Qi Liu wrote:
>> The ETM device can't keep up with the core pipeline when cpu core
>> is at full speed. This may cause overflow within core and its ETM.
>> This is a common phenomenon on ETM devices.
>>
>> On HiSilicon Hip08 platform, a specific feature is added to set
>> core pipeline. So commit rate can be reduced manually to avoid ETM
>> overflow.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>> Change since v1:
>> - add CONFIG_ETM4X_IMPDEF_FEATURE and CONFIG_ETM4X_IMPDEF_HISILICON
>>   to keep specific feature off platforms which don't use it.
>> Change since v2:
>> - remove some unused variable.
>> Change since v3:
>> - use read/write_sysreg_s() to access register.
>> Change since v4:
>> - rename the call back function to a more generic name, and fix some
>>   compile warnings.
>>
>>  drivers/hwtracing/coresight/Kconfig                |  9 +++
>>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 88 ++++++++++++++++++++++
>>  drivers/hwtracing/coresight/coresight-etm4x.h      |  8 ++
>>  3 files changed, 105 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index c119824..1cc3601 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -110,6 +110,15 @@ config CORESIGHT_SOURCE_ETM4X
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called coresight-etm4x.
>>
>> +config ETM4X_IMPDEF_FEATURE
>> +	bool "Control overflow impdef support in CoreSight ETM 4.x driver "
>> +	depends on CORESIGHT_SOURCE_ETM4X
>> +	help
>> +	  This control provides overflow implement define for CoreSight
>> +	  ETM 4.x tracer module which could not reduce commit race
>> +	  automatically, and could avoid overflow within ETM tracer module
>> +	  and its cpu core.
>> +
>>  config CORESIGHT_STM
>>  	tristate "CoreSight System Trace Macrocell driver"
>>  	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index abd706b..fcee27a 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -3,6 +3,7 @@
>>   * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>   */
>>
>> +#include <linux/bitops.h>
>>  #include <linux/kernel.h>
>>  #include <linux/moduleparam.h>
>>  #include <linux/init.h>
>> @@ -28,7 +29,9 @@
>>  #include <linux/perf_event.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/property.h>
>> +
>>  #include <asm/sections.h>
>> +#include <asm/sysreg.h>
>>  #include <asm/local.h>
>>  #include <asm/virt.h>
>>
>> @@ -103,6 +106,87 @@ struct etm4_enable_arg {
>>  	int rc;
>>  };
>>
>> +#ifdef CONFIG_ETM4X_IMPDEF_FEATURE
>> +
>> +#define HISI_HIP08_AMBA_ID		0x000b6d01
>> +#define ETM4_AMBA_MASK			0xfffff
>> +#define HISI_HIP08_CORE_COMMIT_CLEAR	0x3000
> 
> Here bit 12 and 13 are cleared but in etm4_hisi_config_core_commit() only bit 12
> is set - is this intentional?  What is bit 13 for? 
> 
bit 12 and 13 are used together to set core-commit, 2'b00 means cpu is at full speed,
2'b01, 2'b10, 2'b11 means reduce the speed of cpu pipeline, and 2'b01 means speed is
reduced to minimum value. So bit 12 and 13 should be cleared together in
etm4_hisi_config_core_commit().

Qi

>> +#define HISI_HIP08_CORE_COMMIT_SHIFT	12
>> +#define HISI_HIP08_CORE_COMMIT_REG	sys_reg(3, 1, 15, 2, 5)
>> +
>> +struct etm4_arch_features {
>> +	void (*arch_callback)(bool enable);
>> +};
>> +
>> +static bool etm4_hisi_match_pid(unsigned int id)
>> +{
>> +	return (id & ETM4_AMBA_MASK) == HISI_HIP08_AMBA_ID;
>> +}
>> +
>> +static void etm4_hisi_config_core_commit(bool enable)
>> +{
>> +	u64 val;
>> +
>> +	val = read_sysreg_s(HISI_HIP08_CORE_COMMIT_REG);
>> +	val &= ~HISI_HIP08_CORE_COMMIT_CLEAR;
>> +	val |= enable << HISI_HIP08_CORE_COMMIT_SHIFT;
>> +	write_sysreg_s(val, HISI_HIP08_CORE_COMMIT_REG);
>> +}
>> +
>> +static struct etm4_arch_features etm4_features[] = {
>> +	[ETM4_IMPDEF_HISI_CORE_COMMIT] = {
>> +		.arch_callback = etm4_hisi_config_core_commit,
>> +	},
>> +	{},
>> +};
>> +
>> +static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
>> +{
>> +	struct etm4_arch_features *ftr;
>> +	int bit;
>> +
>> +	for_each_set_bit(bit, drvdata->arch_features, ETM4_IMPDEF_FEATURE_MAX) {
>> +		ftr = &etm4_features[bit];
>> +
>> +		if (ftr->arch_callback)
>> +			ftr->arch_callback(true);
>> +	}
>> +}
>> +
>> +static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
>> +{
>> +	struct etm4_arch_features *ftr;
>> +	int bit;
>> +
>> +	for_each_set_bit(bit, drvdata->arch_features, ETM4_IMPDEF_FEATURE_MAX) {
>> +		ftr = &etm4_features[bit];
>> +
>> +		if (ftr->arch_callback)
>> +			ftr->arch_callback(false);
>> +	}
>> +}
>> +
>> +static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
>> +				      unsigned int id)
>> +{
>> +	if (etm4_hisi_match_pid(id))
>> +		set_bit(ETM4_IMPDEF_HISI_CORE_COMMIT, drvdata->arch_features);
>> +}
>> +#else
>> +static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
>> +{
>> +}
>> +
>> +static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
>> +{
>> +}
>> +
>> +static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
>> +				     unsigned int id)
>> +{
>> +}
>> +#endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
>> +
>>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>  {
>>  	int i, rc;
>> @@ -110,6 +194,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>  	struct device *etm_dev = &drvdata->csdev->dev;
>>
>>  	CS_UNLOCK(drvdata->base);
>> +	etm4_enable_arch_specific(drvdata);
>>
>>  	etm4_os_unlock(drvdata);
>>
>> @@ -476,6 +561,7 @@ static void etm4_disable_hw(void *info)
>>  	int i;
>>
>>  	CS_UNLOCK(drvdata->base);
>> +	etm4_disable_arch_specific(drvdata);
>>
>>  	if (!drvdata->skip_power_up) {
>>  		/* power can be removed from the trace unit now */
>> @@ -1547,6 +1633,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>>  		drvdata->boot_enable = true;
>>  	}
>>
>> +	etm4_check_arch_features(drvdata, id->id);
>> +
>>  	return 0;
>>  }
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index eefc737..3dd3e06 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -8,6 +8,7 @@
>>
>>  #include <asm/local.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/types.h>
>>  #include "coresight-priv.h"
>>
>>  /*
>> @@ -203,6 +204,11 @@
>>  /* Interpretation of resource numbers change at ETM v4.3 architecture */
>>  #define ETM4X_ARCH_4V3	0x43
>>
>> +enum etm_impdef_type {
>> +	ETM4_IMPDEF_HISI_CORE_COMMIT,
>> +	ETM4_IMPDEF_FEATURE_MAX,
>> +};
>> +
>>  /**
>>   * struct etmv4_config - configuration information related to an ETMv4
>>   * @mode:	Controls various modes supported by this ETM.
>> @@ -415,6 +421,7 @@ struct etmv4_save_state {
>>   * @state_needs_restore: True when there is context to restore after PM exit
>>   * @skip_power_up: Indicates if an implementation can skip powering up
>>   *		   the trace unit.
>> + * @arch_features: Bitmap of arch features of etmv4 devices.
>>   */
>>  struct etmv4_drvdata {
>>  	void __iomem			*base;
>> @@ -463,6 +470,7 @@ struct etmv4_drvdata {
>>  	struct etmv4_save_state		*save_state;
>>  	bool				state_needs_restore;
>>  	bool				skip_power_up;
>> +	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>>  };
>>
>>  /* Address comparator access types */
>> --
>> 2.8.1
>>
> 
> .
> 

