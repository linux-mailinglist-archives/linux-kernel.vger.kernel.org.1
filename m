Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7042988FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772476AbgJZJBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:01:31 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42441 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1772468AbgJZJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:01:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B9E8E601;
        Mon, 26 Oct 2020 05:01:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 05:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=+/GZWhqZAcBw8iYVCDYF6ckTubr
        agdTsqcteVeeutuM=; b=Vt5NNr4waIUuRCqpS2ZyK3zYuAvr3Ff8z6rmpqSrBi5
        yF++56Yiakq6Q2x00SL+1QnZfI402hFXPxlAsPc31ZQWDROBxDdRHEJhId3yckZE
        MDx+PAgKpU3jUOwUnURf44tvGWfNVqkh7xMtLFy0Kkf7lWmk9GbZMMWwlmQeeqMk
        PBiYQ8jWLLpm7knb89ubSVIqw3KsStaBC6qohOP8+4qbg4tsLX63yGZSJsEmf8/n
        PtGdwN0oiaThS2O94ct9RcTlctsQYmWSMSG8oDh4+u2GR4Td543pjafefb+q/TAX
        8R4YNkkqwMPS++DCBz76ZvIKIOqmKkCVMoA5XbJmQOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+/GZWh
        qZAcBw8iYVCDYF6ckTubragdTsqcteVeeutuM=; b=CYzRm9mNv9aMde+zNEXhNR
        22jY8o6ciiJpbbGfuiKUc5DRu09UdlJ2dD2aJbkrXAN9ZCVct3dK7ktP/2E3+His
        a2UBhuriwkzkC1+I77x4EaJkANxTjb7EcWssIdF0c9S4SgjfuMs0xqhpuIoTz60t
        s135Y1GBC50SJ87gWRGwq7yoP+6XCDd2d9UPQ7r3Ptfe3bxePqKMoJI7rJsNNnLi
        5Jzo5TLbhm+F255AuZhnxAgjmMgzwhqokHcnDwDDtqebjR/CsqU07L2LFjI+YGYo
        E6sBwyBMCflSqD/6ATHuFKDY+q6SQ5K6SI5hRG96lx0tb5wqIJda+z38VVTR7GBA
        ==
X-ME-Sender: <xms:aZCWX_EdY6gyb-cd2t-Nlw5tj9cu4tI80eD0phT31ovEbPHuFyyNtw>
    <xme:aZCWX8VhPJ8_Hz5pycGg1bwu1pCjdusIIoNuHRT9h7rQV7HrTrcU95FJ6svCjqUax
    RmPS9fCAlccTvZFPD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeehgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aZCWXxL3iPt5X9GP7MASvOMbTLRcBz68eDBZ48Dk0Xt8QkKTRTglOg>
    <xmx:aZCWX9HKxsxXulDsCr0OHOMO7LFfTDMkMsdoNRTVrtyED_mWjIFetg>
    <xmx:aZCWX1Xlyz3sx75rkmL4i0JOb8SHHPmaNkArcuWa3AfEkHFc4qoDgA>
    <xmx:aZCWX7xZ6EHLbaPyYIjYtcVxe3yQamEZyPRewD1kiE1dAZCvu2BmiA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D8D8E306467D;
        Mon, 26 Oct 2020 05:01:28 -0400 (EDT)
Date:   Mon, 26 Oct 2020 10:01:27 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Pine H64: Fix ethernet node
Message-ID: <20201026090127.w673xfvfdquul5ap@gilmour.lan>
References: <20201023194902.368239-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mwdshxs4xsxpu5o"
Content-Disposition: inline
In-Reply-To: <20201023194902.368239-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mwdshxs4xsxpu5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 09:49:02PM +0200, Jernej Skrabec wrote:
> Ethernet PHY provides RX and TX delay on both models, A and B. Although
> schematic for model A suggests only TX delay, network never worked with
> such configuration.
>=20
> Fix ethernet node to reflect PHY delays.
>=20
> Fixes: 729e1ffcf47e ("arm64: allwinner: h6: add support for the Ethernet =
on Pine H64")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Corentin sent the same patch last week. It's part of the fixes branch alrea=
dy.

maxime

--2mwdshxs4xsxpu5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5aQZwAKCRDj7w1vZxhR
xSPeAQDXOetNx+UqI2TFn9679Gd2Q2U6sifVgN52YT2DiwgIFwEA5gTvVzFpYwUn
FK9UNJEp9oVHYZo5/VEk/zVJQ+F/mg4=
=W35L
-----END PGP SIGNATURE-----

--2mwdshxs4xsxpu5o--
