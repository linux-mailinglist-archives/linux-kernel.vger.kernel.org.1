Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3C2AD300
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgKJKCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:02:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44887 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgKJKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:02:06 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DAA195C0198;
        Tue, 10 Nov 2020 05:02:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Nov 2020 05:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Z0eryG8U/sz/7obT3nA7LwAZm2e
        WTP8JBDoovnYQktI=; b=o31zzj3SjHOJsZjxpDT8HqKTVLVSIm/PqgTvG2cR5hO
        AFlZgsIZABTvzlGJ6RLDVkyjc2Xjx5gi6nRVDPj0pF3QUCckDWEI7anOkSaUoX22
        K6sGhJiTFHq4u9P0lD1N5q4WAUurCXpeFMT+c+fnNBfjXCSyrDwzl7yCd84Zrxo3
        exfx1D0miphj96pkGjFgD2lKaway/Zh9zZXmm4F9tA3yJZdWS8jMe4r0TmCKpM4y
        TKuhQf+8AuJ30AMilwPoznNIubylS0EI5Y3KFx7/uqnHXNWVj1O53iE85S7uRkRk
        k4nb0JdWl8Zw2Sdb+TxNO7dZNYNBBg31wvnuYHJvNwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z0eryG
        8U/sz/7obT3nA7LwAZm2eWTP8JBDoovnYQktI=; b=jE8/FHK+u0ob8XL0REunmT
        UG2ZVFNQwI8ib7PaLC0zjpybDuQKJdn05jy7vt9r61yuvghcbA3Icbu9e0h3J7uV
        clU+EDW3lONsKMzWGbxleyVfoUw8485i+TgtnWEJ34rl2YIodFnvumsbuhuZVBHj
        A411lHuvohMN5yiMYZf35xBtuhGZH2G/VKfmiT2iBNOC1KJ2mBg15CAgT9SxKrZJ
        BpXEcnRZDADgvcKcd/Oo91Cm5pyoNLVopcqO/aYxvr8ZQ3XKePCNNwDlj7t9u9Qw
        XJfe/EZn5wYChS4+9vu4ecE7mp4Ed4hlc1BljmYRdA49jUkT1lHdF0VnUhABwEag
        ==
X-ME-Sender: <xms:G2WqX7l82ZdsLMny_owT2J0IV2P6VBdy1f72a_bTlKZWoWAn59hYow>
    <xme:G2WqX-1sKr5b_nTxoYf0lpaJuAfBUpeUkLhrD_E1G9Nn3ox7GqzjoFIidSWWoUVFe
    Rr84MjC0YGvwjtvmvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HGWqXxqnyf3eBjzs3FNZjL_cxR8K2mSLYtVcfsubbDwHDeCkOzqttA>
    <xmx:HGWqXznu2Bfh-rmf3cHQ8Pvl8PgZhnmU-8XE4LLSs_GG9kJHW19Nsg>
    <xmx:HGWqX51oNFRSWa_AzHGt843kCQT-K9y9APouzLyCz8OOOz-vON8Y1g>
    <xmx:HGWqXx9aI2C9gRssPDCzILN-JA-Q8wNGscghuPseDPJG77bYhO1N6A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B28303280064;
        Tue, 10 Nov 2020 05:02:03 -0500 (EST)
Date:   Tue, 10 Nov 2020 11:02:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     vkoul@kernel.org, wens@csie.org, krzk@kernel.org,
        colin.king@canonical.com, tiny.windzz@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] phy: sun4i-usb: Use power efficient workqueue for
 debounce and poll
Message-ID: <20201110100202.wscduggy76jtlts3@gilmour.lan>
References: <20201109121214.19012-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u7272awyvqgkjwck"
Content-Disposition: inline
In-Reply-To: <20201109121214.19012-1-frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u7272awyvqgkjwck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 08:12:14PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> The debounce and poll time is generally quite long and the work not
> performance critical so allow the scheduler to run the work anywhere
> rather than in the normal per-CPU workqueue.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--u7272awyvqgkjwck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6plGgAKCRDj7w1vZxhR
xevsAP0dQNe6uUscvhtHfqIMrBPK4OoJDYJ76adIKQPo8x8h8gEAwIlemE55HXvX
bH7pdRN0bDRonTgEPf68yDS+TxwKygI=
=K9kr
-----END PGP SIGNATURE-----

--u7272awyvqgkjwck--
