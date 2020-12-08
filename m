Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675AA2D2DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgLHO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgLHO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:58:16 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF9C061794;
        Tue,  8 Dec 2020 06:57:30 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id q8so19811369ljc.12;
        Tue, 08 Dec 2020 06:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W77ZHSjcC07+ncgEX9oe8j59pCWg7z2sENxFcfkBStg=;
        b=Fygaz4oqGa+a+NhDoQ8SamecGfNZ1oVDdtouE+1xOrZbXrfLU52J3cAVxI4dQVhp+H
         1Y9xRZopYNvvoKW/QRvyelPzt4+YblzJKMIvzFZsQ8FjtaUen+fxeedTrnBvhIDkrqL5
         y4Rf+Ty/QjmV6ttD0uRX3oX/p5OuhpcDlzHHzCFZsCh6/nwGPX/6Gi6CMexo4MFE+UX8
         qwhqnnJ4pIyVKm6oyI54CjmP2lBstvFuPJ3DtDN36POvmqPIbb2S0ArLSo1NLrJbWJ24
         w97plpEJV8bEWQVBsVNpqwUF8GI/dexQ+sHR64nb/rsLg2UKV9At8rfg9FvwR9zCEUg+
         buGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W77ZHSjcC07+ncgEX9oe8j59pCWg7z2sENxFcfkBStg=;
        b=ep1adgjr6R9Uahd/8EHfVNrrLyw4w2Zw0QySCLvsAvuD/pfKQDBlhRsmCDFUIZOwzD
         shfCv7D0UO4PxXulGNl8wyFJd/eDqSuzrm1G32IEFX5Cqf5TFXgl6nuSsfenjXACo/Rn
         sDqLSAwHPhZjNYsYN2rDsCirkrAGV/DYT/HcTAf+3A6FHAm1JJZseXXb5uVLXWrrh+4/
         BxkAmuFmf4KrqO92DuNBocyQt2+5ENOO8jsJzFm+zHu2XA7Dvwj6U3ZXQSXtt/q3CPux
         AxwvvQdkGBM00P311EZ6CHZY3ndw8mwtpO6tCat6XnlPROOVdm4MOo32jDRxruComTpk
         jwCg==
X-Gm-Message-State: AOAM533YUYz5dypsDix9BxgeE/nMvXb66pSigHjwUwqJIWUoTEADmHpO
        egZV3JxfA1+XHYAkcM3eFgIg9sPAC88od35bmt13FHsH
X-Google-Smtp-Source: ABdhPJxmOiEwTy3F/12ct7dtwFip8ZHWt2BKMQMbRSbbR+rMAWc51tX8HxlziLqS3Dv2o9M34+HB4ErL3vZeXyk9X8U=
X-Received: by 2002:a2e:7607:: with SMTP id r7mr3783025ljc.168.1607439448625;
 Tue, 08 Dec 2020 06:57:28 -0800 (PST)
MIME-Version: 1.0
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
 <1607011595-13603-2-git-send-email-u0084500@gmail.com> <20201207164247.GB398093@robh.at.kernel.org>
In-Reply-To: <20201207164247.GB398093@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 8 Dec 2020 22:57:17 +0800
Message-ID: <CADiBU3-fKrGEUDD90nnLqeUP9wUth6_oOnn4THw2iZC4=yF7Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
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
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Dec 04, 2020 at 12:06:33AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Adds DT binding document for Richtek RT4831 backlight.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../leds/backlight/richtek,rt4831-backlight.yaml   | 86 ++++++++++++++=
++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ri=
chtek,rt4831-backlight.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,r=
t4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ric=
htek,rt4831-backlight.yaml
> > new file mode 100644
> > index 00000000..df1439a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-b=
acklight.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: GPL-2.0
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
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      rt4831@11 {
> > +        compatible =3D "richtek,rt4831";
> > +        reg =3D <0x11>;
> > +
> > +        backlight {
> > +          compatible =3D "richtek,rt4831-backlight";
> > +          default-brightness =3D <1024>;
> > +          max-brightness =3D <2048>;
> > +          richtek,bled-ovp-sel =3D /bits/ 8 <RT4831_BLOVPLVL_21V>;
> > +          richtek,channel-use =3D /bits/ 8 <RT4831_BLED_ALLCHEN>;
> > +        };
> > +      };
>
> Just do 1 complete example in the mfd binding.
>
Ack.
> > +    };
> > --
> > 2.7.4
> >
