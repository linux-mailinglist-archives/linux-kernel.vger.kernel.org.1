Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813E42988F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772466AbgJZJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:01:07 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59295 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1770950AbgJZJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:01:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 993202C3;
        Mon, 26 Oct 2020 05:01:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Oct 2020 05:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZVhHc08kr8nC7KZ5EUcxT1LIt24
        PpsTE58kIRlGmRW4=; b=bQzXef1tXDRnCa/26+53msw8Xg91eXl9QWlymg0lZln
        5S4frg+zJraqih8PKZKpH/HPLNFYaxxSultsU6la/DvqlINC2xeFxPzxZnSWUmKs
        VjKsOMjjoMkxeEkzx2sl4iMxIZ4zhgtdWq9xbrB0L5VzzfMBhLnke8NXDEdONhwS
        yGo1EBbA088V030MatRUS4vd8+HF2PxuPah18BKHqEjJJOcxYIDpz3PqnRi5AXNJ
        taCyeQSVvDdb8LxbnaRhhmjUbyLGL+P32N9/yTuJpbG4MlXsk1Amj70QCLLbHgpp
        ml5MPbrVcpRNYxDdB968yEWZcxaP7Idq2vEpffqaE1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZVhHc0
        8kr8nC7KZ5EUcxT1LIt24PpsTE58kIRlGmRW4=; b=dF1MKdU5kKLuIAC9rfeqy2
        TzsKYbaNy8rgDiddB4Bg2AlhoFgcxZKX3w/SFSnmsENh7K1t4tB+dlKUZ8F5BO7Z
        X9qz30MLxyC1hzKP5NVMF6Kr1cXNGkfpMcLDvgsIydvB2VBNlNIwdotdWDr9EYib
        tIJaTXr92+mHuKrmzCvfnBz6fsBZJDwTCd5tlXbc20wTb0DjvO4S+RAdJtiZlUP/
        dzxWMjAVbntjhb/8oOTjhoH2KmXOVtfFZgDPZnt9uqYS0EU6bPDCPF+T8wvSBaZ0
        57sJe6LE9LZ1d8ABJv3GYtumQRsd2vKa8cQiSTQAkEZyNaQqwwnHKt3b1z6JEM5Q
        ==
X-ME-Sender: <xms:T5CWX_dIn3s1P0D0qF1uQp965GJvZUflpNcjul-YHiTWLPHSRy_S4A>
    <xme:T5CWX1MXCnwrPChC3GQQ680OF5znlR_78k93YaIDFrv4971q5w_fXinke3uOVMTWq
    iv9qmxbuNz32gT-7T8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeehgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:T5CWX4jYJFNuc3Pqf7kuuYN2W0ioDXxvtuebR8KTsTQZr44_tbvi2w>
    <xmx:T5CWXw_OfVMgF-OeYptAzRXE6VD2go4ZPv3LMWMyfBNEvAk6KY0Luw>
    <xmx:T5CWX7v6yceZNQQGtVjyasP9T-1e-FMRpB_aVjTOE6Ms-ZA347Zr4A>
    <xmx:UZCWX1Jhvs8jLTy_vW2H5RexT5KLX0Qe595Bbzx7SDAnsXvlTd63Sw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74028328005A;
        Mon, 26 Oct 2020 05:01:03 -0400 (EDT)
Date:   Mon, 26 Oct 2020 10:01:01 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h5: OrangePi PC2: Fix ethernet
 node
Message-ID: <20201026090101.v573ultstlrp3npa@gilmour.lan>
References: <20201023184858.3272918-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mliymakqdhxd5k4d"
Content-Disposition: inline
In-Reply-To: <20201023184858.3272918-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mliymakqdhxd5k4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 08:48:58PM +0200, Jernej Skrabec wrote:
> RX and TX delay are provided by ethernet PHY. Reflect that in ethernet
> node.
>=20
> Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks

Maxime

--mliymakqdhxd5k4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5aQTQAKCRDj7w1vZxhR
xWIWAP0QsbzMvoQtRlXCw4aCHUYm0HC6H0vL70IZepvHn78/3wD/eWGNRJm6/b4y
OZ+LCDx9GHvvv5QMQjSlLHoz9Ff+wgs=
=+DVr
-----END PGP SIGNATURE-----

--mliymakqdhxd5k4d--
