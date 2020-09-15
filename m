Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C754426AE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgIOTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgIOTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:49:44 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB59C06178A;
        Tue, 15 Sep 2020 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2f/FQQsVUE+ceJvZjFwrqZDE7+h9xmxrnKqETPyRkZE=; b=m8PoPwHNuUBO8GElPGKAh0H/CV
        /PGxRFJbO1gjJYHNDIhMbIQ2WNTPxDrR9sA9/fejksdKaaw97RXTyP8/gpoS6b4BAg92K+lMIyRRi
        WZxOwlId/9knHxBB/h6DKaxKRWjMYhs0PtxUrru842kZv9kd9zjYuclGP/AigB6YzIvU=;
Received: from p200300ccff0cb3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:b300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kIGxJ-0000nE-OP; Tue, 15 Sep 2020 21:49:34 +0200
Date:   Tue, 15 Sep 2020 21:49:30 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Rob Herring <robh@kernel.org>
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH] dt-bindings: mfd: Convert rn5t618 to json-schema
Message-ID: <20200915214930.48eaff87@aktux>
In-Reply-To: <20200915171152.GA2124960@bogus>
References: <20200908201303.17271-1-andreas@kemnade.info>
        <20200915171152.GA2124960@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 11:11:52 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Sep 08, 2020 at 10:13:03PM +0200, Andreas Kemnade wrote:
> > Convert the RN5T618 binding to DT schema format. Also
> > clearly state which regulators are available.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > I have noted myself here as maintainer because I wrote most of the
> > code of the several subdevices, although not of the .txt-binding.
> > Due to its .txt-format history BSD license was not added.
> > I happily ignored the "does MAINTAINERS need updating" thing
> > from checkpatch.pl, I do not know whether that PMIC should
> > have a separate entry there.
> > 
> >  .../bindings/mfd/ricoh,rn5t618.yaml           | 113 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
> >  2 files changed, 113 insertions(+), 52 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > new file mode 100644
> > index 000000000000..9596dde7a69a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > @@ -0,0 +1,113 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ricoh,rn5t618.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ricoh RN5T567/RN5T618/RC5T619 PMIC
> > +
> > +maintainers:
> > +  - Andreas Kemnade <andreas@kemnade.info>
> > +
> > +description: |
> > +  Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
> > +  integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
> > +  GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
> > +  The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
> > +  fuel gauge, and an ADC.
> > +  The RC5T619 additionnally includes USB charger detection and an RTC.
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ricoh,rn5t567
> > +    then:
> > +      properties:
> > +        regulators:
> > +          patternProperties:
> > +            "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$":
> > +              $ref: ../regulator/regulator.yaml
> > +          additionalProperties: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ricoh,rn5t618
> > +    then:
> > +      properties:
> > +        regulators:
> > +          patternProperties:
> > +            "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$":
> > +              $ref: ../regulator/regulator.yaml
> > +          additionalProperties: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ricoh,rc5t619
> > +    then:
> > +      properties:
> > +        regulators:
> > +          patternProperties:
> > +            "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
> > +              $ref: ../regulator/regulator.yaml
> > +          additionalProperties: false  
> 
> I prefer under 'regulators' below, you have all possible regulator 
> names:
> 
> patternProperties:
>   "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
>      $ref: ../regulator/regulator.yaml
> 
> and then above you just need to restrict the possible names:
> 
> regulators:
>   propertyNames:
>     pattern: "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$"
> 
> (propertyNames schema is applied to all an object's properties and you 
> don't need additionalProperties here.)
> 
hmm, dt_binding_check refuses to digest things like this:

allOf:
  - if:
      properties:
        compatible:
          contains:
            const: ricoh,rn5t567
    then:
      properties:
        regulators:
          propertyNames:
            pattern: "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$"

I get:
andi@aktux:~/kernel$ DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml makearm dt_binding_check
  CHKDT   Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
/home/andi/kernel/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml: allOf:0:then:properties:regulators: Additional properties are not allowed ('propertyNames' was unexpected)
/home/andi/kernel/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml: allOf:0:then:properties:regulators: 'propertyNames' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']

andi@aktux:~/kernel/Documentation$ grep -R propertyNames *
devicetree/bindings/mfd/ricoh,rn5t618.yaml:          propertyNames:
devicetree/bindings/mfd/ricoh,rn5t618.yaml:          propertyNames:
devicetree/bindings/mfd/ricoh,rn5t618.yaml:          propertyNames:

... and I am the only user, it is not documented.
and yes I have updated my tools
andi@aktux:~/kernel$ dt-validate --version
2020.8.1

Regards,
Andreas

