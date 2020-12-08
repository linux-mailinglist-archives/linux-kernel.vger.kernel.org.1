Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2382D22EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgLHFMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 00:12:30 -0500
Received: from mout02.posteo.de ([185.67.36.66]:44285 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgLHFM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:12:29 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id F26FD2400FB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607404292; bh=g5u4UyZ2WJ2e3hMxa5bog0RzU7/VxWIOWf101N3wx4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=DybgU/EoITZdhVMVJ+Y8LnW/g+1o6whTQbPxXD7k4uYx336EFODuHZ/eWa8pF+H5/
         FHb2zaqdg4rjsev+xTaJYBvoTUvfp46QsjRDd9lL5+7YK/egmtLuKcv1hnyP8mbbtx
         j/WrFKn2sg23sAzaVG2P9NqF6HG3FVaTNJ/iIi4g2gyyyP1aAEs8NReGCEkVBvqcfH
         k7LZ87vo1HYTfcMYJTRGArkH6bsgaH4e+AYGts1RYhrJaVrcKxoMzq+AYHV4K0GF+B
         8Xvewvq+hfMRMShPXjbrkbr7q1lGESoHmFcUtnIpfh7SvaLmG+C2rkf9RDH1coe3Ee
         hGKSyybFii0/g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CqpDy22J3z9rxG;
        Tue,  8 Dec 2020 06:11:30 +0100 (CET)
Date:   Tue, 8 Dec 2020 06:11:28 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
 documentation
Message-ID: <20201208061128.3e20f00b@monster.powergraphx.local>
In-Reply-To: <4ceaf71c-dbac-4dc3-7921-d59a40fbece7@sholland.org>
References: <cover.1607353274.git.wilken.gottwalt@posteo.net>
        <ac2c2b279be52876d66c91826a1ccebd08fe4810.1607353274.git.wilken.gottwalt@posteo.net>
        <20201207161259.z6no7m2xqwb2jrju@gilmour>
        <4ceaf71c-dbac-4dc3-7921-d59a40fbece7@sholland.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 21:22:23 -0600
Samuel Holland <samuel@sholland.org> wrote:

> On 12/7/20 10:12 AM, Maxime Ripard wrote:
> > Hi,
> > 
> > On Mon, Dec 07, 2020 at 05:05:03PM +0100, Wilken Gottwalt wrote:
> >> Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
> >> compatible SoCs.
> >>
> >> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >> ---
> >>  .../bindings/hwlock/sun8i-hwspinlock.yaml     | 63 +++++++++++++++++++
> >>  1 file changed, 63 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> >> b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml new file mode 100644
> >> index 000000000000..2954ee0b36a7
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> >> @@ -0,0 +1,63 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/hwlock/sun8i-hwspinlock.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: SUN8I hardware spinlock driver for Allwinner sun8i compatible SoCs
> >> +
> >> +maintainers:
> >> +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - allwinner,sun8i-hwspinlock
> > 
> > This can be a const instead of an enum, and since it was introduced with
> > the A33 it should be sun8i-a33-hwspinlock. There's a lot of SoCs in that
> > family, some without that IP, and we could even see new SoCs in that
> > family with a different IP at some point.
> 
> I just looked at the A31 ARISC blob, and it uses the hwspinlock hardware
> as well, with the same MMIO address and gate/reset bits as A33-H3. So
> the first compatible would actually be sun6i-a31-hwspinlock.

Hmm, so it would make sense to also change the drivers symbols from sun8i to
sun6i, right? Before I do that, is there maybe a sun4i which also includes
the hwspinlock unit? Just in case :D

greetings,
Wilken

> Cheers,
> Samuel
> 
> >> +
> >> +    reg:          # 0x01C18000 (H2+, H3, H5), 0x03004000 (H6), length 0x1000
> >> +      maxItems: 1
> > 
> > There's no need for those comments
> > 
> >> +
> >> +    clocks:       # phandle to the reference clock
> > 
> > This should be the description, and it's fairly obvious so you don't
> > really need that comment.
> > 
> >> +      maxItems: 1
> >> +
> >> +    clock-names:  # name of the bus ("ahb")
> >> +      maxItems: 1
> > 
> > You don't need clock-names if there's a single clock
> > 
> >> +
> >> +    resets:       # phandle to the reset control
> >> +      maxItems: 1
> > 
> > Same thing than for the clocks
> > 
> >> +
> >> +    reset-names:  # name of the bus ("ahb")
> >> +      maxItems: 1
> >> +
> > 
> > Ditto
> > 
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - clocks
> >> +  - clock-names
> >> +  - resets
> >> +  - reset-names
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +
> >> +  - |
> >> +    /* H2+ based OrangePi Zero */
> >> +    hwspinlock: hwspinlock@1C18000 {
> > 
> > Unit-address's are lowercase
> > 
> >> +      compatible = "allwinner,sun8i-hwspinlock";
> >> +      reg = <0x01c18000 0x1000>;
> >> +      clocks = <&ccu CLK_BUS_SPINLOCK>;
> >> +      clock-names = "ahb";
> >> +      resets = <&ccu RST_BUS_SPINLOCK>;
> >> +      reset-names = "ahb";
> >> +    };
> >> +
> >> +    /* H6 based OrangePi 3 */
> >> +    hwspinlock: hwspinlock@3004000 {
> >> +      compatible = "allwinner,sun8i-hwspinlock";
> >> +      reg = <0x03004000 0x1000>;
> >> +      clocks = <&ccu CLK_BUS_SPINLOCK>;
> >> +      clock-names = "ahb";
> >> +      resets = <&ccu RST_BUS_SPINLOCK>;
> >> +      reset-names = "ahb";
> >> +    };
> > 
> > Different examples should be different items on that list, but both are
> > essentially the same binding so you can drop one.
> > 
> > Maxime
> > 
> 

