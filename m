Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C214283596
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgJEMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:15:01 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60667 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgJEMPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:15:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 594E55800E8;
        Mon,  5 Oct 2020 08:14:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 08:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ss5xOBW/WUbyI+sqAnG3dhdUG/1
        ZeoV+/0ua+YhjLAg=; b=gGP4c3jXp33tWZ9lx4tCQFiS8zHysT4bMIV3JrQRvfi
        eAr2/liTG+jEecjMB9g/H3Y37tqWqYTLBWJL1xZ0FTc8Eor2jGsIYZ1NjjoQb74y
        s/L/9BzdxQuNYKxoNcnBIkRm/IK6AOuqX587B5DJX2zEzDpoR+IuUK3VjQ6fBFoG
        cPLHrR2rV5dHRqN73wLHyNKQ5dpwYNmMWY+L2O/L6B0hArE1fYw92LkTdNBmH4hP
        5Cqr/hsDlvw4SoiK5bcQUARVcHjqlLkxUgAx5arOKOOBctNh/iZX09a2vgX2QIVb
        dc7zDqOiaTBhVdskCROmY8RJ3hMuAqK6M9I/uil55hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ss5xOB
        W/WUbyI+sqAnG3dhdUG/1ZeoV+/0ua+YhjLAg=; b=ZWwt3gNzEbRdF1kaZEfT37
        qd5TjSXt1JBvby8q5+jqAyrNrzP+FUvyUWq6bMiHadAsuNwERW4sVXlLNZ7HrXuX
        Fq8xupZCYUBuwnLo7OJxSTR1wAk8tsKOJXwmgeCAZpXPOhiYlULsf9EN1X/rKXLU
        wUm6zyxakNRc4IcYkuOfqGunZkuuzj2OYfm0Xeazbm/dYkk7zNcT1tP6lYC5Mea5
        Fl2+F/dTjd/bRi8bPDnJsfideb13b3gNNbKuMifpjRq9qfI2pPNtjwhS+NRh+Tvf
        vnvAU3uf5Ji+x2LIyYzy2VPtAKufFPj1+irJntV2ZYQ4vGBRhN3GyIGXMUJw/SDA
        ==
X-ME-Sender: <xms:Qw57X-xgkmcbRT5VaK-FKevy-wh9Cc0QZ56I-rJlHWkt-HP5B9NBEw>
    <xme:Qw57X6Ro7eXLW6zWfvRgAOZbqWbbnU2JJZ-mEy6rLjmSncv0luZJ57HVPKe6Uyxg-
    pt8poksVLkVt7WhvGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Qw57XwU-qdggpgCoRMLmX-btmWUQz5azDt2UtB1UlYMMmzFcMtCfkw>
    <xmx:Qw57X0hSRxVKGP_l4JqyKMiaN9FbRY2GgOMVr_ZCQsg6yFweeEj0-g>
    <xmx:Qw57XwB97qkEBB5YbcWpLpE1H561N0u7VW9r-2meZJcIckagqSNU8g>
    <xmx:Qw57X5LgHXOpVPEY26s8adN3g0gWtFkavI6MHaSZIGV-IHotk06EuA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5E983280067;
        Mon,  5 Oct 2020 08:14:58 -0400 (EDT)
Date:   Mon, 5 Oct 2020 14:14:57 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 08/14] ASoC: sun4i-i2s: fix coding-style for callback
 definition
Message-ID: <20201005121457.akbixtzf3rqwtq7t@gilmour.lan>
References: <20201003141950.455829-1-peron.clem@gmail.com>
 <20201003141950.455829-9-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oaws3jxb46bccpfd"
Content-Disposition: inline
In-Reply-To: <20201003141950.455829-9-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oaws3jxb46bccpfd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2020 at 04:19:44PM +0200, Cl=E9ment P=E9ron wrote:
> Checkpatch script produces warning:
> WARNING: function definition argument 'const struct sun4i_i2s *'
> should also have an identifier name.
>=20
> Let's fix this by adding identifier name to get_bclk_parent_rate()
> and set_fmt() callback definition.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--oaws3jxb46bccpfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sOQQAKCRDj7w1vZxhR
xQI8AP9peje1FGUYiKYyd7X0xC7UqZYUpLKKGvsYwHL5Aky1UQEAuSUPd0mxp+bS
mAn5oBpY/2OYS5TNxvsIbiEY6REDBAk=
=drfJ
-----END PGP SIGNATURE-----

--oaws3jxb46bccpfd--
