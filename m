Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E653C2876E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgJHPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:13:20 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43233 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730650AbgJHPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:13:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 28FA6882;
        Thu,  8 Oct 2020 11:13:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Oct 2020 11:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=gAAtAfDZQ+SVtFKSeugyWhxxrLY
        /NxMX+mMNTVPsT/U=; b=jfIXSq4j09XVXiVfSHu0TgunQ3Y+HIE6t0ml+2TraGs
        Js9ClZuLQSXeaUlsIi4TLrteyt4I2D6ES5jqO9NNOCMJhTVkp2ivq2ma6CYLMymQ
        /NY4RQTGkXj1JTxdFriA0BRIooBIJ5pFtN0TAIM/qoSZZaGJ0xfh8welv1AGvRKF
        XhejeKs5re4C8HH1GH+pfDidC4tf9mBxYklt4b90old+yJoNGNyY8vjWdtrnnnmL
        gBtlibFs8j5UVPeJ/RluOebMvfwttEaiYaoeE00RwYCyYgnVMWadZdrSzjr+JFMU
        vtTxMTrMcmzSCyQmA72W96JowdrWBNf0M4G9T1xP+cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gAAtAf
        DZQ+SVtFKSeugyWhxxrLY/NxMX+mMNTVPsT/U=; b=M0DohbovIWDD1bWxoDhkxy
        T9LEu7X86W9MmvWjNdgqVOFLhsSRN+ZWXQy6Wls+fuKnPNGAYg8QIeNpsndgF9h6
        zLJQzuWQYOy6N+8utr5x1aJvV/sgWKwwxHFCXdfuO3yt8a21J4BrRKDNM7VqJwtp
        1DM2OLwg1qLwwGyNe+6iOVHfrUtPmZgKghUsJidvV9fmpoDvR2gD5+HfbvzM27R0
        KUQ9P1fRyKlD3gwxzDUhsLxmFC0eoTHQPFgeCzOGwrR7th2vv9z/Ky6E7qYrjLOt
        UDNPpoNjkEuhrKGcjRgvRDkdVpvOwKRyoq+HtnjRoRz+1gQnNgS5K2PqUbgnWP0A
        ==
X-ME-Sender: <xms:jSx_X2TpghYd1nNGNObRfTFbnG0MONf3WfcZCkPmpz_CILEyGdzRXQ>
    <xme:jSx_X7xTk1vZjIij0thdOGWJcQ6izMXVyfIVm6slysvvIzBR5G1fptmMlZZNVfRws
    aasPtqnB3xjVhpqamk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeelgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:jSx_Xz3npYtFC2qZvMe31ePg_HRtFZBuf-ayWb_Yo5zhSafsFSsHYw>
    <xmx:jSx_XyCvg9pnKAge1x9fS_T9Yn4gsxz_r8B0hSLsyO-xJrJ-BoJAkg>
    <xmx:jSx_X_gULMdXsTiWVlMA0PwMV4laswn-MMV2F0PSpuyhxkRwcHW8qw>
    <xmx:jix_X8tSwKKBPIe9VJfv_trW0I8cmjjf3Yyww1PDyCaGrKN7Ad-3bQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1FE33280059;
        Thu,  8 Oct 2020 11:13:16 -0400 (EDT)
Date:   Thu, 8 Oct 2020 17:13:15 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on
 Orange Pi Zero board
Message-ID: <20201008151315.v3geykbs6musl4wq@gilmour.lan>
References: <20200929083025.2089-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3jq5ty6aibw6pauv"
Content-Disposition: inline
In-Reply-To: <20200929083025.2089-1-msuchanek@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3jq5ty6aibw6pauv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 29, 2020 at 10:30:25AM +0200, Michal Suchanek wrote:
> The flash is present on all new boards and users went out of their way
> to add it on the old ones.
>=20
> Enabling it makes a more reasonable default.
>=20
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm=
/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index f19ed981da9d..061d295bbba7 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -163,8 +163,8 @@ &ohci1 {
>  };
> =20
>  &spi0 {
> -	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
> -	status =3D "disabled";
> +	/* Enable optional SPI NOR by default */
> +	status =3D "okay";
> =20
>  	flash@0 {
>  		#address-cells =3D <1>;

Unfortunately, it's optional, so there's really no reason to enable it
all the time. If it's troublesome to users, then the distros or vendors
should make the changes necessary to the hardware, bootloader or their
documentation to make it easier for those users.

Maxime

--3jq5ty6aibw6pauv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX38siwAKCRDj7w1vZxhR
xcSAAP9PvkQx5Q81Zhhvzgn+tmPzl7bCxG1cUlqZZ+/JGJt+TwD+KubY5HG4h852
7ppZm294af5hYuKgY0iPbBpYbxNuYgk=
=OfOL
-----END PGP SIGNATURE-----

--3jq5ty6aibw6pauv--
