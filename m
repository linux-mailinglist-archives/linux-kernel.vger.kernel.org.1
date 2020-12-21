Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DAB2DFB39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLUKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:52:33 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5AC061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:51:52 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 15so10850222oix.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MNobEilaD0h1UawZqnqzshuQEXfNf6QvqrdcgX0cMjQ=;
        b=dHSFfanVm4ow6eIvl0iRyabcaty+3B3PDQwZTQUnM710BAkk2LIfArzbjS4qQsXpJU
         f4VwdCAoJ+ZQudclnRlZ2q6Mb7Bt0Qav6TQYFGXraJb/8NgpogVjZ3qgEyM8HJ3CT311
         4FbMKcKCBUEYaqs/pz9ublufxybe4jInJtch90bvPlRbJaLRIXQ/nFnVFbPSR6WtMfLn
         urUrgPuQQ4kbc+Jxs0gPmrOha5EeIWzIaZ2bq/FRSKLW6ka/1hDPlHOuz7E3KiJNtqvg
         o8tQuptHdbwwkgu/Jk/GPIDQjBcpKocTerfFOeTbJfBAwaWrGhy9veJPPRs/iq1UtTqP
         LO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MNobEilaD0h1UawZqnqzshuQEXfNf6QvqrdcgX0cMjQ=;
        b=dkuwOV4MDpB/1XjajtK2I7EJPxUKXSPpf22RVkiIXA+KpO8TrTYgqUX3cvyWPfBX/t
         SdIrPCQV0kyt6i55cPUvNJXcKw6ulS7cz7V4zNqYPoKnq+L/BlFSi0PVSOdgRw3e1F1J
         pOncvbo1UkwzJTx/qjmBr7dR0ncJ3EsMKQ9XcW+3AweoIGcrQR333bF3QJJqIfwm7vwN
         5LYTDJq8T+8Y0EmjPIFx3pGaO/S1QAduww8zGNVbX3kHCru3Gb9Gvi3pufYz6Y6tFil3
         kY2gSk6rNhfuy7MvMRQaJdWX3xpqqnb7vIrCerAYoEOP6C5ZeYDU5KDnyUMM6R1xsW4l
         c9ZQ==
X-Gm-Message-State: AOAM533YDLPMN2eI8SvvIkpZ7HwubgTyh0NUeOu6K473fdpK9kNryqfw
        D7WGoPf0UM0e/dS4ZGoczb73mhnC9h1yPJcGpRk=
X-Google-Smtp-Source: ABdhPJy0JJYoLHrIqteOw9R2MMMleBY69h0cj+ODrRDaNLimV5Z/aRdAnAEcut/KdKcewAUG5qGx9ayD+KDHMNVNqt8=
X-Received: by 2002:aca:c492:: with SMTP id u140mr10446437oif.51.1608547912229;
 Mon, 21 Dec 2020 02:51:52 -0800 (PST)
MIME-Version: 1.0
References: <1597912530-5374-1-git-send-email-gene.chen.richtek@gmail.com> <CAE+NS37_YY1aVYv-MBsxoBXCkvj7+fBK+vZke9yG7eY1aMHLKQ@mail.gmail.com>
In-Reply-To: <CAE+NS37_YY1aVYv-MBsxoBXCkvj7+fBK+vZke9yG7eY1aMHLKQ@mail.gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 21 Dec 2020 18:51:40 +0800
Message-ID: <CAE+NS36_HCJvk4_f_8G=5Lke87jCgHO-i0HJ-Q27vhDkacFGEw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: Add bindings for MT6360 PMIC
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Reviewers,

    Should I wait for all sub-devices dt-binding review done, then
send the integral binding document?

Gene Chen <gene.chen.richtek@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=881=
3=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:54=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Dear Reviewers,
>
>    Please let me know if there is anything need to be revised.
>
> Gene Chen <gene.chen.richtek@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=88=
20=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add bindings for MT6360 PMIC
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/mt6360.yaml | 142 ++++++++++++++=
++++++++
> >  1 file changed, 142 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/mt6360.yaml b/Docume=
ntation/devicetree/bindings/mfd/mt6360.yaml
> > new file mode 100644
> > index 0000000..5ad1afd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/mt6360.yaml
> > @@ -0,0 +1,142 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/mt6360.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MT6360 PMIC from MediaTek Integrated
> > +
> > +maintainers:
> > +  - Gene Chen <gene_chen@richtek.com>
> > +
> > +description: |
> > +  MT6360 is a PMIC device with the following sub modules.
> > +  It is interfaced to host controller using I2C interface.
> > +
> > +  This document describes the binding for PMIC device and its sub modu=
le.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6360
> > +
> > +  reg:
> > +    description:
> > +      I2C device address.
> > +    maxItems: 1
> > +
> > +  wakeup-source: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +      enum:
> > +        - IRQB
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +    description:
> > +      The first cell is the IRQ number.
> > +
> > +  regulator:
> > +    $ref: ../regulator/mt6360-regulator.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        mt6360@34 {
> > +            compatible =3D "mediatek,mt6360";
> > +            reg =3D <0x34>;
> > +            wakeup-source;
> > +            interrupts-extended =3D <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> > +            interrupt-names =3D "IRQB";
> > +            interrupt-controller;
> > +            #interrupt-cells =3D <1>;
> > +            regulator {
> > +                compatible =3D "mediatek,mt6360-regulator";
> > +                LDO_VIN3-supply =3D <&BUCK2>;
> > +                buck1 {
> > +                    regulator-compatible =3D "BUCK1";
> > +                    regulator-name =3D "mt6360,buck1";
> > +                    regulator-min-microvolt =3D <300000>;
> > +                    regulator-max-microvolt =3D <1300000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP
> > +                                               MT6360_OPMODE_ULP>;
> > +                };
> > +                BUCK2: buck2 {
> > +                regulator-compatible =3D "BUCK2";
> > +                    regulator-name =3D "mt6360,buck2";
> > +                    regulator-min-microvolt =3D <300000>;
> > +                    regulator-max-microvolt =3D <1300000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP
> > +                                               MT6360_OPMODE_ULP>;
> > +                };
> > +                ldo6 {
> > +                    regulator-compatible =3D "LDO6";
> > +                    regulator-name =3D "mt6360,ldo6";
> > +                    regulator-min-microvolt =3D <500000>;
> > +                    regulator-max-microvolt =3D <2100000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP>;
> > +                };
> > +                ldo7 {
> > +                    regulator-compatible =3D "LDO7";
> > +                    regulator-name =3D "mt6360,ldo7";
> > +                    regulator-min-microvolt =3D <500000>;
> > +                    regulator-max-microvolt =3D <2100000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP>;
> > +                };
> > +                ldo1 {
> > +                    regulator-compatible =3D "LDO1";
> > +                    regulator-name =3D "mt6360,ldo1";
> > +                    regulator-min-microvolt =3D <1200000>;
> > +                    regulator-max-microvolt =3D <3600000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP>;
> > +                };
> > +                ldo2 {
> > +                    regulator-compatible =3D "LDO2";
> > +                    regulator-name =3D "mt6360,ldo2";
> > +                    regulator-min-microvolt =3D <1200000>;
> > +                    regulator-max-microvolt =3D <3600000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP>;
> > +                };
> > +                ldo3 {
> > +                    regulator-compatible =3D "LDO3";
> > +                    regulator-name =3D "mt6360,ldo3";
> > +                    regulator-min-microvolt =3D <1200000>;
> > +                    regulator-max-microvolt =3D <3600000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP>;
> > +                };
> > +                ldo5 {
> > +                    regulator-compatible =3D "LDO5";
> > +                    regulator-name =3D "mt6360,ldo5";
> > +                    regulator-min-microvolt =3D <2700000>;
> > +                    regulator-max-microvolt =3D <3600000>;
> > +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +                                               MT6360_OPMODE_LP>;
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.7.4
> >
