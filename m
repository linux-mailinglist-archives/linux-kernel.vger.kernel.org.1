Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFD27C2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgI2K5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgI2K5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:57:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3526AC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:57:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so14393445eja.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FhizWYiFCKnBtC8/tA+nizG1qTE8PVjfV9nyM3Y1zO8=;
        b=pdwAIkxvU9Pwa87xAP6RNIhpm3ZfmbmA8ia8TXtHVNVEEAss8VNnr3AcQL/IVjQwNA
         gYcVrxXZWaH8Y2cda7fE2hGU0P/Mj33lRx6NSpTT3BwXGWKV1JDbiY1T3n9tHday6yK/
         dAzzVMTiGPdiOhGK+3pRQ/pvsxMq5RXygh1rVx4fHaBo9wyMqXwI2YA9u02bPVsujJS+
         DKqwsbkmnQquEJkpf2zBhLGciUJ8jN06qyKZwmPXsYnq/wlT/ZCHwLBI4S4AjTsRK27B
         qqQWzMfoTJXvQavl+u8CP/ds63M1dKU7toCsvRPA09PlZB7rvnElubehR1dowwDk4Q+9
         vtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FhizWYiFCKnBtC8/tA+nizG1qTE8PVjfV9nyM3Y1zO8=;
        b=pZY3UDXhmsiEg4hZ/ASb8+5QPPNm7ycWpxNrPuCfOoWT3X79eozQ0UsDh5Sv2Ifjnk
         cLp/ZAdyk1KB92OrvLJnGlu8YOvo3Bp+APn5lUzqbZ4Flv2DZ7mKS7YhFefhXJLB7FQo
         eZ54z0IJKAif63x315fWoVQ/DZEeHxAKuMRCykqhoxf9ClOcoYpLxwSpA31y72hlo0m+
         5sZADp9Du0eMJuh5p54hnaiIyy5pCCN8C1i2IIqYumYJFXAcVqaWb1J4jP7BSXDFt8Z2
         y5Nr7Las9Tb0lqDIaFxvkunRch31PaF3Rn1i/9tggMgFRreDInHo8C1hZAqIeO8JNfbC
         I7sQ==
X-Gm-Message-State: AOAM531Cxc6hIVWymS9VbaYx4MGCcXj7db7XVFMnSTXbcztmO1dxrJFf
        /exzyVzomsNj2FKbEJNvWcbnLfwF5ocXWnR7gw6g8cj6BYQ=
X-Google-Smtp-Source: ABdhPJxDe1VD06bmgQQAfhWXToP7XtNSgbLxKOeGr2nV8Nyjh5Vw1Ydaz9jhh+ZMj+Bv5SGFgghQ+wP+TRG4hoQ+iwM=
X-Received: by 2002:a17:906:7cb:: with SMTP id m11mr3296888ejc.41.1601377037669;
 Tue, 29 Sep 2020 03:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <68f20a2b2bb0feee80bc3348619c2ee98aa69963.1598263539.git.michal.simek@xilinx.com>
In-Reply-To: <68f20a2b2bb0feee80bc3348619c2ee98aa69963.1598263539.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 29 Sep 2020 12:57:06 +0200
Message-ID: <CAHTX3dKmsHEobQEKv1SXAnhDwX-OxWGAkYZZRcRvY+8WKE4y6Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: zynqmp: Rename buses to be align with
 simple-bus yaml
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 24. 8. 2020 v 12:05 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.co=
m> napsal:
>
> Rename amba-apu and amba to AXI. Based on Xilinx ZynqMP TRM (Chapter 15)
> chip is "using the advanced eXtensible interface (AXI) point-to-point
> channels for communicating addresses, data, and response transactions
> between master and slave clients."
>
> Issues are reported as:
> ...: amba: $nodename:0: 'amba' does not match
> '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>         From schema: .../dt-schema/dtschema/schemas/simple-bus.yaml
> ...: amba-apu@0: $nodename:0: 'amba-apu@0' does not match
> '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>         From schema: .../dt-schema/dtschema/schemas/simple-bus.yaml
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> The only one problem with this patch is that it breaks paths in
> /proc/device-tree/.
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index 165a95a106c8..98073f3223e5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -182,7 +182,7 @@ fpga_full: fpga-full {
>                 ranges;
>         };
>
> -       amba_apu: amba-apu@0 {
> +       amba_apu: axi@0 {
>                 compatible =3D "simple-bus";
>                 #address-cells =3D <2>;
>                 #size-cells =3D <1>;
> @@ -201,7 +201,7 @@ gic: interrupt-controller@f9010000 {
>                 };
>         };
>
> -       amba: amba {
> +       amba: axi {
>                 compatible =3D "simple-bus";
>                 #address-cells =3D <2>;
>                 #size-cells =3D <2>;
> --
> 2.28.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
