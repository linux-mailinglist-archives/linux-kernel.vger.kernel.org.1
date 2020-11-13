Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C506F2B15A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 06:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMFyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 00:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgKMFyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 00:54:36 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DFC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 21:54:36 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n89so8003092otn.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 21:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GoKt9qTDKQE4GT9citKUvVB07Do0nzIggyEPsURICQ0=;
        b=ep6PAcX8q2OYEcvsYcnL+vTaiY+MpyOfcSA5Fs/wx+naVDdzKYsQsXfgAqYkdd/jr6
         JIEOfKluXhzghjH6S7LY576jTXduSMCYxytuldkBfXyV1+8i8egziI6aAgTgxwsPT6qV
         9ssPkkZL8WtkwaK3+rvMo12fYgcCMAwneUeWpTRc6L17Cvh8PrVw+0vTkV8+9UqXONqx
         UwwmzEVX+OOzIuRfDpHrrsPQYa2qRQqnvx2O2a1tJ0ZVZI+jaTASMLlgm1JW6AWOJS+Q
         zZqMvvWshUK9NrWpEXhD4TLJkxBsEbk2T7E7RO2DQyFwThr9yCg38MzCyGmobqbFJltX
         wQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GoKt9qTDKQE4GT9citKUvVB07Do0nzIggyEPsURICQ0=;
        b=gBpIzoIlZ4A/+YRmosVsf3FaNoeoWv4uT0p/8v3opWK1S4UxhJG5/8/heef69k2ri3
         mVw2TNVg0MxbfEOvl5prkZr1QjqMvP1g6H+oaJ5hQRJHcOA0rv0y5rVUbn/YR7/jgGe7
         KY8OgbbRHd3DSC0xL8FHmTpXJMpuHx08KemngZ3GC0jtjEvm8VpCkN7YNQtqueRx1reI
         P2KEi+sOayrVXCP1apY72YxoW0JBlNT85YBEBywMbcZL6hDiPXe0J8uNTCAfX1th7aj7
         XngcmRaQYYFtN+vBWde1GUGtMxSg7uv6s5Ps9ZbZPxYAf5hSHmT9CnpXPV8Phon437Kr
         wp+A==
X-Gm-Message-State: AOAM533BRhAA+7XtGX/Jc2urHxb+UuBrWgr+6g2XiC1dkJbhIHaJxGcS
        NLbhKnfdJCNa7xV73myo40dqnffJpofSvMv4Lig=
X-Google-Smtp-Source: ABdhPJz+KXXHD9NpM6gCw/C0H/t+n34q85yCTi8xEmCCS5Jrze497ziFd7rb2ZrF2QyPR+UIORZHk43zKDARLwhN0gY=
X-Received: by 2002:a9d:7a97:: with SMTP id l23mr475701otn.232.1605246875383;
 Thu, 12 Nov 2020 21:54:35 -0800 (PST)
MIME-Version: 1.0
References: <1597912530-5374-1-git-send-email-gene.chen.richtek@gmail.com>
In-Reply-To: <1597912530-5374-1-git-send-email-gene.chen.richtek@gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 13 Nov 2020 13:54:24 +0800
Message-ID: <CAE+NS37_YY1aVYv-MBsxoBXCkvj7+fBK+vZke9yG7eY1aMHLKQ@mail.gmail.com>
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

   Please let me know if there is anything need to be revised.

Gene Chen <gene.chen.richtek@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Gene Chen <gene_chen@richtek.com>
>
> Add bindings for MT6360 PMIC
>
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6360.yaml | 142 ++++++++++++++++=
++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/mt6360.yaml b/Document=
ation/devicetree/bindings/mfd/mt6360.yaml
> new file mode 100644
> index 0000000..5ad1afd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mt6360.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mt6360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6360 PMIC from MediaTek Integrated
> +
> +maintainers:
> +  - Gene Chen <gene_chen@richtek.com>
> +
> +description: |
> +  MT6360 is a PMIC device with the following sub modules.
> +  It is interfaced to host controller using I2C interface.
> +
> +  This document describes the binding for PMIC device and its sub module=
.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6360
> +
> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +      enum:
> +        - IRQB
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description:
> +      The first cell is the IRQ number.
> +
> +  regulator:
> +    $ref: ../regulator/mt6360-regulator.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        mt6360@34 {
> +            compatible =3D "mediatek,mt6360";
> +            reg =3D <0x34>;
> +            wakeup-source;
> +            interrupts-extended =3D <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-names =3D "IRQB";
> +            interrupt-controller;
> +            #interrupt-cells =3D <1>;
> +            regulator {
> +                compatible =3D "mediatek,mt6360-regulator";
> +                LDO_VIN3-supply =3D <&BUCK2>;
> +                buck1 {
> +                    regulator-compatible =3D "BUCK1";
> +                    regulator-name =3D "mt6360,buck1";
> +                    regulator-min-microvolt =3D <300000>;
> +                    regulator-max-microvolt =3D <1300000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP
> +                                               MT6360_OPMODE_ULP>;
> +                };
> +                BUCK2: buck2 {
> +                regulator-compatible =3D "BUCK2";
> +                    regulator-name =3D "mt6360,buck2";
> +                    regulator-min-microvolt =3D <300000>;
> +                    regulator-max-microvolt =3D <1300000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP
> +                                               MT6360_OPMODE_ULP>;
> +                };
> +                ldo6 {
> +                    regulator-compatible =3D "LDO6";
> +                    regulator-name =3D "mt6360,ldo6";
> +                    regulator-min-microvolt =3D <500000>;
> +                    regulator-max-microvolt =3D <2100000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP>;
> +                };
> +                ldo7 {
> +                    regulator-compatible =3D "LDO7";
> +                    regulator-name =3D "mt6360,ldo7";
> +                    regulator-min-microvolt =3D <500000>;
> +                    regulator-max-microvolt =3D <2100000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP>;
> +                };
> +                ldo1 {
> +                    regulator-compatible =3D "LDO1";
> +                    regulator-name =3D "mt6360,ldo1";
> +                    regulator-min-microvolt =3D <1200000>;
> +                    regulator-max-microvolt =3D <3600000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP>;
> +                };
> +                ldo2 {
> +                    regulator-compatible =3D "LDO2";
> +                    regulator-name =3D "mt6360,ldo2";
> +                    regulator-min-microvolt =3D <1200000>;
> +                    regulator-max-microvolt =3D <3600000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP>;
> +                };
> +                ldo3 {
> +                    regulator-compatible =3D "LDO3";
> +                    regulator-name =3D "mt6360,ldo3";
> +                    regulator-min-microvolt =3D <1200000>;
> +                    regulator-max-microvolt =3D <3600000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP>;
> +                };
> +                ldo5 {
> +                    regulator-compatible =3D "LDO5";
> +                    regulator-name =3D "mt6360,ldo5";
> +                    regulator-min-microvolt =3D <2700000>;
> +                    regulator-max-microvolt =3D <3600000>;
> +                    regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> +                                               MT6360_OPMODE_LP>;
> +                };
> +            };
> +        };
> +    };
> --
> 2.7.4
>
