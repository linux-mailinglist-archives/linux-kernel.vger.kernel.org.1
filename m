Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A92BB102
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgKTQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:56:24 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36353 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730103AbgKTQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:56:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A06305C00E1;
        Fri, 20 Nov 2020 11:56:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 20 Nov 2020 11:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=qKqAaN7huqBFTY1CCd2pvJiT0qq
        gNumhzJuMiM1PToA=; b=G128wEp3WtyPBwsipktjQgC51ZmKDQ3hpqkwxlA7PQT
        P21y0WtKpQ1ZYDA9cilEv5a/0sjV/rKy4Q7rSpdq9AIMjKAibBgRLO2TyekYtZs6
        BBUTuFmss2b7RclIdhG1BFe9MAunqMSCwWosFnVicTPICmfDbd8nKOprdjkDu374
        bm3XbJG9j64lSNZfIacaaqN+4qRG5virDyBN/K/nHT78RUrbKJAkrZizywOvPctW
        bhxhvP7UcAdeYKd2wzic8tREjyceTbIs7m/8sZbWAyNslUL/UbPxwctaNJzRA71y
        4czva1l/X+jSK0E2nqOZsX7s2KPj+HFFJjoJ7icv/Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qKqAaN
        7huqBFTY1CCd2pvJiT0qqgNumhzJuMiM1PToA=; b=kBCX00cosIXbLWZeP2JpqU
        VU5GzZjCKUSZrr9JS10OTtDgRi4ianYeWue/l6vfqytBNOFqFUgUB938x9CYgu8P
        y83+JM/sHssaLU2qx3RRr1+HT6eS96wXcp7HU6QWaAg4iKcJmyqZwJeOebscN5TS
        0uYlKjO3pAQxyH4l6SJJsbo7j4glvxMoWOHY/zhgqJS5dax7F3z/3oI4KSiVA5EE
        vQTdMk7ZiQ34D+jt8V2KX7AkZCVYbqZzOIR6OA4uTEHkXW/MCRmG3Q1XUnPHILq0
        QQ/sl2WWobzYwQLsoRxkCM6JUQSXMab69P9OUaH9LTrwrRScMyOnuv6EE2RIViJA
        ==
X-ME-Sender: <xms:NfW3XzkDf1QkTzzYmCwYyqXsf8JvaQEfl7WoVTFkNnLL8iJPPa-X3A>
    <xme:NfW3X22xe8Wg0l6A-kGkgr-JnTTETcbsBdDaLNjZAIqmKwXbRbP0j6tEVskXlRAZO
    TxfSPI3l6SP5Vzim84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NfW3X5rR7kRmJqVIzcsoQy7lCMc5sXhKPG1pidwEClaGZeGJL5rg1Q>
    <xmx:NfW3X7kG2_QjUhiMh7oWFfew6Cwqpfiu28CCfftlWX82fQzwk8kTRA>
    <xmx:NfW3Xx3XG-Z4gtyDA16y_3Vd1gAwjvbZszJ01fK8xI_7CjTbLquzGQ>
    <xmx:NvW3X8SttZ2yrlph8JlcUfwDJ4fMauzuu--dAeRhmGHn9UqfiYBdxQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE8E33280066;
        Fri, 20 Nov 2020 11:56:20 -0500 (EST)
Date:   Fri, 20 Nov 2020 17:56:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: v3s: fix GIC node memory range
Message-ID: <20201120165619.ou4uigdg22qrehne@gilmour>
References: <20201120050851.4123759-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pche2hgr46ibicqn"
Content-Disposition: inline
In-Reply-To: <20201120050851.4123759-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pche2hgr46ibicqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 01:08:51PM +0800, Icenowy Zheng wrote:
> Currently the GIC node in V3s DTSI follows some old DT examples, and
> being broken. This leads a warning at boot.
>=20
> Fix this.
>=20
> Fixes: f989086ccbc6 ("ARM: dts: sunxi: add dtsi file for V3s SoC")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--pche2hgr46ibicqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7f1MwAKCRDj7w1vZxhR
xUZBAP9QRE5hT0jW96ROUXmoNRdQ1tcb+Epmu0ONjtDfDNb1UwD8DYiy9nj2COwe
kI8zIqBZ4DlOXwG6ZamC532PUGK7zgQ=
=2jDO
-----END PGP SIGNATURE-----

--pche2hgr46ibicqn--
