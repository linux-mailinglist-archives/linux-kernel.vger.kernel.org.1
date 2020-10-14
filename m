Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8328D775
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbgJNAaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:30:20 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:40950 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgJNAaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:30:04 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 6D1EB1410;
        Wed, 14 Oct 2020 08:27:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19667T139950929123072S1602635253071439_;
        Wed, 14 Oct 2020 08:27:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c059e3b8dae9b4aba3b46bc811c4c4a5>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v10 6/8] arm: dts: rockchip: Add NFC node for RV1108 SoC
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
 <20200930020902.7522-1-yifeng.zhao@rock-chips.com>
 <20200930020902.7522-2-yifeng.zhao@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <fd4ed2c6-b8a6-c2df-1086-10460f855344@rock-chips.com>
Date:   Wed, 14 Oct 2020 08:27:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930020902.7522-2-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/30 上午10:09, Yifeng Zhao wrote:
> Add NAND FLASH Controller(NFC) node for RV1108 SoC.
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
>   arch/arm/boot/dts/rv1108.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Looks good to me,

Reviewed-by: Kever Yang<kever.yang@rock-chips.com>

Thanks,
- Kever

>
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index a1a08cb9364e..1696ea19488b 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -452,6 +452,17 @@
>   		#reset-cells = <1>;
>   	};
>   
> +	nfc: nand-controller@30100000 {
> +		compatible = "rockchip,rv1108-nfc";
> +		reg = <0x30100000  0x1000>;
> +		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
> +		clock-names = "ahb", "nfc";
> +		assigned-clocks = <&cru SCLK_NANDC>;
> +		assigned-clock-rates = <150000000>;
> +		status = "disabled";
> +	};
> +
>   	emmc: mmc@30110000 {
>   		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
>   		reg = <0x30110000 0x4000>;


