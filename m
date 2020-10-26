Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B60298A55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769653AbgJZKYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:24:34 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47637 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1768771AbgJZKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:24:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EE3808E8;
        Mon, 26 Oct 2020 06:24:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 06:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2ZhRGSvv/jjHAxDiujKncLgDXYt
        agG6O5+IATyPG/uw=; b=m56e3aFo4EM+DxD3fQ+/gn3k8c4WulnKt3jigj2BlCf
        JRc3Dx2aC0INfMRRBsbDIbB84Z7dC2hWkBKmXbRWVmtDi1VvW4+oq9rqHLn9bNsN
        /eQPCZ4jlKAdTpN6D+efZkv4mtU3h2aYuVn74MoARfzZ0amLDsM775VAkN/Ptl41
        2wPwJrM312qJXK8SC6QbZ16G/gKdrpZF0/n7Bm+Nay2Ef+IkeAr8JjhRO/79BcBj
        D1JsQwwyakjRB6dbkovUgh9IjXipqneOI+saNUuMRu5WM9bCfpDTZ4G2D1pXyp5+
        yYeN7LHGYokxloqSu++uQPlQOnIj/VbA86GULKy0iKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2ZhRGS
        vv/jjHAxDiujKncLgDXYtagG6O5+IATyPG/uw=; b=ZwXHFKyYhER5d+Fjj4W25u
        MN1I/MYVwQiZo/t1ozgjdDSar8CcwVDpDh/n6bHvzDg4Fh2j+CbYDBUnTBeuTbbw
        X0Rj/3z8yCtYsa+7QJZoNaL9ZSoBc1XdxOMJefZRuiuooJbe1Tu1XC8ha5G/S/lw
        T6RcQOG92H+2Rc4y+uzrSOq/iER0XG78SiAn8tuhmEN8pYo4BXjJ5s+ieX7950Y1
        k0Y0Obn3eIzskeyGx7GqlqacOBAmvNUjkrKT5yVkoTvY36u4/XrRFeB4+sCzVQL3
        SZFM81qL7ylK8uWMZQXRykx8ZyWZ4poO6SpiN4nDyCv8/gSsvJgqIoQOBYJfo8dg
        ==
X-ME-Sender: <xms:4KOWXzkJDbujYke8sqcX22P5LcVbpGEAITaNgRDsjpbr_rkUkU0DcQ>
    <xme:4KOWX20_WJH7AY9DU-ApYPspJI9QOK77QvNixIKvHIpT3rK4yOiS4oIBsX66Sc7A7
    zPD3EMSAdZ3pox4kqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4KOWX5pHayHjrW9ywwPK7CWCGrPWf_PTH758gY_9JmDB_RiNLRTguQ>
    <xmx:4KOWX7lE3W8huql-iswMIcoFvZc9M_Izbwpu3EDJR3IbduMVyuouDg>
    <xmx:4KOWXx09xHGKVTTJnnPIJW6YxFBA6Y-bQQMD1FnQHqiFb81tA4RyKA>
    <xmx:4KOWX8RDaMFwxTNYD8HpLXRz6IWdz-_eM58_fA7u0sGCEiGnYDwM4A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA3FF3280064;
        Mon, 26 Oct 2020 06:24:31 -0400 (EDT)
Date:   Mon, 26 Oct 2020 11:24:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: a64: bananapi-m64: Enable
 RGMII RX/TX delay on PHY
Message-ID: <20201026102430.co4mzchcjf6lc7y6@gilmour.lan>
References: <20201024162515.30032-1-wens@kernel.org>
 <20201024162515.30032-10-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5uklxrnanoloapf"
Content-Disposition: inline
In-Reply-To: <20201024162515.30032-10-wens@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5uklxrnanoloapf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2020 at 12:25:15AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The Ethernet PHY on the Bananapi M64 has the RX and TX delays
> enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
>=20
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
>=20
> Fixes: e7295499903d ("arm64: allwinner: bananapi-m64: Enable dwmac-sun8i")
> Fixes: 94f442886711 ("arm64: dts: allwinner: A64: Restore EMAC changes")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied all the patches, thanks!
Maxime

--f5uklxrnanoloapf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5aj3gAKCRDj7w1vZxhR
xei5AQCDg8DQPf0s3v3YS4D7UftbO4VY5RXe9WeTfKeURzOZMAD+P04Qwag76lDm
fN2KIDN9tkN4Dht4E5G/UD0iA25wDgs=
=JtBU
-----END PGP SIGNATURE-----

--f5uklxrnanoloapf--
