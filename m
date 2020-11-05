Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C300E2A7CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgKELZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:25:26 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35123 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729113AbgKELZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:25:26 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3DA10B26;
        Thu,  5 Nov 2020 06:25:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 05 Nov 2020 06:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=JksiuIJMahHykc5MTLuiF//MZ6p
        JzDDfwl5B6+Ahx94=; b=NtgoKXP+STUlaBKKDW4oqt7ud2+2hJ4+tKwq561GjP5
        RG+ZKX7tyTHXwI5PjejA9oV5FmDDk23+xMvRa7sYp+82BUrY7yC7YWxpTIzshlXi
        P0WHf+RynUaNwabqWfzMueHQLFANk2P+bJysGPJeYqucaD97zQhSGR0H0xwSdW5Z
        ucYKpaNQsVZyCqEQq5fWMOyd+WXe7Cj/PqeI3WbR5rmEKFUePhY9gZnFztF6qzqd
        74jY9clJ64hbiCSqz7Gd0gbxDUY42SEmGSE1UJlzTjLYrmAhM/Vcyk/pJ1mJNe79
        VhyGNyIC4qyibWYgio0e4nYMItdJfrc8U1G885Wn+Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JksiuI
        JMahHykc5MTLuiF//MZ6pJzDDfwl5B6+Ahx94=; b=S5FqE9k6vwczV1ONLdX97J
        OnuazeCvhTFzLVmjVf2rKRnkW61Xt2k7mNkuCkpwDbRLRYVFgmRxVEdX74S1wFI8
        BL1oiqnJ8qUmycFV7V7p2EH6Qgc8zmzLsXLxvNnq6qwGC2zmRe7tjTYNOe6PoT1t
        Zdbyjd2S+8GUxw8zfVw6jfIU8RaZtKEbnpMozGoZu+xYSFt20eT7Kr+pnzwVzkX2
        VgPyg10VwwvFnGmDFHkACydO7EO5ZdpDEYpqFtabPC1Wx/wJSCI2Lv7ZG0kj2qDw
        Tfc5n8cJnnR6QWWR/qnqKEiTpZqeFeoC5GtN2wON3OsVG5dnBFk9pO9DbmP43aIw
        ==
X-ME-Sender: <xms:JOGjX_pkHKm38AhjjTDoPXgY2c-kKH3WRatHVGpWSvftUNki-4BLtw>
    <xme:JOGjX5q2Pa51wOxo9ZVFhYtaWngfvFYm9-DWltIkhiY90il4VFU0kHH3R7tFY0Geg
    gIIGATKxxU25_ffnoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JOGjX8NzrXv2klqFBIJcQxHJZt2mDYqpARfLkHp6Na5rS1VZtBxykg>
    <xmx:JOGjXy7ogpXr8aivBA-IrCo_DAug9ybfuTbE4kj4FsCrHiPbZLj_FQ>
    <xmx:JOGjX-7zAXAEFmy-ZZGTCamAhk_UrpIKSp_sjkrC19gwIF80v_98SQ>
    <xmx:JOGjXwRCW87C62OzM38gAerUmSP-PtiJJ1mvNWUc4vvhsIwvpXFqyQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E4F4306005C;
        Thu,  5 Nov 2020 06:25:24 -0500 (EST)
Date:   Thu, 5 Nov 2020 12:25:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/6] PinePhone Device Tree Enhancements
Message-ID: <20201105112523.t3azspklmbnr5ool@gilmour.lan>
References: <20201105054135.24860-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zk3em6umaq6fe35u"
Content-Disposition: inline
In-Reply-To: <20201105054135.24860-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zk3em6umaq6fe35u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2020 at 11:41:29PM -0600, Samuel Holland wrote:
> This series fixes a couple of small issues with the PinePhone device
> tree, and collects some patches adding support for peripherals that
> recently received driver or DT binding support.

Applied all those patches, thanks!
Maxime

--zk3em6umaq6fe35u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6PhIwAKCRDj7w1vZxhR
xZtTAP0Wqs9XqGNllc/3pI4xg0aRRs+DJnaJ3kRTiXcUnBtRGAD7B5xOX+fFjRRa
hu7j77fDAsRsG//sRpq4IRlboAWOAQ4=
=jbwU
-----END PGP SIGNATURE-----

--zk3em6umaq6fe35u--
