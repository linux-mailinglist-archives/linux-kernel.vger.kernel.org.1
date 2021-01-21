Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102DD2FF93A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbhAVAGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:06:54 -0500
Received: from mout.perfora.net ([74.208.4.196]:43365 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbhAVAGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:06:41 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 19:06:40 EST
Received: from localhost.localdomain ([81.221.216.133]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MXanQ-1lYAcw2uRS-00WX3t;
 Fri, 22 Jan 2021 00:58:25 +0100
Message-ID: <23c78a3592efab9b2261e384398957819b5e016d.camel@ziswiler.com>
Subject: Re: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Daniel Walker <danielwa@cisco.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        Daniel Walker <dwalker@fifo99.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 22 Jan 2021 00:58:21 +0100
In-Reply-To: <20210121231237.30664-1-danielwa@cisco.com>
References: <20210121231237.30664-1-danielwa@cisco.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.module_f33+10736+4f8d5006) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qmw0h7kExStXWq5NOHbP7vhVO7EaZ8EPeDx/2Vdrdu2h+JwJODh
 S3IxBPAaS+kbJiHhzTTQK0AiA54vgg89ZN1ll8Lfv2WHRWhZ244G2+SSHwPdxKLW1Z+xGpF
 SPYEImuXx4uqMVsBXb4ruRfws+z5M95z0Imr3jrUJz41E/VO2iW6pvL1UL3WljNvzcVJHtD
 37jgvYj868SdGWySAOuuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KP/hmN7afJU=:Uis286NEbHxZJ0slUL71dd
 OsHpXtbLPBM3YkSvuF1VUn1nzKOZJFXLJGOeEcrsiWAlk8/ZTaQKczHcIksp+PmPJjSK9+BzC
 f2KoGz+YPIvZJfQNxflOsz9LSdW+X+gu1DBE21svZbn7ywNCEajLn8AJKm8iCPGXEK5GloTHc
 2evalJyA+F2xCl3ewQWsPbGzwOdlLzAVj0uUsqIU1NI2sWBhvd6bTC1oMct4lYojtu05CeSiu
 Kb7b0iDuiFopVZ6Ds+vafdMf/obicv/027DGmgC4DiVLA9tz92FdiMHO3NXWtqSDxnk1V8J3u
 M0tAoF+SRRuU0Z8Wvp2qRBYE8j/w5WW3ldSRRgKpkbbkw1/0xjg9SsiIj89QCkyLhhhuDrkj+
 zmEZ1C//6pq8K2hAggg44LMMXY9PbFIWZIEn1v5nITVz3IM4pCWJTsozrRE44/Q8UXjYKujZH
 xIrUExzehg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

Is it just me or something looks rather askew with the indentation of your dts' (e.g. tabs vs. spaces)?

Cheers

Marcel

On Thu, 2021-01-21 at 15:12 -0800, Daniel Walker wrote:
> Add Petra and Hellcat dts file. These platforms are based on
> the Xilinx Zynqmp platform.
> 
> Signed-off-by: Daniel Walker <dwalker@fifo99.com>
> Cc: xe-linux-external@cisco.com
> ---
>  arch/arm64/boot/dts/xilinx/Makefile           |   2 +
>  .../boot/dts/xilinx/zynqmp-petra-hellcat.dts  | 856 ++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-petra.dts   | 847 +++++++++++++++++
>  3 files changed, 1705 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra.dts
> 
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 60f5443f3ef4..d9eacb3c60e5 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -15,3 +15,5 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-petra.dts
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-petra-hellcat.dts
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts b/arch/arm64/boot/dts/xilinx/zynqmp-petra-
> hellcat.dts
> new file mode 100644
> index 000000000000..87e23c1cac65
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts
> @@ -0,0 +1,856 @@
> +/*
> + * dts file for Cisco Petra-Hellcat Switching IOT platform
> + *
> + * (C) Copyright 2016-2018, Cisco Systems, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
> +
> +/*
> + ********************* PL *********************
> + */
> +
> +/ {
> +    reserved-memory {
> +        #address-cells = <0x2>;
> +        #size-cells = <0x2>;
> +        ranges;
> +
> +        rproc@3ed00000 {
> +            no-map;
> +            reg = <0x0 0x3ed00000 0x0 0x1000000>;
> +        };
> +        zynqmp_sha_reserved: buffer@0 {
> +            compatible = "shared-dma-pool";
> +            no-map;
> +            reg = <0x0 0x78000000 0x0 0x00020000>;
> +        };
> +    }; 
> +
> +    sha384 {
> +        compatible = "xlnx,zynqmp-keccak-384";
> +        memory-region = <&zynqmp_sha_reserved>;
> +    };
> +
> +       amba_pl: amba_pl@0 {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               compatible = "simple-bus";
> +               ranges ;
> +               design_1_i_axi_iic_BP: i2c@80104000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +            clocks = <0x3 0x47>;

Spaces above vs. tabs before.

> ...

