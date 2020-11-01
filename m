Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA62A1E46
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgKANSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgKANSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:18:14 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD9C0617A6;
        Sun,  1 Nov 2020 05:18:13 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id y20so12317112iod.5;
        Sun, 01 Nov 2020 05:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYeAT6dJLfefaPNV5FnKXZ4l6XlxctIP4BfQPNcbJ74=;
        b=ZRezXskScbgR7llhZ7otT4TiSS4M0H4bD/Xz8WSOjVlRwhiTFsdqHsGK4d+QI/RxO1
         tSNI5vErt0Z8ITWNexK3M+BqT1eLjkAy2IYdzU96hJM5I3gxMKTByHtdf50cjBMtvvQL
         VZ6xchl8uYEkF7RiJIQUpvyWg0k9X1T0NyNQgJY7izOGB5EJu/1hcNdvwbgAE1uNMiQW
         7DQ+KVgSqOCPvW/O15b1a2JkG3ytu96TUPl7jqg5zGz0TLXtrMyVk2Orc5IU1GdETPyy
         Tzz1oiZFsA7msRorG+V4KYKQuPov6Cw5ojI5KcXlxb9JWRGF5RjjbX5V4Rc5vwmSb43N
         OimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYeAT6dJLfefaPNV5FnKXZ4l6XlxctIP4BfQPNcbJ74=;
        b=qaRPGSYZhyuCkCs2O2gpGr3sq3mNsSGrqLirMGfmUUr3Da7eQ7Uxv/3XJZ2V85h1Ua
         vy4Nd/ir4FuPXkgoevKor1Ou493Magbg8rvoIToTOOlrwUAlxui/V2G6tpmngk7oHbZH
         GDRKzPQGN8cegJdp+p+UhGbNmYZDp6DYkWc6IBq2HvG07lgSwZfKdrTUYb8KrOUksh8o
         LBYUID1wzr4h+hFViLwHJEqEUL7TsUvgD+ehn7nS6I/i6hnTKDvJCPLi3aBzX4aWgD1M
         qQNc4useBQFhdkE07DZhInLsswDhy4J+PMxpeBGfDn2DVNTxVYmzvEIu6SID3oSlP/P6
         oEhg==
X-Gm-Message-State: AOAM531Co3/uSKCZsCudb0J5NQwHTIhT/UZlOVbqNiswEKIkJYsEZvBu
        SGt/DsglU1hE3728tokIt6SI6jScD2tTUz3LIQw=
X-Google-Smtp-Source: ABdhPJxoEzc66/waHQsBWxCpNHn+7XsH2lL/aCsIinyjRY5z/0mXIhKLKplO6sUjGEq1nMiI3OmcWZKrPVzIRcyzHiY=
X-Received: by 2002:a05:6638:22bb:: with SMTP id z27mr8443320jas.47.1604236693098;
 Sun, 01 Nov 2020 05:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20201019174529.289499-1-aford173@gmail.com> <20201101020308.GC31601@dragon>
In-Reply-To: <20201101020308.GC31601@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 1 Nov 2020 07:18:01 -0600
Message-ID: <CAHCN7xLAROzBKFi67CiGzDGofu2QTwN4mwDMHPhBJnn_0d4BNg@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 9:03 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Oct 19, 2020 at 12:45:24PM -0500, Adam Ford wrote:
> > The driver exists for the Enhanced Asynchronous Sample Rate Converter
> > (EASRC) Controller, but there isn't a device tree entry for it.
> >
> > On the vendor kernel, they put this on a spba-bus for SDMA support.
> >
> > Add the the node for the spba-bus with the easrc node inside.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index 746faf1cf2fb..7d34281332e1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -246,6 +246,34 @@ aips1: bus@30000000 {
> >                       #size-cells = <1>;
> >                       ranges;
> >
> > +                     spba-bus@30000000 {
>
> spba: bus@30000000

Go ahead and disregard my V2.  I'll submit a V3.  I sent the V2 before
I got this feedback.

>
> > +                             compatible = "fsl,spba-bus", "simple-bus";
>
> "fsl,spba-bus" is undocumented.  Document it or drop it.

I just submitted a patch to document this bus.  It's used on a bunch
of imx boards, so I think it's important to document it.
I assigned you as the maintainer of the binding doc since you're
listed as the maintainer of the SDMA driver which is what's using
the compatible flag.  I hope that is the correct thing to do.

>
> > +                             #address-cells = <1>;
> > +                             #size-cells = <1>;
> > +                             reg = <0x30000000 0x100000>;
> > +                             ranges;
> > +
> > +                             easrc: easrc@300C0000 {
> > +                                     compatible = "fsl,imx8mn-easrc";
> > +                                     reg = <0x300C0000 0x10000>;
> > +                                     interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > +                                     clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> > +                                     clock-names = "mem";
> > +                                     dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> > +                                            <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> > +                                            <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> > +                                            <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> > +                                     dma-names = "ctx0_rx", "ctx0_tx",
> > +                                                 "ctx1_rx", "ctx1_tx",
> > +                                                 "ctx2_rx", "ctx2_tx",
> > +                                                 "ctx3_rx", "ctx3_tx";
> > +                                     fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";
>
> Undocumented property?

That's my fault.  I accidentally copied the device tree entry from the
vendor kernel instead of using the naming from the device tree binding
document.
I fixed this in my V2, but I need to send a V3 anyway.

adam

>
> Shawn
>
> > +                                     fsl,asrc-rate  = <8000>;
> > +                                     fsl,asrc-width = <16>;
> > +                                     status = "disabled";
> > +                             };
> > +                     };
> > +
> >                       gpio1: gpio@30200000 {
> >                               compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
> >                               reg = <0x30200000 0x10000>;
> > --
> > 2.25.1
> >
