Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0842A2BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgKBNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:44:23 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36801 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbgKBNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:44:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9A9B3D30;
        Mon,  2 Nov 2020 08:44:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 08:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=fE52HILFIEUYX8gSPdSyC8jCaH6
        8aUucFwybO+du16k=; b=T9FfJT1d/rWjadkKk9V8jydL0dEEJ6WD319p8ZST6R6
        SW8jwwxwff/uua1ZzcIBZuxrVpbrmVUPzVQ9wAmZrx8lxec1yGeo12mSAVupHXZ6
        T8NbWuADmwMVprT15cTAvKBR6REBuTz6hEkyzapOYs+YDxA5EmIduE+YqQCSRVen
        ylJ19SPuJNMwrhuLLEnlV1CZXZGQbJmQ2HypKaRcUd7pbza541iSPV+lKtOO8lpX
        dSUnIgqooyIx0CyrvtYfcuIFwrw8usPOAsK2dyiE4sj0hKNzC7ta8cFK4lRxYOg0
        vTAkb0NeuAd52lPnHojoKbhzUZqyfB8WXspnwlW2vFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fE52HI
        LFIEUYX8gSPdSyC8jCaH68aUucFwybO+du16k=; b=ozO57LCJBj25oXnBaWDr5n
        P2JTOi8K8wLlr81WWAVnIeAsdHfGu+cUIeptcB2vzdkx9gKFK2sSYqGbUdqJ5mqv
        kxUrnHQbEhXopqwZhXSBWsUa2QG1e0eUx33cgZ69m+8JICT2onUBeJB66zDv0HsH
        mFuOjCCN8CKwLgZy08ElpycMMmw79CbajOm6EWcloS80o/tJpZzS0HEpPDG9Zrls
        zDChY75vxKDuGjBWne6P9zyyqqUPfGOgZverbpyustbzzSQK1axVTZmYKt6XzHCv
        0/6qsnexVE525hIixY0PIiH7WI8DYVZtb75AyEBjpgkzD8yhIQwdJ9XKWKx7DZJw
        ==
X-ME-Sender: <xms:NA2gX85uaTdBbSP72m9QH16HMaVKRsOfg3COOMHsAJOoGYJD4xtrLw>
    <xme:NA2gX95dT2MnmVBIZ44vvBC3r_tiDzcJPhHK4Xi7cIpOrE5miEEoOBPuQ2bSOquql
    cSE4yQ2a1Nw9SL_m60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NA2gX7fDKJvh3X25qFBt5igG9TmtaUs_E0lL0hsiRGFUFkMXlOssxQ>
    <xmx:NA2gXxIryROmEGBsI7TYwg6e5-3v6qVWyfLQ7DCcQRz59ltOg2pGaw>
    <xmx:NA2gXwJHNbaCCB0hzjNp-ImuC428o3dM-UHFP_0lsFaTIlVrOpPeNA>
    <xmx:NQ2gX6hPB5JYkIrnD8EO2mfhxGoE5DFHcFLbNaa5Du7jMz97YjMw7A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3F2A6328005D;
        Mon,  2 Nov 2020 08:44:20 -0500 (EST)
Date:   Mon, 2 Nov 2020 14:44:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 6/9] ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
Message-ID: <20201102134418.vn7i3e4gpwomxcnj@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-7-contact@paulk.fr>
 <20201102101211.wtkmgfm2rcm5gdyp@gilmour.lan>
 <20201102102522.GB11809@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zradx5x6omb6x434"
Content-Disposition: inline
In-Reply-To: <20201102102522.GB11809@aptenodytes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zradx5x6omb6x434
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 11:25:22AM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Mon 02 Nov 20, 11:12, Maxime Ripard wrote:
> > On Sat, Oct 31, 2020 at 07:21:34PM +0100, Paul Kocialkowski wrote:
> > > The V3s/V3 has a NMI interrupt controller, mainly used for the AXP209.
> > > Its address follows the sytsem controller block, which was previously
> > > incorrectly described as spanning over 0x1000 address bytes.
> >=20
> > Is it after, or right in the middle of it?
>=20
> That's up for interpretation actually:
> - The V3 datasheet mentions that System Control is 0x01C00000 --- 0x01C00=
FFF;
> - In practice, sunxi_sram.c uses a regmap with max_reg set to 0x30 for the
>   V3s/H3 so this gives us some room.
>=20
> Looking at other SoCs with the same setup (take sun8i-r40 for instance),
> system-control is limited to 0x30 and the NMI controller follows it.
> In the case of R40, the SRAM controlled is also said to be 4K-long in the
> Allwinner docs.
>=20
> So all in all, this leads me to believe that the system-controller instan=
ce
> stops well before 0x1c000d0 on the V3s as well. Otherwise, we should also
> make the R40 consistent.

That's a bit unfortunate, but yeah, I guess we want to remain consistent he=
re.

Maxime

--zradx5x6omb6x434
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6ANMgAKCRDj7w1vZxhR
xeLVAQCfo9QP+iBi8lib7fzKbLt/6ce/jsOJTm1DL/3gqqV0TAD9HGLPZ0b5HPUl
9Xr7omeEc75bFxlNsDP66SFuUiLCSAM=
=hsn7
-----END PGP SIGNATURE-----

--zradx5x6omb6x434--
