Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C452A2C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKBOKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:10:21 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60265 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKBOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:10:20 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 11971E97;
        Mon,  2 Nov 2020 09:10:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 09:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dpGVrUN7sbNNdMBO00Igg8XQCXh
        zbGHZw4VAOKfwtSc=; b=NmIr3HRzYMgzYCEbdESzMfYJrU0Kj1SUWwCRnJtt5zR
        jfh8sWJSWn4TQuZ7pE7QHkuvOvueILyAfVVu2OS71kXvkth71JEZzBO9A19ZZyqC
        3CEAOmHWKwA5zqcJIQAVnRGJI7HPdlAXZnu9PH+PBe3E9+UzYOtkoFccnSyPAu2e
        0dNKwMEaNevi0N2kPWed3DxLJRTqHZ3K0c6H61Vi3jcHXVY/2p5gSBKn/JW4lYSU
        bTT24OyxdMPvFEOMrgzi9qT0WHQRUJF3JXaQu5NPDrx75JdeBYWf0/+pJ3Nfr3Ss
        be9kmWXbkGGgxhhwpGT2pNo+4kR4P7ngBSekV3u6gDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dpGVrU
        N7sbNNdMBO00Igg8XQCXhzbGHZw4VAOKfwtSc=; b=n+eij2smEm+gpDH/36irax
        f4cxCovblUmCwqoUCVaTeyb9uVB0MKv13uX7/BQecurOhlTv0VBRkl9O9xgESpkS
        X3ADUHnF7K5yft2Liop4cajF1HQNV9CJt6FXxJycLoVF9KOSw4A6/Iw8ZRICt9WL
        5FQ5jSpB2l9UpQTteQcQ+ZRWZ04UcbwQ3DhlW1CQ08LkbzVdmGJA3TaIf/57t0FV
        C6x2PALBjaZdQmhz8SX9568mOndcX5KmtdcozCONCvkqprFFx7iKu52BJvgNAEMV
        PlhpraziMng6E0J/DS1QrupKTS5+U9K9mjbJ9ppqPVV4e7kLafJbxF2x1BC+kLsg
        ==
X-ME-Sender: <xms:SBOgX7PDFooeO1NL6btsjZAHTuk8UVh6hjszBojzxHxBJq5FBHfn0A>
    <xme:SBOgX19Bfir03GnNUyEiTF813ylJzQNN1cmcu1JsAdDqvfPvl9Ugck0-xu9xAtzwt
    jtEWH56lsdfQaBGkR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeekkefftdffhffhvedvudetgfdtleejveffvedvvdetgeeltdfggefhhedv
    ieffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SBOgX6SHcSPoY_wEJqU-NmcW6S1TtcgfKpalIuvY7QDswYVrBv0DUg>
    <xmx:SBOgX_uER5-XQGPo8b-LlXWy1orsnOiugPQEWQg4LtNaocbbB5ZsSw>
    <xmx:SBOgXzfllJDBGbHns1rKca56SrnffiyyLW00pxFlmjK4Xs11Jo8I2w>
    <xmx:ShOgX0Uz6-x_bCwi8N806SFF0Qp3WXlS84phQiXbpUV0vhKCA3syKm7ksiE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8CAE33064683;
        Mon,  2 Nov 2020 09:10:16 -0500 (EST)
Date:   Mon, 2 Nov 2020 15:10:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/15] Add Allwinner H3/H5/H6/A64 HDMI audio
Message-ID: <20201102141015.dfxrkd3tultmmqij@gilmour.lan>
References: <20201030144648.397824-1-peron.clem@gmail.com>
 <160408688151.11950.1284919768798155829.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubfn37nzngxzsnsr"
Content-Disposition: inline
In-Reply-To: <160408688151.11950.1284919768798155829.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ubfn37nzngxzsnsr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 07:41:21PM +0000, Mark Brown wrote:
> On Fri, 30 Oct 2020 15:46:33 +0100, Cl=E9ment P=E9ron wrote:
> > This series add H6 I2S support and the I2S node missing to support
> > HDMI audio in different Allwinner SoC.
> >=20
> > As we first use some TDM property to make the I2S working with the
> > simple soundcard. We have now drop this simple sound card and a
> > proper dedicated soundcard will be introduce later.
> >=20
> > [...]
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next
>=20
> Thanks!
>=20
> [01/11] ASoC: sun4i-i2s: Fix lrck_period computation for I2S justified mo=
de
>         commit: 93c0210671d8f3ec2262da703fab93a1497158a8
> [02/11] ASoC: sun4i-i2s: Change set_chan_cfg() params
>         commit: c779e2de0ac6156bea63e759481ee383587336cc
> [03/11] ASoC: sun4i-i2s: Add support for H6 I2S
>         commit: 73adf87b7a5882408b0a17da59e69df4be12a968
> [04/11] ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
>         commit: 9c2d255f0e63f8e54bd8345f9c59c4060cf4bbd4
> [05/11] ASoC: sun4i-i2s: Set sign extend sample
>         commit: d8659dd9a13ce7a92c017c352aea1c390f300937
> [06/11] ASoC: sun4i-i2s: Add 20 and 24 bit support
>         commit: 6ad7ca6297f8679162ee62ed672b603e8d004146
> [07/11] ASoC: sun4i-i2s: Fix sun8i volatile regs
>         commit: 64359246abe4421ad409be5b0bc9a534caa18b7d
> [08/11] ASoC: sun4i-i2s: Fix setting of FIFO modes
>         commit: 38d7adc0a003298013786cfffe5f4cc907009d30
> [09/11] ASoC: sun4i-i2s: fix coding-style for callback definition
>         commit: 08c7b7d546fddce76d500e5e5767aa08836f7cae
> [10/11] ASoC: sun4i-i2s: Add H6 compatible
>         commit: e84f44ba4604e55a51e7caf01464f220d0eabef4
> [11/11] ASoC: sun4i-i2s: Document H3 with missing RX channel possibility
>         commit: 0bc1bf241de551842535c3d0b080e0f38c11aed1

Applied the rest, thanks!
Maxime

--ubfn37nzngxzsnsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6ATRwAKCRDj7w1vZxhR
xSeUAP409mFvtehJOKw6zjbq/EI3VuiLjVcok4IzPRcqjtogAQEA98Jf5ouRTvsr
D9YlV4LZU6igTx7Wr3X/CXNsXsmHEgM=
=FLzW
-----END PGP SIGNATURE-----

--ubfn37nzngxzsnsr--
