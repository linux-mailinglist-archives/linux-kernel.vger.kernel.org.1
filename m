Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559192D7420
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392192AbgLKKnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393033AbgLKKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:43:15 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2878C0613CF;
        Fri, 11 Dec 2020 02:42:34 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so12676154lfd.5;
        Fri, 11 Dec 2020 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U+y+tDZjJH7JyLjfyadetwPt0gf0m/ga9lELQW2CCaU=;
        b=YOxctUmd6aySO+yRHhWybfiYYtjLN1kzmau+gTL9/ZdGZMThIXDohvlHfv1VmwWuIv
         rp+BHIQr5ay3ohoc9P1JwvEZwl9ASIfo67kQtJ+/58qsBsTUaJGxY8P16a1QZaYzQTFO
         ovuLVMxuSF0dN0aN3a8J4hKKfdtJ7Bgvpv6GP7Q0fCo+9HgX3AVwy5xD+K8cjvWo78gQ
         xS+t041IkDwZ57KeEoIz9AqYHPaoeUp03SuYHHtMrE9hqAUehWV5Yp0V0WSaedF/JmTD
         30KzH+No+omEquNDuaOh3RrR9YWBJBfofebHVr5p+BXxBpBFC+CH3xOUtbiXvW7N+WPy
         6DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U+y+tDZjJH7JyLjfyadetwPt0gf0m/ga9lELQW2CCaU=;
        b=ZZGJsl9gORynG+DP9gFrU0QeN6eal0WEu5r6+ImhOn1iynR3O+E3HfPEMZNoCJ55Q2
         tiN5m5pGnXo8cxPQ0kWnm3/LLvrov1taukVG1dn8LIQNZjRVmooiyKv27PHdvts39KQj
         72C0OqYr8NIFv7ETA/GJuC8KY84G0iq8L0xwJ4Z91+cH5SrO39a+9dorh51dysMtP0NH
         DJiJuVDZL4r8dvyL7G0wBj7YSdJLQ4MYHS/QilAFxuT5j4b0SOy8JBzWdv/Hd/RyhTxo
         yPllGUDIXLQZdzAOVp9BpalLEDE2LZtRDoQquJqeoQrzH0/IjOE8qEhk0ozdJm/4v3ff
         m7+Q==
X-Gm-Message-State: AOAM531RUtCrKs7oAUQtMZOqGYu7M3zTlNHKGJvW9xm14BsH4C/a1GRN
        df5/z9Rg9uipChEC+D7QeP0VAPzfTh9rtiuQYRc=
X-Google-Smtp-Source: ABdhPJy02b8KUSA9swQaEtY1e+kwg9ZkoRN8mN3nHzMCt8PaBh9BPzwL2n1a+Hj9OWh/Co07BciugzwaQoowkirrvEM=
X-Received: by 2002:a19:747:: with SMTP id 68mr4107957lfh.408.1607683353004;
 Fri, 11 Dec 2020 02:42:33 -0800 (PST)
MIME-Version: 1.0
References: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
 <1607442886-13046-3-git-send-email-u0084500@gmail.com> <20201210151742.GB2518014@robh.at.kernel.org>
In-Reply-To: <20201210151742.GB2518014@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 11 Dec 2020 18:42:20 +0800
Message-ID: <CADiBU3_Z7jPxGPxYpdq=fJyS1kwxx32F8FjjSw5L3_LK0VG28g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] regulator: rt4831: Adds DT binding document for
 Richtek RT4831 DSV regulator
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

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=8810=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 08, 2020 at 11:54:45PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Adds DT binding document for Richtek RT4831 DSV regulator.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > since v3
> > - Add dual license tag in regulator binding document.
> > - Left regulator dt-binding example only.
> > ---
> >  .../regulator/richtek,rt4831-regulator.yaml        | 57 ++++++++++++++=
++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek=
,rt4831-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4831=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt483=
1-regulator.yaml
> > new file mode 100644
> > index 00000000..c6741f2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regula=
tor.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/richtek,rt4831-regulator.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT4831 Display Bias Voltage Regulator
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
> > +  It is sufficient to meet the current LCD power requirement.
> > +
> > +  DSVLCM is a boost regulator in IC internal as DSVP and DSVN input po=
wer.
> > +  Its voltage should be configured above 0.15V to 0.2V gap larger than=
 the
> > +  voltage needed for DSVP and DSVN. Too much voltage gap could improve=
 the
> > +  voltage drop from the heavy loading scenario. But it also make the p=
ower
> > +  efficiency worse. It's a trade-off.
> > +
> > +  Datasheet is available at
> > +  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
> > +
> > +patternProperties:
> > +  "^DSV(LCM|P|N)$":
> > +    type: object
> > +    $ref: regulator.yaml#
> > +    description:
> > +      Properties for single Display Bias Voltage regulator.
>
> Just put this into the MFD schema directly if you don't have any custom
> properties to add.
>
OK, I'll directly remove rt4831 regulator dt-binding and put the
descriptions into mfd binding.
Ack in next series of patch.
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    regulators {
> > +      DSVLCM {
> > +        regulator-min-microvolt =3D <4000000>;
> > +        regulator-max-microvolt =3D <7150000>;
> > +        regulator-allow-bypass;
> > +      };
> > +      DSVP {
> > +        regulator-name =3D "rt4831-dsvp";
> > +        regulator-min-microvolt =3D <4000000>;
> > +        regulator-max-microvolt =3D <6500000>;
> > +        regulator-boot-on;
> > +      };
> > +      DSVN {
> > +        regulator-name =3D "rt4831-dsvn";
> > +        regulator-min-microvolt =3D <4000000>;
> > +        regulator-max-microvolt =3D <6500000>;
> > +        regulator-boot-on;
> > +      };
> > +    };
> > --
> > 2.7.4
> >
