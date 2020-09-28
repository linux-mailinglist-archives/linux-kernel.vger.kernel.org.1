Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0545A27AA06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgI1Izz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:55:55 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:48547 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgI1Izy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:55:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 58758B74;
        Mon, 28 Sep 2020 04:55:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wUSUu2G3aVIryWaeA7vOSq4b5nt
        Z2lJ4mb84/YsXOuI=; b=WZM48iBF91gdKnDjQ7uhJ0/RIFRw5RhXsOOeZlZJCKo
        ysOwTqjBtlBCZj08M9nF22EmaxFAVEoLPCI8HL/0jdPlzcH2YFICniXpCoLiPtqH
        VpOBH47bt+ui/2YfhU/yW5VfSsau0KQrKRpIe0o0c/LA7MH8NR/XbJViG+pkL2jD
        B/g/l2T60cdiT268BZyz1XUMfVw55IQig/jerb/vptjxlA1X6M9x6a83g0v0CBK5
        Bmmq1FDcnqounb0O4rwjBb8ol1ZrgQbcaIJowXG8EgIrm6mkVObuBjZaEx3BtVfa
        XrLcZKvTOl2wgSLOTL7PgfwIArfBy2SMIZW7HfyAtbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wUSUu2
        G3aVIryWaeA7vOSq4b5ntZ2lJ4mb84/YsXOuI=; b=A4aQVk9qURplYZemoSbP0T
        EUoSZyu6BP+ZXw6FNbxPs0GVkLXlfle+zceapwfhWF20BfQ34PdGbXpWpcwdus8w
        T8ByrOAMTp9PAVFOq7Dw8hBc+2GLY+/0ycOmDjNEUvrO37DrvgPHjPIMrlXu/3SH
        5q8/uU/TxEl/IcgFyNTAaaq99scwACFHzeUlUBgrJI8c5BAIL7QKXasqfwACLnP3
        OKdCTsL3Z0OzDIGDuPBTeNGz7iGRXdtW0uJDyfeK4dvfUEvLgEi//GS+qrpG9FgJ
        z2gTBIwFOb2DHf8rlSu69xN17a5yR33Xj3A8eP4bkmOVhqRwYRi/uXVd98IT2DcQ
        ==
X-ME-Sender: <xms:F6VxX9h8l3bdAdhKV7_ZeWNJSwUX_O1_FpWJwZe1u_C2JnuMPQGRKQ>
    <xme:F6VxXyBUwEdfOyLmpzIxGe9WCsxP_0R9KFUgHeaQKe4QIaeVg9mSAC_s3igP0_uM7
    w1WHRnZF_vmQISJkGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:F6VxX9HpWJ2SssBbPsr8cR0GdgkIsAFIl4TChPshZo0Qsl62OBNPrA>
    <xmx:F6VxXyTAfPBcPd-lFgiNOUKT-Dk05hFMJ2dwQsw_6WiFT0kUbPlw0Q>
    <xmx:F6VxX6zrMQ_V4GpMBxdfOcUtIBmmlvBxqky092uEANXubuudMIwvkA>
    <xmx:GKVxX1qlyUa-jOEbIeG-OVdzvi-kstcBwRc9s__r2vQLN4KC_S3NA-TUoVc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50723328005E;
        Mon, 28 Sep 2020 04:55:51 -0400 (EDT)
Date:   Mon, 28 Sep 2020 10:55:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 02/22] ASoC: sun4i-i2s: Change set_chan_cfg() params
Message-ID: <20200928085549.izpgwdtkq5cwa4ut@gilmour.lan>
References: <20200921102731.747736-1-peron.clem@gmail.com>
 <20200921102731.747736-3-peron.clem@gmail.com>
 <20200921122918.kzzu623wui277nwr@gilmour.lan>
 <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z5fpfx6vrqwdiuav"
Content-Disposition: inline
In-Reply-To: <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z5fpfx6vrqwdiuav
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 07:15:13PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Maxime,
>=20
> On Mon, 21 Sep 2020 at 14:29, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Mon, Sep 21, 2020 at 12:27:11PM +0200, Cl=E9ment P=E9ron wrote:
> > > As slots and slot_width can be overwritter in case set_tdm() is
> > > called. Avoid to have this logic in set_chan_cfg().
> > >
> > > Instead pass the required values as params to set_chan_cfg().
> >
> > It's not really clear here what the issue is, and how passing the slots
> > and slot_width as arguments addresses it
> >
> > > This also fix a bug when i2s->slot_width is set for TDM but not
> > > properly used in set_chan_cfg().
> >
> > Which bug?
>=20
> Do you mean my commit log is too short or is it a real question to unders=
tand ?

Both, actually :)

Maxime

--z5fpfx6vrqwdiuav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3GlFQAKCRDj7w1vZxhR
xYJzAP90E3Ebs8ekSnakjeM+AFop/3Kt5use/kVDKsSr/V2JlwD6A8+jug6YBRDY
7kZEe3Y1iUyb4oLqEpjNxunahn+yfQA=
=0O29
-----END PGP SIGNATURE-----

--z5fpfx6vrqwdiuav--
