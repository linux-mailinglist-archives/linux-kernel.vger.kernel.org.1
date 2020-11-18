Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28662B883B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKRXOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgKRXOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:14:07 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F19DC0613D4;
        Wed, 18 Nov 2020 15:14:07 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id j23so3930257iog.6;
        Wed, 18 Nov 2020 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cORbKtU76Psix/GK5OrEHSszl8JAUDGusX/snTcAhko=;
        b=SDdiurQd1M90OQwpwBkVsT/bkyk6tLQlJP3XiG2jEGoMdvQc9kv7BwlMZIVY6xmfAe
         6z7BxCNu+bFDTc5hYz3cl6HBGt4S91dxh5VXs+oYXWn1D5E2pYlzBaQCf5SSK3196IJX
         JvmI4XaciZsbZi5vEuLudhMdvvh+41ztl/HQ0lM52wkaj8rCWG2jbEY451vdrH+LSrzx
         uKn72d8g5kSREGqIBorzx1RUmak2iv5D93QEG7JJO0oMkQhGSEUxNWGPRDGBAdeSaahN
         Q1W8G2nGJnIdX6YzdHiGbgKQULlvof41T++QGO3m5LYGTXFD9RVJrBuweg0Kr72KADgg
         Dmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cORbKtU76Psix/GK5OrEHSszl8JAUDGusX/snTcAhko=;
        b=H9EHcpe7duSzxvR5fzwuo0zGUeMtzl9rmVk9InTcGSLOj/+FLWVsOmhHhDTKaN3prm
         A8ITE29G5dkxEzJHu950GsTmLqqPKjihQEPAAeOu+RPFiTMiT7zYXB3GYjHhtfiejms+
         Y27uJDFC0YF5KcK/pu4z+kVB8UzRRl5hYt5F6Jz6GHvd2HY0pcOPzxTRrUd6DYenfb/K
         uMb6HgBruPw2eA1gqUohfIej3Pj9VMTmxtAdPdIXrDbRRnLVT8oPMJWtVSO/OH74MTy0
         bl7OxU6jHUky06fxm7HMG8+FCs0Zjlg4NHli+nA1VkEuce3WQHqQLSbJkbDeYpP5el+z
         60Yg==
X-Gm-Message-State: AOAM531tzbcCaWJ7IoNXeQjV/k3DRY+KV6X364/nwGvne+x0VTaV4QOV
        mdCc4YhAmLGwnm742KOSwzpsj0kkNZJQXe0WupQ=
X-Google-Smtp-Source: ABdhPJxmS19vZNzw0U8sLRt5vOW0HhRnp5WfN+8B5YozHZ8kiIhyzVxCJk9gkxLsgzl9KM6ff7AuUMix7ZWRN7lMQRc=
X-Received: by 2002:a5d:9b8f:: with SMTP id r15mr18016223iom.35.1605741246325;
 Wed, 18 Nov 2020 15:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20201107115809.1866131-1-aford173@gmail.com> <20201107115809.1866131-2-aford173@gmail.com>
In-Reply-To: <20201107115809.1866131-2-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Nov 2020 17:13:54 -0600
Message-ID: <CAHCN7xLxUHoc=VFHhbo36ytCLMc11a8DbD1Gh5eK2vogO=75Ww@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] arm64: dts: imx8mn: Enable Asynchronous Sample
 Rate Converter
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 7, 2020 at 5:58 AM Adam Ford <aford173@gmail.com> wrote:
>
> The driver exists for the Enhanced Asynchronous Sample Rate Converter
> (EASRC) Controller, but there isn't a device tree entry for it.
>
> On the vendor kernel, they put this on a spba-bus for SDMA support.
>
> Add the node for the spba-bus with the easrc node inside.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Shawn,

I split the dt-binding into a separate patch since I was struggling
with checking the yaml syntax.  Rob helped me find the proper branch
to use. I hope it goes through this time.

Do you have any comments on the rest of the series? I would like to
fix them if you have any concerns so I can resend if/when the
dt-binding is accepted.

thanks,

adam

> ---
> V4:  No change
> V3:  Change spba-bus@30000000 to spba: bus@30000000
> V2:  Make the DT node more in-line with the dt binding and remove
>      vendor customizations that are not applicable.
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index a06d2a6268e6..61560c083300 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -253,6 +253,34 @@ aips1: bus@30000000 {
>                         #size-cells = <1>;
>                         ranges;
>
> +                       spba: bus@30000000 {
> +                               compatible = "fsl,spba-bus", "simple-bus";
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               reg = <0x30000000 0x100000>;
> +                               ranges;
> +
> +                               easrc: easrc@300c0000 {
> +                                       compatible = "fsl,imx8mn-easrc";
> +                                       reg = <0x300c0000 0x10000>;
> +                                       interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> +                                       clock-names = "mem";
> +                                       dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> +                                              <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> +                                              <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> +                                              <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> +                                       dma-names = "ctx0_rx", "ctx0_tx",
> +                                                   "ctx1_rx", "ctx1_tx",
> +                                                   "ctx2_rx", "ctx2_tx",
> +                                                   "ctx3_rx", "ctx3_tx";
> +                                       firmware-name = "imx/easrc/easrc-imx8mn.bin";
> +                                       fsl,asrc-rate  = <8000>;
> +                                       fsl,asrc-format = <2>;
> +                                       status = "disabled";
> +                               };
> +                       };
> +
>                         gpio1: gpio@30200000 {
>                                 compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
>                                 reg = <0x30200000 0x10000>;
> --
> 2.25.1
>
