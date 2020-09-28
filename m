Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE99127ACB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1L3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1L3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:29:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D78C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:29:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b12so814276lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lOJ0AWm3YJOVnOmUCV+bNOZz7ZfBv/S9uQ0d2HcfN7k=;
        b=uIWDKilIs6PYPY2J7+vnF0Kh07TAdJ9J+4Uq8F1Di5H8w0t26HAJXR0BH/qCC4BA8k
         ahx0eckrqQhHF1k3OxRInJBd7au+RCs1o9ITRI+9wBd9K451aaZ1WtHVMOHy89l1+JGR
         fZmH3GD1ez1FDDvEFHuuriK6GIGTkOjUPmEcZVcVuOzVMejwdsT+MtU1ahCYmgyptS+O
         peksGrTLCZtT7+5K+UecXnZRHOe1qZ36+VYTEIFU1pmMEC4YJbcCmmHKZyKOUDrp5gAH
         MzRYeLMSDtX0CGPn7aEY+BAYQKNr4P4dVSy/3J7+cAy7JjJo/4Jv9t2LaMPwLygDTWRq
         bSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lOJ0AWm3YJOVnOmUCV+bNOZz7ZfBv/S9uQ0d2HcfN7k=;
        b=HrRQ3gAr6QgJBAFkBW8EDoCEzRJ8ik1ZNlgINTg9/hUaeRw9WchjdmO0awQDcPRXwA
         sw1Js80VsA7M57YdZPsLO6EPI3dznhdpq5auL8QRvnBMIX4uSGKj8vk3YH8oXXcSx+3J
         HnS7Ng1icxtTLKHW5xkEZZ6h0A/TGUzgIK37zqd3nyjS2BEVdgGaWPqriDbgE7AWeh5A
         I6iLqkAwe+AhyIDONmXnuZB+Jf17N0REU2f2h4XewSIOaBUs4M5l6EA0PzZLbzak1Hjd
         1D6WpfIJ38UsKCmRIhPkGYiUyQdlLiIvUCuk9+Etm12+uqd+ZUshT/XflR4+wBdjSqZF
         zi+Q==
X-Gm-Message-State: AOAM533yR23hTzBNkTlsuvwdOxi4BHehHqxwsOA6CRInMKCMBMDLbm44
        qfQ09+yoN11NUV8HSk85HaOS4S1PL9RpGLniVxo=
X-Google-Smtp-Source: ABdhPJzHNFbDFW7PcGhWflV7iM01F6meqG6uj4mVQAKODdf3pJwG+HaH10gvHjhKgC+fjL8jYQlDmngHW8ZzFglxtZY=
X-Received: by 2002:a19:8386:: with SMTP id f128mr298937lfd.78.1601292552928;
 Mon, 28 Sep 2020 04:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
 <1601274460-7866-6-git-send-email-kevin3.tang@gmail.com> <20200928082029.cohvqu5zf3uiqz4a@gilmour.lan>
In-Reply-To: <20200928082029.cohvqu5zf3uiqz4a@gilmour.lan>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Mon, 28 Sep 2020 19:29:01 +0800
Message-ID: <CAFPSGXaCE_QN3N6fRoEPv=DDrmF10g2Vd76fD=xVgV0cbdDa8Q@mail.gmail.com>
Subject: Re: [PATCH RFC v7 5/6] dt-bindings: display: add Unisoc's mipi
 dsi&dphy bindings
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maxime,
Sorry, I forgot to describe ports subnode with my two port@X, i will be fix=
 it.

Thanks for reminding

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2020=E5=B9=B49=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> On Mon, Sep 28, 2020 at 02:27:39PM +0800, Kevin Tang wrote:
> > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > Adds MIPI DSI Master and MIPI DSI-PHY (D-PHY)
> > support for Unisoc's display subsystem.
> >
> > RFC v7:
> >   - Fix DTC unit name warnings
> >   - Fix the problem of maintainers
> >
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > ---
> >  .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 98 ++++++++++++++=
++++++++
> >  .../display/sprd/sprd,sharkl3-dsi-phy.yaml         | 75 ++++++++++++++=
+++
> >  2 files changed, 173 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd=
,sharkl3-dsi-host.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd=
,sharkl3-dsi-phy.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl=
3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,shark=
l3-dsi-host.yaml
> > new file mode 100644
> > index 0000000..b6bbf67
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-h=
ost.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc MIPI DSI Controller
> > +
> > +maintainers:
> > +  - Kevin Tang <kevin.tang@unisoc.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sprd,sharkl3-dsi-host
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      Physical base address and length of the registers set for the de=
vice.
> > +
> > +  interrupts:
> > +    maxItems: 2
> > +    description:
> > +      Should contain DSI interrupt.
> > +
> > +  clocks:
> > +    minItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: clk_src_96m
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +    description: A phandle to DSIM power domain node
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  port@0:
> > +    type: object
> > +    description:
> > +      A port node with endpoint definitions as defined in
> > +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +      That port should be the input endpoint, usually coming from
> > +      the associated DPU.
> > +  port@1:
> > +    type: object
> > +    description:
> > +      A port node with endpoint definitions as defined in
> > +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +      That port should be the output endpoint, usually output to
> > +      the associated DPHY.
>
> Is there a specific reason you don't follow the OF-graph and have a
> ports subnode with your two port@X in there?
>
> Maxime
