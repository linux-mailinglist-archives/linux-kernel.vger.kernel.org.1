Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0328350A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJELev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:34:51 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40047 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgJELev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:34:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 26F275C0118;
        Mon,  5 Oct 2020 07:34:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ifyO2YZqYLdft9YmvXovOZ4UH+M
        lmzTcMafQ82WJ5Fc=; b=sDt7exSIpv1iOp18EMCKRgVkYIH25NOOg7+8zY5/zOc
        0bs0JGtb68EXcKQ01jHG0qv6FmGfk3Sk6PIQPbmkzJEb6KVJI8YJ8cpYtXvWGfIi
        9X7b+M1WJVrDeFc0WKtXcFVRgjC6gxBfZFkewFWp2o/xLzRDGHhTMY+NNEWmrsZt
        DB4GQJ07vRpdOlD6nW8g1CyzIn0yExvolOtbQdjmtQnW9cPs2XMnZYR4OB4UoQTE
        aifYJWbFr72jdC1D+Hi3TRHBCJrJvVzn9vL0tQ6vzfbsqZMwyw+QFulthYh/2e2j
        Ze1Eu0Px1/PfliZ4SZWveiIr7mb54Y7IgHUuOl/LYpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ifyO2Y
        ZqYLdft9YmvXovOZ4UH+MlmzTcMafQ82WJ5Fc=; b=T5Q/l2AgLEz5SkUe7GsL7D
        Hll1HhaJz6VrSa1JcKdkaxEJswCghi1Io+oBMjg9JYmVJID1mPhbJC8CesefEnWZ
        F7VD62IngxgI5aCztdlQnphmC4MrF1eFOwoo9CcMP/xcowydY7Y+w6puRfq2HpIG
        /Terwq9llJkLhlX0BOarw2osEX+zYIf7UIyVWqrguPshr7QM/uZZ/2d+tbiwzWiO
        tonIacAXEo8ca+T4S0ybmeexRlNXMCKuD+clpCARToZFaj5n5jP2/BddsWiJo70S
        FYzl2lHj9lGxQwl+MHGMka9H334cT7eFPr5wvaXPvFTRC/HHG/Ceg7v6SihdcRnA
        ==
X-ME-Sender: <xms:2QR7X26yNSOBV7PSwqB9tJWZWHBnNAKH5TRSq72JXigPHTxjdZT1CA>
    <xme:2QR7X_7oiWXYv_2QavIAtfW8grrrQKxpU_d9-WuC0b2dWy1DeCj-pzwl3kE-lYYbt
    IOsLRV6KscV8HTckqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2QR7X1fAlCjlgaxpZd1mU0HLG0eFPYhc-kzXh9Lxfp3MEpUIRBggIQ>
    <xmx:2QR7XzJ7O_O2w9Pg99DXmauIgojCEwCCkpOW9FMFzGuGXId6gj1Oxg>
    <xmx:2QR7X6IkXiu1GpEY6pWbvQsQ-g9w0lqQ-wHqv_JNEaE3muqojm4l7A>
    <xmx:2gR7X7quV6HfJdgxtOyXBIpy2aUG1tJ-BVGmDAi6bMrH3gSeaen_Zw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8DDC328005E;
        Mon,  5 Oct 2020 07:34:49 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:34:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/25] ASoC: sun8i-codec: Support the TDM slot binding
Message-ID: <20201005113448.4v3llw57q2eucmj4@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-16-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4w6bfh7n4zwz26m"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-16-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4w6bfh7n4zwz26m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:38PM -0500, Samuel Holland wrote:
> Now that BCLK and LRCK rate calculations can handle any
> hardware-supported slot width and number of slots, enable
> support for overriding these parameters from the device tree.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--z4w6bfh7n4zwz26m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sE2AAKCRDj7w1vZxhR
xYTIAP4xF3dpNPqtQmWgzulksPMnq3M+hJMpVypcETqDyTo4GQEAoKZ82DgAudDt
EfED7ceftvG9034QICEpQOhxpKNaZQ4=
=+Iyx
-----END PGP SIGNATURE-----

--z4w6bfh7n4zwz26m--
