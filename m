Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF71428D770
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgJNAaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:30:07 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:41334 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730489AbgJNAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:30:03 -0400
Received: from localhost (unknown [192.168.167.8])
        by regular1.263xmail.com (Postfix) with ESMTP id 5181C7C4;
        Wed, 14 Oct 2020 08:27:00 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2450T140206569150208S1602635219176695_;
        Wed, 14 Oct 2020 08:27:00 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ef929fe8e4cc1e537cc2cf17bf1f3b56>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: zyf@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v10 4/8] arm64: dts: rockchip: Add NFC node for RK3308 SoC
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Yifeng Zhao <zyf@rock-chips.com>
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
 <20200930020710.7394-5-yifeng.zhao@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <53694a0d-6990-26a6-5e21-19fae9f3321f@rock-chips.com>
Date:   Wed, 14 Oct 2020 08:26:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930020710.7394-5-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/30 上午10:07, Yifeng Zhao wrote:
> From: Yifeng Zhao <zyf@rock-chips.com>
>
> Add NAND FLASH Controller(NFC) node for RK3308 SoC.
>
> Signed-off-by: Yifeng Zhao <zyf@rock-chips.com>
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
>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Looks good to me,

Reviewed-by: Kever Yang<kever.yang@rock-chips.com>

Thanks,
- Kever

>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 0cf954062387..f98c65c9bd13 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -629,6 +629,21 @@
>   		status = "disabled";
>   	};
>   
> +	nfc: nand-controller@ff4b0000 {
> +		compatible = "rockchip,rk3308-nfc",
> +			     "rockchip,rv1108-nfc";
> +		reg = <0x0 0xff4b0000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
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
>   	cru: clock-controller@ff500000 {
>   		compatible = "rockchip,rk3308-cru";
>   		reg = <0x0 0xff500000 0x0 0x1000>;


