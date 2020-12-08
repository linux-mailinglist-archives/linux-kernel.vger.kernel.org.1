Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0B2D31EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgLHSQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:16:27 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158BC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:15:41 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so12905868pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BYiuJd/S0sGcvRUfqU0BKz1RjNggo50l+V+ub6i5qfM=;
        b=bUbcHC3bGnqWwFfr4hFlr/tTJ7utvXoJpmQbXFyA5iL/yQApe0suAOqvTUG3owLG4n
         T2lZu7cJJTGxZ1kh6T9KWlAawgdqEAzuzB1vvMQdQNEANMUkIdRa7BtyGdXGQr5nFbj1
         VVwFWoJDtWJjDSb/61wkQI9mRFRGmqX2l5atgCE6k+YD7mCam0qrXqCGAYIgu9uI9sdk
         ICwPJBK3dNfQMv2f433ILuQ2pLwt9TUOTPfOMX9QZFFro9aSEgKE3Sdvgkb7UUdoPrWA
         eARqvgHpNfhwnfWhMuaCIyY0HLN37ey2syiKvT4qxTEx6tUwKmnsPpty+q07W17+sj0b
         RjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BYiuJd/S0sGcvRUfqU0BKz1RjNggo50l+V+ub6i5qfM=;
        b=mk7UgXBrFIZMSJEeV+Kuzs22tXulrfy+mveuiZaNv9ZTTQp1OzX+Yl1IlghBprjyY3
         1ub+aZdlEOwNLYYnECuF8J1Qru37oMrswBaOg5dZayh8D3hFuHv69DQgsQ0PJKVq+Xre
         IBN8Ic3HYUe1CjiGdeNTusdDS+whGMCif+ZkT2aDq3XLOXPKGlyuqohuI9Fss7rz5fQ+
         xHEKvQp9gJjiqx3wn/aEduPDGJTT6flDHesyBD6DBsJ8ryIik5rz/D3sKSTUxatHOoxZ
         ZzYlfOxMgsQicdFwPiSh94kJZhKXjCCOM3nbQ26yNgjb9NWb3dGVjM3QeJuBAef/rQ0v
         TiTA==
X-Gm-Message-State: AOAM532Km0oI6qvXwruR1Rkr+u1wwk5jEVtqRIyhJAIOc2EWyyHIO8O0
        07fyDeJL/251blJdKe5d9bmfE+jQFk1IBG3P
X-Google-Smtp-Source: ABdhPJwMdUr+JwoHBrgG6bEgiEjALZ+8a+CNwYTvkMMFy0VyxDnEMUqb+wSV6JkP24lvS/ctsDvdvw==
X-Received: by 2002:a63:e5a:: with SMTP id 26mr23527198pgo.450.1607451340309;
        Tue, 08 Dec 2020 10:15:40 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 24sm18989180pgy.45.2020.12.08.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:15:39 -0800 (PST)
Date:   Tue, 8 Dec 2020 11:15:37 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
Subject: Re: [PATCH v6] coresight: etm4x: Modify core-commit of cpu to avoid
 the overflow of HiSilicon ETM
Message-ID: <20201208181537.GA1544290@xps15>
References: <1607411960-54363-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607411960-54363-1-git-send-email-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:19:20PM +0800, Qi Liu wrote:
> The ETM device can't keep up with the core pipeline when cpu core
> is at full speed. This may cause overflow within core and its ETM.
> This is a common phenomenon on ETM devices.
> 
> On HiSilicon Hip08 platform, a specific feature is added to set
> core pipeline. So commit rate can be reduced manually to avoid ETM
> overflow.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>

I have applied your patch after making modifications to the title and the
Kconfig description.

Thanks,
Mathieu

> ---
> Change since v1:
> - add CONFIG_ETM4X_IMPDEF_FEATURE and CONFIG_ETM4X_IMPDEF_HISILICON
>   to keep specific feature off platforms which don't use it.
> Change since v2:
> - remove some unused variable.
> Change since v3:
> - use read/write_sysreg_s() to access register.
> Change since v4:
> - rename the call back function to a more generic name, and fix some
>   compile warnings.
> Change since v5:
> - add function comments about HISI_HIP08_CORE_COMMIT_REG, and use
>   explicitly masked values when update register.
> 
>  drivers/hwtracing/coresight/Kconfig                |  9 ++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 98 ++++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-etm4x.h      |  8 ++
>  3 files changed, 115 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index c119824..1cc3601 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -110,6 +110,15 @@ config CORESIGHT_SOURCE_ETM4X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called coresight-etm4x.
> 
> +config ETM4X_IMPDEF_FEATURE
> +	bool "Control overflow impdef support in CoreSight ETM 4.x driver "
> +	depends on CORESIGHT_SOURCE_ETM4X
> +	help
> +	  This control provides overflow implement define for CoreSight
> +	  ETM 4.x tracer module which could not reduce commit race
> +	  automatically, and could avoid overflow within ETM tracer module
> +	  and its cpu core.
> +
>  config CORESIGHT_STM
>  	tristate "CoreSight System Trace Macrocell driver"
>  	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index abd706b..0cbc92a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>   */
> 
> +#include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
>  #include <linux/init.h>
> @@ -28,7 +29,9 @@
>  #include <linux/perf_event.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +
>  #include <asm/sections.h>
> +#include <asm/sysreg.h>
>  #include <asm/local.h>
>  #include <asm/virt.h>
> 
> @@ -103,6 +106,97 @@ struct etm4_enable_arg {
>  	int rc;
>  };
> 
> +#ifdef CONFIG_ETM4X_IMPDEF_FEATURE
> +
> +#define HISI_HIP08_AMBA_ID		0x000b6d01
> +#define ETM4_AMBA_MASK			0xfffff
> +#define HISI_HIP08_CORE_COMMIT_MASK	0x3000
> +#define HISI_HIP08_CORE_COMMIT_SHIFT	12
> +#define HISI_HIP08_CORE_COMMIT_FULL	0b00
> +#define HISI_HIP08_CORE_COMMIT_LVL_1	0b01
> +#define HISI_HIP08_CORE_COMMIT_REG	sys_reg(3, 1, 15, 2, 5)
> +
> +struct etm4_arch_features {
> +	void (*arch_callback)(bool enable);
> +};
> +
> +static bool etm4_hisi_match_pid(unsigned int id)
> +{
> +	return (id & ETM4_AMBA_MASK) == HISI_HIP08_AMBA_ID;
> +}
> +
> +static void etm4_hisi_config_core_commit(bool enable)
> +{
> +	u8 commit = enable ? HISI_HIP08_CORE_COMMIT_LVL_1 :
> +		    HISI_HIP08_CORE_COMMIT_FULL;
> +	u64 val;
> +
> +	/*
> +	 * bit 12 and 13 of HISI_HIP08_CORE_COMMIT_REG are used together
> +	 * to set core-commit, 2'b00 means cpu is at full speed, 2'b01,
> +	 * 2'b10, 2'b11 mean reduce pipeline speed, and 2'b01 means level-1
> +	 * speed(minimun value). So bit 12 and 13 should be cleared together.
> +	 */
> +	val = read_sysreg_s(HISI_HIP08_CORE_COMMIT_REG);
> +	val &= ~HISI_HIP08_CORE_COMMIT_MASK;
> +	val |= commit << HISI_HIP08_CORE_COMMIT_SHIFT;
> +	write_sysreg_s(val, HISI_HIP08_CORE_COMMIT_REG);
> +}
> +
> +static struct etm4_arch_features etm4_features[] = {
> +	[ETM4_IMPDEF_HISI_CORE_COMMIT] = {
> +		.arch_callback = etm4_hisi_config_core_commit,
> +	},
> +	{},
> +};
> +
> +static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
> +{
> +	struct etm4_arch_features *ftr;
> +	int bit;
> +
> +	for_each_set_bit(bit, drvdata->arch_features, ETM4_IMPDEF_FEATURE_MAX) {
> +		ftr = &etm4_features[bit];
> +
> +		if (ftr->arch_callback)
> +			ftr->arch_callback(true);
> +	}
> +}
> +
> +static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
> +{
> +	struct etm4_arch_features *ftr;
> +	int bit;
> +
> +	for_each_set_bit(bit, drvdata->arch_features, ETM4_IMPDEF_FEATURE_MAX) {
> +		ftr = &etm4_features[bit];
> +
> +		if (ftr->arch_callback)
> +			ftr->arch_callback(false);
> +	}
> +}
> +
> +static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
> +				      unsigned int id)
> +{
> +	if (etm4_hisi_match_pid(id))
> +		set_bit(ETM4_IMPDEF_HISI_CORE_COMMIT, drvdata->arch_features);
> +}
> +#else
> +static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
> +{
> +}
> +
> +static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
> +{
> +}
> +
> +static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
> +				     unsigned int id)
> +{
> +}
> +#endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
> +
>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	int i, rc;
> @@ -110,6 +204,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	struct device *etm_dev = &drvdata->csdev->dev;
> 
>  	CS_UNLOCK(drvdata->base);
> +	etm4_enable_arch_specific(drvdata);
> 
>  	etm4_os_unlock(drvdata);
> 
> @@ -476,6 +571,7 @@ static void etm4_disable_hw(void *info)
>  	int i;
> 
>  	CS_UNLOCK(drvdata->base);
> +	etm4_disable_arch_specific(drvdata);
> 
>  	if (!drvdata->skip_power_up) {
>  		/* power can be removed from the trace unit now */
> @@ -1547,6 +1643,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  		drvdata->boot_enable = true;
>  	}
> 
> +	etm4_check_arch_features(drvdata, id->id);
> +
>  	return 0;
>  }
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index eefc737..3dd3e06 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -8,6 +8,7 @@
> 
>  #include <asm/local.h>
>  #include <linux/spinlock.h>
> +#include <linux/types.h>
>  #include "coresight-priv.h"
> 
>  /*
> @@ -203,6 +204,11 @@
>  /* Interpretation of resource numbers change at ETM v4.3 architecture */
>  #define ETM4X_ARCH_4V3	0x43
> 
> +enum etm_impdef_type {
> +	ETM4_IMPDEF_HISI_CORE_COMMIT,
> +	ETM4_IMPDEF_FEATURE_MAX,
> +};
> +
>  /**
>   * struct etmv4_config - configuration information related to an ETMv4
>   * @mode:	Controls various modes supported by this ETM.
> @@ -415,6 +421,7 @@ struct etmv4_save_state {
>   * @state_needs_restore: True when there is context to restore after PM exit
>   * @skip_power_up: Indicates if an implementation can skip powering up
>   *		   the trace unit.
> + * @arch_features: Bitmap of arch features of etmv4 devices.
>   */
>  struct etmv4_drvdata {
>  	void __iomem			*base;
> @@ -463,6 +470,7 @@ struct etmv4_drvdata {
>  	struct etmv4_save_state		*save_state;
>  	bool				state_needs_restore;
>  	bool				skip_power_up;
> +	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>  };
> 
>  /* Address comparator access types */
> --
> 2.8.1
> 
