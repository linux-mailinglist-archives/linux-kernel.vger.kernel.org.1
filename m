Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF99283500
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJELbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:31:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37845 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgJELbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:31:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E255C5C00D0;
        Mon,  5 Oct 2020 07:31:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZIQmHdb/ZtkJpXvL4aNPLntGSaV
        8oOLW2+hwiNNW+yQ=; b=cPUt+IEIUBnnrbU1fcJM3em4UWoMW3+YJhb2VMMPMY/
        4FWf0iefoGz8Qxttz4WcXJ/3GIYcZVTcLxFDIHeY5IfilBSyud0r6pV7iDZKZLTX
        N5oGlZdGDwgs0U87Egdea31wy8i5Nmy0ULzQOX+DtqTN2mmI9FIdRXh8k/8H/mHy
        qvgIvLhBoA+3TA6fLt7RcYtfg8MHkGhe3g/eOt/I9QiCBbvClGwcC86EFAnYXwnd
        vBUHopOcrDSJVAIWO6k8gML9zcp9RJuW2CgC3b47cPaeCzG3c46vZc+gXqSfGdaw
        BHCdtuBUXimisUBo1EfWUQim9a/kwCFknpuFE5SYjiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZIQmHd
        b/ZtkJpXvL4aNPLntGSaV8oOLW2+hwiNNW+yQ=; b=eIqwday2T1qbW2tZmsFpXn
        VEXdLzcXiTp69kmYJs+zeK8PdABcexL2hBr5Nbnk1/f+decWSXPbJiTRqDrLQvb8
        X0iaYuaS6uv29TMc87eQtyMCj/J/fj07V1n0ZlNUF9aD9YliuHf79R9TyTS5HQNM
        X+3W7fC0/TgvzxRXYXaGUFBSPYNamB8pv4q4C+LMTQcO+BjEZIqhXLWL95WJsgU1
        50xSpHzhFMn94HE+FqY8wB61HyzyNmLNWnbKeI+oaeJvu7TTPE4q286/NM7spe0w
        xnHB1yDmkORcWw1NljvtwoBL0krmREM0cnj6QDqsn2FF2E5zuKjyexyem3Pm/tBQ
        ==
X-ME-Sender: <xms:FgR7X3gazs2SINpDUNy27biQpcllfLHk6yQ2alcMchCt3pAmd1OUJg>
    <xme:FgR7X0AxH4s5srbXESHwSU3Kr8aFSsDyvcQPetpo1ETf-V-n3N8o_GteFICulZF68
    X9qNGkCh77Vxy3o4U0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FgR7X3HQ5yDcuhmRZP0sjRz-4vIMsKJvMnFmOvOSR1xT9uFCyKkwkQ>
    <xmx:FgR7X0SyCLOXCfu_CuicQx3jt7OrIyg6szx_7UzuXtHMQJ5XTbJGmA>
    <xmx:FgR7X0zD0JXr-WFFXJWzruqvjYC55MmYvYuwKCYXYPYBs4-R321f3A>
    <xmx:FgR7X3yLt9Qx3uMrPJnGhwZXvOLxfrywy5lFqarDyKtcxXqdlJdARg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 631E83280059;
        Mon,  5 Oct 2020 07:31:34 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:31:33 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] ASoC: sun8i-codec: Round up the LRCK divisor
Message-ID: <20201005113133.vftzhf45ctzzmbdq@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-14-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j7tj6ihkcu4iiffd"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-14-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j7tj6ihkcu4iiffd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:36PM -0500, Samuel Holland wrote:
> The codec supports only power-of-two BCLK/LRCK divisors. If either the
> slot width or the number of slots is not a power of two, the LRCK
> divisor must be rounded up to provide enough space. To do that, use
> order_base_2 (instead of ilog2, which rounds down).
>=20
> Since the rounded divisor is also needed for setting the SYSCLK/BCLK
> divisor, return the order base 2 instead of fully calculating the
> hardware register encoding.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--j7tj6ihkcu4iiffd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sEFQAKCRDj7w1vZxhR
xRC4AP9cMQdx9DuUE6bytBFkzj2hACb3LUETn/mRypWtZtB3egEAk3UyKIzvUWNB
U8VvDTubU4PKI/UIlKt28CTY5znGdA8=
=ases
-----END PGP SIGNATURE-----

--j7tj6ihkcu4iiffd--
