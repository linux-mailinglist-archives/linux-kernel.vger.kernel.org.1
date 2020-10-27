Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87729C3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822529AbgJ0RuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:50:07 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:46663 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1822520AbgJ0RuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:50:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id B143E580477;
        Tue, 27 Oct 2020 13:49:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 27 Oct 2020 13:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=SoPfxx2oik+qKdyMuP/1zfe19eO
        7ppN9RekIgp6vhlw=; b=BdGoAhwjsCzkCG4mDq9NmB86rVpuaMvLO9ayWVZ85K4
        IM2iBiSsNB5n1q/XlAKkveQM9Y0aDSRNNHcqLys8xqRYz9NRyMEdYlLdDgvwkxup
        jOv6sbi/ZO3QbhrtU2E1MYKwEuClgdk30Ln+HWGcnP8hGMRuAlTmJwQJEWqk5l7U
        SnJ5ACRgsqywnhMV6RU8iP9vWUIM8GZ4hq34GvQ5gHdxYaRlf2yUmIbmOxx2fjgG
        DrHCqaUitAoUUKPW9E0DmXV5O5M/we7cOQony0OH551htSSVSfgfjVC9lh++0T9D
        HeOTnel7qEZyHKgdrWv040GCEGZyd4yEu/6WT+f8yjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SoPfxx
        2oik+qKdyMuP/1zfe19eO7ppN9RekIgp6vhlw=; b=Tz7aCWr+1Do9oUCd/WtjDl
        UxVxsS3fFTDjWkM76MvyYhb27+maRdtIrET0vchwESn2el6r6cj93lStE1Wsdu9n
        aSpxCG1e//ocgJL3vEJ8NGjvU584cj3zjZtB4ZL9juS0FfqG5jE3LVm84eBD54+z
        t6OAcux5UsbFq+NjLZzSRDlmKm/5g6KgkN6QM8Bb7xmhbaT8o/q0/I3B2Up56A/v
        fOLDKIogCfVyReCDJ+FKJYgS6bmSA3swWrdqe8nBoQzddbe/JaB3Ssa4+p03Gl67
        UR7uAmUQR0QPSwF05YsRzxJAHx0+ewhgCjQZzznBjFiAcmmeJemwG/W0L67cd+iA
        ==
X-ME-Sender: <xms:x12YXyXsj9a5uVfoR-jq5y72b4eIKA45LNlLgl76fx9HirIjyrMQig>
    <xme:x12YX-nlgrllZZAz8mN3UmvFYNVfn-Xgq-sUJvqb1vestlyb6UA1aLoImIfz663l3
    KTXfvQ1fDP_MwLF6H8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:x12YX2aSd49wEBYL3oZn5Q7f5D83rcjKlc7OymGKnQmY2Bxq9h90Ew>
    <xmx:x12YX5VlXDLXdZA8Ai_8qhvudWlryWmw1vnD5zCibbh_sdYozojBYg>
    <xmx:x12YX8niOozogfraXlAimIbIcDMvWuUOVVbJhOPQONy4IYYWBvyMrQ>
    <xmx:x12YX2ccPIXCfFpNSRXeM_XCfDFojm9qilXJmBtv6jVGH7td3mMVqg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 280FE306467E;
        Tue, 27 Oct 2020 13:49:59 -0400 (EDT)
Date:   Tue, 27 Oct 2020 18:49:57 +0100
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
Subject: Re: [PATCH v8 02/14] ASoC: sun4i-i2s: Add support for H6 I2S
Message-ID: <20201027174957.ui4ootubgb46dqgv@gilmour.lan>
References: <20201026185239.379417-1-peron.clem@gmail.com>
 <20201026185239.379417-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2cpe5wngdf44cto7"
Content-Disposition: inline
In-Reply-To: <20201026185239.379417-3-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2cpe5wngdf44cto7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 07:52:27PM +0100, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> H6 I2S is very similar to that in H3, except it supports up to 16
> channels.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>
Maxime

--2cpe5wngdf44cto7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5hdxQAKCRDj7w1vZxhR
xfstAPwNh4kC5XbQtUCP4L5Gm0B2rKNz/cw4/UvvSrad7luH5QEAugCk5XMoWfrG
uIeJcwrL897i8RZAX7HB/GTMzQqh6wc=
=2/aQ
-----END PGP SIGNATURE-----

--2cpe5wngdf44cto7--
