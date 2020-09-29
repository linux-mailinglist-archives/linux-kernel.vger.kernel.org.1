Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A719927D0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgI2OPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbgI2OP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:27 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933CB2145D;
        Tue, 29 Sep 2020 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601388926;
        bh=cLgnG2Shmw3nDRs/2jX33t8JJi+HuUvBJykKXGQYNE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xBAjlIKnElDoC7VPgN5Cx+ocqM7zh2xzgOqDHPyXIzA3cy3eXsTpL+bGL1nvYl61i
         +J5FBrbwk0ehaSsv36e8QOaDhuKjDA2Dp+3tDKZ9FlhVSIgSk9naa2R9umPC3yC3od
         8sVQkCEc728GM22eGIPj5UaTZCZt73gi2CyDfOBA=
Received: by mail-oi1-f178.google.com with SMTP id 26so5599740ois.5;
        Tue, 29 Sep 2020 07:15:26 -0700 (PDT)
X-Gm-Message-State: AOAM533ifw+y8fiNZceLZU90KnhGVKlbb/whLSI/oZScA/VcWMpMUTZV
        wOfUvw5UpTR4m5qk/5nC3KASzyIp7pk22G80Sw==
X-Google-Smtp-Source: ABdhPJwlKDmJWdNqRPaVIwF51Eov3Fc7UbVsQGT8uyml36bYynhwP/W7POKfaYgZY1e/+Aw93kwpYbXuUiqxnmx5sD4=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr2801580oie.152.1601388925716;
 Tue, 29 Sep 2020 07:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200916061757.32144-1-andreas@kemnade.info> <20200923014041.GA3669674@bogus>
 <20200923221702.0ce93780@aktux>
In-Reply-To: <20200923221702.0ce93780@aktux>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 09:15:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJWt91+aZwAWEUVjOBQgsYw6GBHqmoHwU_T5qZabxX+Aw@mail.gmail.com>
Message-ID: <CAL_JsqJWt91+aZwAWEUVjOBQgsYw6GBHqmoHwU_T5qZabxX+Aw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: Convert rn5t618 to json-schema
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 3:17 PM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> On Tue, 22 Sep 2020 19:40:41 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, Sep 16, 2020 at 08:17:57AM +0200, Andreas Kemnade wrote:
> > > Convert the RN5T618 binding to DT schema format. Also
> > > clearly state which regulators are available.
> > >
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v2:
> > > - drop irq description
> > >
> > > Due to its .txt-format history BSD license was not added.
> > >  .../bindings/mfd/ricoh,rn5t618.yaml           | 111 ++++++++++++++++++
> > >  .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
> > >  2 files changed, 111 insertions(+), 52 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > > new file mode 100644
> > > index 000000000000..d70e85a09c84
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > > @@ -0,0 +1,111 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/ricoh,rn5t618.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Ricoh RN5T567/RN5T618/RC5T619 PMIC
> > > +
> > > +maintainers:
> > > +  - Andreas Kemnade <andreas@kemnade.info>
> > > +
> > > +description: |
> > > +  Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
> > > +  integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
> > > +  GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
> > > +  The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
> > > +  fuel gauge, and an ADC.
> > > +  The RC5T619 additionnally includes USB charger detection and an RTC.
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: ricoh,rn5t567
> > > +    then:
> > > +      properties:
> > > +        regulators:
> > > +          patternProperties:
> > > +            "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$":
> > > +              $ref: ../regulator/regulator.yaml
> > > +          additionalProperties: false
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: ricoh,rn5t618
> > > +    then:
> > > +      properties:
> > > +        regulators:
> > > +          patternProperties:
> > > +            "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$":
> > > +              $ref: ../regulator/regulator.yaml
> > > +          additionalProperties: false
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: ricoh,rc5t619
> > > +    then:
> > > +      properties:
> > > +        regulators:
> > > +          patternProperties:
> > > +            "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
> > > +              $ref: ../regulator/regulator.yaml
> > > +          additionalProperties: false
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ricoh,rn5t567
> > > +      - ricoh,rn5t618
> > > +      - ricoh,rc5t619
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  system-power-controller:
> > > +    type: boolean
> > > +    description: |
> > > +      See Documentation/devicetree/bindings/power/power-controller.txt
> > > +
> > > +  regulators:
> > > +    type: object
> >
> > Add here:
> >
> > $ref: ../regulator/regulator.yaml
> >
> > And then the occurrances up above can be just 'true'.
> >
> That feels wrong. I would think that gets applied to things directly
> below regulator node and not to the individual regulator subnodes. To
> check that I did:

Ah right, you'd need another level in there. I guess just leave it as is.

Reviewed-by: Rob Herring <robh@kernel.org>
