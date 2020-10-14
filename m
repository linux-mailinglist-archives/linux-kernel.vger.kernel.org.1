Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB028D77F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbgJNAcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:32:05 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:56808 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389682AbgJNAcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:32:03 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 20:32:02 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id CFAAC7F7;
        Wed, 14 Oct 2020 08:28:10 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30218T139798299801344S1602635289936229_;
        Wed, 14 Oct 2020 08:28:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <092ed86f293027f386d50ecd0a6b6597>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v10 8/8] arm: dts: rockchip: Add NFC node for RK3036 SoC
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
 <20200930020902.7522-1-yifeng.zhao@rock-chips.com>
 <20200930020902.7522-4-yifeng.zhao@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <cd4ac8ed-49b4-fe7d-f483-f267376acec6@rock-chips.com>
Date:   Wed, 14 Oct 2020 08:28:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930020902.7522-4-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/30 上午10:09, Yifeng Zhao wrote:
> Add NAND FLASH Controller(NFC) node for RK3036 SoC.
>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
>
> Changes in v10: None
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>   arch/arm/boot/dts/rk3036.dtsi | 52 +++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)

Looks good to me,

Reviewed-by: Kever Yang<kever.yang@rock-chips.com>

Thanks,
- Kever

>
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index 093567022386..dda5a1f79aca 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -292,6 +292,21 @@
>   		status = "disabled";
>   	};
>   
> +	nfc: nand-controller@10500000 {
> +		compatible = "rockchip,rk3036-nfc",
> +			     "rockchip,rk2928-nfc";
> +		reg = <0x10500000 0x4000>;
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
> +		clock-names = "ahb", "nfc";
> +		assigned-clocks = <&cru SCLK_NANDC>;
> +		assigned-clock-rates = <150000000>;
> +		pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_csn0
> +			     &flash_rdn &flash_rdy &flash_wrn>;
> +		pinctrl-names = "default";
> +		status = "disabled";
> +	};
> +
>   	cru: clock-controller@20000000 {
>   		compatible = "rockchip,rk3036-cru";
>   		reg = <0x20000000 0x1000>;
> @@ -643,6 +658,43 @@
>   			};
>   		};
>   
> +		nfc {
> +			flash_ale: flash-ale {
> +				rockchip,pins = <2 RK_PA0 1 &pcfg_pull_default>;
> +			};
> +
> +			flash_bus8: flash-bus8 {
> +				rockchip,pins = <1 RK_PD0 1 &pcfg_pull_default>,
> +						<1 RK_PD1 1 &pcfg_pull_default>,
> +						<1 RK_PD2 1 &pcfg_pull_default>,
> +						<1 RK_PD3 1 &pcfg_pull_default>,
> +						<1 RK_PD4 1 &pcfg_pull_default>,
> +						<1 RK_PD5 1 &pcfg_pull_default>,
> +						<1 RK_PD6 1 &pcfg_pull_default>,
> +						<1 RK_PD7 1 &pcfg_pull_default>;
> +			};
> +
> +			flash_cle: flash-cle {
> +				rockchip,pins = <2 RK_PA1 1 &pcfg_pull_default>;
> +			};
> +
> +			flash_csn0: flash-csn0 {
> +				rockchip,pins = <2 RK_PA6 1 &pcfg_pull_default>;
> +			};
> +
> +			flash_rdn: flash-rdn {
> +				rockchip,pins = <2 RK_PA3 1 &pcfg_pull_default>;
> +			};
> +
> +			flash_rdy: flash-rdy {
> +				rockchip,pins = <2 RK_PA4 1 &pcfg_pull_default>;
> +			};
> +
> +			flash_wrn: flash-wrn {
> +				rockchip,pins = <2 RK_PA2 1 &pcfg_pull_default>;
> +			};
> +		};
> +
>   		emac {
>   			emac_xfer: emac-xfer {
>   				rockchip,pins = <2 RK_PB2 1 &pcfg_pull_default>, /* crs_dvalid */


