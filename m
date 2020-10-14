Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6027328D772
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389529AbgJNAaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:30:12 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:35128 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbgJNAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:30:03 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id C095310D7;
        Wed, 14 Oct 2020 08:26:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18907T140199826794240S1602635202134719_;
        Wed, 14 Oct 2020 08:26:43 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e3f77f875e6cfdb329f84277ad795cbf>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v10 3/8] MAINTAINERS: add maintainers to ROCKCHIP NFC
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
 <20200930020710.7394-4-yifeng.zhao@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <fc80d29f-de2d-6cc6-9fee-d10e9a85aec2@rock-chips.com>
Date:   Wed, 14 Oct 2020 08:26:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930020710.7394-4-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/30 上午10:07, Yifeng Zhao wrote:
> Add maintainers to ROCKCHIP NFC.
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
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me,

Reviewed-by: Kever Yang<kever.yang@rock-chips.com>

Thanks,
- Kever

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 190c7fa2ea01..5500df349836 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2382,12 +2382,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-rockchip@lists.infradead.org
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
> +F:	Documentation/devicetree/bindings/*/*rockchip*.yaml
>   F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
> -F:	Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> -F:	Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>   F:	arch/arm/boot/dts/rk3*
>   F:	arch/arm/boot/dts/rv1108*
>   F:	arch/arm/mach-rockchip/
> +F:	drivers/*/*/*/*rockchip*
>   F:	drivers/*/*/*rockchip*
>   F:	drivers/*/*rockchip*
>   F:	drivers/clk/rockchip/


