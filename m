Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0642F24B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404982AbhALAZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404179AbhAKXmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:42:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8363F22D58;
        Mon, 11 Jan 2021 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610408493;
        bh=bAdBibgGiN3GffakXSvlfufHBbmFvs3gZF4zW1QIPpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L3BqG9CGa09IpwCasB09cDGIciJcOXqu7U3MvkaKQMvBrwmPc4pmmHDLrh/dwkHOB
         IgUb+dNtWdUdI7wYU0CjHeGmoeFTjBuc9W8f6Wc+jyMnggRJevPS+xhryDHnOPYR+X
         o/6gPsoPhZCG1Y2/v0+U38Q6lD00OM//dQRxh9Lb7PDJMxVkO+W6Yo3sUp7O/2RxFr
         tiWyLzyzUIm6NDAmPyS4U7Sy0/lEvbKr81Qs2Zd5vE3IK9Zn+WB/LKNW1R//BHYAaA
         6bqdXK5drOTyaNFQg/Zn+Eo6suXH+qf2QoOeiZl82R3XC56Y+VEPeIddq1P8S1MuuQ
         ScdEi4eEZy/Cg==
Received: by mail-ej1-f42.google.com with SMTP id t16so811389ejf.13;
        Mon, 11 Jan 2021 15:41:33 -0800 (PST)
X-Gm-Message-State: AOAM533A5cdqgfCY52cNBY0Fr2D2mF1dvFP5OF1rT/lZnqXyFGLUnDxb
        OaXH7+eUBZ1tMoEIAaf2zcSoUrh4EYCblE6M0Q==
X-Google-Smtp-Source: ABdhPJwCU5QtQSu4pGneT7CiYRhLN+GuNo45i3i9kOMEPcfgJCLW31Imu8cmY84UsOP4oS+yyGkTfbpPfs0nar26w7E=
X-Received: by 2002:a17:907:d8b:: with SMTP id go11mr1205672ejc.303.1610408491970;
 Mon, 11 Jan 2021 15:41:31 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 07:41:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_823uf3sNkzPnH_22MO716ibJMPC7uRzBk=PfkMStvYzQ@mail.gmail.com>
Message-ID: <CAAOTY_823uf3sNkzPnH_22MO716ibJMPC7uRzBk=PfkMStvYzQ@mail.gmail.com>
Subject: Re: [PATCH v3, 03/15] arm64: dts: mt8192: add display node
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add display node
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 134 +++++++++++++++++++++++++=
++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8192.dtsi
> index e12e024..dcf9fdf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -15,6 +15,11 @@
>         #address-cells =3D <2>;
>         #size-cells =3D <2>;
>
> +       aliases {
> +               ovl2-2l2 =3D &ovl_2l2;
> +               rdma4 =3D &rdma4;
> +       };
> +
>         clk26m: oscillator0 {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
> @@ -508,5 +513,134 @@
>                         #size-cells =3D <0>;
>                         status =3D "disabled";
>                 };
> +
> +               mmsys: syscon@14000000 {
> +                       compatible =3D "mediatek,mt8192-mmsys", "syscon";
> +                       reg =3D <0 0x14000000 0 0x1000>;
> +                       //mboxes =3D <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> +                       //       <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0 0x1000>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +                mutex: mutex@14001000 {
> +                       compatible =3D "mediatek,mt8192-disp-mutex";
> +                       reg =3D <0 0x14001000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_MUTEX0>;
> +                       //mediatek,gce-events =3D <CMDQ_EVENT_DISP_STREAM=
_DONE_ENG_EVENT_0>,
> +                       //                    <CMDQ_EVENT_DISP_STREAM_DON=
E_ENG_EVENT_1>;
> +               };
> +
> +               ovl0: ovl@14005000 {
> +                       compatible =3D "mediatek,mt8192-disp-ovl";
> +                       reg =3D <0 0x14005000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_OVL0>;
> +                       //iommus =3D <&iommu0 M4U_PORT_L0_OVL_RDMA0>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;

I think you should not mark these property.

Regards,
Chun-Kuang.

> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0x5000 0x1000>;
> +               };
> +
> +               ovl_2l0: ovl@14006000 {
> +                       compatible =3D "mediatek,mt8192-disp-ovl-2l";
> +                       reg =3D <0 0x14006000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_OVL0_2L>;
> +                       //iommus =3D <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0x6000 0x1000>;
> +               };
> +
> +               rdma0: rdma@14007000 {
> +                       compatible =3D "mediatek,mt8192-disp-rdma";
> +                       reg =3D <0 0x14007000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_RDMA0>;
> +                       //iommus =3D <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
> +                       //mediatek,larb =3D <&larb0>;
> +                       //mediatek,rdma-fifo-size =3D <5120>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0x7000 0x1000>;
> +               };
> +
> +               color0: color@14009000 {
> +                       compatible =3D "mediatek,mt8192-disp-color",
> +                                    "mediatek,mt8173-disp-color";
> +                       reg =3D <0 0x14009000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_COLOR0>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0x9000 0x1000>;
> +               };
> +
> +               ccorr0: ccorr@1400a000 {
> +                       compatible =3D "mediatek,mt8192-disp-ccorr";
> +                       reg =3D <0 0x1400a000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_CCORR0>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xa000 0x1000>;
> +               };
> +
> +               aal0: aal@1400b000 {
> +                       compatible =3D "mediatek,mt8192-disp-aal";
> +                       reg =3D <0 0x1400b000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_AAL0>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xb000 0x1000>;
> +               };
> +
> +               gamma0: gamma@1400c000 {
> +                       compatible =3D "mediatek,mt8183-disp-gamma",
> +                                    "mediatek,mt8192-disp-gamma";
> +                       reg =3D <0 0x1400c000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_GAMMA0>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xc000 0x1000>;
> +               };
> +
> +               postmask0: postmask@1400d000 {
> +                       compatible =3D "mediatek,mt8192-disp-postmask";
> +                       reg =3D <0 0x1400d000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_POSTMASK0>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xd000 0x1000>;
> +               };
> +
> +               dither0: dither@1400e000 {
> +                       compatible =3D "mediatek,mt8192-disp-dither",
> +                                    "mediatek,mt8183-disp-dither";
> +                       reg =3D <0 0x1400e000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_DITHER0>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xe000 0x1000>;
> +               };
> +
> +               ovl_2l2: ovl@14014000 {
> +                       compatible =3D "mediatek,mt8192-disp-ovl-2l";
> +                       reg =3D <0 0x14014000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_OVL2_2L>;
> +                       //iommus =3D <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
> +                       //       <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x4000 0x1000>;
> +               };
> +
> +               rdma4: rdma@14015000 {
> +                       compatible =3D "mediatek,mt8192-disp-rdma";
> +                       reg =3D <0 0x14015000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       //power-domains =3D <&scpsys MT8192_POWER_DOMAIN_=
DISP>;
> +                       //clocks =3D <&mmsys CLK_MM_DISP_RDMA4>;
> +                       //iommus =3D <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
> +                       //mediatek,rdma-fifo-size =3D <2048>;
> +                       //mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x5000 0x1000>;
> +               };
>         };
>  };
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
