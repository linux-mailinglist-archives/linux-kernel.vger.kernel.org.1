Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26043283316
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgJEJVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:21:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46901 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgJEJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:21:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 681455C007C;
        Mon,  5 Oct 2020 05:21:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 05:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sYQ4pzNC9cqjDeSD0R7YfK0ytjx
        0ArPJK7bw7Rbe02c=; b=V/yRtJwIuJkvBhIW6m471SjLopz0p5B/VQRw6PwrvK1
        PxsXY5cbvbetzUaj/K3y89Q485VMGSPe9HliHKp3b717BzxEFEg2Mfdl94npIEJx
        kHsMKyAhXSnl63SD42ACbLsEDy9gkHKgR4K/5jlEbKKVb+aXIAd+cRUPuCu8mXoO
        bDLwEwgiIxPemN1/Pp4LypT7iD7JhqanisZlEpwXjJSdQokJ67L7L4xhR9mTYIfU
        5z3GTwqPcCF/u7lyLJDAw6h1FfDT5EA3zvKNypxhCC3pDlSqpNhpCHYQN/5REhdX
        HNcjoSgQIOYXGTNcOMzzz0003sxwy4nTU8TD1g2vZdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sYQ4pz
        NC9cqjDeSD0R7YfK0ytjx0ArPJK7bw7Rbe02c=; b=Ab6a1sqKkBwQiX2oBOs7fe
        4Y8r4ZWpvs5hEBacaAc1Bw12Mj5BiRdXrlrNXivZcX5dEyEcw5YiqFQVzTZnUWjI
        HTlYIfhcYhDIsSp4LbA3LwwI5X+gVeECKDsUChbxY//LlLpJMADskkFbYYgi1diI
        5zcGFFAUf5tTuYC0TxyYjUA17t8u7O4IVBd808G7ZuIWuttaffmbfpDvgi5CPFvv
        Yck3PMqGR1zM/vJsdojo4RHcohmLcQey0PoW0/e9jd5mNQuFIiQGq89ljY4W4Xpg
        w0BPebhBGXXyYe9GsLJ3dFQHGsw5vu3VmgSjPCwSq+I9eZV4IrTb7lOLrLRRMaUw
        ==
X-ME-Sender: <xms:q-V6X3XMKBY1TFrHmtiLBG6hYOx93t5AU7bSLGBb8jT5PKQ8vWZ05Q>
    <xme:q-V6X_lH4lC-np9EeNTUyfQFRBP_rA-V2HIgGpTIzkECReDfqtMLM_dWiquc-8UHZ
    FuE_xxp7yOQo7IuPI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:q-V6Xzaz7vv-yHYAHqdxYUpDPPFk7ngYcYleBxGEqRDF-4aAk3RmTw>
    <xmx:q-V6XyU-UAh-x6-z1HETZJFFq8-QuZjgEvyF4Ccn8UXKxT4sJH1DWg>
    <xmx:q-V6Xxl4Xz7Uhre-KD5icrf3lgCCsCTWJSHXt-zI51v1x5YtdKsQPw>
    <xmx:rOV6X3iipoILxEiC-_yIVbvZGiWrEkXDXZ9GG_Y7v4x8Q35zh_2-NA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 392CD328005A;
        Mon,  5 Oct 2020 05:21:47 -0400 (EDT)
Date:   Mon, 5 Oct 2020 11:21:45 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property
 for Beelink GS1
Message-ID: <20201005092145.wdu4m4pwxydv76ou@gilmour.lan>
References: <20201003092001.405238-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c4ix5n55lrdh2mia"
Content-Disposition: inline
In-Reply-To: <20201003092001.405238-1-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c4ix5n55lrdh2mia
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Cl=E9ment,

On Sat, Oct 03, 2020 at 11:20:01AM +0200, Cl=E9ment P=E9ron wrote:
> Sunxi MMC driver can't distinguish at runtime what's the I/O voltage
> for HS200 mode.

Unfortunately, that's not true (or at least, that's not related to your pat=
ch).

> Add a property in the device-tree to notify MMC core about this
> configuration.
>=20
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
>  	non-removable;
>  	cap-mmc-hw-reset;
> +	mmc-hs200-1_8v;
>  	bus-width =3D <8>;
>  	status =3D "okay";
>  };

I'm not really sure what you're trying to fix here, but as far as MMC
goes, eMMC's can support io voltage of 3.3, 1.8 and 1.2V. Modes up until
HS DDR (50MHz in DDR) will use an IO voltage of 3.3V, higher speed modes
(HS200 and HS400) supporting 1.8V and 1.2V.

The mmc-hs200-1_8v property states that the MMC controller supports the
HS200 mode at 1.8V. Now, I can only assume that since BLDO2 is set up at
1.8V then otherwise, the MMC core will rightfully decide to use the
highest supported mode. In this case, since the driver sets it, it would
be HS-DDR at 3.3V, which won't work with that fixed regulator.

I can only assume that enabling HS200 at 1.8V only fixes the issue you
have because otherwise it would use HS-DDR at 3.3V, ie not actually
fixing the issue but sweeping it under the rug.

Trying to add mmc-ddr-1_8v would be a good idea

Maxime

--c4ix5n55lrdh2mia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3rlqQAKCRDj7w1vZxhR
xZMxAQDNyd1ZGwKGk+fSv4NeOTTL+ZLS6HM+lF1zM9gDmNYgVQD7BKqG2TFD8s6y
Wl/7bqwW+9JdvOkXwEoqfyACLdYuRQQ=
=JJEw
-----END PGP SIGNATURE-----

--c4ix5n55lrdh2mia--
