Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9470E2C93B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbgLAAJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbgLAAJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:09:17 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E202CC0613D2;
        Mon, 30 Nov 2020 16:08:36 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id f20so5374276ioc.12;
        Mon, 30 Nov 2020 16:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LIjPe1ddrNQtbgZL7NsrcHrWkQiww/enltfYuRG5i8=;
        b=fxM2869V3mR9pm1gipA3kIqryH7UQmMjU+8MmCehC8LspUN+DJTpbsi25AKovL1bZU
         2+88Bku7SvpGfhP2L9BblYiFvBvqosyqQfQ35wG2EUhVnYctvsXgU0W6gSzsSO6iVtUu
         5zQU1d2rLISVW2O665ajvuFAFuHIY7mxwebHCehUUWx8Zar5Pw5Co0ebN31DiGu+btQ4
         9CJl912AF8f/735NGUkp5QQrFZajOI68IY9iURvYIoWQQpV0VpLXAmqc46Y5wns3iABI
         AJbuqXcmwGoeO56Sr+vs4qqxtyNiLhT3ybxUgaiJtqEznO8w23/YBgQhde6YnJWXl/fh
         yy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LIjPe1ddrNQtbgZL7NsrcHrWkQiww/enltfYuRG5i8=;
        b=Vxrq+JwaRaBy6jcKBLTQod2MfXpu9EFShIjXt0xJ4DAvBsIdyWgyXBvtAQPOlymlWg
         AKi8T0rjWcj6tufNMqh9SbaPKMgunnU6uc+InKtMjQxKgM8WRXWP+tVB3EEd0F4324Y/
         i0GZBBcRjdCKaVb0bzAgNU5ZY5t9odYpeE9TrU5CuMbXzZEQ5G2pWghla1eXn9A0/OaC
         s/TG8IWPBQWhgSm9KaaPbxavbO0u8l6wzCTzaRPjwx7pmIrXJhZEhIwFF/ZXyvzLjohK
         XqiLFl5XOwQpPmeh4OUQfAbAjMA0wJq4dhyPAc/qLPbSczA34NLMMDYGaRfiJnLfZn4u
         GiDA==
X-Gm-Message-State: AOAM532ooKQxsvxm/+1mur3taXCLiT0UnnF412J6bRRdUjJ4t6m+XIpo
        3VLe8BMpGaPa9ctWujTnrsKhHIZLzWg6ETKFekgdSrbDvKp7Sg==
X-Google-Smtp-Source: ABdhPJxixhvFBhd/XUaDp+4XSCsCo5c26Ri07x0QWOOht/Fm978RKOghwM2ctILkGH2Ba1FXAL+/GVH2P1emb6WumO0=
X-Received: by 2002:a05:6638:153:: with SMTP id y19mr301689jao.47.1606781316019;
 Mon, 30 Nov 2020 16:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20201107115809.1866131-1-aford173@gmail.com> <20201107115809.1866131-2-aford173@gmail.com>
 <CAHCN7xLxUHoc=VFHhbo36ytCLMc11a8DbD1Gh5eK2vogO=75Ww@mail.gmail.com>
In-Reply-To: <CAHCN7xLxUHoc=VFHhbo36ytCLMc11a8DbD1Gh5eK2vogO=75Ww@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 30 Nov 2020 18:08:25 -0600
Message-ID: <CAHCN7xJ8y--v-xbY+Z-SjxScDsAqkxBiqgCMyZMTLzJxdy8nig@mail.gmail.com>
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

On Wed, Nov 18, 2020 at 5:13 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Sat, Nov 7, 2020 at 5:58 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > The driver exists for the Enhanced Asynchronous Sample Rate Converter
> > (EASRC) Controller, but there isn't a device tree entry for it.
> >
> > On the vendor kernel, they put this on a spba-bus for SDMA support.
> >
> > Add the node for the spba-bus with the easrc node inside.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Shawn,
>
> I split the dt-binding into a separate patch since I was struggling
> with checking the yaml syntax.  Rob helped me find the proper branch
> to use. I hope it goes through this time.
>
> Do you have any comments on the rest of the series? I would like to
> fix them if you have any concerns so I can resend if/when the
> dt-binding is accepted.

Shawn,

The dt-binding was accepted per [1].  How do you want me to proceed
for the rest of the series?  I can resend the other parts without the
dt-binding if you like.

thanks,

adam
[1] - https://lkml.org/lkml/2020/11/30/1211

>
> thanks,
>
> adam
>
> > ---
> > V4:  No change
> > V3:  Change spba-bus@30000000 to spba: bus@30000000
> > V2:  Make the DT node more in-line with the dt binding and remove
> >      vendor customizations that are not applicable.
> >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 28 +++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index a06d2a6268e6..61560c083300 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -253,6 +253,34 @@ aips1: bus@30000000 {
> >                         #size-cells = <1>;
> >                         ranges;
> >
> > +                       spba: bus@30000000 {
> > +                               compatible = "fsl,spba-bus", "simple-bus";
> > +                               #address-cells = <1>;
> > +                               #size-cells = <1>;
> > +                               reg = <0x30000000 0x100000>;
> > +                               ranges;
> > +
> > +                               easrc: easrc@300c0000 {
> > +                                       compatible = "fsl,imx8mn-easrc";
> > +                                       reg = <0x300c0000 0x10000>;
> > +                                       interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > +                                       clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> > +                                       clock-names = "mem";
> > +                                       dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> > +                                              <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> > +                                              <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> > +                                              <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> > +                                       dma-names = "ctx0_rx", "ctx0_tx",
> > +                                                   "ctx1_rx", "ctx1_tx",
> > +                                                   "ctx2_rx", "ctx2_tx",
> > +                                                   "ctx3_rx", "ctx3_tx";
> > +                                       firmware-name = "imx/easrc/easrc-imx8mn.bin";
> > +                                       fsl,asrc-rate  = <8000>;
> > +                                       fsl,asrc-format = <2>;
> > +                                       status = "disabled";
> > +                               };
> > +                       };
> > +
> >                         gpio1: gpio@30200000 {
> >                                 compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
> >                                 reg = <0x30200000 0x10000>;
> > --
> > 2.25.1
> >
