Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10132A6D76
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgKDTFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:05:21 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34925 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727098AbgKDTFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:05:19 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 36E82970;
        Wed,  4 Nov 2020 14:05:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 04 Nov 2020 14:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=jjy2HccS9l9hIwU+k7ne7oMpM36
        YPjEC76Zvpd5ZrLs=; b=IVVHr4HsO1gqpwqTnMBEJhLDXloh8lr8FNs/k0wXfws
        4rqkw33p59s+4/2SHWAAN3nThKGQ5PWhKXPXVM3AtKh9ifSD9pS50UBKL2n3Kd20
        TqtJP1Fwu9Wawpme++FwjajD861b26NxRaCV2Q9QJLMm/e9H8N5jdl76/RPNZOI0
        Nqr9G/8M6yKEffYo+3ztbjv2PMgzZbwPCX0x9E9gQSJuHUoOCxcJJVsPhze97Hoo
        BOu3IaR2lKNROpGya6XNfaO1hxqtVcUTeubt+mQCQmzfqKDcbxSeSYw3gNN6gMyz
        VFG088aef62O5O6sF0DbJAp5kbLMED+HPBr1JYF28tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jjy2Hc
        cS9l9hIwU+k7ne7oMpM36YPjEC76Zvpd5ZrLs=; b=EnXIIu8JQgJLOZfFbkPmD0
        X7RIGdUBolkGycUlq86ENoewwfZdGA2Qzu5kY0iRYUoS/8xGkMWPc+zOwXArhsX2
        r8b66EauK59KwpCmcANZ2cS52IhgwRoeSsCIkAruQYUz0Wy/N5HQhukRUSZFRR7V
        YxlB0RFIalE6EO0m/olRSRXJ3vycLGSIJVTbRCzypgPS2yoXO0WgYhLp9EjHGtFV
        /VDmsesYAdDruLLAUwOLv8Uz+PasI2DQITisw6aLJPdwr35R0xHAqq/WQH+ayyvq
        QhhdasVED3hg9TeCm4JL8Znxs3oAOk6QJGkoiheDaxO4LwfqkQCITPEz50JfNIOA
        ==
X-ME-Sender: <xms:bfuiX6wmQknUB1BorG0Vy6ofTmjvS3DsAQXfCzP4dsXSh0_4EaT_Hg>
    <xme:bfuiX2Qbb7Y6aa2wP69qO5DGqcOGKr69C4L10KOJ2x36FDx9SL0hjnIvLQYQwyS8g
    LyQGjhyk6Yo2qODmUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bfuiX8XZem_eeColnQ-71j1yTg108eULw8RO4Xs3f-m7nQVylg1XWA>
    <xmx:bfuiXwgjdbP38KIKUukV4C0iLGY9xr-tmZzar9PyhnuebqOtfD9XBg>
    <xmx:bfuiX8De_B1-kVbJ96BSKLZl2NbaYNfhgQNU5yxCr0P5Ev4l71OBLQ>
    <xmx:bfuiX_MDfRrC-Z8kED_uFA0q-37ylNWYNXaWa3FlD0C0kwtMhwnqNA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7D74306467E;
        Wed,  4 Nov 2020 14:05:16 -0500 (EST)
Date:   Wed, 4 Nov 2020 20:05:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] ARM: dts: sun8i: s3: Add dts for the Elimo
 Initium SBC
Message-ID: <20201104190515.nppp633zkn2s4j73@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201030234325.5865-6-matteo.scordino@gmail.com>
 <20201102100632.g5tozkzfjzzch4ny@gilmour.lan>
 <5064a1921b0ba98289c13f325e11347b09cd3672.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r442x3op4ovhkptd"
Content-Disposition: inline
In-Reply-To: <5064a1921b0ba98289c13f325e11347b09cd3672.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r442x3op4ovhkptd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 04:33:26PM +0000, Matteo Scordino wrote:
> >=20
> > >  	sun8i-t3-cqa3t-bv3.dtb \
> > >  	sun8i-v3s-licheepi-zero.dtb \
> > >  	sun8i-v3s-licheepi-zero-dock.dtb \
> > > diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/=
boot/dts/sun8i-s3-elimo-initium.dts
> > > new file mode 100644
> > > index 000000000000..7677ddc07bf9
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> > > @@ -0,0 +1,28 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "sun8i-s3-elimo-impetus.dtsi"
> > > +
> > > +/ {
> > > +	model =3D "Elimo Initium";
> > > +	compatible =3D "elimo,initium", "elimo,impetus", "sochip,s3",
> > > +    "allwinner,sun8i-v3";
> >=20
> > You should indent that properly
>=20
> Double ouch.=20
> However, how is a multiline dt property supposed to be indented?=20
> I have tried a few combinations but nothing seemed to make checkpatch.pl =
happy,
> except leaving no space at all at the beginning of the line. But I think =
makes it
> quite unreadable?

We usually pad with tabs, then spaces to match the opening quotes, like

compatible =3D "elimo,initium", "elimo,impetus", "sochip,s3",
	     "allwinner,sun8i-v3";

Maxime

--r442x3op4ovhkptd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6L7awAKCRDj7w1vZxhR
xWXwAQCgVVnhs9mVZlxOlDXTEoPwetnavVYbqxop9mWCp6ts4gD/aA4Gu7KLB+xO
ol188G9HW2NOOY+jGk+wJY2EN/KHxg0=
=+zfh
-----END PGP SIGNATURE-----

--r442x3op4ovhkptd--
