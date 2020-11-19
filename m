Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3E2B944C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgKSOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgKSOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:14:10 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BCC0613CF;
        Thu, 19 Nov 2020 06:14:10 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id o3so5371087ota.8;
        Thu, 19 Nov 2020 06:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUgio/81FC41XmzQ9VpetDatCeAUACvZi+WPwsd/7W4=;
        b=L8mIR7u4RaOi1albfd17SYidyF0LUdipf75unUBTdIHYNH0FQYBNYP5f9gxZ1zSZ8v
         YjPBSIyPXz2QGRUk5DeAR9egjxwN2MZycveE6IrtDQKGby7WAETZfruAhP5N8uZ+cm9s
         KVSaQp1LFBOoAue7AtaPL61npQ5CdOpaCsX/Mi4UbS2x7EMgdHUN50sEv9rtG+0MGHII
         Op5TpPt/90qR48pfsQxsTHZYq+tyzFZIU/nqqIMM1cEM79W/DggkdwqoDb/JcRXmRA0B
         CCYKj1Mp6ORdP6xACdfFdLzbimv8GCm/PrxNV+weYTq7Rk0tjT3JvKIV/4Vw5VV6d9AY
         o9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUgio/81FC41XmzQ9VpetDatCeAUACvZi+WPwsd/7W4=;
        b=jYLN5ff6CHDppC2LPyGyqsh6rosrcn2f0gUU+v5ySWMwSpvTW2QtNEKGbUrpQ4wQC4
         JjUGYsG3HJ/3NcfPIMblwx2DXak6euGNzQZ1+CjZze+R3mkNht4rRF8k6DkHKeHU1DjX
         pxOvnTTr8S2tXDZ0Xcc5x6HKJzsvPJ5DCn5Hhzee/6lsepuzmYbF4pYmQkdWvxf8N4nd
         NPFLLI96GM79IW89vK9rk1lQhzY2J3MMAON8FBLjGN+l6YAMZ6JWM1fkjCDIKMnk+c2S
         aF3JTQ2B2/TrLFHg0RB7U/zlrx90Du14OIMMMnRxKKldIkSb69j1v4o0CFv3NNWfb+z6
         IP1w==
X-Gm-Message-State: AOAM533EMkqAzCh440KrspZGhq2vegPfUqxbVSqCbl/VAzV+qtbtbelJ
        2nidM6y9rjE/2Wru15nF3jtUqG7+kf41IVZ+gkw=
X-Google-Smtp-Source: ABdhPJywDyBlFRRhkbUSMVpJEu9n5cXGSYklY0eUl8bDYcWbkQib/4XOJR+tIFsJINLp+sXTuyIkJ907inh7SU0u+/8=
X-Received: by 2002:a05:6830:359:: with SMTP id h25mr9950222ote.184.1605795249720;
 Thu, 19 Nov 2020 06:14:09 -0800 (PST)
MIME-Version: 1.0
References: <1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com>
 <CAFqH_522NuGY9c-_XWhHxoa3QkrdoM92qTOLxgM8PpOU=-ttbw@mail.gmail.com> <1605791419.19819.4.camel@mtksdaap41>
In-Reply-To: <1605791419.19819.4.camel@mtksdaap41>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 19 Nov 2020 15:13:57 +0100
Message-ID: <CAFqH_51m5Pg9ny4HWt1iwf8wtsGSdShpDCVaGwac=v9BBDj2vg@mail.gmail.com>
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

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 19 de nov.
2020 a les 14:10:
>
> On Thu, 2020-11-19 at 13:13 +0100, Enric Balletbo Serra wrote:
> > Hi Weiyi,
> >
> > Thank you for the patch
> >
> > Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 19 de nov.
> > 2020 a les 11:48:
> > >
> > > Add power domains controller node for SoC mt8192
> > >
> > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > ---
> > >
> > > Change in v3: None, just rebase dts onto v5.10-rc1 and
> > >        V4 of series "Add new driver for SCPSYS power domains controller"[1]
> > >
> > > [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=374013
> > >
> > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 201 +++++++++++++++++++++++++++++++
> > >  1 file changed, 201 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > index 69d45c7..08449eb 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > @@ -9,6 +9,7 @@
> > >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >  #include <dt-bindings/interrupt-controller/irq.h>
> > >  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> > > +#include <dt-bindings/power/mt8192-power.h>
> > >
> > >  / {
> > >         compatible = "mediatek,mt8192";
> > > @@ -257,6 +258,206 @@
> > >                         #interrupt-cells = <2>;
> > >                 };
> > >
> > > +               scpsys: syscon@10006000 {
> > > +                       compatible = "syscon", "simple-mfd";
> > > +                       reg = <0 0x10006000 0 0x1000>;
> > > +                       #power-domain-cells = <1>;
> > > +
> > > +                       /* System Power Manager */
> > > +                       spm: power-controller {
> > > +                               compatible = "mediatek,mt8192-power-controller";
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                               #power-domain-cells = <1>;
> > > +
> > > +                               /* power domain of the SoC */
> > > +                               audio@MT8192_POWER_DOMAIN_AUDIO {
> >
> > If you run the dt_bindings_check it should return some errors, as all
> > these node names should be 'power-domain@'. Which is a bit annoying
> > because then you will get a bunch of errors like this:
> >
> > [    1.969110] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    1.976997] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    1.984828] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    1.992657] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.000685] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.008566] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.016395] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.024221] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.032049] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.039874] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.047699] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.055524] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.063352] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> > [    2.071176] debugfs: Directory 'power-domain' with parent
> > 'pm_genpd' already present!
> >
> > But that's another problem that should be handled in debugfs system.
> >
>
> Indeed...so I chose to use different name in dts to avoid problems in
> debugfs. It does violate the naming rules.
>

But your binding will not pass (or trigger warnings) the dtb check
then. Rob was clear that names should be generic. Proper fix is fix
debugfs not the binding.

Cheers,
  Enric

> > > +                                       reg = <MT8192_POWER_DOMAIN_AUDIO>;
> > > +                                       clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> > > +                                                <&infracfg CLK_INFRA_AUDIO_26M_B>,
> > > +                                                <&infracfg CLK_INFRA_AUDIO>;
> > > +                                       clock-names = "audio", "audio1", "audio2";
> > > +                                       mediatek,infracfg = <&infracfg>;
> > > +                                       #power-domain-cells = <0>;
> > > +                               };
> > > +
> > > +                               conn@MT8192_POWER_DOMAIN_CONN {
> > > +                                       reg = <MT8192_POWER_DOMAIN_CONN>;
> > > +                                       clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
> > > +                                       clock-names = "conn";
> > > +                                       mediatek,infracfg = <&infracfg>;
> > > +                                       #power-domain-cells = <0>;
> > > +                               };
> > > +
> > > +                               mfg@MT8192_POWER_DOMAIN_MFG0 {
> > > +                                       reg = <MT8192_POWER_DOMAIN_MFG0>;
> > > +                                       clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>;
> > > +                                       clock-names = "mfg";
> > > +                                       #address-cells = <1>;
> > > +                                       #size-cells = <0>;
> > > +                                       #power-domain-cells = <1>;
> > > +
> > > +                                       mfg1@MT8192_POWER_DOMAIN_MFG1 {
> > > +                                               reg = <MT8192_POWER_DOMAIN_MFG1>;
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #address-cells = <1>;
> > > +                                               #size-cells = <0>;
> > > +                                               #power-domain-cells = <1>;
> > > +
> > > +                                               mfg2@MT8192_POWER_DOMAIN_MFG2 {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_MFG2>;
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +
> > > +                                               mfg3@MT8192_POWER_DOMAIN_MFG3 {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_MFG3>;
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +
> > > +                                               mfg4@MT8192_POWER_DOMAIN_MFG4 {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_MFG4>;
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +
> > > +                                               mfg5@MT8192_POWER_DOMAIN_MFG5 {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_MFG5>;
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +
> > > +                                               mfg6@MT8192_POWER_DOMAIN_MFG6 {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_MFG6>;
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +                                       };
> > > +                               };
> > > +
> > > +                               disp@MT8192_POWER_DOMAIN_DISP {
> > > +                                       reg = <MT8192_POWER_DOMAIN_DISP>;
> > > +                                       clocks = <&topckgen CLK_TOP_DISP_SEL>,
> > > +                                                <&mmsys CLK_MM_SMI_INFRA>,
> > > +                                                <&mmsys CLK_MM_SMI_COMMON>,
> > > +                                                <&mmsys CLK_MM_SMI_GALS>,
> > > +                                                <&mmsys CLK_MM_SMI_IOMMU>;
> > > +                                       clock-names = "disp", "disp-0", "disp-1", "disp-2",
> > > +                                                     "disp-3";
> > > +                                       mediatek,infracfg = <&infracfg>;
> > > +                                       #address-cells = <1>;
> > > +                                       #size-cells = <0>;
> > > +                                       #power-domain-cells = <1>;
> > > +
> > > +                                       ipe@MT8192_POWER_DOMAIN_IPE {
> > > +                                               reg = <MT8192_POWER_DOMAIN_IPE>;
> > > +                                               clocks = <&topckgen CLK_TOP_IPE_SEL>,
> > > +                                                        <&ipesys CLK_IPE_LARB19>,
> > > +                                                        <&ipesys CLK_IPE_LARB20>,
> > > +                                                        <&ipesys CLK_IPE_SMI_SUBCOM>,
> > > +                                                        <&ipesys CLK_IPE_GALS>;
> > > +                                               clock-names = "ipe", "ipe-0", "ipe-1", "ipe-2",
> > > +                                                             "ipe-3";
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #power-domain-cells = <0>;
> > > +                                       };
> > > +
> > > +                                       isp@MT8192_POWER_DOMAIN_ISP {
> > > +                                               reg = <MT8192_POWER_DOMAIN_ISP>;
> > > +                                               clocks = <&topckgen CLK_TOP_IMG1_SEL>,
> > > +                                                        <&imgsys CLK_IMG_LARB9>,
> > > +                                                        <&imgsys CLK_IMG_GALS>;
> > > +                                               clock-names = "isp", "isp-0", "isp-1";
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #power-domain-cells = <0>;
> > > +                                       };
> > > +
> > > +                                       isp2@MT8192_POWER_DOMAIN_ISP2 {
> > > +                                               reg = <MT8192_POWER_DOMAIN_ISP2>;
> > > +                                               clocks = <&topckgen CLK_TOP_IMG2_SEL>,
> > > +                                                        <&imgsys2 CLK_IMG2_LARB11>,
> > > +                                                        <&imgsys2 CLK_IMG2_GALS>;
> > > +                                               clock-names = "isp2", "isp2-0", "isp2-1";
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #power-domain-cells = <0>;
> > > +                                       };
> > > +
> > > +                                       mdp@MT8192_POWER_DOMAIN_MDP {
> > > +                                               reg = <MT8192_POWER_DOMAIN_MDP>;
> > > +                                               clocks = <&topckgen CLK_TOP_MDP_SEL>,
> > > +                                                        <&mdpsys CLK_MDP_SMI0>;
> > > +                                               clock-names = "mdp", "mdp-0";
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #power-domain-cells = <0>;
> > > +                                       };
> > > +
> > > +                                       venc@MT8192_POWER_DOMAIN_VENC {
> > > +                                               reg = <MT8192_POWER_DOMAIN_VENC>;
> > > +                                               clocks = <&topckgen CLK_TOP_VENC_SEL>,
> > > +                                                        <&vencsys CLK_VENC_SET1_VENC>;
> > > +                                               clock-names = "venc", "venc-0";
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #power-domain-cells = <0>;
> > > +                                       };
> > > +
> > > +                                       vdec@MT8192_POWER_DOMAIN_VDEC {
> > > +                                               reg = <MT8192_POWER_DOMAIN_VDEC>;
> > > +                                               clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> > > +                                                        <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> > > +                                                        <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> > > +                                                        <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
> > > +                                               clock-names = "vdec", "vdec-0", "vdec-1", "vdec-2";
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #address-cells = <1>;
> > > +                                               #size-cells = <0>;
> > > +                                               #power-domain-cells = <1>;
> > > +
> > > +                                               vdec2@MT8192_POWER_DOMAIN_VDEC2 {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_VDEC2>;
> > > +                                                       clocks = <&vdecsys CLK_VDEC_VDEC>,
> > > +                                                                <&vdecsys CLK_VDEC_LAT>,
> > > +                                                                <&vdecsys CLK_VDEC_LARB1>;
> > > +                                                       clock-names = "vdec2-0", "vdec2-1",
> > > +                                                                     "vdec2-2";
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +                                       };
> > > +
> > > +                                       cam@MT8192_POWER_DOMAIN_CAM {
> > > +                                               reg = <MT8192_POWER_DOMAIN_CAM>;
> > > +                                               clocks = <&topckgen CLK_TOP_CAM_SEL>,
> > > +                                                        <&camsys CLK_CAM_LARB13>,
> > > +                                                        <&camsys CLK_CAM_LARB14>,
> > > +                                                        <&camsys CLK_CAM_CCU_GALS>,
> > > +                                                        <&camsys CLK_CAM_CAM2MM_GALS>;
> > > +                                               clock-names = "cam", "cam-0", "cam-1", "cam-2",
> > > +                                                             "cam-3";
> > > +                                               mediatek,infracfg = <&infracfg>;
> > > +                                               #address-cells = <1>;
> > > +                                               #size-cells = <0>;
> > > +                                               #power-domain-cells = <1>;
> > > +
> > > +                                               cam_rawa@MT8192_POWER_DOMAIN_CAM_RAWA {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_CAM_RAWA>;
> > > +                                                       clocks = <&camsys_rawa CLK_CAM_RAWA_LARBX>;
> > > +                                                       clock-names = "cam_rawa-0";
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +
> > > +                                               cam_rawb@MT8192_POWER_DOMAIN_CAM_RAWB {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_CAM_RAWB>;
> > > +                                                       clocks = <&camsys_rawb CLK_CAM_RAWB_LARBX>;
> > > +                                                       clock-names = "cam_rawb-0";
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +
> > > +                                               cam_rawc@MT8192_POWER_DOMAIN_CAM_RAWC {
> > > +                                                       reg = <MT8192_POWER_DOMAIN_CAM_RAWC>;
> > > +                                                       clocks = <&camsys_rawc CLK_CAM_RAWC_LARBX>;
> > > +                                                       clock-names = "cam_rawc-0";
> > > +                                                       #power-domain-cells = <0>;
> > > +                                               };
> > > +                                       };
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > >                 apmixedsys: syscon@1000c000 {
> > >                         compatible = "mediatek,mt8192-apmixedsys", "syscon";
> > >                         reg = <0 0x1000c000 0 0x1000>;
> > > --
> > > 1.8.1.1.dirty
> > >
>
