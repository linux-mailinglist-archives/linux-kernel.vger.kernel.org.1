Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB54B2C0D01
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgKWOND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:13:03 -0500
Received: from foss.arm.com ([217.140.110.172]:50980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgKWONC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:13:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02278101E;
        Mon, 23 Nov 2020 06:13:02 -0800 (PST)
Received: from [10.57.53.209] (unknown [10.57.53.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8336C3F718;
        Mon, 23 Nov 2020 06:13:00 -0800 (PST)
Subject: Re: [PATCH] coresight: etm4x: Modify core-commit of cpu to avoid the
 overflow of HiSilicon ETM
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <1606138167-8076-1-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cfa91a72-6e01-85ce-583a-9a49093a875b@arm.com>
Date:   Mon, 23 Nov 2020 14:12:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606138167-8076-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi

Thanks for the changes. Mostly looks good to me, except for the
name of the call back.


On 11/23/20 1:29 PM, Qi Liu wrote:
> The ETM device can't keep up with the core pipeline when cpu core
> is at full speed. This may cause overflow within core and its ETM.
> This is a common phenomenon on ETM devices.
> 
> On HiSilicon Hip08 platform, a specific feature is added to set
> core pipeline. So commit rate can be reduced manually to avoid ETM
> overflow.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>


> ---
> Change since v1:
> - add CONFIG_ETM4X_IMPDEF_FEATURE and CONFIG_ETM4X_IMPDEF_HISILICON
>    to keep specific feature off platforms which don't use it.
> Change since v2:
> - remove some unused variable.
> Change since v3:
> - use read/write_sysreg_s() to access register.
> 
>   drivers/hwtracing/coresight/Kconfig                |  9 +++
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 84 ++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-etm4x.h      | 12 ++++
>   3 files changed, 105 insertions(+)
> 

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index eefc737..1784975 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -8,6 +8,7 @@
> 
>   #include <asm/local.h>
>   #include <linux/spinlock.h>
> +#include <linux/types.h>
>   #include "coresight-priv.h"
> 
>   /*
> @@ -203,6 +204,11 @@
>   /* Interpretation of resource numbers change at ETM v4.3 architecture */
>   #define ETM4X_ARCH_4V3	0x43
> 
> +enum etm_impdef_type {
> +	ETM4_IMPDEF_HISI_CORE_COMMIT,
> +	ETM4_IMPDEF_FEATURE_MAX,
> +};
> +
>   /**
>    * struct etmv4_config - configuration information related to an ETMv4
>    * @mode:	Controls various modes supported by this ETM.
> @@ -415,6 +421,7 @@ struct etmv4_save_state {
>    * @state_needs_restore: True when there is context to restore after PM exit
>    * @skip_power_up: Indicates if an implementation can skip powering up
>    *		   the trace unit.
> + * @arch_features: Bitmap of arch features of etmv4 devices.
>    */
>   struct etmv4_drvdata {
>   	void __iomem			*base;
> @@ -463,6 +470,11 @@ struct etmv4_drvdata {
>   	struct etmv4_save_state		*save_state;
>   	bool				state_needs_restore;
>   	bool				skip_power_up;
> +	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
> +};
> +
> +struct etm4_arch_features {
> +	void (*set_commit)(bool enable);

The set_commit is too hisilicon specific :-). Could we please rename
this to soemthing more generic. The callback for hisilicon etms, could still
be xx_commit". May be simply call it

	callback() ?

or may be even
	arch_callback() ?


>   };

nit: This need not be part of the header file, as it is not used
outside the etm4x-core.c

Suzuki
