Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DFE2D9A34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440054AbgLNOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388406AbgLNOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:41:48 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9EC061794;
        Mon, 14 Dec 2020 06:41:08 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s75so19398459oih.1;
        Mon, 14 Dec 2020 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=emYH1CDyNm1BhuqvaRMloeDz4m115YgfkfIi4eq8Wq8=;
        b=B3vxtso6GenEmv5N7OfFAOW+pAGPqwE3gWVo0+MjnBpTrUdnahF9rA15EIdqvfigH+
         8TuIugvQ9w/KoVeYBORgYX/DB3CPrTkW0VRNkGGAU66r7uIkIaU7ZjHTK7KV6O7qbxoI
         YzxZ7vDx4YehjcOtXbOGUkaeSk+E9RL7npCFlAbMVLwOcJcvLKb4mHTLWyQZxwoFrL47
         Z1OCVoR7NyK+7VYYrzd6zcG+gkifFHAoxFDvYPa5RoqcWTqVemtiXyb0PZcEhMp3XAF0
         NVxyWM0UTcJiVhzUllYiPMGyXuUKm8B2IuzKsaru29R5PacRyjJHKFIxOSma8H1xal/O
         SBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=emYH1CDyNm1BhuqvaRMloeDz4m115YgfkfIi4eq8Wq8=;
        b=JZOFAaEut8mV2EbhlvT9Vnn9G4Drsceb8xrB3m75i9A/c4RYLaLCaXLDak0yPHw2YJ
         SypQV2K2SmXvK0UGbriM5bsqTDz819rcalgYRNzn3bcXlHey0El466yHLjoM8wlGoOJd
         D9qq3YqbM6rUbO7uynMf0o7ML9xU4m7OiiKu6l3YLAgonyOiLxAbYx6dKY7IU1t/lRJb
         G4hBM2i7yQJZEnFYKlaw/H4PZwVxorUD+Kiadn+1DUa3xvLeH5p/krSal2WuEGNOBddp
         B9HV4p977c+++MedQHKK8WnGhOOV0DfVcYRrWFgt8mRCS71VNQ/tvx9UbULjTY85ZF7G
         MR4w==
X-Gm-Message-State: AOAM530npXxKeLKUtz+9l6E9pI+MybYu6YrwDazk7rBgs9trWC8n7ovL
        Ewx+7bhLxGkewk3kv8dAIhKEXv+27McDj/XdudOEHsW0
X-Google-Smtp-Source: ABdhPJxXOvuFwQayUv3DdPo2h+A7x8DDHAt6Nt9SPYFiUn+UebDb+s+6bYFZqDZx/d6/WRuNkVn1pdMYrLyTUP9Ym08=
X-Received: by 2002:aca:4ec9:: with SMTP id c192mr19079047oib.115.1607956867287;
 Mon, 14 Dec 2020 06:41:07 -0800 (PST)
MIME-Version: 1.0
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com> <20201214095916.4g47zlueng4wa3hv@holly.lan>
In-Reply-To: <20201214095916.4g47zlueng4wa3hv@holly.lan>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 14 Dec 2020 22:40:55 +0800
Message-ID: <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Thompson <daniel.thompson@linaro.org> =E6=96=BC 2020=E5=B9=B412=E6=
=9C=8814=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:59=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Hi CY
>
> On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Adds DT binding document for Richtek RT4831 backlight.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>
> This patch got keyword filtered and brought to my attention
> but the rest of the series did not.
>
> If it was a backlight patch series you need to send it To: the
> all the backlight maintainers.
>
Yes, I'm waiting for mfd reviewing.
Due to mfd patch, I need to add backlight dt-binding patch prior to
backlight source code.
Or autobuild robot will said mfd dt-binding build fail from Rob.
That's why I send the backlight dt-binding prior to the source code.

I still have backlight/regulator source code patch after mfd reviewing.
Do you want me to send all the patches without waiting for mfd reviewing?
>
> Daniel.
>
>
> > ---
> > since v3
> > - Move inlcude/dt-bindings/leds/rt4831-backlight.h from v3 mfd binding =
patch to here.
> > - Add dual license tag in header and backlight binding document.
> > - Left backlight dt-binding example only.
> > ---
> >  .../leds/backlight/richtek,rt4831-backlight.yaml   | 76 ++++++++++++++=
++++++++
> >  include/dt-bindings/leds/rt4831-backlight.h        | 23 +++++++
> >  2 files changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ri=
chtek,rt4831-backlight.yaml
> >  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,r=
t4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ric=
htek,rt4831-backlight.yaml
> > new file mode 100644
> > index 00000000..f24c8d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-b=
acklight.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/richtek,rt4831-backl=
ight.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT4831 Backlight
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  RT4831 is a mutifunctional device that can provide power to the LCD =
display
> > +  and LCD backlight.
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
> > +    const: richtek,rt4831-backlight
> > +
> > +  default-brightness:
> > +    description: |
> > +      The default brightness that applied to the system on start-up.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 2048
> > +
> > +  max-brightness:
> > +    description: |
> > +      The max brightness for the H/W limit
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 2048
> > +
> > +  richtek,pwm-enable:
> > +    description: |
> > +      Specify the backlight dimming following by PWM duty or by SW con=
trol.
> > +    type: boolean
> > +
> > +  richtek,bled-ovp-sel:
> > +    description: |
> > +      Backlight OVP level selection, currently support 17V/21V/25V/29V=
.
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    default: 1
> > +    minimum: 0
> > +    maximum: 3
> > +
> > +  richtek,channel-use:
> > +    description: |
> > +      Backlight LED channel to be used.
> > +      BIT 0/1/2/3 is used to indicate led channel 1/2/3/4 enable or di=
sable.
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    minimum: 1
> > +    maximum: 15
> > +
> > +required:
> > +  - compatible
> > +  - richtek,channel-use
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/rt4831-backlight.h>
> > +    backlight {
> > +      compatible =3D "richtek,rt4831-backlight";
> > +      default-brightness =3D <1024>;
> > +      max-brightness =3D <2048>;
> > +      richtek,bled-ovp-sel =3D /bits/ 8 <RT4831_BLOVPLVL_21V>;
> > +      richtek,channel-use =3D /bits/ 8 <RT4831_BLED_ALLCHEN>;
> > +    };
> > diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-b=
indings/leds/rt4831-backlight.h
> > new file mode 100644
> > index 00000000..125c635
> > --- /dev/null
> > +++ b/include/dt-bindings/leds/rt4831-backlight.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * This header provides constants for rt4831 backlight bindings.
> > + *
> > + * Copyright (C) 2020, Richtek Technology Corp.
> > + * Author: ChiYuan Huang <cy_huang@richtek.com>
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
