Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808992A9975
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgKFQ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:29:12 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6193C0613CF;
        Fri,  6 Nov 2020 08:29:11 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n129so2060423iod.5;
        Fri, 06 Nov 2020 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6nSgqBmUhBpJwa4thMACEUia1oLwn74my+0co4/xNs=;
        b=FdWP8dfWCga70b1A6JmgDfSou+GcHU4ue6PdWZE77PpaM/J2UWD00VDZrbyEvuffvM
         zjKTgYUGYATgq0xSXQVD7p+ooxIypPGwY2rGLRo37HW1lFhFTXJPqxGxiMx7JYAKa7HU
         QoPjFcy09COzqtLH7n/U6ut3x1w+qveAyt7kKwZv78gPBE6ScYnBsJuWgWMHASA+V8EK
         rpY0kPDzZ0YIR+GK5gwl884xB4iEaj3tdXXZF3ksrlvaT4Fdf6OcNMIVzOnkVa9KAa8/
         WANylE0RqeEJ0GICi/mKwoMirtEFMu8H2eFuakhKFWvXunKFnLDQyiokpag4krE4YYHf
         VVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6nSgqBmUhBpJwa4thMACEUia1oLwn74my+0co4/xNs=;
        b=cowK/RKpYVnOUhTwspjNl8rTdoW1utbYxhmPKQZWTc0bXouKxaVjOlol3Fxty0nu0b
         bRLLfBgY8Huf9Yj/3vrwHkyQtqx/zZa5sCkaJ9U6UJY3ia24RjVSSwxwykGw6lP/OP1P
         wj/kzx865fcTtTwZV/7uIrAyn1A2083kbb5PqnSOl6AXHyEDU/jntPSdXKG0ILZ52AIt
         NwD7j1TJ6UIm67TfqMpuQ62gOvsHGwHAPqrvXHczI2D/BW2/Vl+wkIEzyT0xfiH9PC8L
         ooyvLT9XAaAZNgOdtDn3WlnoF39FsaF9Qnvy2CYJ2lQVEmvS3dIAOERoZ0C2EL4br3Uz
         UVDg==
X-Gm-Message-State: AOAM531LipxDiI3zh+NQLseKCssa1IieJNwUhPvVeHOifGPkw3eZF9ci
        Oe8SVCoMPimyEdkBWtxrbCIz9CZg3U+s3XoCIPE=
X-Google-Smtp-Source: ABdhPJz4PV0P7oD7ftG8SKYmePF8Kn2r7L483dQi0WFFpwDxm6AhPD0QWFecYs9cadK3LXtxhjCsc2oh0tQhL09XGKc=
X-Received: by 2002:a6b:d00c:: with SMTP id x12mr2061570ioa.10.1604680150988;
 Fri, 06 Nov 2020 08:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20201106111543.1806809-1-aford173@gmail.com> <20201106161948.GA3300756@bogus>
In-Reply-To: <20201106161948.GA3300756@bogus>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 6 Nov 2020 10:28:59 -0600
Message-ID: <CAHCN7x+FvAD4oMj_atjdN2QEBbM5uq2tN2DBHxiHm1mK0fnvQQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Rob Herring <robh@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 10:19 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Nov 06, 2020 at 05:15:39AM -0600, Adam Ford wrote:
> > Add binding doc for fsl,spba-bus.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  New to series
>
> Please implement my review comments from the last version you sent.

Sorry about that.  I grabbed from the wrong branch.  I implemented
them, but apparently I did it on the wrong branch.

I'll send a V4.

Sorry for the noise.

adam
>
> >
> > diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> > new file mode 100644
> > index 000000000000..0a2add841145
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Shared Peripherals Bus Interface
> > +
> > +maintainers:
> > +  - Shawn Guo <shawnguo@kernel.org>
> > +
> > +description: |
> > +  A simple bus enabling access to shared peripherals.
> > +
> > +  The "spba-bus" follows the "simple-bus" set of properties, as
> > +  specified in the Devicetree Specification.  It is an extension of
> > +  "simple-bus" because the SDMA controller uses this compatible flag to
> > +  determine which peripherals are available to it and the range over which
> > +  the SDMA can access.  There are no special clocks for the bus, because
> > +  the SDMA controller itself has its interrupt, and clock assignments.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^bus(@[0-9a-f]+)?$"
> > +
> > +  compatible:
> > +    contains:
> > +      const: fsl,spba-bus
> > +    description:
> > +      Shall contain "fsl,spba-bus" in addition to "simple-bus"
> > +      compatible strings.
> > +
> > +  '#address-cells':
> > +    enum: [ 1, 2 ]
> > +
> > +  '#size-cells':
> > +    enum: [ 1, 2 ]
> > +
> > +  ranges: true
> > +
> > +required:
> > +  - compatible
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - ranges
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    bus {
> > +        compatible = "fsl,spba-bus", "simple-bus";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges;
> > +    };
> > --
> > 2.25.1
> >
