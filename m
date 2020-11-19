Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C22B9254
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgKSMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgKSMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:13:24 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C164C0613CF;
        Thu, 19 Nov 2020 04:13:24 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id g19so5010651otp.13;
        Thu, 19 Nov 2020 04:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQc+X8tX3Skl+8b2tpkeVeyjt/V7WtkyUSE/Jqv+xFM=;
        b=r/4THq9bF9j7pLUlG16N3Xz2AyQVe02eRcTO5IaP87TlA/Ua1lr6WPc2r4TY54L8ms
         4PqWcpG8NnoSjQo5vVX5tRn0S6JV/xMgfzOVapq0khZ4xZIeRJWQ1VaTHo37zAQiRYQo
         UxOElDeSI+W0Kfn406A4/NzGy6HCUD6pD1+303eS1o7CIVxA6K8LMNDXF2L/pN0F/jjE
         Icsbqk8a7KU7HNgdjLOFJsiYkjV/OCH4e9AR6OfPAA0sD61HctQ6uKrHf+L2+GbbM2/M
         pLXw6Py3YLoh2RiQKYnt43fjIteg+gefu0LMERkqgVBedOQ2+jWZkq5B1ok3Tz4hEN7n
         V30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQc+X8tX3Skl+8b2tpkeVeyjt/V7WtkyUSE/Jqv+xFM=;
        b=nVSzykUnKneWNWnPVoby8y1v7Ffg/+neve/iVLf23BIJVf0zf1xwqt6J/tMvNoELCE
         nKQwRMArUXVi5zzrcWo8Z6lIlT9wJTn2pkmKEOxWcnO+/R86aGJt0M+y2Cs5FLRYSmbU
         XrnGu7CPTzCkNpsLdpgIuY53sIqnQigd5cozL66zv0km34neibYcsoYpIZMLVLQL6cAS
         wE7h8APXo908oE60+yGikSk6nmUPE+PKaBadoOpWX84ZhbG3oDPt7i/VuwCLgdCXhPrz
         GHnH4FPIG7fuAo99rl2IM16XAAl0dhwT4rEO0zp5Azisb1jJ4gRKsKYmn++whQ+B4CEM
         S/zQ==
X-Gm-Message-State: AOAM531Y+XDK6loqtgWXPUDMoS6bKSzQ/eUi/r3sVU5F/xeFxmhXe+fk
        cBi88bMWv/ezOCKvyKFVsyIsEeUBBZ74+xtBzb9MbAE86h8vXyGM
X-Google-Smtp-Source: ABdhPJx3GO7VyQt5grvkV6z9Yds2ImTGd48WfhZH4qUF9RioCCVt8s5ncXtwa99GyVPBIe/E9L/aaMZb+c6g7r+6nCI=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr9366277oto.362.1605788003373;
 Thu, 19 Nov 2020 04:13:23 -0800 (PST)
MIME-Version: 1.0
References: <1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 19 Nov 2020 13:13:11 +0100
Message-ID: <CAFqH_522NuGY9c-_XWhHxoa3QkrdoM92qTOLxgM8PpOU=-ttbw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add mt8192 power domains controller
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

Thank you for the patch

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 19 de nov.
2020 a les 11:48:
>
> Add power domains controller node for SoC mt8192
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>
> Change in v3: None, just rebase dts onto v5.10-rc1 and
>        V4 of series "Add new driver for SCPSYS power domains controller"[1]
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=374013
>
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 201 +++++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 69d45c7..08449eb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> +#include <dt-bindings/power/mt8192-power.h>
>
>  / {
>         compatible = "mediatek,mt8192";
> @@ -257,6 +258,206 @@
>                         #interrupt-cells = <2>;
>                 };
>
> +               scpsys: syscon@10006000 {
> +                       compatible = "syscon", "simple-mfd";
> +                       reg = <0 0x10006000 0 0x1000>;
> +                       #power-domain-cells = <1>;
> +
> +                       /* System Power Manager */
> +                       spm: power-controller {
> +                               compatible = "mediatek,mt8192-power-controller";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               #power-domain-cells = <1>;
> +
> +                               /* power domain of the SoC */
> +                               audio@MT8192_POWER_DOMAIN_AUDIO {

If you run the dt_bindings_check it should return some errors, as all
these node names should be 'power-domain@'. Which is a bit annoying
because then you will get a bunch of errors like this:

[    1.969110] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    1.976997] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    1.984828] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    1.992657] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.000685] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.008566] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.016395] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.024221] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.032049] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.039874] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.047699] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.055524] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.063352] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!
[    2.071176] debugfs: Directory 'power-domain' with parent
'pm_genpd' already present!

But that's another problem that should be handled in debugfs system.

> +                                       reg = <MT8192_POWER_DOMAIN_AUDIO>;
> +                                       clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> +                                                <&infracfg CLK_INFRA_AUDIO_26M_B>,
> +                                                <&infracfg CLK_INFRA_AUDIO>;
> +                                       clock-names = "audio", "audio1", "audio2";
> +                                       mediatek,infracfg = <&infracfg>;
> +                                       #power-domain-cells = <0>;
> +                               };
> +
> +                               conn@MT8192_POWER_DOMAIN_CONN {
> +                                       reg = <MT8192_POWER_DOMAIN_CONN>;
> +                                       clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
> +                                       clock-names = "conn";
> +                                       mediatek,infracfg = <&infracfg>;
> +                                       #power-domain-cells = <0>;
> +                               };
> +
> +                               mfg@MT8192_POWER_DOMAIN_MFG0 {
> +                                       reg = <MT8192_POWER_DOMAIN_MFG0>;
> +                                       clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>;
> +                                       clock-names = "mfg";
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       #power-domain-cells = <1>;
> +
> +                                       mfg1@MT8192_POWER_DOMAIN_MFG1 {
> +                                               reg = <MT8192_POWER_DOMAIN_MFG1>;
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #address-cells = <1>;
> +                                               #size-cells = <0>;
> +                                               #power-domain-cells = <1>;
> +
> +                                               mfg2@MT8192_POWER_DOMAIN_MFG2 {
> +                                                       reg = <MT8192_POWER_DOMAIN_MFG2>;
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +
> +                                               mfg3@MT8192_POWER_DOMAIN_MFG3 {
> +                                                       reg = <MT8192_POWER_DOMAIN_MFG3>;
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +
> +                                               mfg4@MT8192_POWER_DOMAIN_MFG4 {
> +                                                       reg = <MT8192_POWER_DOMAIN_MFG4>;
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +
> +                                               mfg5@MT8192_POWER_DOMAIN_MFG5 {
> +                                                       reg = <MT8192_POWER_DOMAIN_MFG5>;
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +
> +                                               mfg6@MT8192_POWER_DOMAIN_MFG6 {
> +                                                       reg = <MT8192_POWER_DOMAIN_MFG6>;
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +                                       };
> +                               };
> +
> +                               disp@MT8192_POWER_DOMAIN_DISP {
> +                                       reg = <MT8192_POWER_DOMAIN_DISP>;
> +                                       clocks = <&topckgen CLK_TOP_DISP_SEL>,
> +                                                <&mmsys CLK_MM_SMI_INFRA>,
> +                                                <&mmsys CLK_MM_SMI_COMMON>,
> +                                                <&mmsys CLK_MM_SMI_GALS>,
> +                                                <&mmsys CLK_MM_SMI_IOMMU>;
> +                                       clock-names = "disp", "disp-0", "disp-1", "disp-2",
> +                                                     "disp-3";
> +                                       mediatek,infracfg = <&infracfg>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       #power-domain-cells = <1>;
> +
> +                                       ipe@MT8192_POWER_DOMAIN_IPE {
> +                                               reg = <MT8192_POWER_DOMAIN_IPE>;
> +                                               clocks = <&topckgen CLK_TOP_IPE_SEL>,
> +                                                        <&ipesys CLK_IPE_LARB19>,
> +                                                        <&ipesys CLK_IPE_LARB20>,
> +                                                        <&ipesys CLK_IPE_SMI_SUBCOM>,
> +                                                        <&ipesys CLK_IPE_GALS>;
> +                                               clock-names = "ipe", "ipe-0", "ipe-1", "ipe-2",
> +                                                             "ipe-3";
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #power-domain-cells = <0>;
> +                                       };
> +
> +                                       isp@MT8192_POWER_DOMAIN_ISP {
> +                                               reg = <MT8192_POWER_DOMAIN_ISP>;
> +                                               clocks = <&topckgen CLK_TOP_IMG1_SEL>,
> +                                                        <&imgsys CLK_IMG_LARB9>,
> +                                                        <&imgsys CLK_IMG_GALS>;
> +                                               clock-names = "isp", "isp-0", "isp-1";
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #power-domain-cells = <0>;
> +                                       };
> +
> +                                       isp2@MT8192_POWER_DOMAIN_ISP2 {
> +                                               reg = <MT8192_POWER_DOMAIN_ISP2>;
> +                                               clocks = <&topckgen CLK_TOP_IMG2_SEL>,
> +                                                        <&imgsys2 CLK_IMG2_LARB11>,
> +                                                        <&imgsys2 CLK_IMG2_GALS>;
> +                                               clock-names = "isp2", "isp2-0", "isp2-1";
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #power-domain-cells = <0>;
> +                                       };
> +
> +                                       mdp@MT8192_POWER_DOMAIN_MDP {
> +                                               reg = <MT8192_POWER_DOMAIN_MDP>;
> +                                               clocks = <&topckgen CLK_TOP_MDP_SEL>,
> +                                                        <&mdpsys CLK_MDP_SMI0>;
> +                                               clock-names = "mdp", "mdp-0";
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #power-domain-cells = <0>;
> +                                       };
> +
> +                                       venc@MT8192_POWER_DOMAIN_VENC {
> +                                               reg = <MT8192_POWER_DOMAIN_VENC>;
> +                                               clocks = <&topckgen CLK_TOP_VENC_SEL>,
> +                                                        <&vencsys CLK_VENC_SET1_VENC>;
> +                                               clock-names = "venc", "venc-0";
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #power-domain-cells = <0>;
> +                                       };
> +
> +                                       vdec@MT8192_POWER_DOMAIN_VDEC {
> +                                               reg = <MT8192_POWER_DOMAIN_VDEC>;
> +                                               clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +                                                        <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +                                                        <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> +                                                        <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
> +                                               clock-names = "vdec", "vdec-0", "vdec-1", "vdec-2";
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #address-cells = <1>;
> +                                               #size-cells = <0>;
> +                                               #power-domain-cells = <1>;
> +
> +                                               vdec2@MT8192_POWER_DOMAIN_VDEC2 {
> +                                                       reg = <MT8192_POWER_DOMAIN_VDEC2>;
> +                                                       clocks = <&vdecsys CLK_VDEC_VDEC>,
> +                                                                <&vdecsys CLK_VDEC_LAT>,
> +                                                                <&vdecsys CLK_VDEC_LARB1>;
> +                                                       clock-names = "vdec2-0", "vdec2-1",
> +                                                                     "vdec2-2";
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +                                       };
> +
> +                                       cam@MT8192_POWER_DOMAIN_CAM {
> +                                               reg = <MT8192_POWER_DOMAIN_CAM>;
> +                                               clocks = <&topckgen CLK_TOP_CAM_SEL>,
> +                                                        <&camsys CLK_CAM_LARB13>,
> +                                                        <&camsys CLK_CAM_LARB14>,
> +                                                        <&camsys CLK_CAM_CCU_GALS>,
> +                                                        <&camsys CLK_CAM_CAM2MM_GALS>;
> +                                               clock-names = "cam", "cam-0", "cam-1", "cam-2",
> +                                                             "cam-3";
> +                                               mediatek,infracfg = <&infracfg>;
> +                                               #address-cells = <1>;
> +                                               #size-cells = <0>;
> +                                               #power-domain-cells = <1>;
> +
> +                                               cam_rawa@MT8192_POWER_DOMAIN_CAM_RAWA {
> +                                                       reg = <MT8192_POWER_DOMAIN_CAM_RAWA>;
> +                                                       clocks = <&camsys_rawa CLK_CAM_RAWA_LARBX>;
> +                                                       clock-names = "cam_rawa-0";
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +
> +                                               cam_rawb@MT8192_POWER_DOMAIN_CAM_RAWB {
> +                                                       reg = <MT8192_POWER_DOMAIN_CAM_RAWB>;
> +                                                       clocks = <&camsys_rawb CLK_CAM_RAWB_LARBX>;
> +                                                       clock-names = "cam_rawb-0";
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +
> +                                               cam_rawc@MT8192_POWER_DOMAIN_CAM_RAWC {
> +                                                       reg = <MT8192_POWER_DOMAIN_CAM_RAWC>;
> +                                                       clocks = <&camsys_rawc CLK_CAM_RAWC_LARBX>;
> +                                                       clock-names = "cam_rawc-0";
> +                                                       #power-domain-cells = <0>;
> +                                               };
> +                                       };
> +                               };
> +                       };
> +               };
> +
>                 apmixedsys: syscon@1000c000 {
>                         compatible = "mediatek,mt8192-apmixedsys", "syscon";
>                         reg = <0 0x1000c000 0 0x1000>;
> --
> 1.8.1.1.dirty
>
