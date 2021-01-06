Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3D2EBCB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAFKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:51:08 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:52393 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbhAFKvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:51:07 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9BBFA12D6;
        Wed,  6 Jan 2021 05:50:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Jan 2021 05:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=LlNe0xlQY9j4Dmv+UE306N9jBv8
        IVwNK7gTu57/YVN0=; b=SydIZks8nCAHSSrkdGXuxKKf3UM85NNJaalQr+P2j6J
        C80Q4w9Zh/DzgUmGROt6d78wODzT3oPIntF95E9JTn9f+zDK/iSMsdBzc+KfBuRy
        jsMsZs10Z8tUeL2GrF0MMb5A7ohuNE5Z6HPkf9LwRgVEB9rDo70CFTKsnDKPlYUW
        JUJ8s1Xz9f4ilufurMtQX59H/cIziUJ6ghucHEgzZAHQJ3GnY0H72g/PzZZZJvD1
        S0WNIj9qXJNsInYzQMonlUXiGPqfosTH6ATLVwZVTK9SGurQ6TQ9J0qB7imzqYHM
        ED1pseMtZWiQov6KxHARO3BuA4VYRjFkNV3zBqCIu5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=LlNe0x
        lQY9j4Dmv+UE306N9jBv8IVwNK7gTu57/YVN0=; b=Rob6P0PDU8HdpO6iB9z/B+
        zI2tZwq0NmU9ZlIqswKTMimJuPmeCNlBDyAy3FRgnShiDZf8rjOu9MNXqLzLxjI2
        EKOHqA7L5xos0VvOybpKeslcvup1/TwAYBu2zc8A6NbWZ4QExhpwg8AyelQOh/sJ
        j8hV4MNUlmmQWcl2i6rdJ3CAXVDZZEUAZReILKL4iD+qhaQtTtk/DyqPrrsos94R
        ov93l1+oJzBGwtPb2LtQ4rkRUUXdJERbG2V0DhK4Bi5xtbJ5AXqvwZ28oL3BhBzu
        LR+22fGwFtO8SeFeWNQ6ELehl4VX3lsJbyObfkW3GzzxRsx/Odqac+A8W89CO2gw
        ==
X-ME-Sender: <xms:2JX1X09uT8fj7NXJvZjlBbX83gyYLvNS_dsKMyRcbNfPle3bqgB7Dg>
    <xme:2JX1X8sNt7RtS2ZEAvqoRKvRa40nTGQcsbfoVVSo5qeKm_j18NaGIyh7IVs7r3ert
    fv3ELA-qhblax-wTVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2JX1X6CZ2SC5GgnqD5beemCaYF6iQCyBkTMaLNxdmH0IQQYQaDnRDA>
    <xmx:2JX1X0eVDyF9RFeSzw66v6eEp8gx-QbbltaeiZfWGQeZm31veQRaIA>
    <xmx:2JX1X5MdeH8JmH5EcOu9cqWJWnPQMUX-PpIW75fV45Hub2qaOKgGzw>
    <xmx:2ZX1X-rWeom4KJXgbLFCMSTaQFYrg5y3XCgxZ2dlwNM3CzIxLGHf8Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E773024005C;
        Wed,  6 Jan 2021 05:49:59 -0500 (EST)
Date:   Wed, 6 Jan 2021 11:49:58 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/4] bus: sunxi-rsb: Implement power managment
Message-ID: <20210106104958.k4ooczptqjgdrbfd@gilmour>
References: <20210103110635.34823-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k5uvr567gfdbyr5c"
Content-Disposition: inline
In-Reply-To: <20210103110635.34823-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k5uvr567gfdbyr5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Jan 03, 2021 at 05:06:31AM -0600, Samuel Holland wrote:
> This series adds system (complete power down) and runtime (clock gate)
> PM hooks to the RSB controller driver. Tested on A64 and H6.
>=20
> Samuel Holland (4):
>   bus: sunxi-rsb: Move OF match table
>   bus: sunxi-rsb: Split out controller init/exit functions
>   bus: sunxi-rsb: Implement suspend/resume/shutdown callbacks
>   bus: sunxi-rsb: Implement runtime power management
>=20
>  drivers/bus/sunxi-rsb.c | 211 ++++++++++++++++++++++++++++------------
>  1 file changed, 150 insertions(+), 61 deletions(-)

For the whole series,

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--k5uvr567gfdbyr5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/WV1gAKCRDj7w1vZxhR
xd1CAP9Tb4Xdqruq2i1SeQ0sgFpGnf0usDwEaKiI+ZmKkIAe0gD/RF0rIoiLx+tr
DjNFbXZeMdH/KRkpf7K99dCOxpMJcA8=
=SkuB
-----END PGP SIGNATURE-----

--k5uvr567gfdbyr5c--
