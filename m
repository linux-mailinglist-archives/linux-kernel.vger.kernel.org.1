Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA42A2476
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 06:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKBFxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 00:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgKBFxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 00:53:31 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B053C0617A6;
        Sun,  1 Nov 2020 21:53:31 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l28so15799464lfp.10;
        Sun, 01 Nov 2020 21:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2IhVGGy9LoXienasL7ylaLMwfquHIM1PDGypRLbzcA4=;
        b=HwzVmbu5EFUY4E3z2rs0sFP6WXrqWNB28nqQoGE40DW1Trsz70bhCXdFI7Nr7hmBua
         +uXpEbtLqHTI7q3NvWcfMv6LdfT3GK8hVgGP+RtZEoYUtU8C/Nz3GXu74GOn91JgfeNc
         ziBfWdxCzOqoQV+1IFz+IZzAH8mHffnNGlTPfq5rkVQtiW7Ugi5vFqDxbzYZVuvbJTIh
         zlte4SeJW/yn71g7ggnjYV3M6kfl8EEoK8+IqjQk1BYNL8EYHBJqBTX2iSVIaC+Swspg
         9Hl0WHsgTnuVg9ylSvj62OuFScQxWTbTsZT685Uyg6UuqZvVwQhPwNS4qSYfhE9fE3Lw
         6qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2IhVGGy9LoXienasL7ylaLMwfquHIM1PDGypRLbzcA4=;
        b=KJ9BRykp9OyHdMZRNIfUV138MDLU31Nwc6n2bDvh4FwFCM5td6b0clqKTXiE+TTSdb
         AzFPqQGHHHwBh6NL9L2FeJdLKqTHYwgU5NdcnFwLWeCTte9nqdYvzAIjEq6Ad3Ajf/Eo
         DJiv84OhOYoBb2eDZUqwNuOLM93D+0PRhXPMHejYUWSLhlSQbbfApjGWH8VAIS79Or6w
         hIw+1L0Xoe0mViXCXzwIJgson/0aq7PFaVZ6fT2UjvHvJBzWjF7KMLyePJwFAqWA6TKc
         51NjZXwk1PLaXMwzpGzi2q14d6T7Lv/h44e30pfe2Glf6qZ8m4b4xhZCsJgHLmtJfIkR
         ismw==
X-Gm-Message-State: AOAM531EN5MtTrpDZRXs387naLh2MMU8RLVgC47cxPf8pMUKhHG9fHmm
        7J01a6jg16/TrPPeJoBdQe0Se8Bkr+cc2w791OqhfsPRIug=
X-Google-Smtp-Source: ABdhPJwHyxU7ztZgGl9kqwIv07ilGQCRugQU5oXvmjbAzhzQaCtphMj5G6i+c8wwpwZPE2q85aOLwShTjx7yCFzfQMw=
X-Received: by 2002:ac2:57c7:: with SMTP id k7mr5426332lfo.20.1604296409691;
 Sun, 01 Nov 2020 21:53:29 -0800 (PST)
MIME-Version: 1.0
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com> <1604286803-20698-2-git-send-email-u0084500@gmail.com>
In-Reply-To: <1604286803-20698-2-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 2 Nov 2020 13:53:18 +0800
Message-ID: <CADiBU38Wmpobg-Z6euax2csa2s7E1M2CJS5Ks9gNTOZ=xRobkA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: rt4505: Adds DT binding document for Richtek
 RT4831 MFD core
To:     Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org
Cc:     cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I seems I typo the wrong comment headline, not RT4505. It's RT4831.
Please just review the contents, I'll fix it in next series patch.


cy_huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=882=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Adds DT binding document for Richtek RT4831 MFD core.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 89 ++++++++++++++++=
++++++
>  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.=
yaml
>  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
>
> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/=
Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
> new file mode 100644
> index 00000000..c602d50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/richtek,rt4831.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT4831 DSV and Backlight Integrated IC
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  RT4831 is a mutifunctional device that can provide display panel power=
 for
> +  positive/negative voltage and also display panel wled driving.
> +
> +  For the display voltage output, the range is about 4V to 6.5V. It is s=
ufficient
> +  to meet the current display panel design.
> +
> +  For the panel backlight, it can provide four channels driving capabili=
ty
> +  Each driving current is up to 30mA
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
> +
> +properties:
> +  compatible:
> +    const: richtek,rt4831
> +
> +  reg:
> +    description: I2C device address.
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: |
> +      GPIO to enable/disable the chip. It is optional.
> +      Some usage directly tied this pin to follow VIO 1.8V power on sequ=
ence.
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: ../regulator/richtek,rt4831-regulator.yaml
> +
> +  backlight:
> +    $ref: ../leds/backlight/richtek,rt4831-backlight.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/rt4831-backlight.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      rt4831@11 {
> +        compatible =3D "richtek,rt4831";
> +        reg =3D <0x11>;
> +
> +        regulators {
> +          DSVLCM {
> +            regulator-min-microvolt =3D <4000000>;
> +            regulator-max-microvolt =3D <7150000>;
> +          };
> +          DSVP {
> +            regulator-name =3D "rt4831-dsvp";
> +            regulator-min-microvolt =3D <4000000>;
> +            regulator-max-microvolt =3D <6500000>;
> +            regulator-boot-on;
> +          };
> +          DSVN {
> +            regulator-name =3D "rt4831-dsvn";
> +            regulator-min-microvolt =3D <4000000>;
> +            regulator-max-microvolt =3D <6500000>;
> +            regulator-boot-on;
> +          };
> +        };
> +
> +        backlight {
> +          compatible =3D "richtek,rt4831-backlight";
> +          default-brightness =3D <1024>;
> +          max-brightness =3D <2048>;
> +          richtek,bled-ovp-sel =3D /bits/ 8 <RT4831_BLOVPLVL_21V>;
> +          richtek,channel-use =3D /bits/ 8 <RT4831_BLED_ALLCHEN>;
> +        };
> +      };
> +    };
> diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bin=
dings/leds/rt4831-backlight.h
> new file mode 100644
> index 00000000..7084906
> --- /dev/null
> +++ b/include/dt-bindings/leds/rt4831-backlight.h
> @@ -0,0 +1,23 @@
> +/*
> + * This header provides constants for rt4831 backlight bindings.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef _DT_BINDINGS_RT4831_BACKLIGHT_H
> +#define _DT_BINDINGS_RT4831_BACKLIGHT_H
> +
> +#define RT4831_BLOVPLVL_17V    0
> +#define RT4831_BLOVPLVL_21V    1
> +#define RT4831_BLOVPLVL_25V    2
> +#define RT4831_BLOVPLVL_29V    3
> +
> +#define RT4831_BLED_CH1EN      (1 << 0)
> +#define RT4831_BLED_CH2EN      (1 << 1)
> +#define RT4831_BLED_CH3EN      (1 << 2)
> +#define RT4831_BLED_CH4EN      (1 << 3)
> +#define RT4831_BLED_ALLCHEN    ((1 << 4) - 1)
> +
> +#endif /* _DT_BINDINGS_RT4831_BACKLIGHT_H */
> --
> 2.7.4
>
