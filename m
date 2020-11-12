Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDBA2B024C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgKLJy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:54:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58887 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727654AbgKLJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:54:25 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4209B5C0270;
        Thu, 12 Nov 2020 04:54:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 12 Nov 2020 04:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=TuclOS/aZHuG6/ZdRLGM53ZDxtW
        QD1qVs4e0nGcIEIA=; b=Ux1+UQx1k1DximQrtrmf5rO0OzZwAwufUnBr+BVIQQC
        IFaGo4JmFfAxn0BWAerlKDeF2dmFh8486B/oGV+n44Ne+I6QtrckniyuMmb7tjCC
        hTbL86iQDsojPboBA+ZxiZJoUvqG4sYrfHbCJ6cgp/1IttOnQqS7BDCOyKV/uiyw
        A/bSQMVnJSZwJ7Olv4dmXx3PgxPCNuYFROLWn04vps1BN/Qvyoi+p/ej3PWkN7OS
        NYhihkXl0n/vnjabU98iLZdCFkOwy4MSxsaArwnZ/CzwOV6FWgrHUPKtg9tQutOA
        MpgR+YHFIQNtLFuUPg21lp5+doq+umcs1EZNWF3CDjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TuclOS
        /aZHuG6/ZdRLGM53ZDxtWQD1qVs4e0nGcIEIA=; b=MPb6lm5Wq5oqjfpAK8uNoI
        aqqFAYRjIp4H8uEuYRAom51vyL74fau9RKAfKK4pG7H0KPH4pxzv7wiX1WEsQ3bI
        NZMWP8AT2vg0Zx0zSiK6bNDpSQakMG6riDMfhsX5XN3YKb7Dx12wkkgW0l+YS3Sz
        ImVubpcXFDx9/MV1dCkb4kSQCH5sihzgTgX957m0aMSXHjKOXYjmnJkdefkx+rlW
        AzxEuo08VtX/7hW3W9J+BzgHQS2tR3dz90XKIWtv96O8/BklEz6t+gAeN/lUghPu
        D1FDZ4Cfl22nSQh0Fg6YeAgLS7VUzmE7E9fAtywK4OL6rA9zHlYYp+UxStH8D6/w
        ==
X-ME-Sender: <xms:UAatX_mPWFEPqROPoEdRfsjEEhbBMuZh_H1MBPQQ63Lz86hPUxAH5A>
    <xme:UAatXy0fkSM-OT2RnrhTh9RMq9rU63dvDsr6d03kaiH3Mr1Pw_LgziSXskuPN4YIV
    6_O0wVLcKYizAAmBO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvvddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UAatX1oMqUGAdBYgm7bGNmhMQmkAvTeTC-ouiKWNdxjIUc67dzvCSA>
    <xmx:UAatX3mK7omnIpcP-26YrV8APNg50hqj5GoeaScFtB4Dvr_akXmg8Q>
    <xmx:UAatX91vydy1KFon42XqnLVDqFvQSa4bIs8277qGfXrtHYXWTvfipw>
    <xmx:UAatX4TsFidiWG0MxXVol0NeBgkf99SzvGPXSaLkyNMxDpw-c-uM3Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B97943066098;
        Thu, 12 Nov 2020 04:54:23 -0500 (EST)
Date:   Thu, 12 Nov 2020 10:54:22 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiny.windzz@gmail.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: fix sid node name
Message-ID: <20201112095422.in6s5ctgv7in35on@gilmour.lan>
References: <20201109122101.23302-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ja54jhtdryuhpwu3"
Content-Disposition: inline
In-Reply-To: <20201109122101.23302-1-frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ja54jhtdryuhpwu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 09, 2020 at 08:21:01PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Sid should be an efuse type device accurately. And no one
> needs sid label, so delete it.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index dc238814013c..96543df5d890 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -520,7 +520,7 @@ mmc2: mmc@1c11000 {
>  			#size-cells =3D <0>;
>  		};
> =20
> -		sid: eeprom@1c14000 {
> +		efuse@1c14000 {
>  			compatible =3D "allwinner,sun50i-a64-sid";
>  			reg =3D <0x1c14000 0x400>;
>  			#address-cells =3D <1>;

I agree with this on principle, but we should do it on all the SoCs at
once. Can you send another version doing so?

Thanks!
Maxime

--ja54jhtdryuhpwu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX60GTgAKCRDj7w1vZxhR
xVERAP97kOrnqreDaUK+yUflbqy4M0PS2Zje0xX+CM4v2nj/EgD/XqZe6xQGR5vD
WBR+Qr+EY72WpPHKCiZQqgZN0IhPwg0=
=kh5v
-----END PGP SIGNATURE-----

--ja54jhtdryuhpwu3--
