Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90E3045CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393678AbhAZR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:56:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11879 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbhAZIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:54:19 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DQ0q25myxz7b4D;
        Tue, 26 Jan 2021 16:52:14 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 16:53:18 +0800
Message-ID: <600FD87D.1080600@hisilicon.com>
Date:   Tue, 26 Jan 2021 16:53:17 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 2/4] arm64: dts: correct vendor prefix hisi to hisilicon
References: <20201208124641.1787-1-thunder.leizhen@huawei.com> <20201208124641.1787-3-thunder.leizhen@huawei.com>
In-Reply-To: <20201208124641.1787-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

On 2020/12/8 20:46, Zhen Lei wrote:
> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> stated in "vendor-prefixes.yaml".
> 
> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks!
Applied to the hisilicon arm64 dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 49c19c6879f95ce..bfb1375426d2b58 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -345,7 +345,7 @@
>  		crg_rst: crg_rst_controller {
>  			compatible = "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  
> @@ -376,7 +376,7 @@
>  
>  		iomcu_rst: reset {
>  			compatible = "hisilicon,hi3660-reset";
> -			hisi,rst-syscon = <&iomcu>;
> +			hisilicon,rst-syscon = <&iomcu>;
>  			#reset-cells = <2>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 85b0dfb35d6d396..5c5a5dc964ea848 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -155,7 +155,7 @@
>  			compatible = "hisilicon,hi3670-reset",
>  				     "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  		pctrl: pctrl@e8a09000 {
> 
