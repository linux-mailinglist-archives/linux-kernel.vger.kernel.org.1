Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478792A2823
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgKBKXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:23:14 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45173 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbgKBKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:23:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 81B70F58;
        Mon,  2 Nov 2020 05:23:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=YuURcf+7tOjKrSfDQk94W3WVSnj
        EFGfT9fSMDlBxuys=; b=Cv8DsezNjjH7PfKp4JRLJuJDWoykiAPejFTekHs1BOw
        nPbYJjCvI4tfn/PrY8pNO6Btr5JyVjWf2aFf/9bUuDsgufsYyAqoJXs0WJjpyQUJ
        QO55A91sz83WviL4U9ElRM1R5DM5/Hj8TloN8BB7/FF8VTD7DkfvbBZbIWEjGGoi
        uHbXCSZcJUPeRhRF/XtDZu59fjgBbt2twP8UC8DdfZjCaEPXtc+GSYO9y/o1zIBI
        ZLTFPyOVZQprPjKTuVs34c8sd2ICHlBtxi5t1K7FeYmBTwymt1lBp0M1jkW4nwgn
        BRQ+m1kUbQNOWq4ONzGbSPYkzRRtvF0jvPZlFxSv3wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YuURcf
        +7tOjKrSfDQk94W3WVSnjEFGfT9fSMDlBxuys=; b=aIe7no/wQ+tJOnbYtU0fdk
        mCaiGjSEe3eH3geNz4nUdhB7ajHyIbMncda3LQjyICJYyFEnSqLb54QWg4u85Uwk
        lctRavxCP/zzjxpVh/7GwLqHdX1Uw3ZxCc3eGzH7ugJrihCY0VyikiUyCNVGDBmz
        3/FvphlxJWE+tNnj4jxtPkR9tKSoI4mHdZwPhMuokQVmj8sauTDtoB+paIrz+g5V
        BNQ7G7ZZ5lQTodU88Pup/tg/CSjHrZruXZOa0EBkwYw+mBBOgCMvAepVoacY3+3l
        q6Ihi/EKxqqFZg7ax9heI3GAJi5hgdBBJ/s1MTST2Cpooe2sPQOP5bXFOVg1x5ug
        ==
X-ME-Sender: <xms:D96fXzI7axdnbj6n5bHSitDJ9Dw_x0tDSr-aGzVy6lc-2PKBFBuoWg>
    <xme:D96fX3I85YWlSh2l1Mn7Hs-FDZUnpX5dhDBoDqHrcPH1p_XGqQ-7AXYMCQ99HgPZN
    8MQ6ojgohzGdapdgPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:D96fX7uAYYN9MyJeu723HFPxdDXljxSR65Nab_gh8zACYTsDX5QLKA>
    <xmx:D96fX8Y9c6Ue_9eHP4tPaBjtzFh2RdH3LT4H3aRkgJD6mQzmmQhjzQ>
    <xmx:D96fX6b1XN6FhGdHQwY57aMek0TJ0QnXHvXBn03hZR_P57K1hIxSNA>
    <xmx:EN6fXxUDLEe3HtG6fAQF7TGFAzNsADYt--sh4FaeY9ugEY51wmrnug>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94D84306468A;
        Mon,  2 Nov 2020 05:23:11 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:23:09 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: PineH64 model B: Add wifi
Message-ID: <20201102102309.xbrqfszpq3i62vor@gilmour.lan>
References: <20201030172530.1096394-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fj3fhevzjxjy2rgx"
Content-Disposition: inline
In-Reply-To: <20201030172530.1096394-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fj3fhevzjxjy2rgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 06:25:30PM +0100, Jernej Skrabec wrote:
> PineH64 model B contains RTL8723CS wifi+bt combo module.
>=20
> Since bluetooth support is not yet squared away, only wifi is enabled
> for now.
>=20
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--fj3fhevzjxjy2rgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/eDQAKCRDj7w1vZxhR
xRfPAQDGyuAJQmmdszu3SSMVCP3kyuqLOJeYvRUexBCpSAJkJgEA9Smgfe7GGqAR
59ntEcW7DK+VeWO9tvAnxxbaONdQsAQ=
=zusj
-----END PGP SIGNATURE-----

--fj3fhevzjxjy2rgx--
