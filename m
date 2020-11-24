Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03D92C298D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgKXO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:27:00 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53527 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388132AbgKXO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:26:59 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B5FB95C0135;
        Tue, 24 Nov 2020 09:26:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Nov 2020 09:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=JTRY2CpqUesYkJOvp9c76LrBGIw
        tR2cAMy3w5x4i/2g=; b=KLWljQGMqHPYwjCbJpwWZNNB8FsNZa036Mh6yeJ02Ur
        Afwp5iMw131+Z0OgD9BC2dXG0F4X7iENdYJTQyLbeKUGdKtU/MEOgs8BIZsjm2pH
        nwODMSGnUg+/Mbnn/5c6sDil6MDViOPm6fYc7Ui5PJDd1ab1zomU5IMFJ/JkPu5H
        ncrGbUczOAg72fmn34oRA+lkZjEzsoLvxr7JwyDu7S3YBc/gH3vsvBSgGy+bkOI2
        cQu9Y3hwCG1C4zjcSY/PFOxgMOYufPzQQerpQhT+xj8+nlZ6Uuz65gXJrLmlw3VG
        0HVQoWIG/LN3kxwT20p4j+G28Jdpxw7do/ixffnjtpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JTRY2C
        pqUesYkJOvp9c76LrBGIwtR2cAMy3w5x4i/2g=; b=Zr7o/o53Mf8BZ5sDcu5jk6
        zl8DI3lyJeGA8jvEAmYSpyseOBZlwzixddVgzYmDhBeJb5XCMpqbig/8xLNooIeN
        SGkVLjtlGHNiHNW/I2c4KLkdY1U+Y8TZfTDnzAUIKHwN6JLAuTt0qhuXj64AIuSB
        gK45FfrflfZOy4AAgvUud/J9JYmqWJjawak0IhCoweQVXTMbJRLrMxPg6b81WV38
        95CfXxcLD4PurY0EnkSn461RiMwizRQuZeM6Snh8TgTt+vQOl26Bw9+sSKauClPK
        4BeLNaFWwtRCa5vc06lqKSNuQtsUiswC6/+Syv4/246s1CyApNhD4rggWfiGc65w
        ==
X-ME-Sender: <xms:MRi9X-T9CihUHLuc2xKOdb6xCsvRWVacjZJ39elDkNLZHXQCfrKLag>
    <xme:MRi9XzwO7_p35u5_y3E0aHFdW5T-xlpfLy4d3rqbCGPg55xXfghJzKg_4F9Vz_Pdk
    t4ebdg_-bn2CTrdL-s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MRi9X71PQ72gLNlm40R-2wcRHyl2aPKLFrOkaJ2xhaLS-l6WJUlBCg>
    <xmx:MRi9X6AtbLwQBjWs1n8BnBA3FVFVQwJ0HtS3uuywao7GSyAc3NQFBg>
    <xmx:MRi9X3jx0HZsml1nnkUm_wTTqylsR5HbQLLhOoW_LlvMMQIe5Mliag>
    <xmx:Mhi9X0sF13YplVvCIte2zfoT2-sGm1QOoMyqRJTwQbOaiQUpaF0epw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86B5F3064AAE;
        Tue, 24 Nov 2020 09:26:57 -0500 (EST)
Date:   Tue, 24 Nov 2020 15:26:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 poweroff node to DT
Message-ID: <20201124142656.wz6ipwa2xayn433x@gilmour>
References: <20201124131933.2l2go6z6ltar5fpa@gilmour>
 <20201124133633.672259-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vp5zfmwxtuhchxup"
Content-Disposition: inline
In-Reply-To: <20201124133633.672259-1-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vp5zfmwxtuhchxup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 02:36:33PM +0100, Michael Klein wrote:
> Add poweroff node to allow the board to power itself off after shutdown
> by disabling the SYSTEM and CPUX regulators (U5 resp. U6).  The RST
> button can be used to restart the board.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
>  1 file changed, 5 insertions(+)

You should have a summary of the changes between versions here

> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/=
arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index 4c6704e4c57e..ea2fa48a1647 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -46,6 +46,11 @@ sw4 {
>  		};
>  	};
> =20
> +	poweroff {
> +		compatible =3D "gpio-poweroff";
> +		gpios =3D <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
> +	};
> +

Like I said in the previous version, this should really be modelled as a
regulator instead of just a GPIO

Maxime

--vp5zfmwxtuhchxup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX70YMAAKCRDj7w1vZxhR
xXekAQDNMhodfkVHL9ngSP7kjTeSxw/MJwsCjsAhqiLZm0dHkQD9E90d8y8nOnaS
FERvFANkkFNagtK38l/l1bZeYVt6NQU=
=y9Dc
-----END PGP SIGNATURE-----

--vp5zfmwxtuhchxup--
