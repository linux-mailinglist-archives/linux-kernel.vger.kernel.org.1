Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9F42A2C46
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBOHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:07:21 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:52271 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKBOHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:07:20 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 73135E26;
        Mon,  2 Nov 2020 09:07:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 09:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=6pjAAzn4bGnUGxwS8ieUNt5m6qs
        NflBdQvF5aGF2P2w=; b=Hjdn924FFnWuPRB4F8/+FSCWRyeX/JhjEKRXwhnQs5k
        Hgm1L5m5MpPr1IG8ycIfgPrPEf4cGXajTe7mAMeMqYuqgHrYOjhk7bx06yJ/WTMo
        WntZjCF/rZqySIo6nDb/qsXF7xb+kYvxvzBVsUohk7Z5EfvHuPILZ706HEnO1OtX
        iahPA7RIkpq/cTpdaisF5LaGBX/727mWZeupFRrb6+LZt43tUzZ+UUMJAQQTbZ7E
        9hOw9JO+qSxtCUiEG1/VWPGNh46vyZtJPAns7qTP6IaC2dLQU9IEuN6vgBLnrouL
        fXy2TfxBVqGCXR1oj/ZnhFCnwf4jjBG11VZfRAQipTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6pjAAz
        n4bGnUGxwS8ieUNt5m6qsNflBdQvF5aGF2P2w=; b=bB5eOpq61J2TIvAkMChz7Q
        lI4/aJyt6NpIT+TCBWFXtgtzaeMfQ1kAaOYnfufPluqu+aXti6WZkZe0keT7ZhoD
        xVLI9CxnqqZzxLYovJJRNK1EUkpDi1mVQDdGBVLTpsR/ElMkkxwOxpDwJuWK7BAm
        //WThqKRCRtdUk0XnZBZjfLF45AGPdFuLWrHE8EBlKtNehCUw1Qbwf8jVk1MQxaw
        uk9EqN+Ct2eyH5DpDBQduQJBi3H6FtNluJqr7qffV/xLIPeLVnwtX649Fms1+dr4
        Q9g2mxF7xryZhGKbzqFpLd+UXKNq0K3rmLUH0cVsZlLqkTYUnWEiw05kznhmgj7g
        ==
X-ME-Sender: <xms:lBKgX1VJJyVoeHNmeTlQBhqtzz8hvAG76d7jnn_h_wndadh_jzuZ_g>
    <xme:lBKgX1mz7rVRcJNq5K69LlcTARUwucHaoHLC8TYtaF32w9C741gdME65-tUpuBM9i
    QR6evK_vmiJ3JAj8DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lRKgXxarMGc060ANBcd63kZDzeqVsdayly4WKqqLH-B3AD31m2Rfrw>
    <xmx:lRKgX4UImrp6Z-hCNAuLD_6S8dde13dtHQDIepaPccs8DkN-WxrgNg>
    <xmx:lRKgX_niHEQhqAfTsykk1jcQK3ug7uavN9_BpkDyxILizdgxwR7ERg>
    <xmx:lxKgX9XFv6U-tVIW9nczrIJ1kujyHr_JptUSgmARHIUp7w9l05mxWw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AACA93280059;
        Mon,  2 Nov 2020 09:07:16 -0500 (EST)
Date:   Mon, 2 Nov 2020 15:07:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun7i: bananapi: Enable RGMII RX/TX delay on
 Ethernet PHY
Message-ID: <20201102140715.r72yz7jx3usuhqi7@gilmour.lan>
References: <1604190857-3078-1-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jqpl26c6tdknkwl4"
Content-Disposition: inline
In-Reply-To: <1604190857-3078-1-git-send-email-pgreco@centosproject.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jqpl26c6tdknkwl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 31, 2020 at 09:34:15PM -0300, Pablo Greco wrote:
> The Ethernet PHY on the Bananapi M1 has the RX and TX delays enabled on
> the PHY, using pull-ups on the RXDLY and TXDLY pins.
>=20
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
>=20
> Fixes: 8a5b272fbf44 ("ARM: dts: sun7i: Add Banana Pi board")
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Thanks for sending those patches.

However, I'm not entirely sure how you sent it but the odd threading you
used (each other patches being in reply to this one without 0/N in the
name) seem to confuse the tools we use to apply the patches.

Can you resend it properly?
Thanks!
Maxime

--jqpl26c6tdknkwl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6ASkwAKCRDj7w1vZxhR
xZeSAPoCDlgzwSbXeAApsmFdr2R9H+CLTz5aAts/EOsxs3PZnQD/bp1BJHX57Ud8
uMjSs/37Mfb81/ALV5ejMqQVAAdCfAw=
=rUm3
-----END PGP SIGNATURE-----

--jqpl26c6tdknkwl4--
