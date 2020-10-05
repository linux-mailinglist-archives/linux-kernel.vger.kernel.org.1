Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A407528353B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJEL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:59:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58431 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJEL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:59:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 75EEF5C016C;
        Mon,  5 Oct 2020 07:59:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Q897tT8ubWR5jUvQHUMctBSuXaQ
        szl7lev1kFoxWyhQ=; b=nBJWnvAoK//RQnwLHXVaamj0TZD9axahq1PvmX5oHKr
        M36gVJsCWqz41mlvuiyrdahIa6RIFu+rjqnS6Q4IeOuxJ9YSWT1LFtJvy1oJzVXC
        4TQlUB5coV3gndmt1zAyPiy4mnhyyLhtmNLEevKcBtJLxDaKfxtOnrcTBPuMbTwG
        53DnvBE13EsTHpDdiyYGQ3fqc8u/iVG2p++1T8Ebq0joiltou73sV+occKfYNWtS
        p/1ChINJUiGupAN+Ok7heLIARXM6p7Lju2Hors3NB/q+m0SYDwSpk7zHbyaPUrkc
        g1lwZjBF/SMump/EdW64S3WsOPDocsy9AAic1RkJf+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Q897tT
        8ubWR5jUvQHUMctBSuXaQszl7lev1kFoxWyhQ=; b=VbgmYZDeg7gS6JS4KpsvwT
        wPGqZio8PmRNgsW1zCx2NfX4lK3GIw0IQBIHvPpHlWN52Ts50XOs+Xkdf94QUVXT
        cmoRVVCyQWA5LG4dZkfHSeJuhq8YOHfMlP0CTCr4bO2D7VN7s268A7jQ0Tz9PZyo
        Rt4pAZh7Xv1mA5I4nZXTsXeIIpQJCusZFAd9mJZbGCDbedWjQRtcxcPzmV0bF60w
        9YmaAD4s3lN0SSDlf9UVCUD5Z6VMEY7TzdrF1wy+x6k1nIjJ37DB0IV1h3u3pfUq
        mFz9HighppAr+gC6d10h9eI6mcjKfRipdclX7cdVccyBErqPThF1L16z9SOkVhzQ
        ==
X-ME-Sender: <xms:qAp7X7qvBgwkEkBzGgVCocJ4wXxLqun9B-Xz4I0_vS6Ger5FJauK_Q>
    <xme:qAp7X1oKKLSNKuejN2ppXJWs1t3XzgQGwCOooQG5QoBTMwwFxFONnNAdQYQF0xYDd
    od0-8kX7x68psTytv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:qAp7X4OcsTxnXkJ_gzAGsMXQdtRt1DJnL9z_hZX9Yz4ILOK2KvLcog>
    <xmx:qAp7X-7B5JETdLWROqkH20YfQNtdsAMp0DbWK5cUZjI6x0LtMBXYXA>
    <xmx:qAp7X64qTgzGUFCZG58FkLzn5LUSS21LTjyg7Sda5VfE3vVsTwIBSA>
    <xmx:qAp7XxbfcHH6sNNMZuSMnuEZGqNdulTb9aQIW544eq2QD-4nW9muiw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB4433064610;
        Mon,  5 Oct 2020 07:59:35 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:59:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/25] ASoC: sun8i-codec: Constrain to compatible sample
 rates
Message-ID: <20201005115934.srtcf5f74kfc4rol@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-20-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="svg53ayom7l4t3od"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-20-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--svg53ayom7l4t3od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:42PM -0500, Samuel Holland wrote:
> While another stream is active, only allow userspace to use sample rates
> that are compatible with the current SYSCLK frequency. This ensures the
> actual sample rate will always match what is given in hw_params.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--svg53ayom7l4t3od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sKpgAKCRDj7w1vZxhR
xd9pAQC/j8ToJOZuhDga2Xzm9h4rkaQuXqqemTxlrn3E4pb0LQEAreN/HZlgti9b
CM2uL2AYaJty/gHyCrfWkzutUz57CQI=
=CK7x
-----END PGP SIGNATURE-----

--svg53ayom7l4t3od--
