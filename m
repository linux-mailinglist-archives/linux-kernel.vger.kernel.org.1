Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15729DAED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbgJ1Xim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389019AbgJ1Xha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:37:30 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8844C0613CF;
        Wed, 28 Oct 2020 16:37:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so1392712ioo.7;
        Wed, 28 Oct 2020 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/A3CEwa9ZFQ6exulGwUCkA+aZ+1mPx+5qugmy/RoAHc=;
        b=VoD311MDfxBIgRqk43Hi8k7w5dsWdemKv5g5D01kst8I7lYMqYEw7EHrLuiMDMhnMJ
         Nfkd2V53e45RjYqUKzFzAGwjpydQ0M/Ediw6eN6lwRxkof2o3jbc2nRiScnfdbDG6zcR
         b2l++CcrXH555WrlbATUIsuEyuCx4z8q1XT7V7RDHDSjCFkKQ/ZymlJwTdgCSjH7PwJl
         V4zXyG583t1Xx3JzxAr/QIdV2u0QCgoeoAb8Nhgzcy9dXlhv+ky5+hBFmT7MoefWFWu1
         vNoTrcOl9VmI4XJeHv3IsmTomuUdjw4oiORf/KUFOerYOIddmvfsxrNsQ/QQDPf65kSr
         qMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/A3CEwa9ZFQ6exulGwUCkA+aZ+1mPx+5qugmy/RoAHc=;
        b=t41vYzgOomOF1OQJS37exK6E7PO8A9ZKRpeoP6XSN6R7VmCslHDWL+2W/47OUVDxK2
         mIABJQRRwyxiU1N/6d8m7xZpG5fdhdAXN5ZXVyrq6f7LGd5O0WYe2QmxkV7yFXCFupN/
         kmcqk3qAUvjcrsvNf1qKWRv1Pu1UXeXVE3SwVBQou+8HdvUCrDBGVrMLdf11HJogC9Tk
         nnjTYIw8rx7F3Errqj1+r4jBXaVwfoXhiIySVTEVyfg/cPpm9DLGKFST+3c61sy6I1Ay
         EcDzIPPsLDGN5Qt1I4EtK8kBhdNQloJ5E87c0JrAPGllT9mKPGPr+G9Nr6BoVm1KPMTy
         bxTw==
X-Gm-Message-State: AOAM531v5y90HCKPX32IkT9wZ1KHs5kB1GmbWQEVgPWkoY+EJNL0iayf
        zBynFQkhBfXacVZ3sHtPzRwkOr+tspGsW+hgs7lzx1fwXm8=
X-Google-Smtp-Source: ABdhPJxB39cK4LoLPV+rayymmlN4yuGJL6W04dfmN5biZiNchT7DQioArPW9ZWexdAhR2Swk3KQ5KSCHwBGQEvqE+sA=
X-Received: by 2002:a5d:8487:: with SMTP id t7mr5793859iom.35.1603887047936;
 Wed, 28 Oct 2020 05:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200502125949.194032-1-aford173@gmail.com> <20200502125949.194032-2-aford173@gmail.com>
 <20200520010348.GE11739@dragon>
In-Reply-To: <20200520010348.GE11739@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 28 Oct 2020 07:10:37 -0500
Message-ID: <CAHCN7xKBx_YXCGSUJWO3YCaGfx4oc7iuv6S4qi500_NjV9pW=w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add support for micfil
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        aford@beaconemedded.com, Rob Herring <robh+dt@kernel.org>,
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

On Tue, May 19, 2020 at 8:03 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Sat, May 02, 2020 at 07:59:48AM -0500, Adam Ford wrote:
> > The i.MX8M Mini has supports the MICFIL digital interface.
> > It's a 16-bit audio signal from a PDM microphone bitstream.
> > The driver is already in the kernel, but the node is missing.
> >
> > This patch adds the micfil node.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index c63685ae80ee..d46e727fc362 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -339,6 +339,25 @@ sai6: sai@30060000 {
> >                               status = "disabled";
> >                       };
> >
> > +                     micfil: micfil@30080000 {
>
> Find a generic node name, audio-controller maybe?

The SAI's nodes are called SAI@xxxx

If that's a deal-breaker, I can push a V3.

I didn't see anyone from the device tree side comment, and the device
tree binding doc states 'micfil@xxxxxx' so I used what was documented
in the fsl,micfil.txt

adam
>
> Shawn
>
> > +                             compatible = "fsl,imx8mm-micfil";
> > +                             reg = <0x30080000 0x10000>;
> > +                             interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > +                                          <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> > +                                          <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> > +                                          <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clocks = <&clk IMX8MM_CLK_PDM_IPG>,
> > +                                      <&clk IMX8MM_CLK_PDM_ROOT>,
> > +                                      <&clk IMX8MM_AUDIO_PLL1_OUT>,
> > +                                      <&clk IMX8MM_AUDIO_PLL2_OUT>,
> > +                                      <&clk IMX8MM_CLK_EXT3>;
> > +                             clock-names = "ipg_clk", "ipg_clk_app",
> > +                                           "pll8k", "pll11k", "clkext3";
> > +                             dmas = <&sdma2 24 25 0x80000000>;
> > +                             dma-names = "rx";
> > +                             status = "disabled";
> > +                     };
> > +
> >                       gpio1: gpio@30200000 {
> >                               compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
> >                               reg = <0x30200000 0x10000>;
> > --
> > 2.25.1
> >
