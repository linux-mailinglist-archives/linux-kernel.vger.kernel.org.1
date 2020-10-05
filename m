Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C82833A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJEJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:53:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36569 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgJEJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:53:41 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BE5D75C00A8;
        Mon,  5 Oct 2020 05:53:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 05:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=a3Kdh27qJh0L6hcJBNIfK8XDjWN
        1U92ZxA5pBLTQkNQ=; b=RLVJ4IJRLOGpk+4jo7PUzRLm/3gU+V4Xxx6/IucSuD9
        zqeTc3ftNPpBKSNzX2wpv3C8hOg1fC6DK5ptPMf1bODUIWoU4Puch/9rTNxl11bD
        i6h3eIaX2WgdaVZPiIkYQCe/BDPakSBma85HkEXwpTVlvlXCqbWWl9p//y3ECsG5
        jNN4BEwX6xn5CgomnpYPVO+LJfOGdH5G0QseQ0DtDWGovyfdVJrp7UfdttdC5ANf
        uGrfwXaEENYUiKERnI02eYI/dGNoNV4U1wNqimwrZ3aJJNmWE4o3erz+VOkeiSkU
        x/OiTvVRM/0X6s+FjnTsa1oH0Zn5zGpJ5q5EJMXaIuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=a3Kdh2
        7qJh0L6hcJBNIfK8XDjWN1U92ZxA5pBLTQkNQ=; b=IfTt5C1EESiRAB5hH4okOj
        LyXyyL+xSwHo/9Rf2OO7VlMIyuyBeWSDWOTA8kUC1dCBGSLj18NFycLmWzl6nIPu
        PJs+xhCzNdCu5XCNL7YzhCPPWkzxTIv5I3AWobbU1KH1Gs+4azESwy1ozFBpEZK4
        kWBaFegYKW/NSRo9ThrpgOMpkSbGLq8fmlGh2TJOHuJfTPejESghM4GAafWFZCLV
        UulZHnffJs0ZqrSs/wUUj0lDEVjBbv2F8nHHNDoq3E4DzVlqSFE9dQxVYn9xkKQ9
        VfGSJD3oaArY/YLg/5zCH5MFRVSSjfYW4AdLRxx00vM80C3WcKNXXxgLt7j/rPHw
        ==
X-ME-Sender: <xms:Iu16X8fIFhhZXtXT1g18RAqsFdOWuIdmZMeA0KSFc8VtXEapHUqP8g>
    <xme:Iu16X-NigKuGwYkl2T7wEvc8T6NNq9H3H1Dy_pr8mmB-Om7usnljkm8vKpon3ovLe
    mJvXJEx3KLv6CK_4f0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Iu16X9hkJln9mreZ0CtghMaEIC0ib4qXENAa30kah66Mqeq-VZ7CFA>
    <xmx:Iu16Xx9s9v8tfXYKzhDcU3N8n9bI8upZ7QcWenJNV5msNwZ9VgGc5A>
    <xmx:Iu16X4un5ys88qxhXIXgpQUu8M3rWQb5RMhJMjt1i4m-xr9aeDZwMA>
    <xmx:JO16X99rpG3kxR5j6COCt-nKwhCxeWEG7yT1eHOIvK9kZR-l72wEzQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 68B80328005A;
        Mon,  5 Oct 2020 05:53:38 -0400 (EDT)
Date:   Mon, 5 Oct 2020 11:53:36 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] ASoC: sun8i-codec: Set up clock tree at probe time
Message-ID: <20201005095336.wzvdfjg7tyipiblc@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bfbi64475avkiovi"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bfbi64475avkiovi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:24PM -0500, Samuel Holland wrote:
> The sun8i codec is effectively an on-die variant of the X-Powers AC100
> codec. The AC100 can derive its clocks from either of two I2S master
> clocks or an internal PLL. For the on-die variant, Allwinner replaced
> the codec's own PLL with a connection to SoC's existing PLL_AUDIO, and
> they connected both I2S MCLK inputs to the same source -- which happens
> to be an integer divider from the same PLL_AUDIO.
>=20
> So there's actually no clocking flexibility. To run SYSCLK at the
> required rate, it must be run straight from the PLL. The only choice is
> whether it goes through AIF1CLK or AIF2CLK. Since both run at the same
> rate, the only effect of that choice is which field in SYS_SR_CTRL
> (AIF1_FS or AIF2_FS) controls the system sample rate.
>=20
> Since AIFnCLK is required to bring up the corresponding DAI, and AIF1
> (connected to the CPU) is used most often, let's use AIF1CLK as the
> SYSCLK parent. That means we no longer need to set AIF2_FS.
>=20
> Since this clock tree never changes, we can program it from the
> component probe function, instead of using DAPM widgets. The DAPM
> widgets unnecessarily change clock parents when the codec goes in/out
> of idle and the supply widgets are powered up/down.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--bfbi64475avkiovi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3rtIAAKCRDj7w1vZxhR
xc8eAP0bXlNFAgDQHOBfRxm3VEecjJXH/Mon6DpSnsh19/gbFQD/ef2AX40M1Qvg
8TTnjRMLXcsvCsCCrfP2ndB5hx0jjgU=
=i7U6
-----END PGP SIGNATURE-----

--bfbi64475avkiovi--
