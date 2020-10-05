Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39D6283558
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJEMF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:05:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39915 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgJEMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:05:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A3CB95C0190;
        Mon,  5 Oct 2020 08:05:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 08:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=DdtczL+cYcTx9dQiC0gmku2IiM9
        cruIOpdGZSLlZsB0=; b=NkvetsvbvNMllOJjzZFcK7yulRoWdDiPLp1kw287mEH
        QDEkPnIJej/7agQOUmWH5kghRYKOlZHuE1kCoxSfUp/fHCY15C8xBRSSPY9hXLU9
        go9jD2cy//wfGPtWT2DF0wP167QtHdpoFt2EN5d9WfuSLhbckO8MvepOX5yNyJAH
        r58bKjl69PdZx+FOsv7q2b1XzKEaYRmgiKWlS4UwQQzUCY5K2pp+SKl9Tin+sDVd
        JUN2ZsogOK0l4dkUDYf7P/pb2e1ll8mKb8lGJyfjOjxFj1FpQwCbPTTeLEM+LfGL
        raa9mY7+MGT91ZA8lHu6Ia5Xa52vJWSYuO/UFs+GZYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DdtczL
        +cYcTx9dQiC0gmku2IiM9cruIOpdGZSLlZsB0=; b=VJV5AmwKP62lIHFIuFptmd
        oj2afs7m1NrNuJBNEXy0s1xIh4fLqg7rcR5D1F6NCjVKfYdBaIXO/swElsyCQZFA
        sfiU2BIsn2F2/+G22vAyo2tljgK63NnhRlpYhtxlELfv2LgkgWAZ1SGUuEtbS3Sy
        KNNTLYrsoIsQprg4HJKwFO6VaJEQdc8BvyRjet27nQngi3Y01WmiH7DO9wMS3jZb
        JBGKcpWlTrO3TggYXIqSKDpg0cEftn/lb/Mo1Kt22hED0FlnykG/PkbkzFZCj7O/
        GAvkJppoq/ttf/+Jh9O+nPgjw3TvRJacg9ekZbncCrP4FrgFF8USpuMWEeiZZK3A
        ==
X-ME-Sender: <xms:Bwx7X0WRzGZjQ5gs7OK35u_O6kbjMRBzL1mbXxoegZh2Etn7aET8mg>
    <xme:Bwx7X4n0L5nHfwbcTg8wQZQ5vHtSB_PGxoh1DgHa2wRYCxXDa-d3Uf5tKDtV1BZDf
    aWAEumKOw3WIJJ3Vvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Bwx7X4aMyoIRaAqYtuQMz9cx9x9vLWLefa87URDoicqVf_GRCIrpRQ>
    <xmx:Bwx7XzWl6a4DHUN0uI7u8f49Zk3Oxnvx2hbNfjncsVNZRE_PWhhKFw>
    <xmx:Bwx7X-m5COMg_DOGDI8AQMRwQvcvVl8yD0yt-KuRQ2olb4W5uTcaCA>
    <xmx:Bwx7XwWzk2WCsewBI3950WDMRFn17iAEjy4RIPdezmutM6DmznHDxw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 385643064674;
        Mon,  5 Oct 2020 08:05:27 -0400 (EDT)
Date:   Mon, 5 Oct 2020 14:05:26 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/25] ASoC: sun8i-codec: Add a DAI, widgets, and routes
 for AIF2
Message-ID: <20201005120526.acptx6e4hcdlj5pj@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-25-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gsxps3a4pixzmtrb"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-25-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gsxps3a4pixzmtrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:47PM -0500, Samuel Holland wrote:
> This adds support for AIF2, which is stereo and has full clocking
> capability, making it very similar to AIF1.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--gsxps3a4pixzmtrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sMBgAKCRDj7w1vZxhR
xWTgAQCyyHGI+XTOmFHzVwEN6M+nYXVb3e/3CuD7P7RGSFJ0LQEArkcjfH3wUxfV
R3U2LAYKxa8L0lkwnb27cwGdCgrjJw8=
=ewTZ
-----END PGP SIGNATURE-----

--gsxps3a4pixzmtrb--
