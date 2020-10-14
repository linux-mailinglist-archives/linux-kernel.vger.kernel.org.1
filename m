Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2F28D76F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgJNAaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:30:02 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:40948 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbgJNAaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:30:02 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 2A776137E;
        Wed, 14 Oct 2020 08:27:19 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19667T139950918633216S1602635237277608_;
        Wed, 14 Oct 2020 08:27:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <78ee4579de79111539b25c0541edb441>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v10 5/8] arm64: dts: rockchip: Add NFC node for PX30 SoC
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
 <20200930020902.7522-1-yifeng.zhao@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <d334b3f3-fb68-e7e7-4d46-b76b7408f17e@rock-chips.com>
Date:   Wed, 14 Oct 2020 08:27:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930020902.7522-1-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/30 上午10:08, Yifeng Zhao wrote:
> Add NAND FLASH Controller(NFC) node for PX30 SoC.
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
>   arch/arm64/boot/dts/rockchip/px30.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Looks good to me,

Reviewed-by: Kever Yang<kever.yang@rock-chips.com>

Thanks,
- Kever

>
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> index 2695ea8cda14..6cd67e80d623 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -973,6 +973,21 @@
>   		status = "disabled";
>   	};
>   
> +	nfc: nand-controller@ff3b0000 {
> +		compatible = "rockchip,px30-nfc";
> +		reg = <0x0 0xff3b0000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
> +		clock-names = "ahb", "nfc";
> +		assigned-clocks = <&cru SCLK_NANDC>;
> +		assigned-clock-rates = <150000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_cs0
> +			     &flash_rdn &flash_rdy &flash_wrn &flash_dqs>;
> +		power-domains = <&power PX30_PD_MMC_NAND>;
> +		status = "disabled";
> +	};
> +
>   	gpu: gpu@ff400000 {
>   		compatible = "rockchip,px30-mali", "arm,mali-bifrost";
>   		reg = <0x0 0xff400000 0x0 0x4000>;


