Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5951F2851A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgJFSer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:34:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37997 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:34:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so7410702ota.5;
        Tue, 06 Oct 2020 11:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/nFz+O76MoZAtkSPqoZ0ETSJ6m02PU0D0DZHAvgJEQ=;
        b=EVCyH+KB+DDaT3khR0P+a9HXwSp+uGeNN+TxU2K6Mx79GmEP7MRzUWXxoCa3Dk2Nx/
         roZBIaWpMwd0302eaFtNEKEvtvLQ2Q18Z50I1YcPIxGsWvKSr9IC70Mk1X6q2Dn3NLPQ
         NayUeklL/bNRQ2ay1+AEtYk3Y+yJUEPmpBaPbXhHIu59/VSJGdvRT5Cw1anl+uS2XrqE
         UO/S33ACTowSJaC85onJj6MEQttBELLjNHnh/TRupMTug54uD1ouAmCCi4bWn0rM9l6Y
         tl+BcfCvmA4O04e5tKnfnAuygO4qglV8BuUAESGsIoyvygWJcjivmGgWJPIZczWqNvrV
         +0eQ==
X-Gm-Message-State: AOAM532hqUHiy+AmDcpCMuDz1xACntqahtMCuEuOyIQi084tBmfydJnO
        oKM02jY15fH1qXr6Ww8iwQ==
X-Google-Smtp-Source: ABdhPJx1phcZuRuWBcr3gfWZUoekTD2tydrcY/GXETjtFdoxVappQeymuyeEy49v7QhaTXJ8YJ0LpQ==
X-Received: by 2002:a9d:67c3:: with SMTP id c3mr4065466otn.9.1602009284472;
        Tue, 06 Oct 2020 11:34:44 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm1339206otl.71.2020.10.06.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:34:43 -0700 (PDT)
Received: (nullmailer pid 2597692 invoked by uid 1000);
        Tue, 06 Oct 2020 18:34:42 -0000
Date:   Tue, 6 Oct 2020 13:34:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: dt-bindings: fsl_xcvr: Add document for XCVR
Message-ID: <20201006183442.GA2591611@bogus>
References: <1601371167-32239-1-git-send-email-viorel.suman@oss.nxp.com>
 <1601371167-32239-3-git-send-email-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601371167-32239-3-git-send-email-viorel.suman@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:19:27PM +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> XCVR (Audio Transceiver) is a new IP module found on i.MX8MP.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,xcvr.yaml        | 103 +++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> new file mode 100644
> index 00000000..8abab2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,xcvr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Audio Transceiver (XCVR) Controller
> +
> +maintainers:
> +  - Viorel Suman <viorel.suman@nxp.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^xcvr@.*"
> +
> +  compatible:
> +    const: fsl,imx8mp-xcvr
> +
> +  reg:
> +    items:
> +      - description: 20K RAM for code and data
> +      - description: registers space
> +      - description: RX FIFO address
> +      - description: TX FIFO address
> +
> +  reg-names:
> +    items:
> +      - const: ram
> +      - const: regs
> +      - const: rxfifo
> +      - const: txfifo
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +      - description: PHY clock
> +      - description: SPBA clock
> +      - description: PLL clock
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: phy
> +      - const: spba
> +      - const: pll_ipg
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    const: imx/xcvr/xcvr-imx8mp.bin
> +    description: |
> +      Should contain the name of the default firmware image
> +      file located on the firmware search path

We generally only have this if the name/path can't be fixed (per 
compatible) in the driver. Given you only have 1 possible value, that 
doesn't seem to be the case here.

> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - firmware-name
> +  - resets

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +    #include <dt-bindings/reset/imx8mp-reset.h>
> +
> +    xcvr: xcvr@30cc0000 {
> +           compatible = "fsl,imx8mp-xcvr";
> +           reg = <0x30cc0000 0x800>,
> +                 <0x30cc0800 0x400>,
> +                 <0x30cc0c00 0x080>,
> +                 <0x30cc0e00 0x080>;
> +           reg-names = "ram", "regs", "rxfifo", "txfifo";
> +           interrupts = <0x0 128 IRQ_TYPE_LEVEL_HIGH>;
> +           clocks = <&audiomix_clk IMX8MP_CLK_AUDIOMIX_EARC_IPG>,
> +                    <&audiomix_clk IMX8MP_CLK_AUDIOMIX_EARC_PHY>,
> +                    <&audiomix_clk IMX8MP_CLK_AUDIOMIX_SPBA2_ROOT>,
> +                    <&audiomix_clk IMX8MP_CLK_AUDIOMIX_AUDPLL_ROOT>;
> +           clock-names = "ipg", "phy", "spba", "pll_ipg";
> +           dmas = <&sdma2 30 2 0>, <&sdma2 31 2 0>;
> +           dma-names = "rx", "tx";
> +           firmware-name = "imx/xcvr/xcvr-imx8mp.bin";
> +           resets = <&audiomix_reset 0>;
> +    };
> -- 
> 2.7.4
> 
