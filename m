Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA727E692
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgI3K1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:27:37 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40535 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729018AbgI3K1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:27:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9477F5C007C;
        Wed, 30 Sep 2020 06:27:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 30 Sep 2020 06:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=1y4Y0NHZAXecbtxa1zV02fr80/8
        WXgLtRma17gWfLkk=; b=TJ7FBPDfGxi5+eE/Bo5YTSGNZbhRZVl/DlsW9iZFIGY
        Aevz23PpsNdYDLHemYmpY1NnxitOyrqaHM0t6TaGieDNRLNYqOurBIDp2ZYjCO+c
        piTRpEqPbVZN0H5O4QVWtMi91aamtv1zhoEk8VXpNETh23FIFiVwdPm2UWJkXN7v
        hCVplBYKeXzgFAg+uHYNwJqR/T+hOrHhFOeL+dXFOivWYj3gc7O/+DCSV5DMkzig
        rMB9uHx3k4w0V1FPlM44u+8ZO/H5o9SBQrMW0TQ4a7/aGMhiJOITlhovKZbPZZwr
        QysMqTz1H4HcPgf4c7HT2aKMHwNUPjjZiNx+jTaFTHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1y4Y0N
        HZAXecbtxa1zV02fr80/8WXgLtRma17gWfLkk=; b=IbORayQHzOnV8n6WFxaKS9
        lFh7SOu5Xrbc9ODFv1N/l47kWHn+ehB5GC5svKIZCVOI+vGrgdu9gdODdsnIUab2
        CndzcNyhMjGxqjJ+fCLF6IVcc071cmMdmuvAuuPZougVoq9s6xX2yJLh5WiIXs9V
        HXHm9WJFL6HMrNJsvfWHtH8KbVCiGC5BMluVFskZ9bk+ZcZlLU1VdbQldNPfTV5r
        +bR6becco53rM7PcL+PDkndhzTLa5CL+z8qNGezsc/cqZjvwlY2ZDPfBVN7BsLNR
        Oknl8hzf5wuHua05FwOjg3aOTFCNQNe5aArODHC+hrvl2Fzh+DPVOO5AZLc6GsKA
        ==
X-ME-Sender: <xms:ll10X5qI_R_z4PzkPO8kz2l_ldbCqwrwmh6raWjXHQZnBDfND0B-Ng>
    <xme:ll10X7qhmylxMCk5i6fZ28im3aKwNesF9etS5U7akLOckopo9tjCIEmxLaquq1n5a
    IsPjCapNEoKsvQ296M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ll10X2NQaeWdDnTsxjo3psTsUg5zgF6ztRQKBmE9J1csH3qns81nsg>
    <xmx:ll10X06YN4bnc3MBS1ZCrocow_ewgrTerZ_D0mCor_qxAbsjI6YJDg>
    <xmx:ll10X46xrWDhbMBpLqKDVyK5SFiPRGIMTgdMyahnePATZsk1yODXeA>
    <xmx:l110X2mgRXFI2GLEeLIjV7Jmcq2Duw67J3CYFwALa1vg7SftdAuZEw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C63963280059;
        Wed, 30 Sep 2020 06:27:33 -0400 (EDT)
Date:   Wed, 30 Sep 2020 12:27:32 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: add eMMC voltage property for
 Beelink GS1
Message-ID: <20200930102732.zc3vs4vzm3fyt5dc@gilmour.lan>
References: <20200928150038.97413-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6lpxdfuiykpljni3"
Content-Disposition: inline
In-Reply-To: <20200928150038.97413-1-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6lpxdfuiykpljni3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 28, 2020 at 05:00:37PM +0200, Cl=E9ment P=E9ron wrote:
> VQMMC supply is connected to BLDO2 which provides 1.8V.
>=20
> Let's reflect this in the device-tree.

This commit log doesn't really explain what is going on though?

> Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 bo=
ard")
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 049c21718846..3f20d2c9bbbb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -145,6 +145,7 @@ &mmc2 {
>  	vqmmc-supply =3D <&reg_bldo2>;

The Device Tree already expresses that the vqmmc supply is connected to
BLDO2 which provides 1.8V here (together with the reg_bldo2 node).

>  	non-removable;
>  	cap-mmc-hw-reset;
> +	mmc-hs200-1_8v;

Whereas this indicates that the eMMC supports the HS200 MMC mode at 1.8V

Maxime

--6lpxdfuiykpljni3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3RdlAAKCRDj7w1vZxhR
xSesAP9s9WAi1LMpMRDxK5vzmj9DgMppelaptRFG3PuJh0gWFAD+JYOfwFY0H7ya
8OXTPwa/4b3zt5HyzazAGeoEnAtqwAY=
=Chcd
-----END PGP SIGNATURE-----

--6lpxdfuiykpljni3--
