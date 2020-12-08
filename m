Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7822D2DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgLHO5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgLHO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:57:23 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF64C061749;
        Tue,  8 Dec 2020 06:56:42 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so23728618lfd.9;
        Tue, 08 Dec 2020 06:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b3T1EGSizP8McR4LWZyLIg302Ui1Jg73aX+G6hWD4cA=;
        b=ASJdtRosEUOHuvYK+PKK9e66gqzYrU4LSs1i4HTLYutPqAvzM+wYVGTgyyEMl7WZr8
         XxrRWI5ubRgszmdULjEQM9Z9ZB69VbYXdn/85LdOvhoRk8ZWks/jUj9RF4UVwWedVLk4
         e2p/ZmCFgUm4Bil28L2q7wC+uXcejxEYPbW/EULY/ZJ4I2M5aBdXfvDGgbxcr9avfQ22
         rgar2qA3W81MUgBZgqygWhHyYjCtcO2aNVxQaSh2G9PFOog2eKTcxSp5LcQUz9Z8vloi
         JdxLbafRj6jHG//OqlwptZKf3+LwQn3Qt6Ugt4JiHguv58D6VodtPmXxkAf/eCbSUt4E
         jqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3T1EGSizP8McR4LWZyLIg302Ui1Jg73aX+G6hWD4cA=;
        b=mZGed9C8M13gS5g6SlF0ZSXuhN7j3Dy4EJb/bE47h9cOSIaTZc9SZ9xfcG1Fww6Tl3
         Q4ZeIEniooagQOBI0uPyjwq5ke8ptEL2iuOvAFiHa0aY1U+ZRZ7GTvzvIe9ZQ/Esxy7E
         u6iu794RFFib2UBApqdZ3tZByJsGSfv2qg6MdF6/NCmA9FGuoN4JfRC2YS0YGFGSYNP/
         6T75whIgEEMSxnQdsHGhVezMb24a/MMoTQALH+wqzAZgs1FtW9OeU8G0u1FLaF0/nSOc
         mhSU70IBJAKAzyBPXcG0t4iJrdwZjCJ9GNQlZEoF1xfvOkCecK3wh28yeF/8mnnXSVe5
         UMBA==
X-Gm-Message-State: AOAM533apmAEUf6suqWPEST0XvdUJY15YSgfHpti5HNd+LRZ2F11AjHv
        ndvDfEZ0yo6q0wpldXZB+5oz5nV9IesHOcZsGiPeXyd/
X-Google-Smtp-Source: ABdhPJxUHJ6KqGkHcw3Z0liLfsAW7aJUIZnuvtae5Ipkm37qbMbCX06JWwvy+KKsPejOSuIWChlANPDh+wj82WaR8xk=
X-Received: by 2002:a19:641:: with SMTP id 62mr1890929lfg.424.1607439400932;
 Tue, 08 Dec 2020 06:56:40 -0800 (PST)
MIME-Version: 1.0
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
 <1607011595-13603-4-git-send-email-u0084500@gmail.com> <20201207164144.GA398093@robh.at.kernel.org>
In-Reply-To: <20201207164144.GA398093@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 8 Dec 2020 22:56:29 +0800
Message-ID: <CADiBU3_S918K3CcjLvmtZxQBzA0a-nCKM41LeqU==RvOuvhSJA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mfd: rt4831: Adds DT binding document for Richtek
 RT4831 MFD core
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=888=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Dec 04, 2020 at 12:06:35AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Adds DT binding document for Richtek RT4831 MFD core.
> >
> > This patch depends on
> >
> > "backlight: rt4831: Adds DT binding document for Richtek RT4831 backlig=
ht".
> > "regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV reg=
ulator".
>
> You generally don't need to state dependencies on other patches in the
> series. You need to state dependencies that are either pending in a
> maintainers tree or patches not yet applied. IOW, anything not in Linus'
> tree. And that information goes below the '---'.

Ok, I'll add the depend on tag below ---
>
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Changes since v2
> > - Add "patch depends on" in commit description.
> > - Adds regulator-allow-bypass flag in DSVLCM.
> > ---
> >  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 90 ++++++++++++++=
++++++++
> >  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
>
> This goes in the backlight binding patch.
>
> >  2 files changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt483=
1.yaml
> >  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml =
b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
> > new file mode 100644
> > index 00000000..c6ca953
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
> > @@ -0,0 +1,90 @@
> > +# SPDX-License-Identifier: GPL-2.0
>
> For new bindings:
>
> (GPL-2.0-only OR BSD-2-Clause)
>
Ack, change three binding files for dual license.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/richtek,rt4831.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT4831 DSV and Backlight Integrated IC
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  RT4831 is a multifunctional device that can provide power to the LCD=
 display
> > +  and LCD backlight.
> > +
> > +  For Display Bias Voltage DSVP and DSVN, the output range is about 4V=
 to 6.5V.
> > +  It's sufficient to meet the current LCD power requirement.
> > +
> > +  For the LCD backlight, it can provide four channel WLED driving capa=
bility.
> > +  Each channel driving current is up to 30mA
> > +
> > +  Datasheet is available at
> > +  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: richtek,rt4831
> > +
> > +  reg:
> > +    description: I2C device address.
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description: |
> > +      GPIO to enable/disable the chip. It is optional.
> > +      Some usage directly tied this pin to follow VIO 1.8V power on se=
quence.
> > +    maxItems: 1
> > +
> > +  regulators:
> > +    $ref: ../regulator/richtek,rt4831-regulator.yaml
> > +
> > +  backlight:
> > +    $ref: ../leds/backlight/richtek,rt4831-backlight.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/rt4831-backlight.h>
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      rt4831@11 {
> > +        compatible =3D "richtek,rt4831";
> > +        reg =3D <0x11>;
> > +
> > +        regulators {
> > +          DSVLCM {
> > +            regulator-min-microvolt =3D <4000000>;
> > +            regulator-max-microvolt =3D <7150000>;
> > +            regulator-allow-bypass;
> > +          };
> > +          DSVP {
> > +            regulator-name =3D "rt4831-dsvp";
> > +            regulator-min-microvolt =3D <4000000>;
> > +            regulator-max-microvolt =3D <6500000>;
> > +            regulator-boot-on;
> > +          };
> > +          DSVN {
> > +            regulator-name =3D "rt4831-dsvn";
> > +            regulator-min-microvolt =3D <4000000>;
> > +            regulator-max-microvolt =3D <6500000>;
> > +            regulator-boot-on;
> > +          };
> > +        };
> > +
> > +        backlight {
> > +          compatible =3D "richtek,rt4831-backlight";
> > +          default-brightness =3D <1024>;
> > +          max-brightness =3D <2048>;
> > +          richtek,bled-ovp-sel =3D /bits/ 8 <RT4831_BLOVPLVL_21V>;
> > +          richtek,channel-use =3D /bits/ 8 <RT4831_BLED_ALLCHEN>;
> > +        };
> > +      };
> > +    };
> > diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-b=
indings/leds/rt4831-backlight.h
> > new file mode 100644
> > index 00000000..7084906
> > --- /dev/null
> > +++ b/include/dt-bindings/leds/rt4831-backlight.h
> > @@ -0,0 +1,23 @@
> > +/*
> > + * This header provides constants for rt4831 backlight bindings.
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
>
> Use SPDX tag. Also, probably should be dual licensed too if you want to
> use your DTs with non-GPL OS.
>
Ack.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_RT4831_BACKLIGHT_H
> > +#define _DT_BINDINGS_RT4831_BACKLIGHT_H
> > +
> > +#define RT4831_BLOVPLVL_17V  0
> > +#define RT4831_BLOVPLVL_21V  1
> > +#define RT4831_BLOVPLVL_25V  2
> > +#define RT4831_BLOVPLVL_29V  3
> > +
> > +#define RT4831_BLED_CH1EN    (1 << 0)
> > +#define RT4831_BLED_CH2EN    (1 << 1)
> > +#define RT4831_BLED_CH3EN    (1 << 2)
> > +#define RT4831_BLED_CH4EN    (1 << 3)
> > +#define RT4831_BLED_ALLCHEN  ((1 << 4) - 1)
> > +
> > +#endif /* _DT_BINDINGS_RT4831_BACKLIGHT_H */
> > --
> > 2.7.4
> >
