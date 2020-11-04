Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC472A5F0B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgKDICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDIC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:02:29 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19F7223C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604476949;
        bh=Gt+k50/uNJh3IRuDkRBTXYHIaTMgChYtN1A0cbfq2A8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UXBiPG1k6PvQRX6mWnTOQBH3OvkIMIrUZlL6KN+PI9jV5o0yAM8mbPtNGep+brWO+
         6sdqGfChU6vKFPVyzg782wWmnF/4TYQaoaNW63nIrw1FA4GRHceDC9NajXWHPIw3TP
         FAugtvjoItuZuydI71q7gavVyyL869TDDnalVXFI=
Received: by mail-ej1-f44.google.com with SMTP id o9so26366716ejg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:02:28 -0800 (PST)
X-Gm-Message-State: AOAM5300xQs8bQ9+jekOk9lJhogBIxYXEAa93QRqQZ8c1oI2hqn5sdYa
        EUsozvh3iJBBYcSL33+mVGSl+KdWBCDcCG9sm6M=
X-Google-Smtp-Source: ABdhPJyr26sB8ujN+LWDSItGcUtw4OL0QL8Rf+ZqlRId+h+uKCqcNp8LaIN/fARq1zSXVNdaydBWk1d7HrBPJwqJM7E=
X-Received: by 2002:a17:906:5618:: with SMTP id f24mr1650845ejq.381.1604476947095;
 Wed, 04 Nov 2020 00:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20201104030645.12931-1-alice.guo@nxp.com> <20201104030645.12931-2-alice.guo@nxp.com>
 <CAJKOXPd_sArJ5-Ka2btZNxn3aBGFioDGOmQKbqeVNgtpUZUw=A@mail.gmail.com>
In-Reply-To: <CAJKOXPd_sArJ5-Ka2btZNxn3aBGFioDGOmQKbqeVNgtpUZUw=A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Nov 2020 09:02:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPewEVsPUoC4w_aku=pDG=FzyajwfK42yPQ15K-vA-brtw@mail.gmail.com>
Message-ID: <CAJKOXPewEVsPUoC4w_aku=pDG=FzyajwfK42yPQ15K-vA-brtw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] LF-2571-1: dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
To:     Alice Guo <alice.guo@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 08:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 4 Nov 2020 at 04:09, Alice Guo <alice.guo@nxp.com> wrote:
> >
> > Add DT Binding doc for the Unique ID of i.MX 8M series.
> >
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > ---
> >  .../bindings/soc/imx/imx8m-unique-id.yaml     | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml b/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
> > new file mode 100644
> > index 000000000000..f1e45458cec7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/nxp/imx8m-unique-id.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX8M Platforms Device Tree Bindings
>
> This is not a title for these bindings. Please describe the bindings
> for this device. Based on description, this might could go to
> bindings/nvmem directory.
>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>
> No need for oneOf.
>
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8mm-soc
> > +              - fsl,imx8mn-soc
> > +              - fsl,imx8mp-soc
> > +              - fsl,imx8mq-soc
> > +          - const: simple-bus
> > +
> > +  nvmem-cells:
> > +    maxItems: 1
> > +    description:
> > +      Reference to an nvmem node for the SOC Unique ID.
>
> Misleading description - nvmem-cells do not contain a reference. Just
> skip it, nvmem-cells should be obvious from the nvmem provider
> bindings.
>
> > +
> > +  nvmem-cells-names:
> > +    const: soc_unique_id
>
> additionalProperties: false

... or what looks more appropriate - you should include nvmem-consumer
bindings and use unevaluatedProperties:false.

Best regards,
Krzysztof
