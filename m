Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914322A7CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgKELYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:24:12 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43617 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgKELYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:24:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 76D65B1C;
        Thu,  5 Nov 2020 06:24:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 05 Nov 2020 06:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2AABR4ODEx75d/UKZpeLRRG+Idf
        OMJAXPG5J8fUHni4=; b=KCo2NskhD8lecpxw5Pn2gxKW3MDYUN/pPWmAAlpH0Kb
        nWmk4o+y9cIMcZgjM1gM3C5KZIvrHgaHxdpaO5Nfu37anI2QRLZ0NH6IyCLJ+DaL
        dCuygE2pD4CMGlazlrMYlZPHZoillUFHC1bGNnJniKSswJFBDrfYDEnKdrfYD0T+
        BhSGbYboJuc7gbG889lpGsq11aVb4ovCwMN4+Vcs0C9OV6SdPecrA98u0eXdOqHc
        25sAWrlxMFhz5yleGeybBBe3CX5ilrl88RvZ428JcG7wcRzvgGdLKSGxrV+oCoNf
        ueTtqFFfqlcuL68Naqk1sCeZ8jTYXhck5fsWaKVK7wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2AABR4
        ODEx75d/UKZpeLRRG+IdfOMJAXPG5J8fUHni4=; b=hT9w2BS9ObzmZ5O9E/PwVM
        X38UMV9dlaYOPIxQnWQBKNLuifMUfVlf3ljfgYgIylkk5QIfVZByv2gEwFOMeMF+
        rkGvVsaLe0nnj5OYQf1b2FrP8zazrQk7wbdd7SUUxe6Y6nGDO9yI+MRI0AJJBChe
        Am425WUZBb7Wycm7SJkwrREzkbT2eF2j557Quskl5hq1y/vYYtN7TkaNkYayx41u
        XALJxMrZX3ZxIQcn2CxbRqXhmQlqz4DBJjR+wzbF3vKSb+pUBCRiVZ9zdmRwSxf/
        7sZw0SRw1mIozE6dLs+JFWhDbDn2scgiX+VmiMykKWprSr6oSrgQNYgd7fC84APg
        ==
X-ME-Sender: <xms:2eCjX9qqPz_QPQuRGQXvPyIJ8aJMVh8nMeGyChNewIq30V9Q1t2tEw>
    <xme:2eCjX_q2ifaRxoMS62MGWU8A4Glre18ovpBkamp8WzHRPHyTDrYa-bcyDwVellzJb
    QR-TuuQ8H58h09CVfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2eCjX6Pc3yRnQxf2TGzFbgVmJjiHpP0O166qKe3KGXSUmwNC5vkIjw>
    <xmx:2eCjX47PsthGIDobaeniLc0LVYJ1YCfidnKWH_9gWZV-GFzQX6qdzw>
    <xmx:2eCjX863x6H-t6S3iNq7E6W0Khs2__CUieBT9A545KepjdBQLL6wNw>
    <xmx:2uCjX5t6tWTFvaurzHVjEe87FWJ3cgJ1Tq8U6lHeTZBWdzRI5chj8g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9EF76306005C;
        Thu,  5 Nov 2020 06:24:09 -0500 (EST)
Date:   Thu, 5 Nov 2020 12:24:08 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH 5/6] arm64: dts: allwinner: pinephone: Add WiFi support
Message-ID: <20201105112408.nzcly24holmpdusm@gilmour.lan>
References: <20201105054135.24860-1-samuel@sholland.org>
 <20201105054135.24860-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fykr42eatnssco3t"
Content-Disposition: inline
In-Reply-To: <20201105054135.24860-6-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fykr42eatnssco3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 11:41:34PM -0600, Samuel Holland wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> The PinePhone has a Realtek rtl8723cs WiFi module.
>=20
> On mainboard revisions 1.0 and 1.1, the reset input is always pulled
> high, so no power sequence is needed. On mainboard revision 1.2, the
> reset input is connected to PL2.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../allwinner/sun50i-a64-pinephone-1.2.dts    |  9 ++++++++
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 22 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> index 94e4f11e0215..e7cf9d8577c1 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> @@ -8,6 +8,11 @@
>  / {
>  	model =3D "Pine64 PinePhone (1.2)";
>  	compatible =3D "pine64,pinephone-1.2", "allwinner,sun50i-a64";
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> +	};

Underscores are not valid in node names. I've fixed it while applying

Maxime

--fykr42eatnssco3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6Pg1wAKCRDj7w1vZxhR
xbf6AQCU7OWSaT/FS2A77Gd+YdRKZNvn81XKN9Lu4Lgikq/mwwEAoCAHbmJKqC0W
QwxM+tIbp1LAJA10SsAx/xI1ADZvqgQ=
=hAim
-----END PGP SIGNATURE-----

--fykr42eatnssco3t--
