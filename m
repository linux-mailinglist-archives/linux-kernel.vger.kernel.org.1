Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD27251549
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgHYJ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHYJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:26:17 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8645C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:26:16 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u131so3398829vsu.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXBH4sOkqPl9zJcXTUASMt/Fu8TtonsFgui8Kl7kFVY=;
        b=TWYP0KD8mtsXXsDXuppZAwQQ67rPdc4tICCU7GvKYEWHxBchEiOadVBDgc3Z8BF4XO
         jgTMzMeNoBBJVXZQfk3AMdbGvkgTBbqlpoiA7C9nNtGeaBxLnx3jEK/vv9nFlnPh9/DJ
         TgJ990nDyVQNC1Kk3CDHNeM0HolTeK2JGc+JeKc0Asg0tf53T/j0z1oYXEUe3TmHHahK
         DMXwFbejlBBLFqp1266S1YpJxC8PokIgG47WLH6Q6IrqGhqIXC4/t/ES0j/TyzAtHMVh
         qHLuYP8F/xPcgPYas5khMHfmzHbhhXfPMw8lKgklue4eg9EkJZXUlSnL6zfYM93OJ86S
         K39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXBH4sOkqPl9zJcXTUASMt/Fu8TtonsFgui8Kl7kFVY=;
        b=X81zL8HFa1VwnnAD9n2VXXHEqLdQdqO4k3ni4GjiP4oRue6AVKqiVlyN7zk4w0sraH
         U3QSVyl9y5iL6Ley0YnLXRbFxrVqJJg2a6A9FnDNeL3xmVDytqtsD0ecYbRqSpwPdUSt
         UrkrEH1pO+24AL7RG777gAPdIVYfZ98iA8USlf36DfKyeHHntR4mKsMJtz5CnYheHnpB
         Fwk5gvRvQqmTsTgEOFrY2p0bGd1HzsowFnqvnIVFxu/XS2aP6rI6S7avKSS8StvgJy7M
         uJuWAhDryNpTh21MCHcmff6D7tcZqGltXM+pBYyWdwdkbD5FXVyewHTSPk1BxXC00apN
         ek3Q==
X-Gm-Message-State: AOAM532Ni1+4VDlQ4uQGWlZcLkig17sHaiHpAxWyL/qdo4PkDidaFB5L
        GSQ1q9o/FON+KMyhnBZc98tPmkjML2P/jAGtmnpVYQ==
X-Google-Smtp-Source: ABdhPJzPB9driK8H4qkeuT9S/aH4aByKHE7EXpTg6JCgldVacqxODAO1rUsFRonHGhpGwdxbkweJVIM8uPGeKAfsn/U=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr5214822vsd.200.1598347574303;
 Tue, 25 Aug 2020 02:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200824151035.31093-1-lars.povlsen@microchip.com>
 <20200824151035.31093-2-lars.povlsen@microchip.com> <CAPDyKFoBom1n4AHniiukPiE_szskHrhcmVXfMpKTvNo9Xw9v0w@mail.gmail.com>
 <20200825084752.GD2389103@piout.net>
In-Reply-To: <20200825084752.GD2389103@piout.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 11:25:37 +0200
Message-ID: <CAPDyKFrCxmpfH9DQNyeWdGEgRVpB9B9qdowpTgSvF+f+MgQeSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 at 10:47, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 25/08/2020 09:33:45+0200, Ulf Hansson wrote:
> > On Mon, 24 Aug 2020 at 17:10, Lars Povlsen <lars.povlsen@microchip.com> wrote:
> > >
> > > The Sparx5 SDHCI controller is based on the Designware controller IP.
> > >
> > > Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> > > ---
> > >  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > > new file mode 100644
> > > index 0000000000000..55883290543b9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > > @@ -0,0 +1,65 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Microchip Sparx5 Mobile Storage Host Controller Binding
> > > +
> > > +allOf:
> > > +  - $ref: "mmc-controller.yaml"
> > > +
> > > +maintainers:
> > > +  - Lars Povlsen <lars.povlsen@microchip.com>
> > > +
> > > +# Everything else is described in the common file
> > > +properties:
> > > +  compatible:
> > > +    const: microchip,dw-sparx5-sdhci
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description:
> > > +      Handle to "core" clock for the sdhci controller.
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: core
> > > +
> > > +  microchip,clock-delay:
> > > +    description: Delay clock to card to meet setup time requirements.
> > > +      Each step increase by 1.25ns.
> > > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > > +    minimum: 1
> > > +    maximum: 15
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/clock/microchip,sparx5.h>
> > > +    sdhci0: mmc@600800000 {
> >
> > Nitpick:
> >
> > I think we should use solely "mmc[n]" here. So:
> >
> > mmc0@600800000 {
> >
> > Please update patch3/3 accordingly as well.
>
> This is not what the devicetree specification says. 2.2.2 says that the
> generic name is mmc, not mmc[n]. Since there is a proper unit-address, I
> don't see the need for an index here.

You are absolutely right, thanks!

My apologies for the noise!

>
> >
> > > +        compatible = "microchip,dw-sparx5-sdhci";
> > > +        reg = <0x00800000 0x1000>;
> > > +        pinctrl-0 = <&emmc_pins>;
> > > +        pinctrl-names = "default";
> > > +        clocks = <&clks CLK_ID_AUX1>;
> > > +        clock-names = "core";
> > > +        assigned-clocks = <&clks CLK_ID_AUX1>;
> > > +        assigned-clock-rates = <800000000>;
> > > +        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > > +        bus-width = <8>;
> > > +        microchip,clock-delay = <10>;
> > > +    };



Kind regards
Uffe
