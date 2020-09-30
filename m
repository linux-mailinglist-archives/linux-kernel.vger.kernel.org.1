Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579DA27DEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgI3DIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:08:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgI3DIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:08:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 35F0D59FB086B3622ADA;
        Wed, 30 Sep 2020 11:08:18 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:08:08 +0800
Subject: Re: [PATCH v5 09/17] ARM: dts: hisilicon: fix ststem controller
 compatible node
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-10-thunder.leizhen@huawei.com>
CC:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F73F698.3040700@hisilicon.com>
Date:   Wed, 30 Sep 2020 11:08:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200929141454.2312-10-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

On 2020/9/29 22:14, Zhen Lei wrote:
> The DT binding for Hisilicon system controllers requires to have a
> "syscon" compatible string.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thanks!
Applied to the hisilicon arm32 dt tree.

Best Regards,
Wei

> ---
>  arch/arm/boot/dts/hi3620.dtsi | 2 +-
>  arch/arm/boot/dts/hip04.dtsi  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
> index 355175b25fd6220..f683440ee5694b4 100644
> --- a/arch/arm/boot/dts/hi3620.dtsi
> +++ b/arch/arm/boot/dts/hi3620.dtsi
> @@ -89,7 +89,7 @@
>  		};
>  
>  		sysctrl: system-controller@802000 {
> -			compatible = "hisilicon,sysctrl";
> +			compatible = "hisilicon,sysctrl", "syscon";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0 0x802000 0x1000>;
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> index f5871b1d1ec452c..555bc6b6720fc94 100644
> --- a/arch/arm/boot/dts/hip04.dtsi
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -213,7 +213,7 @@
>  		};
>  
>  		sysctrl: sysctrl {
> -			compatible = "hisilicon,sysctrl";
> +			compatible = "hisilicon,sysctrl", "syscon";
>  			reg = <0x3e00000 0x00100000>;
>  		};
>  
> 
