Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A122A6F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgKDVUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDVUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:20:08 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F668207BB;
        Wed,  4 Nov 2020 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604524807;
        bh=3W/SvRDz0BTGVsuzXv4ZrhXO+fep4uUqciS3x/IES+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xqmxU6fSjcN3pOQLonXOjZl6TDOV2rbKlOzaMRNH+CecZYVGeYWnnYIU9iU+a6uMR
         dTMznFvKdd3Ibvole5dKpDJArcApKhroPDrsViCbi4mkfk5N6hO2DabBFeV1z4SKKt
         f/pOKsM+8EeSbdtuPtvduTmgJbqxdCk8Yngi+/d8=
Received: by mail-ot1-f42.google.com with SMTP id z16so109481otq.6;
        Wed, 04 Nov 2020 13:20:07 -0800 (PST)
X-Gm-Message-State: AOAM531PDQbYGT7UPOJ1AAPazBwSQtyWFlAKGzcPZpHuBf9Be+N0offR
        R2x4qMJjEXJC4FlU4mhW1BEvQq/nRF6K6RAtcA==
X-Google-Smtp-Source: ABdhPJzoiasaZXJ5eqP/KUP0KLr+pToY/QKoeE7rXkOtJo/eMQjIK3o5Wkiv/oD0yr65wdZAvnTKdM/22T7GM2D02q8=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr18764880oti.107.1604524806704;
 Wed, 04 Nov 2020 13:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20201014082941.25385-1-shihlun.lin@advantech.com.tw>
 <20201014082941.25385-2-shihlun.lin@advantech.com.tw> <20201016183107.GA1609800@bogus>
 <d90b3d7abc1a46cfab33e1cbbf1f58da@taipei09.ADVANTECH.CORP>
In-Reply-To: <d90b3d7abc1a46cfab33e1cbbf1f58da@taipei09.ADVANTECH.CORP>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 4 Nov 2020 15:19:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLSoXBcE2cFQwW=jq-u=XGpO=4hLOKQ6UGYwt9ukKA44w@mail.gmail.com>
Message-ID: <CAL_JsqLSoXBcE2cFQwW=jq-u=XGpO=4hLOKQ6UGYwt9ukKA44w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mfd: ahc1ec0.yaml: Add Advantech
 Embedded Controll - AHC1EC0
To:     "Shihlun.Lin" <Shihlun.Lin@advantech.com.tw>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Campion.Kang" <Campion.Kang@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 1:30 AM Shihlun.Lin
<Shihlun.Lin@advantech.com.tw> wrote:
>
> Hi Rob,
>
> Thank you for taking the time for checking.
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Saturday, October 17, 2020 2:31 AM
> > To: Shihlun.Lin
> > Cc: Lee Jones; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > Campion.Kang; AceLan Kao
> > Subject: Re: [PATCH 2/2] dt-bindings: mfd: ahc1ec0.yaml: Add Advantech
> > Embedded Controll - AHC1EC0
> >
> > On Wed, Oct 14, 2020 at 04:29:41PM +0800, Shihlun Lin wrote:
> > > Add DT binding schema for Advantech embedded controller AHC1EC0.
> >
> > Where's the driver?
> >
>
> Because the maintainers are different people, I separated the submission
> into three groups: maintainer, device tree, and Kernel driver. Should I put
> all maintainers into one Email and send all patches in a group at once?
>
> > >
> > > Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
> > > ---
> > >  .../devicetree/bindings/mfd/ahc1ec0.yaml      | 76
> > +++++++++++++++++++
> > >  1 file changed, 76 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
> > b/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
> > > new file mode 100644
> > > index 000000000000..2a3581d2ecab
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
> > > @@ -0,0 +1,76 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +# All the top-level keys are standard json-schema keywords except for
> > > +# 'maintainers' and 'select'
> >
> > Drop this.
> >
>
> I checked other yaml files. Should I drop all content above, or just remove
> the last two lines?
>
> > > +
> > > +
> > > +$id: http://devicetree.org/schemas/mfd/ahc1ec0.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Advantech Embedded Controller (AHC1EC0)
> > > +
> > > +maintainers:
> > > +  - Shihlun Lin <shihlun.lin@advantech.com.tw>
> > > +  - Campion Kang <campion.kang@advantech.com.tw>
> > > +
> > > +description: |
> > > +  AHC1EC0 is one of the embedded controllers used by Advantech to
> > provide several
> > > +  functions such as watchdog, hwmon, brightness, etc. Advantech
> > related applications
> > > +  can control the whole system via these functions.
> > > +
> > > +  # In this case, a 'false' schema will never match.
> >
> > Drop
> >
>
> I checked other yaml files. I should remove the last line only, right?
>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: advantech,ahc1ec0
> > > +
> > > +  advantech,sub-dev-nb:
> > > +    description:
> > > +      The number of sub-devices specified in the platform.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    maxItems: 1
> >
> > Isn't this just the length of the next property?
> >
>
> You are right, exactly. This is just the number of item about the next property.
> This property will be used in the driver later.
>
> > > +
> > > +  advantech,sub-dev:
> > > +    description:
> > > +      A list of the sub-devices supported in the platform. Defines for
> > the
> > > +      appropriate values can found in dt-bindings/mfd/ahc1ec0.h.
> > > +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> > > +    minItems: 1
> > > +    maxItems: 6
> >
> > This is kind of odd. Aren't you going to need DT info for each of the
> > sub-dev. GPIO is a provider, backlight connection, LED properties, etc.
> >
>
> We will submit 6 sub-devices step-by-step totally. But this time, we only submit
> 2 sub-devices to upstream (Watchdog and HWMonitor).
>
> Should we remove all information about other sub-devices in the
> mfd core Kernel driver, and device tree documentation? Or just keep them?

You should submit a binding for a complete device. At least, as
complete as possible.

What you have here isn't something any other MFD device has done. So
that's not the right way as there's not likely anything special about
this device.

Rob
