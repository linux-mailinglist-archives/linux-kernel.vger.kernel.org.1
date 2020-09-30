Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4D27DEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgI3DGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:06:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgI3DGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:06:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 533237A9299A17EC4285;
        Wed, 30 Sep 2020 11:06:44 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:06:35 +0800
Subject: Re: [PATCH v5 07/17] ARM: debug: add UART early console support for
 SD5203
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-8-thunder.leizhen@huawei.com>
CC:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F73F63A.9020502@hisilicon.com>
Date:   Wed, 30 Sep 2020 11:06:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200929141454.2312-8-thunder.leizhen@huawei.com>
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
> Add support of early console for SD5203.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thanks!
Applied to the hisilicon arm32 SoC tree.

Best Regards,
Wei

> ---
>  arch/arm/Kconfig.debug | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 80000a66a4e3549..d27a7764c3bfb46 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1086,6 +1086,14 @@ choice
>  		  on SA-11x0 UART ports. The kernel will check for the first
>  		  enabled UART in a sequence 3-1-2.
>  
> +	config DEBUG_SD5203_UART
> +		bool "Hisilicon SD5203 Debug UART"
> +		depends on ARCH_SD5203
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on SD5203 UART.
> +
>  	config DEBUG_SOCFPGA_UART0
>  		depends on ARCH_SOCFPGA
>  		bool "Use SOCFPGA UART0 for low-level debug"
> @@ -1639,6 +1647,7 @@ config DEBUG_UART_PHYS
>  	default 0x11006000 if DEBUG_MT6589_UART0
>  	default 0x11009000 if DEBUG_MT8135_UART3
>  	default 0x16000000 if DEBUG_INTEGRATOR
> +	default 0x1600d000 if DEBUG_SD5203_UART
>  	default 0x18000300 if DEBUG_BCM_5301X
>  	default 0x18000400 if DEBUG_BCM_HR2
>  	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
> @@ -1841,7 +1850,7 @@ config DEBUG_UART_VIRT
>  	default 0xfec60000 if DEBUG_SIRFPRIMA2_UART1
>  	default 0xfec90000 if DEBUG_RK32_UART2
>  	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
> -	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
> +	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_SD5203_UART
>  	default 0xfed60000 if DEBUG_RK29_UART0
>  	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
>  	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
> 
