Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B152C36C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKYC1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:27:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7675 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYC1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:27:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CglC242Ynz15Pdc;
        Wed, 25 Nov 2020 10:26:54 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 10:27:11 +0800
Subject: Re: [PATCH v2 06/18] arm64: dts: hisi: Harmonize EHCI/OHCI DT nodes
 name
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
 <20201111091552.15593-7-Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5FBDC0FE.5060409@hisilicon.com>
Date:   Wed, 25 Nov 2020 10:27:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20201111091552.15593-7-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 2020/11/11 17:15, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi       | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> index 12bc1d3ed424..a4acecb75c89 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> @@ -585,7 +585,7 @@ pcie: pcie@9860000 {
>  			status = "disabled";
>  		};
>  
> -		ohci: ohci@9880000 {
> +		ohci: usb@9880000 {
>  			compatible = "generic-ohci";
>  			reg = <0x9880000 0x10000>;
>  			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> @@ -600,7 +600,7 @@ ohci: ohci@9880000 {
>  			status = "disabled";
>  		};
>  
> -		ehci: ehci@9890000 {
> +		ehci: usb@9890000 {
>  			compatible = "generic-ehci";
>  			reg = <0x9890000 0x10000>;
>  			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> index 50ceaa959bdc..1226440d54ad 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> @@ -373,7 +373,7 @@ refclk: refclk {
>  			#clock-cells = <0>;
>  		};
>  
> -		usb_ohci: ohci@a7030000 {
> +		usb_ohci: usb@a7030000 {
>  			compatible = "generic-ohci";
>  			reg = <0x0 0xa7030000 0x0 0x10000>;
>  			interrupt-parent = <&mbigen_usb>;
> @@ -382,7 +382,7 @@ usb_ohci: ohci@a7030000 {
>  			status = "disabled";
>  		};
>  
> -		usb_ehci: ehci@a7020000 {
> +		usb_ehci: usb@a7020000 {
>  			compatible = "generic-ehci";
>  			reg = <0x0 0xa7020000 0x0 0x10000>;
>  			interrupt-parent = <&mbigen_usb>;
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> index 4773a533fce5..93f99a5255ac 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> @@ -1253,7 +1253,7 @@ uart0: uart@602b0000 {
>  			status = "disabled";
>  		};
>  
> -		usb_ohci: ohci@a7030000 {
> +		usb_ohci: usb@a7030000 {
>  			compatible = "generic-ohci";
>  			reg = <0x0 0xa7030000 0x0 0x10000>;
>  			interrupt-parent = <&mbigen_usb>;
> @@ -1262,7 +1262,7 @@ usb_ohci: ohci@a7030000 {
>  			status = "disabled";
>  		};
>  
> -		usb_ehci: ehci@a7020000 {
> +		usb_ehci: usb@a7020000 {
>  			compatible = "generic-ehci";
>  			reg = <0x0 0xa7020000 0x0 0x10000>;
>  			interrupt-parent = <&mbigen_usb>;
> 

Thanks!
But a similar patch has been sent out earlier:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201012131739.1655-8-thunder.leizhen@huawei.com/

Best Regards,
Wei
