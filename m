Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BD2833BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJEKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:00:09 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56401 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgJEKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:00:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CF915C0151;
        Mon,  5 Oct 2020 06:00:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 06:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=OkalKsYC1I9mUJOEmR1LdjsZfF0
        kOEsXJzQ043OLR8w=; b=aOWrR0E2JdWFTAXJMTjYqd3qiJ4sokh7HisawWITMIh
        dTN2nw7fFEp1DgVKoNDnFvzz8/t+H9pBjy3Ao+RHJEm5+W5tl4fzlqcdG600S6BJ
        iq78oQf9i6RhyTrRNeGLbmvPTRfh6zUsqY7LQFAAZ5P/wvdgRj0sRrUHG5oKJH3a
        DRg8GawAjVRiNFgtuGQ2ZgdKZcToLcOr5lkORI4waUPCuZ4vvfekj1I+HoSll9Dr
        6ETjClPq0p5ByfuWWiuYKoafpYFDKjIy9/8hQXYfAmh+EcLfbgtHZgeMZXUkuUNe
        ZVg7JWvsmL/UhO2yKEDsoYQtmW8HFl/nZCb+frx0HTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OkalKs
        YC1I9mUJOEmR1LdjsZfF0kOEsXJzQ043OLR8w=; b=HQStkGu3GyQU7LdDHZxUIQ
        0vGsH4uiwJZBov6bkh+M/BV/O5jA5192wb4wfPPj60N9l+2ECjU7Ka7BOHytmu2x
        yM/PqGfciCI92E5+PSzocrVDjUK0W+Qo4FR784AeCDSBwVlSs5BcN9VkgeQSgRsE
        SzRaO+NHMopPDWCjwUM26YpY7vtCGIxXu1HoT1t0//96s2Fpw80FwtDFChBzuNit
        B3uabfDQfiGcHCa128zg0N9D3fZ76B7iokU3rKLf6DTSZjzxqGNhoqqwpnDEVtWI
        sU7pLtPd2Zys8UkDk9WY1SWlfhhkswvh3j03NhDQJ6MfCxubgJuy2M9KjnGXDj1w
        ==
X-ME-Sender: <xms:pe56XxR7J0bC7puamwq2anIrCJmPkC7eC_1DVN6M2UaVQ-JRBPmhJQ>
    <xme:pe56X6x7yW0RxhLMz2SgIPc9Zvisd8LPjvJaWvCiofVdVyiUOQAwCcDAxKQANExp7
    fDI1398_CqrouEb9jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pe56X22I1uViTGolferX0dYuWtOf7PsCC89SYk9akwswfFQdtpfr_g>
    <xmx:pe56X5BwSSqo3L2yBg2FR9ivre5PVGJ-uOTL4jHz8DchmP7tpwZ46Q>
    <xmx:pe56X6gRat1W3FotzUNHM8-lSfeNCdi1hj0K_4fhKfJf7LbTb7szCQ>
    <xmx:pe56X-hIee_jIVdY3JM299PvZFuNTLOIAealkm2wTeAE2rNmJic4qQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D8F7328006B;
        Mon,  5 Oct 2020 06:00:05 -0400 (EDT)
Date:   Mon, 5 Oct 2020 12:00:03 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/25] ASoC: sun8i-codec: Enable AIF mono/stereo control
Message-ID: <20201005100003.5vm5fyia6z7jy6vy@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6tyumugaboxyzjvd"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-8-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6tyumugaboxyzjvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:30PM -0500, Samuel Holland wrote:
> Each left/right pair of AIF input/output channels can be swapped or
> combined. This is useful for sending a mono audio source to both sides
> of a stereo sink, or for creating complex mixing scenarios.
>=20
> Add the support to control this feature from userspace.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--6tyumugaboxyzjvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3ruowAKCRDj7w1vZxhR
xRoGAQCImF6eXM/9UsszE1OYSxKKguMMBJ9/viLyw1jmI622yQD/RbZlnXWV2O6p
uhmk8NRYSjZ2PQV2vhNRHLbAU208wgw=
=6tYn
-----END PGP SIGNATURE-----

--6tyumugaboxyzjvd--
