Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D074A26B2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgIOW4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbgIOWzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:55:40 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E06420770;
        Tue, 15 Sep 2020 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600210539;
        bh=1SFQXiiZye7ljnWk+fnI0mI9R5gZYpoNVw7RwnMQl5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t4rfk7WpB3ER6vnGXK2QfXXHreodLdG+Qa33fZZl5L7DO1hzwAI3zvlGfD6c83voX
         RmuhNtrH/77nXM+yO3NLQM/tl9qAcbMhJdeuMmTKCMsirwM8bfCtJ6mwec8+1+q2C8
         FCFP//4dXq77abU9QwUi0GFEvgV6ABMjBOQE7pQw=
Received: by mail-oi1-f170.google.com with SMTP id t76so5821680oif.7;
        Tue, 15 Sep 2020 15:55:39 -0700 (PDT)
X-Gm-Message-State: AOAM532UkQBF7orSKP9NBpRSKBO2IFxwIKQyG4ZyKWy4Ot16DIQkD05X
        wQr3lNEPuvkTuTiuq2whUBdtVc4yP4XKXRiSAw==
X-Google-Smtp-Source: ABdhPJzKeMhrngjW3/gVbYkKQIk8OoS6rp2aKRsJ8J3A1k7FRUOKmJNy4T3PQ4iQ6dwhom1KKukkVueZxYhwx5cU4YY=
X-Received: by 2002:aca:1711:: with SMTP id j17mr1242241oii.152.1600210538819;
 Tue, 15 Sep 2020 15:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200908201303.17271-1-andreas@kemnade.info> <20200915171152.GA2124960@bogus>
 <20200915214930.48eaff87@aktux>
In-Reply-To: <20200915214930.48eaff87@aktux>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 16:55:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+sqYBpW_d3j5wjcQ2rOWC+qAy+9zZSu+QB0SJHY61WPA@mail.gmail.com>
Message-ID: <CAL_Jsq+sqYBpW_d3j5wjcQ2rOWC+qAy+9zZSu+QB0SJHY61WPA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: Convert rn5t618 to json-schema
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 1:49 PM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> On Tue, 15 Sep 2020 11:11:52 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Tue, Sep 08, 2020 at 10:13:03PM +0200, Andreas Kemnade wrote:
> > > Convert the RN5T618 binding to DT schema format. Also
> > > clearly state which regulators are available.
> > >
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > I have noted myself here as maintainer because I wrote most of the
> > > code of the several subdevices, although not of the .txt-binding.
> > > Due to its .txt-format history BSD license was not added.
> > > I happily ignored the "does MAINTAINERS need updating" thing
> > > from checkpatch.pl, I do not know whether that PMIC should
> > > have a separate entry there.
> > >
> > >  .../bindings/mfd/ricoh,rn5t618.yaml           | 113 ++++++++++++++++++
> > >  .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
> > >  2 files changed, 113 insertions(+), 52 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > > new file mode 100644
> > > index 000000000000..9596dde7a69a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > > @@ -0,0 +1,113 @@
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
> >
> > I prefer under 'regulators' below, you have all possible regulator
> > names:
> >
> > patternProperties:
> >   "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
> >      $ref: ../regulator/regulator.yaml
> >
> > and then above you just need to restrict the possible names:
> >
> > regulators:
> >   propertyNames:
> >     pattern: "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$"
> >
> > (propertyNames schema is applied to all an object's properties and you
> > don't need additionalProperties here.)
> >
> hmm, dt_binding_check refuses to digest things like this:

That's the overly restrictive meta-schema trying to keep folks in the
lane. Sorry, I should have checked that first.

> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: ricoh,rn5t567
>     then:
>       properties:
>         regulators:
>           propertyNames:
>             pattern: "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$"

So just stick with the form you had:

patternProperties:
  "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$": true
additionalProperties: false

Rob
