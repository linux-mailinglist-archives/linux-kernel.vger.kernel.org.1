Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E252E70A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgL2M1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2M1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:27:33 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B6C061793;
        Tue, 29 Dec 2020 04:26:53 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n4so11934808iow.12;
        Tue, 29 Dec 2020 04:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d++z/oFIkUK4MtkoJbbF9fYR2sWbJGUOSnmPIGySfGQ=;
        b=UyG8+3YvGERn7TItkcj7XjdTNN0oynx300och3nEgvurZ5y+3oOHub0YlhwUokz495
         OsUpTLV3aP1xB9blS0S2Q3C8fzWIYQFCBT4KJtMzwe8DR8XalEh1zbmiWQrMa0f6OS2+
         1Ort0sHSMVHIIy0CfgO18AaSvWCsLydY6ln1F644zbh94czDQh1pBQzM4ssj7JALfIfN
         4PofTh3fFVua0HD5/yVzn/AQZhV1IMePIKXPO3vJa1hHVywNOwMKFBRD5/UI3crYrkUd
         YU6a9k37C6kn7je/61a2zqSwDV99pIfumoeO7DHWXkiUshKmsLC4hBTGljk2zNlqIqXN
         I3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d++z/oFIkUK4MtkoJbbF9fYR2sWbJGUOSnmPIGySfGQ=;
        b=SWK/ckXxIj2NHoZUkMErVjQn0ejv9E+g8D7N3GTmVX4CAKgiX0AYWsyD7wno+5EcNB
         zFvnW961+8WxlRGCHty1x8FmK5VA1HIKwpmT6GZrp4XDPWEfPGUGIKci8O33z1Y1LmIm
         2gKcHhwj6UtK7n5HV2laEb0GNbdxQyYFbNrji8djxqJvKJv5ehvkn0CpFYKOyTkipG3a
         eLv5l/kFNeaz/snhBW3nJh+3QXkdRxVAt1lFBCFmWBEuovOjjdQrf6RRica/oUc49Tsk
         Ic7Dm7n8QBHf+gQhGf3hRheCjBH+vJWAGbvJlPOfWASuamQdn2MqDYw+ab5jFUMfgpjN
         f+VA==
X-Gm-Message-State: AOAM533Oh981cyyRt9c7yMR1/zj6GbNFSY/4VSt18C9yWHHdTs6SVqDw
        MWo2zWurQdUehO/RcH5WZ+fBwG4XBy7OG+sW3hM=
X-Google-Smtp-Source: ABdhPJx+xLhpzMnj9UGuagfEpTyjq2191D5Zg4SR8zdIryqB4Gc/0cktuKhwKnWhFQMiliKkb4+j5EVxtzx//SXQD2Q=
X-Received: by 2002:a02:ca09:: with SMTP id i9mr42482825jak.135.1609244812406;
 Tue, 29 Dec 2020 04:26:52 -0800 (PST)
MIME-Version: 1.0
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com> <1609243245-9671-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1609243245-9671-3-git-send-email-peng.fan@nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 29 Dec 2020 06:26:41 -0600
Message-ID: <CAHCN7x+=ebLn8vrrT=fyByQDydDNfkESFZHjdUrw=OHBz_E0hw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 6:15 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> According to RM, there is a spba bus inside aips3 and aips1, add it.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 362 +++++++++++-----------
>  1 file changed, 189 insertions(+), 173 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c824f2615fe8..91f85b8cee9a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -269,117 +269,125 @@ aips1: bus@30000000 {
>                         #size-cells = <1>;
>                         ranges = <0x30000000 0x30000000 0x400000>;
>
> -                       sai1: sai@30010000 {
> -                               #sound-dai-cells = <0>;
> -                               compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> -                               reg = <0x30010000 0x10000>;
> -                               interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
> -                                        <&clk IMX8MM_CLK_SAI1_ROOT>,
> -                                        <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> -                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> -                               dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                       bus@30000000 {

There is already a bus@30000000 (aips1), and I think the system
doesn't like it when there are multiple busses with the same name.

There was some discussion on fixing the 8mn [1], but it doesn't look
like it went anywhere.

I am guessing the Mini will need something similar to the nano.

[1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com/

adam



> +                               compatible = "fsl,spba-bus", "simple-bus";
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               reg = <0x30000000 0x100000>;
> +                               ranges;
> +
> +                               sai1: sai@30010000 {
> +                                       #sound-dai-cells = <0>;
> +                                       compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> +                                       reg = <0x30010000 0x10000>;
> +                                       interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
> +                                                <&clk IMX8MM_CLK_SAI1_ROOT>,
> +                                                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +                                       clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +                                       dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       sai2: sai@30020000 {
> -                               #sound-dai-cells = <0>;
> -                               compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> -                               reg = <0x30020000 0x10000>;
> -                               interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_SAI2_IPG>,
> -                                       <&clk IMX8MM_CLK_SAI2_ROOT>,
> -                                       <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> -                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> -                               dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               sai2: sai@30020000 {
> +                                       #sound-dai-cells = <0>;
> +                                       compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> +                                       reg = <0x30020000 0x10000>;
> +                                       interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_SAI2_IPG>,
> +                                               <&clk IMX8MM_CLK_SAI2_ROOT>,
> +                                               <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +                                       clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +                                       dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       sai3: sai@30030000 {
> -                               #sound-dai-cells = <0>;
> -                               compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> -                               reg = <0x30030000 0x10000>;
> -                               interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_SAI3_IPG>,
> -                                        <&clk IMX8MM_CLK_SAI3_ROOT>,
> -                                        <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> -                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> -                               dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               sai3: sai@30030000 {
> +                                       #sound-dai-cells = <0>;
> +                                       compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> +                                       reg = <0x30030000 0x10000>;
> +                                       interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_SAI3_IPG>,
> +                                                <&clk IMX8MM_CLK_SAI3_ROOT>,
> +                                                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +                                       clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +                                       dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       sai5: sai@30050000 {
> -                               #sound-dai-cells = <0>;
> -                               compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> -                               reg = <0x30050000 0x10000>;
> -                               interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_SAI5_IPG>,
> -                                        <&clk IMX8MM_CLK_SAI5_ROOT>,
> -                                        <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> -                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> -                               dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               sai5: sai@30050000 {
> +                                       #sound-dai-cells = <0>;
> +                                       compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> +                                       reg = <0x30050000 0x10000>;
> +                                       interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_SAI5_IPG>,
> +                                                <&clk IMX8MM_CLK_SAI5_ROOT>,
> +                                                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +                                       clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +                                       dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       sai6: sai@30060000 {
> -                               #sound-dai-cells = <0>;
> -                               compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> -                               reg = <0x30060000 0x10000>;
> -                               interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_SAI6_IPG>,
> -                                        <&clk IMX8MM_CLK_SAI6_ROOT>,
> -                                        <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> -                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> -                               dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               sai6: sai@30060000 {
> +                                       #sound-dai-cells = <0>;
> +                                       compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> +                                       reg = <0x30060000 0x10000>;
> +                                       interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_SAI6_IPG>,
> +                                                <&clk IMX8MM_CLK_SAI6_ROOT>,
> +                                                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +                                       clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +                                       dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       micfil: audio-controller@30080000 {
> -                               compatible = "fsl,imx8mm-micfil";
> -                               reg = <0x30080000 0x10000>;
> -                               interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> -                                            <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> -                                            <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> -                                            <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_PDM_IPG>,
> -                                        <&clk IMX8MM_CLK_PDM_ROOT>,
> -                                        <&clk IMX8MM_AUDIO_PLL1_OUT>,
> -                                        <&clk IMX8MM_AUDIO_PLL2_OUT>,
> -                                        <&clk IMX8MM_CLK_EXT3>;
> -                               clock-names = "ipg_clk", "ipg_clk_app",
> -                                             "pll8k", "pll11k", "clkext3";
> -                               dmas = <&sdma2 24 25 0x80000000>;
> -                               dma-names = "rx";
> -                               status = "disabled";
> -                       };
> +                               micfil: audio-controller@30080000 {
> +                                       compatible = "fsl,imx8mm-micfil";
> +                                       reg = <0x30080000 0x10000>;
> +                                       interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +                                                    <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +                                                    <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +                                                    <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_PDM_IPG>,
> +                                                <&clk IMX8MM_CLK_PDM_ROOT>,
> +                                                <&clk IMX8MM_AUDIO_PLL1_OUT>,
> +                                                <&clk IMX8MM_AUDIO_PLL2_OUT>,
> +                                                <&clk IMX8MM_CLK_EXT3>;
> +                                       clock-names = "ipg_clk", "ipg_clk_app",
> +                                                     "pll8k", "pll11k", "clkext3";
> +                                       dmas = <&sdma2 24 25 0x80000000>;
> +                                       dma-names = "rx";
> +                                       status = "disabled";
> +                               };
>
> -                       spdif1: spdif@30090000 {
> -                               compatible = "fsl,imx35-spdif";
> -                               reg = <0x30090000 0x10000>;
> -                               interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
> -                                        <&clk IMX8MM_CLK_24M>, /* rxtx0 */
> -                                        <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
> -                                        <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
> -                                        <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
> -                                        <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
> -                                        <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
> -                                        <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
> -                                        <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
> -                                        <&clk IMX8MM_CLK_DUMMY>; /* spba */
> -                               clock-names = "core", "rxtx0",
> -                                             "rxtx1", "rxtx2",
> -                                             "rxtx3", "rxtx4",
> -                                             "rxtx5", "rxtx6",
> -                                             "rxtx7", "spba";
> -                               dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> +                               spdif1: spdif@30090000 {
> +                                       compatible = "fsl,imx35-spdif";
> +                                       reg = <0x30090000 0x10000>;
> +                                       interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
> +                                                <&clk IMX8MM_CLK_24M>, /* rxtx0 */
> +                                                <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
> +                                                <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
> +                                                <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
> +                                                <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
> +                                                <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
> +                                                <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
> +                                                <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
> +                                                <&clk IMX8MM_CLK_DUMMY>; /* spba */
> +                                       clock-names = "core", "rxtx0",
> +                                                     "rxtx1", "rxtx2",
> +                                                     "rxtx3", "rxtx4",
> +                                                     "rxtx5", "rxtx6",
> +                                                     "rxtx7", "spba";
> +                                       dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>                         };
>
>                         gpio1: gpio@30200000 {
> @@ -660,80 +668,88 @@ aips3: bus@30800000 {
>                         ranges = <0x30800000 0x30800000 0x400000>,
>                                  <0x8000000 0x8000000 0x10000000>;
>
> -                       ecspi1: spi@30820000 {
> -                               compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> +                       bus@30800000 {
> +                               compatible = "fsl,spba-bus", "simple-bus";
>                                 #address-cells = <1>;
> -                               #size-cells = <0>;
> -                               reg = <0x30820000 0x10000>;
> -                               interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_ECSPI1_ROOT>,
> -                                        <&clk IMX8MM_CLK_ECSPI1_ROOT>;
> -                               clock-names = "ipg", "per";
> -                               dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               #size-cells = <1>;
> +                               reg = <0x30800000 0x100000>;
> +                               ranges;
> +
> +                               ecspi1: spi@30820000 {
> +                                       compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x30820000 0x10000>;
> +                                       interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_ECSPI1_ROOT>,
> +                                                <&clk IMX8MM_CLK_ECSPI1_ROOT>;
> +                                       clock-names = "ipg", "per";
> +                                       dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       ecspi2: spi@30830000 {
> -                               compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> -                               #address-cells = <1>;
> -                               #size-cells = <0>;
> -                               reg = <0x30830000 0x10000>;
> -                               interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_ECSPI2_ROOT>,
> -                                        <&clk IMX8MM_CLK_ECSPI2_ROOT>;
> -                               clock-names = "ipg", "per";
> -                               dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               ecspi2: spi@30830000 {
> +                                       compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x30830000 0x10000>;
> +                                       interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_ECSPI2_ROOT>,
> +                                                <&clk IMX8MM_CLK_ECSPI2_ROOT>;
> +                                       clock-names = "ipg", "per";
> +                                       dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       ecspi3: spi@30840000 {
> -                               compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> -                               #address-cells = <1>;
> -                               #size-cells = <0>;
> -                               reg = <0x30840000 0x10000>;
> -                               interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_ECSPI3_ROOT>,
> -                                        <&clk IMX8MM_CLK_ECSPI3_ROOT>;
> -                               clock-names = "ipg", "per";
> -                               dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               ecspi3: spi@30840000 {
> +                                       compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x30840000 0x10000>;
> +                                       interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_ECSPI3_ROOT>,
> +                                                <&clk IMX8MM_CLK_ECSPI3_ROOT>;
> +                                       clock-names = "ipg", "per";
> +                                       dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       uart1: serial@30860000 {
> -                               compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
> -                               reg = <0x30860000 0x10000>;
> -                               interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_UART1_ROOT>,
> -                                        <&clk IMX8MM_CLK_UART1_ROOT>;
> -                               clock-names = "ipg", "per";
> -                               dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               uart1: serial@30860000 {
> +                                       compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
> +                                       reg = <0x30860000 0x10000>;
> +                                       interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_UART1_ROOT>,
> +                                                <&clk IMX8MM_CLK_UART1_ROOT>;
> +                                       clock-names = "ipg", "per";
> +                                       dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       uart3: serial@30880000 {
> -                               compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
> -                               reg = <0x30880000 0x10000>;
> -                               interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_UART3_ROOT>,
> -                                        <&clk IMX8MM_CLK_UART3_ROOT>;
> -                               clock-names = "ipg", "per";
> -                               dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> -                               dma-names = "rx", "tx";
> -                               status = "disabled";
> -                       };
> +                               uart3: serial@30880000 {
> +                                       compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
> +                                       reg = <0x30880000 0x10000>;
> +                                       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_UART3_ROOT>,
> +                                                <&clk IMX8MM_CLK_UART3_ROOT>;
> +                                       clock-names = "ipg", "per";
> +                                       dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> +                                       dma-names = "rx", "tx";
> +                                       status = "disabled";
> +                               };
>
> -                       uart2: serial@30890000 {
> -                               compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
> -                               reg = <0x30890000 0x10000>;
> -                               interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clk IMX8MM_CLK_UART2_ROOT>,
> -                                        <&clk IMX8MM_CLK_UART2_ROOT>;
> -                               clock-names = "ipg", "per";
> -                               status = "disabled";
> +                               uart2: serial@30890000 {
> +                                       compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
> +                                       reg = <0x30890000 0x10000>;
> +                                       interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MM_CLK_UART2_ROOT>,
> +                                                <&clk IMX8MM_CLK_UART2_ROOT>;
> +                                       clock-names = "ipg", "per";
> +                                       status = "disabled";
> +                               };
>                         };
>
>                         crypto: crypto@30900000 {
> --
> 2.28.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
