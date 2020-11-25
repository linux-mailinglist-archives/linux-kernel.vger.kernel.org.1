Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8F2C36CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKYC2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:28:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKYC2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:28:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CglCx01mgz15Qf1;
        Wed, 25 Nov 2020 10:27:41 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 10:27:56 +0800
Subject: Re: [PATCH v2 04/18] arm: dts: hisi-x5hd2: Harmonize EHCI/OHCI DT
 nodes name
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
 <20201111091552.15593-5-Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5FBDC12B.9060200@hisilicon.com>
Date:   Wed, 25 Nov 2020 10:27:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20201111091552.15593-5-Sergey.Semin@baikalelectronics.ru>
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
>  arch/arm/boot/dts/hisi-x5hd2.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> index 3ee7967c202d..693b85b2cc7d 100644
> --- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
> +++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> @@ -452,14 +452,14 @@ gmac1: ethernet@1841000 {
>  			status = "disabled";
>  		};
>  
> -		usb0: ehci@1890000 {
> +		usb0: usb@1890000 {
>  			compatible = "generic-ehci";
>  			reg = <0x1890000 0x1000>;
>  			interrupts = <0 66 4>;
>  			clocks = <&clock HIX5HD2_USB_CLK>;
>  		};
>  
> -		usb1: ohci@1880000 {
> +		usb1: usb@1880000 {
>  			compatible = "generic-ohci";
>  			reg = <0x1880000 0x1000>;
>  			interrupts = <0 67 4>;
> 

Thanks!
But a similar patch has been sent out earlier:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201012061225.1597-4-thunder.leizhen@huawei.com/

Best Regards,
Wei
