Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC0273A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgIVGPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgIVGPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:15:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D80C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:15:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o25so6143620pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GUI0or54jzs6SWBeOTIhXJI7pPtDOpGteq+qBUK8BXM=;
        b=dR+Z4ASnMZM/ntfY2CiUiX3vW/jiV+bylVZky7bRX2d8UXPI64aHPjz8sbTX4XtE1z
         ul/fItqCDEBaHqVw/ti2Spj4E8xf28cRj4AaFvHElxj+TAVqRZUIre+oo6fAmJy/6xGq
         Poz9QL9fVnM1wEmmJwTwgpl6PMwc3yIOXLJ8H/T0xeLk3YG/a2IxTz5cqFnt4EWwufeP
         hh9H7UTZl0CCsnpHyxPE8swF1EiFBBVjHmAuAG5iHKqBpXpsQqxINN3jQvg5x+3V7wWk
         G9E+kqvKdgG5mxQ6VWxOK7tBUhJj1c4I1KAghNiGglJGzyhg1Pv0EJo4NZZx8gOS+2uT
         jNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GUI0or54jzs6SWBeOTIhXJI7pPtDOpGteq+qBUK8BXM=;
        b=QDiS66dtbT+O3vInRdwAK6/t1tPO4Pt1VXXZSosKbM+IFxi4Dv7BqKhITKgq/exOsO
         c4pyEnvKJSqpH76vKH2gJy++GyfWmVllaNsvJyOxK5qrkbixmoSPXVbjlZK1aMp9row5
         pWcL/eF9L6TAQtvWqEHT9Q2SaJ/RivEMMyKBC5fG2O8+CAqr3g2QmVd1F4vhe8SI8KaD
         bQ19oDa9XZ2fxWZ/o9lw3tvMnbvurWSjKk7mx980dCE8trV6NZFCEVQ01QGew3cQvfYI
         78q8Qu7k+XsOxP5zkwyz1U66ctGkUxNnMxuNTD883R6NVQjFJIcg+nOxT2249Adng/Vj
         lpaQ==
X-Gm-Message-State: AOAM532cPglWOHrlAuSjcqol41UMAFDjfs6sWLzgz4o2QbWrzXtz3Eg8
        AwHKcECfZP1nDEsIIEiiDYeWv8hW79to
X-Google-Smtp-Source: ABdhPJxvg+wYdjy6w01oHbUTHSHS/EIXkvVEtjrXQpBo+TWQuI/+LGjhw6GlsI59oWMbmx7JNpTvuw==
X-Received: by 2002:a63:500e:: with SMTP id e14mr2359458pgb.36.1600755304319;
        Mon, 21 Sep 2020 23:15:04 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id e62sm13483624pfh.76.2020.09.21.23.14.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 23:15:03 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:44:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>, arnd@arndb.de,
        olof@lixom.net
Cc:     afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v7 4/4] arm64: dts: Add Caninos Loucos Labrador v3
Message-ID: <20200922061454.GA29035@Mani-XPS-13-9360>
References: <20200922024302.205062-1-matheus@castello.eng.br>
 <20200922024302.205062-5-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922024302.205062-5-matheus@castello.eng.br>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 21, 2020 at 11:43:02PM -0300, Matheus Castello wrote:
> Add Device Trees for Caninos Loucos Labrador CoM Core v3 and base board
> M v2. Based on the work of Andreas Färber on Cubieboard 7 device tree.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  arch/arm64/boot/dts/actions/Makefile          |   2 +
>  .../dts/actions/s700-labrador-base-m2.dts     |  34 +++++
>  .../boot/dts/actions/s700-labrador-v3.dtsi    | 122 ++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts
>  create mode 100644 arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi
> 
> diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
> index b57fd2372ecd..3765697fa91e 100644
> --- a/arch/arm64/boot/dts/actions/Makefile
> +++ b/arch/arm64/boot/dts/actions/Makefile
> @@ -2,4 +2,6 @@
> 
>  dtb-$(CONFIG_ARCH_ACTIONS) += s700-cubieboard7.dtb
> 
> +dtb-$(CONFIG_ARCH_ACTIONS) += s700-labrador-base-m2.dtb
> +
>  dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
> diff --git a/arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts b/arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts
> new file mode 100644
> index 000000000000..63bbca46475b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Matheus Castello
> + */
> +
> +/dts-v1/;
> +
> +#include "s700-labrador-v3.dtsi"
> +
> +/ {
> +	compatible = "caninos,labrador-base-m2",
> +		     "caninos,labrador-v3", "actions,s700";
> +	model = "Caninos Labrador Core v3 on Labrador Base-M v2";
> +
> +	aliases {
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial3:115200n8";
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";

No fixed clock?

> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi b/arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi
> new file mode 100644
> index 000000000000..91addba6382b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Matheus Castello
> + */
> +
> +#include "s700.dtsi"
> +
> +/ {
> +	compatible = "caninos,labrador-v3", "actions,s700";
> +	model = "Caninos Labrador Core v3.1";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	memory@1,e0000000 {
> +		device_type = "memory";
> +		reg = <0x1 0xe0000000 0x0 0x0>;
> +	};
> +

What is the size of this memory? The datasheet says only 512MB Max.

> +	/* Labrador v3 firmware does not support PSCI */

Oops. This is unfortunate... I'm not sure if this is even acceptable for
ARM64 machines.

Let me add Olof and Arnd...

Thanks,
Mani

> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	L2: l2-cache {
> +		compatible = "cache";
> +		cache-level = <2>;
> +	};
> +};
> +
> +&timer {
> +	clocks = <&hosc>;
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_default>;
> +};
> +
> +&pinctrl {
> +	i2c0_default: i2c0_default {
> +		pinmux {
> +			groups = "i2c0_mfp";
> +			function = "i2c0";
> +		};
> +		pinconf {
> +			pins = "i2c0_sclk", "i2c0_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c1_default: i2c1_default {
> +		pinmux {
> +			groups = "i2c1_dummy";
> +			function = "i2c1";
> +		};
> +		pinconf {
> +			pins = "i2c1_sclk", "i2c1_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c2_default: i2c2_default {
> +		pinmux {
> +			groups = "i2c2_dummy";
> +			function = "i2c2";
> +		};
> +		pinconf {
> +			pins = "i2c2_sclk", "i2c2_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +};
> --
> 2.28.0
> 
