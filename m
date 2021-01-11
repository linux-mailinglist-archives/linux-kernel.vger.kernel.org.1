Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0F92F0AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 02:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbhAKBf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 20:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAKBf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 20:35:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FE36224B8;
        Mon, 11 Jan 2021 01:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610328887;
        bh=pfavUzDdwY+sLD3YIIPBZfMG3oZWPDlMSzO58n2zQ4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlWqOPQy/4vrZtwpee/zNlgsdwoAFFBeXylMhi/SZzBpdTZuTfffdBqi2G9cg8KAN
         R8dEapuowv+JdOhDt9/hvL8O3GJI/KDyKg7TNhRgl/2ewjHdTSxLjIQEUhZ4PLXp55
         MUHWgR/ouli1ub5UA/wPDyJ+VlHa6SfKbP5170WnCLUWQ0ko1UoX6TaaISo0I+6bge
         pxpl4MxJ9tUCnG3ObZS9D0fnV/s1z7r/fxzQpFLbBjkXGL1MmTBvpIajWLuMpkCKl0
         smrBUOD1ldN3EENImPCinV6HoQDoPiR30aKwlSyvm46+OwZa51gAiIIm6pJ2S25Lkv
         d+fzwzxYj3QOQ==
Date:   Mon, 11 Jan 2021 09:34:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: sl28: add variant 1
Message-ID: <20210111013442.GU28365@dragon>
References: <20201229120321.17103-1-michael@walle.cc>
 <20201229120321.17103-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229120321.17103-2-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 01:03:21PM +0100, Michael Walle wrote:
> There is a new variant 1 of this board available. It features up to four
> SerDes lanes for customer use. Add a new device tree which features just
> the basic peripherals. A customer will then have to modify or append to
> this device tree.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../fsl-ls1028a-kontron-sl28-var1.dts         | 61 +++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 6f0777ee6cd6..79cb0025fcc6 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-kbox-a-230-ls.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var1.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var2.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3-ads2.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
> new file mode 100644
> index 000000000000..52f2f3ffdce1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Device Tree file for the Kontron SMARC-sAL28 board.
> + *
> + * This is for the network variant 1 which has one ethernet port. It is
> + * different than the base variant, which also has one port, but here the
> + * port is connected via RGMII. This port is not TSN aware.
> + * None of the  four SerDes lanes are used by the module, instead they are
> + * all led out to the carrier for customer use.
> + *
> + * Copyright (C) 2020 Michael Walle <michael@walle.cc>
> + *
> + */
> +
> +/dts-v1/;
> +#include "fsl-ls1028a-kontron-sl28.dts"
> +#include <dt-bindings/net/qca-ar803x.h>
> +
> +/ {
> +	model = "Kontron SMARC-sAL28 (4 Lanes)";
> +	compatible = "kontron,sl28-var1", "kontron,sl28", "fsl,ls1028a";
> +};
> +
> +&enetc_port0 {
> +	status = "disabled";
> +	/delete-property/ phy-handle;
> +	/delete-node/ mdio;

As it's disabled anyway, why do we bother to delete the property and
child node?

> +};
> +
> +

One newline is enough.

> +&enetc_port1 {
> +	phy-handle = <&phy0>;
> +	phy-connection-type = "rgmii-id";
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy@4 {
> +			reg = <0x4>;
> +			eee-broken-1000t;
> +			eee-broken-100tx;
> +

Unnecessary newline.

> +			qca,clk-out-frequency = <125000000>;
> +			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
> +

Ditto

Shawn

> +			vddio-supply = <&vddh>;
> +
> +			vddio: vddio-regulator {
> +				regulator-name = "VDDIO";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			vddh: vddh-regulator {
> +				regulator-name = "VDDH";
> +			};
> +		};
> +	};
> +};
> -- 
> 2.20.1
> 
