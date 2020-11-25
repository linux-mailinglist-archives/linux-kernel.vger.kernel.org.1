Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E12C4027
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgKYM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgKYM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:29:33 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F1C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:29:32 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id k27so2730328ejs.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j57EtHMv78PhfHsr0mtpiZiQYvcfhG4oADe/5q+SFdg=;
        b=co/82OQ5r1xF+entk1GBpTloILdzINtmbvow+8Wb+EKoIlt2d/KwYtPLVklopMoTAL
         EX29B763/N97jd28bzeEUrRdGVQRcxoCtIJZTueMIdppWVFWfefH5x8aYsOeKpzmFtvn
         WZHFIn6vGuEGgBGR7j32dJ5nxaZxd9AE/y8S9yIkyoZ5a5ZmABT2Y4QhkV5Eww+lOww2
         5KQ6QBvUbi4jQMu8G0GBLbyV2sYKgLac0Zh6TZ9f9Qp2EnSdKzGKb/qYHNzutGIhiL0W
         o1wX27T8e7m9fv9JSTWVIzFcG7wgR14dWlmt1H4ADL+7GwJ7VPRUP0jXNcKwazupde5i
         1HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j57EtHMv78PhfHsr0mtpiZiQYvcfhG4oADe/5q+SFdg=;
        b=UhErbcw4QXocTNLZaGUvsXg6uu5zOa8wVqAZ0STdnNEqncys9PS0RFGufKo6ntCWoN
         ST+jAvvZg83KFuO2GEuo0aYbb+sMlqPPdiZDmg+QRD3fedW+y/nOWHtnnmBx0mFJQXvK
         UDe2C1DtK7XkFKYd8k/1XmAUcwMY93RDW8l6jLWXraeCG7ZaGW5fzSBLuxd8XSk2i3Lz
         47CEuHtzErTTP2POsix3X7gl2JkbfSpGhktnWACv4On5k7tQKsOLKsBi3DYcxCxTT3r0
         5EALzFbzyi8RHWv/eotuGjcdlAoOC5vL8sPfR+ViGir6Fq7SPrLEPCqJWHQUB+AxXlMD
         SOew==
X-Gm-Message-State: AOAM533C19cRJ01feaMkXkjMRpqWLW5ffMqR7h+intQpXYMS4YBIfhoY
        auA7fsL/u870LaNcwECyonEzg+jxbQ9uMEpMuam9WNcsusWs0Q==
X-Google-Smtp-Source: ABdhPJyeT/9/rRdeYj7/T7dQd4H3e8nFnzlYkCswUXItR63wB4ezcOBsk0XWbx1kr/BcTQdMvOjPLCDaUIRRYDnRwcw=
X-Received: by 2002:a17:906:37d2:: with SMTP id o18mr2904629ejc.379.1606307371357;
 Wed, 25 Nov 2020 04:29:31 -0800 (PST)
MIME-Version: 1.0
References: <5d3523150890e494df308ee69523d0f0e7b33b22.1605185549.git.michal.simek@xilinx.com>
In-Reply-To: <5d3523150890e494df308ee69523d0f0e7b33b22.1605185549.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Nov 2020 13:29:20 +0100
Message-ID: <CAHTX3d+nGPXgfw=t7+UsEEseFahScus7jjMhKGe+RwMbVweeRQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: zynqmp: Wire mailbox with zynqmp-power driver
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 12. 11. 2020 v 13:52 odes=C3=ADlatel Michal Simek
<michal.simek@xilinx.com> napsal:
>
> The support to driver was added by commit ffdbae28d9d1 ("drivers: soc:
> xilinx: Use mailbox IPI callback") that's why also enable it via DT by
> default. It setups communication with firmware via IPI interface.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index 66dad22b8a76..68923fbd0e89 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -99,6 +99,29 @@ opp03 {
>                 };
>         };
>
> +       zynqmp_ipi {
> +               compatible =3D "xlnx,zynqmp-ipi-mailbox";
> +               interrupt-parent =3D <&gic>;
> +               interrupts =3D <0 35 4>;
> +               xlnx,ipi-id =3D <0>;
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +
> +               ipi_mailbox_pmu1: mailbox@ff990400 {
> +                       reg =3D <0x0 0xff9905c0 0x0 0x20>,
> +                             <0x0 0xff9905e0 0x0 0x20>,
> +                             <0x0 0xff990e80 0x0 0x20>,
> +                             <0x0 0xff990ea0 0x0 0x20>;
> +                       reg-names =3D "local_request_region",
> +                                   "local_response_region",
> +                                   "remote_request_region",
> +                                   "remote_response_region";
> +                       #mbox-cells =3D <1>;
> +                       xlnx,ipi-id =3D <4>;
> +               };
> +       };
> +
>         dcc: dcc {
>                 compatible =3D "arm,dcc";
>                 status =3D "disabled";
> @@ -128,6 +151,8 @@ zynqmp_power: zynqmp-power {
>                                 compatible =3D "xlnx,zynqmp-power";
>                                 interrupt-parent =3D <&gic>;
>                                 interrupts =3D <0 35 4>;
> +                               mboxes =3D <&ipi_mailbox_pmu1 0>, <&ipi_m=
ailbox_pmu1 1>;
> +                               mbox-names =3D "tx", "rx";
>                         };
>
>                         zynqmp_clk: clock-controller {
> --
> 2.29.2
>

Applied.
M


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
