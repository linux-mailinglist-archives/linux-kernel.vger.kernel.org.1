Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC152A2807
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgKBKRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:17:00 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30CC0617A6;
        Mon,  2 Nov 2020 02:17:00 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 4EBD0C013D;
        Mon,  2 Nov 2020 11:16:56 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id B257DC1515; Mon,  2 Nov 2020 11:16:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from aptenodytes (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 085FAC0571;
        Mon,  2 Nov 2020 11:16:47 +0100 (CET)
Date:   Mon, 2 Nov 2020 11:16:46 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 4/9] dt-bindings: irq: sun7i-nmi: Add binding for the V3s
 NMI
Message-ID: <20201102101646.GA11809@aptenodytes>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-5-contact@paulk.fr>
 <20201102100918.7vutmnkiwvumgkyf@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102100918.7vutmnkiwvumgkyf@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 02 Nov 20, 11:09, Maxime Ripard wrote:
> On Sat, Oct 31, 2020 at 07:21:32PM +0100, Paul Kocialkowski wrote:
> > The NMI interrupt controller takes a specific compatible for the V3s.
> 
> Why?

Well, it's explained in details in the patch adding support in the driver
and in less details when adding the dt nodes. But okay I'll add a short
explanation here as well :)

> > Add it to the device-tree bindings documentation.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml         | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
> > index 8acca0ae3129..52364c2200ef 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
> > @@ -26,6 +26,7 @@ properties:
> >        - const: allwinner,sun6i-a31-sc-nmi
> >          deprecated: true
> >        - const: allwinner,sun7i-a20-sc-nmi
> > +      - const: allwinner,sun8i-v3s-sc-nmi
> 
> This should be sorted

Ah sorry. So this should be between allwinner,sun8i-a83t-r-intc
and allwinner,sun9i-a80-nmi then.

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
