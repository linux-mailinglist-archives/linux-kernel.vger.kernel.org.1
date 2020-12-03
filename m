Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A872CD074
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgLCHhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:37:05 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37967 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbgLCHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:37:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BB3E3A8F;
        Thu,  3 Dec 2020 02:36:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 03 Dec 2020 02:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=FwCYZUDxMgkWGg6uCHFZXVW4N/x
        5lcRe1cTBmLDJqgg=; b=eNgXuYCyWcb+Vz4pVLaur84Bo0ov9R1aNX3eHvoQ9FA
        62x9aznxEKBtg3Lf5PbkKofoefXoGeBix9ub36HSsGdGj2hfSlDn5C0Omsnn6Qat
        thOSBDvOYFiB0dGWXkMiCHmmg2Prmv2WqtR7kJSUlR0nNsvoD1zPGeofmzwbmHbP
        OUiyim7dcdJmdfV2QDdzPmu3/giFQ4YldZmyaPZ6eoulTF9TrmirSKN7039GAPD4
        gvASWxVH8FLdq2rRX65Jz8W3k5No0A9QecR1urGCg+/cvrepPqOJSpfzu8IgJs+a
        UxCdnTpruVs+LKaJzYkDTPBTkne6n1nVLemrOlG1R1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FwCYZU
        DxMgkWGg6uCHFZXVW4N/x5lcRe1cTBmLDJqgg=; b=ALf5nvVnOkck2Q61UUIGUi
        vNzGfyW2zGhu98x7yifTr3Rs8XOXl+ZbBmAlx3Wnicm6JHRX0nJXWdTuH/dXGgDW
        eF4/Gh0VXgB9B8/5L6Ml2IEqz+yQGATy8+XaVmRRTcgDmnM6YzgVc44HqCD3rq20
        H8dawmP8Wj0SE6EyjOdl5X7zHvPEiuDxTsWu6sYDDWUzhTdOJedJ73Qd4rWvF8dn
        BWBqqlk6xRmDUjo8JdVlWC1OZu7bcUXPNfOXD+HM3Makonj805+xNmz+yl1jlCxn
        HJ0c7IDu+pfChYPJlg++dBt7OBVIB9NlI1AEIMy1MiiCi6g8LElGqDU9E+Reottw
        ==
X-ME-Sender: <xms:cJXIX-Sf4JIC7__OC2Xg6EdB1zDAv7gzTDh9PxsWbirup4_hBrT9zA>
    <xme:cJXIXzwIcb8j-tygtUTV-V1TzZHi8w9jjIsLf6E64VbHpBrR89020_71sSZoiQENS
    U_lqyG7vp5gPi7pQFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeihedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:cJXIX73BNqcO523rhxRTL2wGKj3idNUVD6ZrzstZKuRhnB53C9WOJQ>
    <xmx:cJXIX6C3fyk6gYpgQjNXZn9wd6REUg7cGj7J11s3Nv1U2sU3TNwCEA>
    <xmx:cJXIX3izHq6IGE4UowvpWR7PP-g6rrcVsnqBrLJqBJx-dfMa-4mohQ>
    <xmx:cpXIX9aWO9sJLwY_7SWA0OubnWT31wuph4Ti3gMSUg21zbXcnUTimA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FBE6240064;
        Thu,  3 Dec 2020 02:36:16 -0500 (EST)
Date:   Thu, 3 Dec 2020 08:36:14 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] clk: sunxi-ng: Make sure divider tables have sentinel
Message-ID: <20201203073614.qx5gnh2pyq43pzf2@gilmour>
References: <20201202203817.438713-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djtqvmtn2k7pwnl5"
Content-Disposition: inline
In-Reply-To: <20201202203817.438713-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djtqvmtn2k7pwnl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 02, 2020 at 09:38:17PM +0100, Jernej Skrabec wrote:
> Two clock divider tables are missing sentinel at the end. Effect of that
> is that clock framework reads past the last entry. Fix that with adding
> sentinel at the end.
>=20
> Issue was discovered with KASan.
>=20
> Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <mripard@kernel.org>

Mike, Stephen, it's the only patch we're going to send your way for this
release, could you pick it up directly?

Thanks!
Maxime

--djtqvmtn2k7pwnl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8iVbgAKCRDj7w1vZxhR
xc4zAP9VcNrRXBS7s7Ao1G9/mvHjDdp2KKKMTQwvJZk0y+1j0QD/XfSWPZzV2yg+
Av03eHwKfrM+WPlXflGRRqPJYtlynwk=
=Z6YE
-----END PGP SIGNATURE-----

--djtqvmtn2k7pwnl5--
