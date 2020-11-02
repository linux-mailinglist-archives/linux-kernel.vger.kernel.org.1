Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554862A285F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgKBKdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:33:50 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:56354 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgKBKdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:33:49 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id B5595C0139;
        Mon,  2 Nov 2020 11:33:47 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id E98C6C1D7F; Mon,  2 Nov 2020 11:33:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from aptenodytes (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id C4F8EC1D7A;
        Mon,  2 Nov 2020 11:33:40 +0100 (CET)
Date:   Mon, 2 Nov 2020 11:33:40 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 8/9] dt-bindings: arm: sunxi: Add SL631 with IMX179
 bindings
Message-ID: <20201102103340.GD11809@aptenodytes>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-9-contact@paulk.fr>
 <20201102101333.4bm2lfqpqnbpyp63@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102101333.4bm2lfqpqnbpyp63@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 02 Nov 20, 11:13, Maxime Ripard wrote:
> On Sat, Oct 31, 2020 at 07:21:36PM +0100, Paul Kocialkowski wrote:
> > Document the compatible strings for the SL631 Action Camera with IMX179.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > index afa00268c7db..0fa0c0b5d89f 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -754,6 +754,12 @@ properties:
> >            - const: sinlinx,sina33
> >            - const: allwinner,sun8i-a33
> >  
> > +      - description: SL631 Action Camera with IMX179
> > +        items:
> > +          - const: unknown,sl631-imx179
> > +          - const: unknown,sl631
> > +          - const: allwinner,sun8i-v3
> > +
> 
> unknown is not a valid vendor (and you should explain why you picked
> that vendor name in the first place).

Ah right, it's not in the vendor prefixes. The rationale is that there is no
indication of what the vendor might be on the PCB. Should I maybe use
allwinner here? It looks derived from a V3 reference design anyway
(at least the pin assignment matches e.g. Sochip's S3 EVB and other known S3
boards too apparently) so this could make sense.

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
