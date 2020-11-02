Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D972A26F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgKBJZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:25:56 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38745 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727953AbgKBJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:25:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 30F02ED7;
        Mon,  2 Nov 2020 04:25:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 04:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2u3KySetCrStQBuOBzxXEYYC+qN
        zn31jPLBz4766DEU=; b=GFuTACBkdbo5rFGzb/oYO2OJqhM1RdNEmJlps52N9in
        HrlTsh3UhRafQ2aDJ9sMtrCTMnK8nm60aapWMJ3KDEwdCIiVUKpnjTCUKQPtEQBT
        40J3JCv2DW75hEtoRn2joaIQwNd0ZhNszsES7tHMEZCDzimxR8hl4QX2iuDIqRRu
        TnPPU+W5TMZbQmvItmVmkplH/dKCsiUpchjnnmx36XfpmMRaxvyqSTZHNDmvUUer
        UQeXnLsIYlErkcPZoLWUqIy/TEQ40zQsvkk7t4lGpaDaJH+kADONb5EovluZm9Ng
        w4ay6EORN6sgaW7qFA1YxDBbGS8MfHCZq+jp5f5dSsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2u3KyS
        etCrStQBuOBzxXEYYC+qNzn31jPLBz4766DEU=; b=XjqKzMjZbQSJbAMv12+B7j
        fS+zwXxzxR+ahkxQOz07TYXdkfkPK7tmEH2o3sWapZlOC7bt2EFZs/4BuMA6qrFK
        W+NJoMQ8sE1y2u7c3rwt8y6LpnbUEmaN7lPAa5Lf0SWmfcR1BVg++RvYwrfJYIG3
        VvPNNejmEDWRsgVphVOyWFKI9X+dikk/M0Vh7ncwjCqCLzbtK7sHpGHFnjDJ3EZi
        oSDmcN730wMp41vorzxQvtev6bOygVO5jlfUFg710zbFbgfvQW6LTzJb9kf7pgcS
        bR+6nOckR9WEEJ2wMkJXulk1rEbvphOMo1ed8e1FLF5sRXuzsyW6rGOYW4W9FYzg
        ==
X-ME-Sender: <xms:otCfX3rqc5Yfc7pQv4C-VeDHhALtnZgq-dXZflUrwRUkvYku81TMKw>
    <xme:otCfXxqOcnDpq7Mw07h5Olng0KBoCWog60dA8EyWUU5Wf9nOkQlZpqvgzHwe-zzk0
    NpS0p1V1pqzLjFwm9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:otCfX0M1yk9-Fq9IaNxtFjBx-jxLkn9b4L0mrfwgHYRFufJk-vgPfQ>
    <xmx:otCfX65Lmh1Ef6GCaFJQXfO4K5-QAhLxtGwkONxYKVlHupENiE0M-Q>
    <xmx:otCfX25RXB91NEF7b5xEqLyKUFCjfWL0ovCmPF3_1afZwt7yWq1udw>
    <xmx:otCfXx0RpbdYLXIhRBWYomBLFq7t0fs-nZO31qtKvoxJcBlGy8T0Kw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C43053280059;
        Mon,  2 Nov 2020 04:25:53 -0500 (EST)
Date:   Mon, 2 Nov 2020 10:25:52 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: orangepi-one-plus: Fix
 ethernet
Message-ID: <20201102092552.laumqscusjlnt5v5@gilmour.lan>
References: <20201101072609.1681891-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="taj27mowfuuakenh"
Content-Disposition: inline
In-Reply-To: <20201101072609.1681891-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--taj27mowfuuakenh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2020 at 08:26:09AM +0100, Jernej Skrabec wrote:
> RX/TX delay on OrangePi One Plus board is set on PHY. Reflect that in
> ethernet node.
>=20
> Fixes: 7ee32a17e0d6 ("arm64: dts: allwinner: h6: orangepi-one-plus: Enabl=
e ethernet")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied. It's not clear yet whether it's the best way forward (the PR
got rejected), so it might need some extra work in the future.

Maxime

--taj27mowfuuakenh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/QoAAKCRDj7w1vZxhR
xXIOAPkBr5bVh0WPEaxPkl/Bg3DLRv0/zCwy6hwh9ZbZoLYjOAEAlo3MAP+mA477
FWS2zhpq33bK7iHJ7uP8ik22GY7r2gI=
=lrKT
-----END PGP SIGNATURE-----

--taj27mowfuuakenh--
