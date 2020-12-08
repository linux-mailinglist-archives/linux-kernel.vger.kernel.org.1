Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D182D283C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgLHJzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:55:24 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44447 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgLHJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:55:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 93C89C7F;
        Tue,  8 Dec 2020 04:54:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 08 Dec 2020 04:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=gPk3HsizQnaow95sHf+jqM4Nf+w
        Nb260dU0uWdZXlC8=; b=IpxyqCQppE/s56ZhyW7+RlFg/d/VcbHHRKBr+C/WIOK
        tUSyHAZ3ITK7KQs1DSUyVo0eJufoJR2BMuydLUxR8iAMWCY+8WxPa1QCfvDWhHIG
        8MKIHVijSoeGdNTcfnfJ+AxrBuLCZNXK+33V3h8oHw+Q4kBDBSzG22/JJCXSCEre
        iJY98EjMQr/NDmCObvXhqJkyJPBcS9O2Ipu1QOMwux0II8w7o3BUm9UvarFmjo6V
        8xhOOwsXuSvWX/3Bx/U2fH1KV4yiJHrWjsqLflLcOEfoBdozJ+voRm6EfgX7VkbJ
        FnoR6txEgeiJJz8crBqgWh00NBuRPWElyHzd4z45ppA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gPk3Hs
        izQnaow95sHf+jqM4Nf+wNb260dU0uWdZXlC8=; b=NQZl5mRdQ5tX1+SDy6KH5c
        Q3pyRoka2hSaVdds1kzBsSPfUkTDjSVUAhn3Tmp2ucsuJyoPJlr0ukXc725Cwneh
        oU52dzKA4QL8+eAtsQJbIMff3PrLREXTnvktREge6qDyvbigCsHRqL+4Wl/Nf8FB
        xrfATCrEAkuCuGwGLoutZu+XsRzObo1PqtTtLzzPASLxT7lTU4lH9VRuCOkJrYjb
        DCS3MqSP2XhyrJKhlNPjz2/etF+pmKUIEbv5Ip64e4I6UrWL4WibyWw/7htSEwDV
        iymVGk9soUE0Ag90C91r2gmqyTGkWGxJR7Az6YrqLVpAsh2MsUrRmN4LEy4Ic8Ng
        ==
X-ME-Sender: <xms:XE3PX71Kntkz82ITVKYZgkxicuxQXeEKGhsg2PLdrQC7THENyU7frw>
    <xme:XE3PX6AhPRS9q-NVaaHdKc5ypEr-fFYn6oQk593ECbUMuRQQ3g0dP8lqY26gis_yE
    UYNTOTx8ts0Qv14cdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XE3PX4wG4urGU3SMB2NWNJvKhjt3I-N2GBo6BXR9QRCXKrSYmazpvA>
    <xmx:XE3PX4l-2UakPGeqO9SALXAR8nPuxyM0fqKavsg35TDUqibYY7NFBQ>
    <xmx:XE3PX9H_lBUgCcSJfB1GCw4iy2aS9_W-mqJTIhADy40reifhiOKmQA>
    <xmx:XU3PX9o0b1QivGM84yM5gmku3ucM9ALSyqdQvHKMiyNh7giDpPfcuw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0801A1080069;
        Tue,  8 Dec 2020 04:54:35 -0500 (EST)
Date:   Tue, 8 Dec 2020 10:54:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH] dt-bindings: sram: Document Allwinner V3s bindings for
 system-control
Message-ID: <20201208095434.cmrndlafotedzlyw@gilmour>
References: <20201206164119.1040880-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wsygqpw2hyyy25f5"
Content-Disposition: inline
In-Reply-To: <20201206164119.1040880-1-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wsygqpw2hyyy25f5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2020 at 05:41:19PM +0100, Paul Kocialkowski wrote:
> Add documentation about the Allwinner system-control bindings used
> for the V3s SoC. The bindings are already in use in the device-tree
> files and produced warnings in dt bindings checks.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Queued for 5.12, thanks

--wsygqpw2hyyy25f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX89NWgAKCRDj7w1vZxhR
xZcRAP9oD/KrObOIbw8IOW6OZFOZrZYviyRlXlmhzuzQYnYNXQEArT2cwuHACTBi
tA6UaHI3Fu7jjSkhSdFFk+VwEUYgKwY=
=hc/B
-----END PGP SIGNATURE-----

--wsygqpw2hyyy25f5--
