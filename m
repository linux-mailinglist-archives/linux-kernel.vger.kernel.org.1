Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242A02FACC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394513AbhARVfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:35:04 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40943 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389505AbhARKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:05:02 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E283F129A;
        Mon, 18 Jan 2021 05:04:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 18 Jan 2021 05:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Uy1WS46IbpC3KuVCb+N/ATn8mS5
        U7Ff2FfbpjZEa518=; b=tn1gpcp0AsJYsA1s9QMepflLiNX5nRZjRbPHbx2jr5r
        obrZztyBgqGO3R/dSEB/pmPZBCPmg2nEnfvCOOLwfAD8iTe4DcWJy98e5Z4m88yy
        JIrq0ZohckFvjA8l7cnnPw6EicHVvjJQvRAZsrVGEIfYsPvCI0yu9R312OP8b7l0
        LSMiLfD1709ghSsyVGdREmLqrUT9SO92ZVeFb/G+b+zyvI99KzRL/lgSq2oMq308
        e6dOByzdtkueZ+WyNn6bLyfZAkRi315iZ4zq9p7T/5x9cXb6Ra3s7cIitRc4DBvn
        MNw/uJjRwSy7NkdQqSqPv5Wp+auZqOuWe4D8H+Kyhuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Uy1WS4
        6IbpC3KuVCb+N/ATn8mS5U7Ff2FfbpjZEa518=; b=DgT4DwAzME/QP7DSl51adt
        nKf6W3TdgwIs1d/Ak8vP7br5ohBIUEc8FrYu0rh0AI2GP36Lzd3huuG3ZTEDFykV
        8TgI0wIRnI21r/rBYWS7W42SJKy9OtI5nGTYKsTLsgyIe9BG5XiuGLcVg/jhpStv
        doiRCk2+4rKH+2jEpPR+GyFDeEoVnEIOJNsVyK180/+Ae/+F8nrWNwmlcypTI7XB
        QVHCjRZCr5TCZGtQLD43jr89/bJMCjDnDsEIV8GEvMl/40Eo9/KTe1Y7OMftONGq
        3gGuQzTsoKHXlEphxg+x2i/2Yki0FT+hHeOzwlEdEIAsG2JRltnsuGAh3pTGRk3w
        ==
X-ME-Sender: <xms:G10FYIby5IPLGuvEU01_4thuKEWqHSc7Dn-ikfJJVQYJNi61Pi97Hw>
    <xme:G10FYBO1B3siq7e4tLqzeHDo6OGQMvQEVhecTL4Q1JM5fODpQbXrRcuT7PZBO4Xe-
    GGzFUezUqGuRUZTyjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:G10FYNZgvGNd504E7uF45gybFLb-BSIuoZciluHijSNk7VDCpEnm6g>
    <xmx:G10FYP3ME94XJJxenXjSvVR3vyYEZyE-vvPXiLiUw9Z3xocOTOWjxA>
    <xmx:G10FYDepwD9mLSaDsi4NXDfYV5DsbmNa3d8ak9KHWgMtwfRgXQBoHw>
    <xmx:HF0FYGXcVCqOXE2s7kued5TbOgEaqgEJxSKqBBR6-rZPwMYj-5kqhA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86762108005C;
        Mon, 18 Jan 2021 05:04:11 -0500 (EST)
Date:   Mon, 18 Jan 2021 11:04:10 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, daniel@ffwll.ch, airlied@linux.ie,
        stefan.wahren@i2se.com, broonie@kernel.org, tiwai@suse.com
Subject: Re: [PATCH] drm/vc4: Unify PCM card's driver_name
Message-ID: <20210118100410.co3qph4gsvy3kloy@gilmour>
References: <20210115191209.12852-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tfzxfn4dcinwkokd"
Content-Disposition: inline
In-Reply-To: <20210115191209.12852-1-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfzxfn4dcinwkokd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 08:12:09PM +0100, Nicolas Saenz Julienne wrote:
> User-space ALSA matches a card's driver name against an internal list of
> aliases in order to select the correct configuration for the system.
> When the driver name isn't defined, the match is performed against the
> card's name.
>=20
> With the introduction of RPi4 we now have two HDMI ports with two
> distinct audio cards. This is reflected in their names, making them
> different from previous RPi versions. With this, ALSA ultimately misses
> the board's configuration on RPi4.
>=20
> In order to avoid this, set "card->driver_name" to "vc4-hdmi"
> unanimously.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Fixes: f437bc1ec731 ("drm/vc4: drv: Support BCM2711")

Applied, thanks
Maxime

--tfzxfn4dcinwkokd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAVdGgAKCRDj7w1vZxhR
xb9RAQDb8FrlzrhimVVkmB4VtzIoNkE+tBqN140kwfhlh8De0AD/TBTRgycXlwEM
AMZosesAa3hV4y4MYHHwpj8F+lV+EAk=
=bj5l
-----END PGP SIGNATURE-----

--tfzxfn4dcinwkokd--
