Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE22A27AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgKBKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:02:56 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57739 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728399AbgKBKC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:02:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6260D666;
        Mon,  2 Nov 2020 05:02:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=zpljOXRNjJmtz+RWG1ZKVvy5dTE
        lHZ40JTol5BCuz3g=; b=Qx1DnfEwMxSBuB1wrPjxWtp4LeDXlzl6HTeySj5Whfx
        qFZFHw6CZqEiNHb3bXfx4lilZtMY9wDptHWO8bQFDhYRv7e8Em24kViCoUtBPIFK
        +zSEsRlXlk50SPIGDOFPAz70rby+J76HlI7K+2Jy7hK7cKpqEwjxzpSS9/XxJrUM
        dopApgwjOtmzZyFQu5geNGr/62OZmkjWGo8DT8KcQhJKwTPGLN35HTzoLZhhcQyc
        jkv9q0o8iX0FBr16l9R41JGhD31+/0eBjvITRZJmdzIXOcVtMkhXoKgMsTu1d3qM
        c6N/NgGSQ/0BBYYwEp/QgROlaIn6emV/gvuD7EDE9wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zpljOX
        RNjJmtz+RWG1ZKVvy5dTElHZ40JTol5BCuz3g=; b=p2qVNTyDlfLn3ZCtD+p5d9
        AYotlAXZrd8Iq4yFRiQaNRpQUo03arT0+NgGsa6oI/1DU1fy0+zhXhx5nB+KCT+d
        KtYtv9TEZN9CE5J5GZj6tS7c7s3BsbKcZYk+DVLsdvGw06r1YZLfIvRG0G+yyi/E
        HgxICNgdEukAxwbnJt+oh1pyMbuPb1BenCf5KD1ZxLRtpaKKsFrjeRDSOP+UCadk
        C+lJ8eXb+9AkXpD591ISU5GtXxMwtX7rNTBVhgws0fa0yWgFYnF3onVUqZMdZBTH
        nXb0LhMFth+YSYF8Mrl4DiCIWXEXMGGxjHtl/NhvFHDMgyqbPgb5uwvZyQhGbZ0g
        ==
X-ME-Sender: <xms:TtmfX4MqKKXk_NWbA2uNjViZSRKdmNVo3GALoy04mXZCPQU-kbClIw>
    <xme:TtmfX-_nBXtjwikVLmWfo790lLmWtblsjn8BikrCUFju-Uq-e8O26PLiJ3ilX_inD
    hn1jJe05BkYDqrznIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:TtmfX_TSmLkLEvNBUtJdqIl5BtVT2InASZPW9U7Mn-_nrep4pXlGhQ>
    <xmx:TtmfXwt2bKnJUcx_LVOL5kLyzZzcSsyfiTqB2wpei5OzevOEz0HeXQ>
    <xmx:TtmfXwfpoy2M7H5twEg0IGnul5sWEzl1aGfIBIzqKWevTBnxRXM12A>
    <xmx:T9mfXxpwqnPdAXtSRRZVi_aOjm5cxWJD2w54dAsHA9dd8ZxzxkSybg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C9FEE328005D;
        Mon,  2 Nov 2020 05:02:53 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:02:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: vendors: add Elimo Engineering
 vendor prefix
Message-ID: <20201102100251.24smfjcacozmezoo@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201030234325.5865-2-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a36i2h5d7mawxdbs"
Content-Disposition: inline
In-Reply-To: <20201030234325.5865-2-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a36i2h5d7mawxdbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 11:43:20PM +0000, Matteo Scordino wrote:
> Add elimo as vendor prefix for dt bindings, since we are adding a dtsi
> for a SoM and a dts for an SBC
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>

Applied, thanks!
Maxime

--a36i2h5d7mawxdbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/ZSwAKCRDj7w1vZxhR
xTzYAQCeFZycDnWmSd3OAdjhxqyO0w+/rewzGiT/k1aGTFF6fAEApZPb0afFwU6g
miRWBJ74QREX9FrLe/u9kojgZaKIUAE=
=Xni7
-----END PGP SIGNATURE-----

--a36i2h5d7mawxdbs--
