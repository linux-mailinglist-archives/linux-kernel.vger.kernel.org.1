Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB72F1060
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbhAKKqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbhAKKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:46:38 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927FC0617BB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:46:14 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 11so16434609oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DgDphA8O/OaGpiUzOXGEVjnzalcsMUilm6fpK3IxuZY=;
        b=P3OyxWSbAoSyFpEuQAUWE/G/nvfHDpyHmXZ/01V707QBb4baZqCYsMhU5vWFEU81d+
         OnlPhC5/bv3VY4EaRKf2a3kwJwlkNoyzoPNMeGgKljtaN4Tl3Ft3DZbHQQQJCWDTUFeI
         m7/bgEd9aBveccDb9Gt1LVIsvVrOet7tmw2IBDtFLEld6BHEHKgt8n5Y1we79RS3Blbl
         BtAILTh+aKtJX+lAcWIh0NtePkIUZElFiF8gfhc0NoSW4RG0jLfvj0PwFSQx9MoX2P9y
         eT/akvGwKELB6IjSDpeViTlBpDbSVVjYcBIUCoBzm4isM9ZRb4D4FUW9WJu0hpyr50Vw
         XBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DgDphA8O/OaGpiUzOXGEVjnzalcsMUilm6fpK3IxuZY=;
        b=NrqhKDk7G60Ynnf0yucfYz9chnR2a1YbRc5X/O7Bw+Wjvtuy0g+MkZiHeMBVUJ5QyH
         2yaCkJB7/ZuRbLKTzNb0m9Qmv28Acj3aZ78V+XY8CzMQpL8GJP8QT+xYK4dZdx0lqVlQ
         E4/ImSoTNepikJ0GD+yw9qunuJ6WTJzl6bxleu6bacPvaVYiR2ukwAVGwRfxfzA+Makd
         xFvcqAcpW9yAE8l4DWHHNQr/8GOZzZd/eMS+OqU0DvkE4sBEwWLBUvYj5Ml88giU0GPX
         WwbMBlF9cCKf8qH0hXaxnLkk/IRmtzzFWxu1mIvzWr0ZAMToRd8kXWkp9gttTpiJiCeV
         /Rxw==
X-Gm-Message-State: AOAM530rW6gUpLNRXdUZ5u6YzEq+G3Dy1HHIFnzpNFCsVYqrAXm0omXO
        IL6Sv9+n4pNRRByXIHHzBlOqEz9ic6QM0qkfaxg=
X-Google-Smtp-Source: ABdhPJwtwWAcszv5AktECZV7ekom++ferq0emh1Qt6rmfwnHaqN5qiEoNDnMJG5pxeaHq9Rfp7QdF+ywB5+OHa+araE=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr10331229otr.232.1610361973579;
 Mon, 11 Jan 2021 02:46:13 -0800 (PST)
MIME-Version: 1.0
References: <1608779989-9641-1-git-send-email-gene.chen.richtek@gmail.com> <04b06a6a4020212c4ae65bea9685afccc90c6dee.camel@fi.rohmeurope.com>
In-Reply-To: <04b06a6a4020212c4ae65bea9685afccc90c6dee.camel@fi.rohmeurope.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 11 Jan 2021 18:46:01 +0800
Message-ID: <CAE+NS373aYm9T_mJd23PXvGRqUB9QaEC-T8=zku_OmawQRpGFw@mail.gmail.com>
Subject: Re: [PATCH resend] dt-bindings: mfd: mediatek: Add bindings for
 MT6360 PMIC
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shufan_lee@richtek.com" <shufan_lee@richtek.com>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "gene_chen@richtek.com" <gene_chen@richtek.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wilma.Wu@mediatek.com" <Wilma.Wu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "benjamin.chao@mediatek.com" <benjamin.chao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vaittinen, Matti <Matti.Vaittinen@fi.rohmeurope.com> =E6=96=BC 2021=E5=B9=
=B41=E6=9C=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:13=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello Peeps,
>
> On Thu, 2020-12-24 at 11:19 +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add bindings for MT6360 PMIC
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/mt6360.yaml | 69
> > +++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/mt6360.yaml
> > b/Documentation/devicetree/bindings/mfd/mt6360.yaml
> > new file mode 100644
> > index 0000000..2781c31
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/mt6360.yaml
> > @@ -0,0 +1,69 @@
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
> > +  This document describes the binding for PMIC device and its sub
> > module.
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
>
> Out of the curiosity - is this the complete node? I would assume some
> sub-devices like regulators here?
>

After all sub-devices module review done, I will add new patch to add
reference description.
e.g. max77650.yaml
leds:
  $ref: ../leds/leds-max77650.yaml

> > +        };
> > +    };
>
