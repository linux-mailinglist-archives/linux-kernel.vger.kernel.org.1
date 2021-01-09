Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA632F000C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 14:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAINll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 08:41:41 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35794 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbhAINlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:41:40 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyEUC-0000GE-1w; Sat, 09 Jan 2021 14:40:56 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Demetris Ierokipides <ierokipides.dem@gmail.com>
Cc:     Demetris Ierokipides <ierokipides.dem@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: add extra cpu opp points to rk3288-miqi
Date:   Sat, 09 Jan 2021 14:40:55 +0100
Message-ID: <1680769.VLH7GnMWUR@diego>
In-Reply-To: <20210108151036.36434-3-ierokipides.dem@gmail.com>
References: <20210108151036.36434-1-ierokipides.dem@gmail.com> <20210108151036.36434-3-ierokipides.dem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Demetris,

Am Freitag, 8. Januar 2021, 16:10:36 CET schrieb Demetris Ierokipides:
> Add extra 1.7GHz and 1.8GHz opp points to the MiQi device-tree to improve
> performance.
> 
> Signed-off-by: Demetris Ierokipides <ierokipides.dem@gmail.com>
> ---
>  arch/arm/boot/dts/rk3288-miqi.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
> index 713f55e143c6..1b48855db6ff 100644
> --- a/arch/arm/boot/dts/rk3288-miqi.dts
> +++ b/arch/arm/boot/dts/rk3288-miqi.dts
> @@ -96,6 +96,18 @@ &cpu3 {
>  	cpu-supply = <&vdd_cpu>;
>  };
>  
> +&cpu_opp_table {
> +	opp-1704000000 {
> +		opp-hz = /bits/ 64 <1704000000>;
> +		opp-microvolt = <1350000>;
> +	};
> +
> +	opp-1800000000 {
> +		opp-hz = /bits/ 64 <1800000000>;
> +		opp-microvolt = <1350000>;
> +	};
> +};
> +

sorry, but no .

The OPPs in the mainline kernel match the specifications released by the
soc vendor. Going outside these specs _may_ affect things like stability
on some boards or in general simply the lifetime of the chip itself.

So yes, while boards may generally work with these higher frequencies
I don't think this should be the default coming from the mainline kernel.

If board-owners feel the need to exceed the specs they can still modify
the dts, but we shouldn't force this decision on everyone.


Heiko


