Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75327DE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgI3CYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbgI3CYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:24:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C497C061755;
        Tue, 29 Sep 2020 19:24:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y17so233628lfa.8;
        Tue, 29 Sep 2020 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Xbtte5JrWARC2yq6ReJge5l4j940LmWCxXyXW08EPA=;
        b=cEeqYkAHagaQYn/9dBwvfudjh851VfLCGYAjRqgo7SYFPMWHHwrH6qzPxwlUSHb4NS
         VUtxQeXO4ZXElQ3tMeITECtsb4fauJ5BEnhhpPVnCPnbVgSYfI3/iXiH4IRSNChbxQSU
         OaheOsqhI/ZxJvJVFKs4PqI47B6edO2wNmAoTdhXmrM0Gp670WubshadIp1E5IquzRm8
         f4115Qrn6RZu9ytMP6UR5lgJeA2J776E5CWqN5rNJye+enjaaQPIAnfJqv8GEhvAoe6K
         e/DKtre2/7OxLw3PGV4VrcNnoy5sKMR7YyxwDRrg+bKK7M2aXzj+b5uCtAcIyiwPyZGH
         fSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Xbtte5JrWARC2yq6ReJge5l4j940LmWCxXyXW08EPA=;
        b=oP5XyLkoHwl4w1Oko5ldM/AnXnLdThHcUTqOnHL3hIKUN0atOURD+KJxXA2+nkDhG9
         bT9PZgOfE7gSWtV0kQmuB3zxAvIlJDkGnImyZIGJ24XmH9bDwQM9f4sUO+xiGmKJ9Vkk
         LTpJnRoh3G6d4zna8xicDN7n9Kc9rbnCUBy+XtatIfSB306hIz4Bpv0z8ci9ORSQfyHH
         LJCR75iB7wwh30+Pk4klXiFNFO/zo/DEWq07Ip3AZK58xzeZZG3hogGcLP1YwTuw1Oyq
         4uos59RGVfvcukCx8zQ/eO351RLmVEX3Zo7otD4PByeu7PnEt0FjayRkvfLJZKfZSN51
         5fHA==
X-Gm-Message-State: AOAM531t0ZW/suQbQFXZ0+Z8ju/aJ4WzFL6cmUb46g8yqMwNWLPSrBzp
        Kpx5gsQQfT3bqCOFH+kuf+XS7j7IKG3VkKaoEes=
X-Google-Smtp-Source: ABdhPJyd6f3/5aGfUyPEl4IwMRv0+hVyA7GFlBPxqkek66cTGpwvhu143OJshScnqvlK19sFVDKIitZIYVctBSeBdnY=
X-Received: by 2002:ac2:57c7:: with SMTP id k7mr72885lfo.20.1601432641600;
 Tue, 29 Sep 2020 19:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
 <1601277584-5526-2-git-send-email-u0084500@gmail.com> <20200929150624.GA583524@bogus>
In-Reply-To: <20200929150624.GA583524@bogus>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 30 Sep 2020 10:23:49 +0800
Message-ID: <CADiBU3_7wj7W2evOAG1GM991OigPYy4FXraeOLCVreaMO86HXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: rtmv20: Add DT-binding document for
 Richtek RTMV20
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, cy_huang <cy_huang@richtek.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob
  Ack is in below comments.

Hi, Mark:
   Due to that already merged into your regulator for-next git, may I
send the patch to fix Rob's comment?
And I also found one line need to be added into rtmv20 probe phase.
Please check below.
        /*
         * keep in shutdown mode to minimize the current consumption
         * and also mark regcache as dirty
         */
+      regcache_cache_only(priv->regmap, true);
        regcache_mark_dirty(priv->regmap);
        gpiod_set_value(priv->enable_gpio, 0);

Can I directly merge into one that includes Rob's comment and the
above line to be added?

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8829=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Sep 28, 2020 at 03:19:44PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add DT-binding document for Richtek RTMV20
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../regulator/richtek,rtmv20-regulator.yaml        | 168 +++++++++++++=
++++++++
> >  1 file changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek=
,rtmv20-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv2=
0-regulator.yaml
> > new file mode 100644
> > index 00000000..4cb4b68
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regula=
tor.yaml
> > @@ -0,0 +1,168 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/richtek,rtmv20-regulator.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RTMV20 laser diode regulator
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  Richtek RTMV20 is a load switch current regulator that can supply up=
 to 6A.
> > +  It is used to drive laser diode. There're two signals for chip contr=
ols
> > +  (Enable/Fail), Enable pin to turn chip on, and Fail pin as fault ind=
ication.
> > +  There're still four pins for camera control, two inputs (strobe and =
vsync),
> > +  the others for outputs (fsin1 and fsin2). Strobe input to start the =
current
> > +  supply, vsync input from IR camera, and fsin1/fsin2 output for the o=
ptional.
> > +
> > +properties:
> > +  compatible:
> > +    const: richtek,rtmv20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  wakeup-source: true
> > +
> > +  interrupts-extend:
>
> You mean interrupts-extended?
>
> In any case, use 'interrupts' here and the tooling allows for either.

Yes, you're righ.
Sorry, I key in the yaml file, line by line.
It's really a typo.
>
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description: A connection of the 'enable' gpio line.
> > +    maxItems: 1
> > +
> > +  ld-pulse-delay-us:
> > +    description: |
> > +      load current pulse delay in microsecond after strobe pin pulse h=
igh.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
>
> Don't need a type ref when you have a standard property unit suffix, so
> drop.
Ack, remove type ref for all properties that included unit suffix.
>
> This and all the following need a vendor prefix too.
Is it okay to Add "richtek," prefix for all the properties except lsw
regulator node?
>
> > +    minimum: 0
> > +    maximum: 100000
> > +    default: 0
> > +
> > +  ld-pulse-width-us:
> > +    description: |
> > +      Load current pulse width in microsecond after strobe pin pulse h=
igh.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 0
> > +    maximum: 10000
> > +    default: 1200
> > +
> > +  fsin1-delay-us:
> > +    description: |
> > +      Fsin1 pulse high delay in microsecond after vsync signal pulse h=
igh.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 0
> > +    maximum: 100000
> > +    default: 23000
> > +
> > +  fsin1-width-us:
> > +    description: |
> > +      Fsin1 pulse high width in microsecond after vsync signal pulse h=
igh.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 40
> > +    maximum: 10000
> > +    default: 160
> > +
> > +  fsin2-delay-us:
> > +    description: |
> > +      Fsin2 pulse high delay in microsecond after vsync signal pulse h=
igh.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 0
> > +    maximum: 100000
> > +    default: 23000
> > +
> > +  fsin2-width-us:
> > +    description: |
> > +      Fsin2 pulse high width in microsecond after vsync signal pulse h=
igh.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 40
> > +    maximum: 10000
> > +    default: 160
> > +
> > +  es-pulse-width-us:
> > +    description: Eye safety function pulse width limit in microsecond.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 0
> > +    maximum: 10000
> > +    default: 1200
> > +
> > +  es-ld-current-microamp:
> > +    description: Eye safety function load current limit in microamp.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 0
> > +    maximum: 6000000
> > +    default: 3000000
> > +
> > +  lbp-level-microvolt:
> > +    description: Low battery protection level in microvolt.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +    minimum: 2400000
> > +    maximum: 3700000
> > +    default: 2700000
> > +
> > +  lbp-enable:
> > +    description: Low battery protection function enable control.
> > +    type: boolean
> > +
> > +  strobe-polarity-high:
> > +    description: Strobe pin active polarity control.
> > +    type: boolean
> > +
> > +  vsync-polarity-high:
> > +    description: Vsync pin active polarity control.
> > +    type: boolean
> > +
> > +  fsin-enable:
> > +    description: Fsin function enable control.
> > +    type: boolean
> > +
> > +  fsin-output:
> > +    description: Fsin function output control.
> > +    type: boolean
> > +
> > +  es-enable:
> > +    description: Eye safety function enable control.
> > +    type: boolean
> > +
> > +patternProperties:
> > +  "lsw":
>
> This matches ".*lsw.*". What you wanted? If just 'lsw', then it's not a
> pattern.
>
OK
> > +    type: object
> > +    $ref: "regulator.yaml#"
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - wakeup-source
> > +  - interrupts-extend
> > +  - enable-gpios
> > +  - lsw
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      rtmv20@34 {
> > +        compatible =3D "richtek,rtmv20";
> > +        reg =3D <0x34>;
> > +        wakeup-source;
> > +        interrupts-extend =3D <&gpio26 2 IRQ_TYPE_LEVEL_LOW>;
>
> 2 wrongs make a right... But your driver interrupt probably doesn't work
> too well.
Yes, fix it right now.
>
> > +        enable-gpios =3D <&gpio26 3 0>;
> > +
> > +        strobe-polarity-high;
> > +        vsync-polarity-high;
> > +
> > +        lsw {
> > +                regulator-name =3D "rtmv20,lsw";
> > +                regulator-min-microamp =3D <0>;
> > +                regulator-max-microamp =3D <6000000>;
> > +        };
> > +      };
> > +    };
> > +...
> > --
> > 2.7.4
> >
