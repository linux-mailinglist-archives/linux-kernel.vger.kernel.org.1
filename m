Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC92F2D72B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404270AbgLKJOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:14:33 -0500
Received: from mout02.posteo.de ([185.67.36.66]:42061 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732605AbgLKJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:14:12 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 306162400FF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607677995; bh=pDmsiKGqfAvhyMhiNGVcAerPm0Vf2GJsSU85IkcqBnE=;
        h=Date:From:To:Cc:Subject:From;
        b=bzOClCmBj68sNdepz3XoxvSNKZ/ht8BF8LGHGeY0P5zUpHgOflclus73jKotdLpJb
         tLpQr2krOWCcoFHmTfTRvFMbwDbNhjuqMbktY6IvKWV/jo5pxbaiJ7veaiaNcdoG7F
         JvdQ7OILhCCEt7XJpgUwSX2Y2ILP/h74YOTvWXknsfbq93mXH35ToC2IjBMg4NBlX5
         YKyRjf/IvgYzW59kA8KDKNISMbmRQRTktRFifNqJIwTi3Lk4mHzNrmTZj5qZ7qZmW5
         3x9488CaA2lVdX+NzwPKBiJ7BKMDpXAVt6Gdf+qwypiXORP9uDuxnqZXfdjqZn5WHb
         UqYsXwTOMz2XA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CslST2Rwtz6tmL;
        Fri, 11 Dec 2020 10:13:13 +0100 (CET)
Date:   Fri, 11 Dec 2020 10:13:11 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v4 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
Message-ID: <20201211101311.654ac449@monster.powergraphx.local>
In-Reply-To: <20201211085757.faumhyto7akeayeg@gilmour>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
        <8b0c0b80bfc2dbb9010bac00fe0c90493ad8db09.1607674518.git.wilken.gottwalt@posteo.net>
        <20201211085757.faumhyto7akeayeg@gilmour>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 09:57:57 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> Hi,
> 
> On Fri, Dec 11, 2020 at 09:23:48AM +0100, Wilken Gottwalt wrote:
> > Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
> > compatible SoCs.
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> > Changes in v4:
> >   - changed binding to sun8i-a33-hwpinlock
> >   - added changes suggested by Maxime Ripard
> > 
> > Changes in v3:
> >   - changed symbols from sunxi to sun8i
> > 
> > Changes in v2:
> >   - fixed memory ranges
> > ---
> >  .../bindings/hwlock/sun8i-hwspinlock.yaml     | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> > b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml new file mode 100644
> > index 000000000000..76963d8abd5f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> 
> We usually have the schemas with the same name than the compatible 
> 
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwlock/sun8i-hwspinlock.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SUN8I hardware spinlock driver for Allwinner sun8i compatible SoCs
> > +
> > +maintainers:
> > +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > +
> > +description:
> > +  The hardware unit provides sempahores between the ARM cores and the embedded
> 
>                                 ^ typo

Hmm, you are right. This is odd, the patch checking script didn't catch that one.

> > +  OpenRisc core on the SoC.
> 
> It's not just OpenRisc: there's some SoC that will have an xtensa core. Maybe we can replace
> openrisc by secondary?
 
So there are actually different embedded cores? What about embedded companion core?

> > +
> > +properties:
> > +  compatible:
> > +    const: allwinner,sun8i-a33-hwspinlock
> > +
> > +    reg:
> > +      maxItems: 1
> > +
> > +    clocks:
> > +      maxItems: 1
> > +
> > +    clock-names:
> > +      items:
> > +        - const: ahb
> 
> clock-names is useless when you have a single clock
> 
> > +
> > +    resets:
> > +      maxItems: 1
> > +
> > +    reset-names:
> > +      items:
> > +        - const: ahb
> 
> and reset-names is useless as well when there's a single reset line

So just drop the reset-names lines? I'm still a bit unsure about this dt
yaml documentation format. I try to learn from the existing bindings, but
the quality seems a bit mixed. So thank you for your patience.

greetings,
Wilken

> Maxime

