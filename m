Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9127DEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgI3DFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:05:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgI3DFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:05:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 00F94A841AAE7BF3BE1A;
        Wed, 30 Sep 2020 11:05:29 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:05:19 +0800
Subject: Re: [PATCH v5 06/17] ARM: hisi: add support for SD5203 SoC
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-7-thunder.leizhen@huawei.com>
CC:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F73F5EE.5090000@hisilicon.com>
Date:   Wed, 30 Sep 2020 11:05:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200929141454.2312-7-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

On 2020/9/29 22:14, Zhen Lei wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Enable support for the Hisilicon SD5203 SoC. The core is ARM926EJ-S.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thanks!
Applied to the hisilicon arm32 SoC tree.

Best Regards,
Wei

> ---
>  arch/arm/mach-hisi/Kconfig | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index 3b010fe7c0e9b48..2e980f834a6aa1b 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -1,9 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config ARCH_HISI
>  	bool "Hisilicon SoC Support"
> -	depends on ARCH_MULTI_V7
> +	depends on ARCH_MULTI_V7 || ARCH_MULTI_V5
>  	select ARM_AMBA
> -	select ARM_GIC
> +	select ARM_GIC if ARCH_MULTI_V7
>  	select ARM_TIMER_SP804
>  	select POWER_RESET
>  	select POWER_RESET_HISI
> @@ -15,6 +15,7 @@ menu "Hisilicon platform type"
>  
>  config ARCH_HI3xxx
>  	bool "Hisilicon Hi36xx family"
> +	depends on ARCH_MULTI_V7
>  	select CACHE_L2X0
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
> @@ -25,6 +26,7 @@ config ARCH_HI3xxx
>  
>  config ARCH_HIP01
>  	bool "Hisilicon HIP01 family"
> +	depends on ARCH_MULTI_V7
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
>  	select ARM_GLOBAL_TIMER
> @@ -33,6 +35,7 @@ config ARCH_HIP01
>  
>  config ARCH_HIP04
>  	bool "Hisilicon HiP04 Cortex A15 family"
> +	depends on ARCH_MULTI_V7
>  	select ARM_ERRATA_798181 if SMP
>  	select HAVE_ARM_ARCH_TIMER
>  	select MCPM if SMP
> @@ -43,6 +46,7 @@ config ARCH_HIP04
>  
>  config ARCH_HIX5HD2
>  	bool "Hisilicon X5HD2 family"
> +	depends on ARCH_MULTI_V7
>  	select CACHE_L2X0
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
> @@ -50,6 +54,14 @@ config ARCH_HIX5HD2
>  	select PINCTRL_SINGLE
>  	help
>  	  Support for Hisilicon HIX5HD2 SoC family
> +
> +config ARCH_SD5203
> +	bool "Hisilicon SD5203 family"
> +	depends on ARCH_MULTI_V5
> +	select DW_APB_ICTL
> +	help
> +	  Support for Hisilicon SD5203 SoC family
> +
>  endmenu
>  
>  endif
> 
