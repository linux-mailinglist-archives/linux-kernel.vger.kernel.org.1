Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA61275B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWPKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:10:05 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:61709 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:10:05 -0400
X-Originating-IP: 90.65.92.90
Received: from localhost (lfbn-lyo-1-1913-90.w90-65.abo.wanadoo.fr [90.65.92.90])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C5B9E24000F;
        Wed, 23 Sep 2020 15:10:01 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andre Heider <a.heider@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Get rid of duplicate serial aliases
In-Reply-To: <20200921164830.499548-1-a.heider@gmail.com>
References: <20200921164830.499548-1-a.heider@gmail.com>
Date:   Wed, 23 Sep 2020 17:10:01 +0200
Message-ID: <87y2l0h6ly.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> The included armada-372x.dtsi already defines these two aliases.
>
> Signed-off-by: Andre Heider <a.heider@gmail.com>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>
> This goes on top of Pali's patch:
> "arm64: dts: marvell: espressobin: Add ethernet switch aliases"
>
> The resulting .dtb files are the same.
>
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 0775c16e0ec8..3169a820558f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -17,8 +17,6 @@ aliases {
>  		ethernet1 = &switch0port1;
>  		ethernet2 = &switch0port2;
>  		ethernet3 = &switch0port3;
> -		serial0 = &uart0;
> -		serial1 = &uart1;
>  	};
>  
>  	chosen {
> -- 
> 2.28.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
