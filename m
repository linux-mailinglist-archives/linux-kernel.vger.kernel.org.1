Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6F28D777
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbgJNAa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:30:27 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:49716 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgJNAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:30:03 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 20:30:02 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 07683408;
        Wed, 14 Oct 2020 08:27:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30218T139797091841792S1602635270147880_;
        Wed, 14 Oct 2020 08:27:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <95e12a54f687ec159b92921abe5d4d40>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v10 7/8] arm: dts: rockchip: Add NFC node for RK2928 and
 other SoCs
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
 <20200930020902.7522-1-yifeng.zhao@rock-chips.com>
 <20200930020902.7522-3-yifeng.zhao@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <ec8d8e7e-ec31-997c-87a6-a8702fda9c63@rock-chips.com>
Date:   Wed, 14 Oct 2020 08:27:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930020902.7522-3-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/30 上午10:09, Yifeng Zhao wrote:
> Add NAND FLASH Controller(NFC) node for RK2928, RK3066, RK3168
> and RK3188 SoCs.
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
>   arch/arm/boot/dts/rk3xxx.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)

Looks good to me,

Reviewed-by: Kever Yang<kever.yang@rock-chips.com>

Thanks,
- Kever

>
> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
> index 859a7477909f..97415180d5bb 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -276,6 +276,15 @@
>   		status = "disabled";
>   	};
>   
> +	nfc: nand-controller@10500000 {
> +		compatible = "rockchip,rk2928-nfc";
> +		reg = <0x10500000 0x4000>;
> +		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_NANDC0>;
> +		clock-names = "ahb";
> +		status = "disabled";
> +	};
> +
>   	pmu: pmu@20004000 {
>   		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
>   		reg = <0x20004000 0x100>;


