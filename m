Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BC2EBC38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhAFKPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:15:48 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58405 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbhAFKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:15:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9877D61D;
        Wed,  6 Jan 2021 05:14:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Jan 2021 05:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=eZocXSf05FOBEHxM4TLKo5dzdhx
        s3NeaX6GiWr2606E=; b=ofEN+FilW/7+tHVE3j1PP1bgqNEGMMFHSOUOcIJPMS4
        eumrvqjeK6tR2V6x/RMYlimpCcfvlotA43/gaux6ANbF+9uF/pAVPLHtT97cZF5h
        pnWYAYuZGw2SmjVJVQlBERcQvSBG3eP4dRkh4Wv6OA8uIlYsUlQIU3GfiK3ERliF
        XD+sLzRmLEdkUhbkq5uc3nJ/XuAX4c6tORvk4SCblIqXWonuO6KYqS61xrn7+qEP
        Yq40BxqW3E9GEzbipQmB1ifL20wUj5UCasECMCSleyQUURY3ZT9TCv9ot9iGz9lp
        S230KWVyDM4lhLWAFCbRTxKbfIqeQerG9rM23hwZjEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eZocXS
        f05FOBEHxM4TLKo5dzdhxs3NeaX6GiWr2606E=; b=X/BH2122cVQNR45UulRw7h
        IDFkQsko90aSPVl7GqDah9+WucgA1Vdl/sq1tY5RkWBToyzBON1hV8vf7aCxdpSt
        LReOlCi47n+lNKRT4yIJzpG6OvpLp9PziJ09eO08Acgcqpl2ut8sp6ykL6ckT79m
        NYV8T/E4thnL57jSmgpqeLauk5tnGArXkPAGujwWeyj5wkiD6juzntKDg5+gEofC
        oIBszdxXUvkp/4flDLe4oQL3y+qOfupvgxXkV6aCvIvjFELDGla7LqYHORinwoJx
        lhj/0R87qbAIiohXehuVEIIsskiCRLiIL1xa2s+hbVKETJEc6hUL0pzyQAC1mrtA
        ==
X-ME-Sender: <xms:j431X2NBxaBr3Q9Bv0olJRhVbweL7tWjUkE8lix1lNoy4nO3fgtZYw>
    <xme:j431X0_l9RUby5d_Fjl9HptUTO5ScGlwQ3PJbK-EPuCXQXCuZezTgMc2Eyu3Yhwe-
    sKRsauV-GVJfDnw_is>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffetteevieejteeuhfffgeektefghfeileehhedtuddutefhhfejtddvtddu
    ledvnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:j431X9T06yMLl7T3SYq2cf0WnJHRoon4Bn8PrHJMwmgamC9PJ0p7bQ>
    <xmx:j431X2siwRl6LmtQ_yT9HJnrAWkZE5Z3c8yR26p8Yv7EV-hfMto1VA>
    <xmx:j431X-eNDz0xCZFdaT8Fsil4O499yJkepa68KQtexw8rhQJaA6oquQ>
    <xmx:kI31X7H37cJu5hE1KbcLodDi_bQNMo9bPgOEA1KuWlP1SVHvxOtKKQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E4FDD108005C;
        Wed,  6 Jan 2021 05:14:38 -0500 (EST)
Date:   Wed, 6 Jan 2021 11:14:36 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210106101436.nrjlgaxsllvotxq3@gilmour>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
 <ef9657337a9a033bcbac2bc14805398b907835d6.1608721968.git.wilken.gottwalt@posteo.net>
 <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55y3zjhj665bhz2v"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55y3zjhj665bhz2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 23, 2020 at 03:49:19PM -0700, Rob Herring wrote:
> On Wed, Dec 23, 2020 at 4:34 AM Wilken Gottwalt
> <wilken.gottwalt@posteo.net> wrote:
> >
> > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > compatible SoCs.
>=20
> Please resend to DT list so that automated checks run and it's in my
> queue (PW). You need to run 'make dt_binding_check' as there are
> several issues.
>=20
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> > Changes in v5:
> >   - changed binding to earliest known supported SoC sun6i-a31
> >   - dropped unnecessary entries
> >
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
> >  .../bindings/hwlock/sun6i-a31-hwspinlock.yaml | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwlock/sun6i-a31-=
hwspinlock.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinl=
ock.yaml b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.ya=
ml
> > new file mode 100644
> > index 000000000000..481c5c995ad7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwlock/sun6i-hwspinlock.yaml#
>=20
> This will fail checks. Wrong filename.

Also, the name should be the whole compatible, so
"allwinner,sun6i-a31-hwspinlock.yaml".

> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SUN6I hardware spinlock driver for Allwinner sun6i compatible S=
oCs
> > +
> > +maintainers:
> > +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > +
> > +description:
> > +  The hardware unit provides semaphores between the ARM cores and the =
embedded
> > +  companion core on the SoC.
> > +
> > +properties:
> > +  compatible:
> > +    const: allwinner,sun6i-a31-hwspinlock
> > +
> > +    reg:
> > +      maxItems: 1
> > +
> > +    clocks:
> > +      maxItems: 1
> > +
> > +    resets:
> > +      maxItems: 1

And this is not indented properly, it should be at the same level than
compatible, not under it. Doesn't the meta-schema catch this?

Maxime

--55y3zjhj665bhz2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/WNjAAKCRDj7w1vZxhR
xa9pAQDmGKSAO7IBtgAVPY1Oxq3TFVWFbqh7Dv74oZibv5XAYAD+IRUgYXb02O3S
JHIIqrAWoj0FGZNtBaEVRo5GKp+HWA4=
=ZRTb
-----END PGP SIGNATURE-----

--55y3zjhj665bhz2v--
