Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C23283519
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgJELjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:39:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42081 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJELjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:39:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB2D05C00FF;
        Mon,  5 Oct 2020 07:39:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=4AhZLjFKEOusupGCr/OMydiBcPg
        aw3RrqYS1wR4Erto=; b=P2hwOPLnQJSxKifr01eJwX9kJwDBN33KdT2b0DLa+tn
        lpfXeNsj/vm0Wd9mxy7mN1V3DIiFjIL0nw8AR8TZWaaU++oSuakbKviaZnMFRa3d
        ijYTEzNfp6Hq1aw/lMVbae84A3RRT0y+k0rNw/UJluYDR7Z9gux8Z2XQSIwCJHr8
        5T+VjXDXhtRRaUA89qmDGQbRQrWWEUoeDTmk3ToOtfgTwx77F8u8W1lB72hqiTgP
        73f5KC4xHDHc4QimJ2mFzOFtbYCUxJoPXOaP8a2e/g2RbfWZmcmzbuC0YQ1r0cCN
        xH3z+Zpynn5KtOCJH8ZvvvpRPnWgiTnH7404O1EDvjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4AhZLj
        FKEOusupGCr/OMydiBcPgaw3RrqYS1wR4Erto=; b=Ub4y/Pk4MJLrc697Luo4KP
        270lb1nYL2kPeYjdzLWDd9/vpO3sCEM8zv01SruU0oGaLDXbwLohWgAD9qkPaXI3
        oW7rHLG02tuN6+XKjU23+d52gn5ZynH5G/fW16Ly8y6eU0lPqtJ5DAi+rUwUjoWz
        Kt1Zm23+BrTdsC2DPMaRQKC4xHKMbS1iIdxJJSoAsayNQsAz/F1Km8D2n7N9Decf
        HFkQnMkZfPErpVCL7VyJjMDAzvRMBb6H+8EsDH9X8T/twRFooN6X9KGdoJzpqZqa
        lXNhZ2YwQmbrQIDnaWjXQ2lkUo50WotYjx4CvaT1y7ew2zK3xwpUOvT9J8S7o1uQ
        ==
X-ME-Sender: <xms:9AV7XxqONFQWqUQj_bWdjTUr8XubKzhqDKn2BuqVyAvy96e0NRpZ6g>
    <xme:9AV7Xzr5-eW8rVxYB77FQkWMgVAN9lSCH7YroZkgoLRu9V6xJDNzAQAKaP_S_R-o1
    7vAqf9qLs-2po2iZkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9QV7X-ORMYZy5s7VqSeUdl-_eU_83ut3pYyot1VYgqvF7ST5G4DEdg>
    <xmx:9QV7X857VEhZ-tCbnt4emVhkvf0HeGXE_cn9r3om06v3kM2Jgawj1g>
    <xmx:9QV7Xw6PX7W5TgbA7kVFOeB9iQIJ0U4xHHaQ4msqm_wlkmU6vnY5bw>
    <xmx:9QV7X_ZFHPm5elaqsuS59KNBcgDmzuOqzcJXWOHmInnPiErlLXztxw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF9593064683;
        Mon,  5 Oct 2020 07:39:32 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:39:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/25] ASoC: sun8i-codec: Enable all supported sample
 rates
Message-ID: <20201005113931.djphs5lsdjujlzmx@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-18-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jruaklk2q64a4on7"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-18-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jruaklk2q64a4on7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:40PM -0500, Samuel Holland wrote:
> The system sample rate programmed into the hardware is really a clock
> divider from SYSCLK to the ADC and DAC. Since we support two SYSCLK
> frequencies, we can use all sample rates corresponding to one of those
> frequencies divided by any available divisor.
>=20
> This commit enables support for those sample rates. It also stops
> advertising support for a 64 kHz sample rate, which is not supported.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--jruaklk2q64a4on7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sF8wAKCRDj7w1vZxhR
xZkxAQC122WVocQPizizO35rpyzxgSrmH+hLpPcw4Gn8E8Ue8QEA/8+dpDZdPRTt
ygWEfyJQboRXo9aAtWzasJRMVkB5bQs=
=H99Z
-----END PGP SIGNATURE-----

--jruaklk2q64a4on7--
