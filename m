Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5C2D2876
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgLHKHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:07:52 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44917 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgLHKHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:07:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 71AECC2A;
        Tue,  8 Dec 2020 05:07:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 08 Dec 2020 05:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=MEOLIP+NS6eMq7Iml9RvzbqVIuh
        0M0AomDlreTOk230=; b=thL3L7yuf2UqIMd7dYqm0ORC00AInBIytze9c6lSFPv
        /pwVD00VOYj8q/GT6XbLOzdnHu2zasQbsTuWxkRYdIBsZos8ox/pKgovt/rAffjX
        RX5W85c69/yZsgXd/OIfyalI/+oSP6En07FNupYE/z8VErA0eLsTGzCjp1g8Dz2I
        q8WWJOXd3JRCIABOAs1VZ/ju8dulnzmWQTDqKqVd5Bu4ItMJecQxkF6tz6tMlMnW
        QmYKWxSPW1Xfig8tltyw77UPorOwRWR5JuGKunOYYHW2BRGg6sMY1wAOcU6+ncao
        RDP5JXxlIFQPMyw9bbQ0C4QHIxJzaVldvBcivwoDYfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MEOLIP
        +NS6eMq7Iml9RvzbqVIuh0M0AomDlreTOk230=; b=g7jyXSAUebVMPN6DSNQD2n
        Ru/QR4vAcUH/YU4eTxvmVe3BHClip38lHBg2PlBBEFQDxbf5SbmCs608Zhhvy8I5
        Rs10oXQHoLTilBQl6jaG+EUz0YyaIEl7/HqyU+bMQQqXHWplumq8OCxLAhP0FSaf
        8wO/4tO3fyJLs+b9I/lnhcdTyhGmpxwlQ/OiXfDMjo1GgON1QA4FDuZVtSIbSn/k
        9YoUZ/ajehj23+GiNHGVy3NLob3MgV2quAaPUX0UBr/Kv18AT4UUAFrabuHPjvOK
        fw0Kl0fZtX8PxiVsAUSZRf/pr6fdt1U+pxJFclU3R5LelsJtmio31iz2NPI1h3Lw
        ==
X-ME-Sender: <xms:R1DPX7zXVc31oSNtzUMoW-fTCFNh5N6B7AuOuxiwuvy3JDGVaM_skQ>
    <xme:R1DPXzTfpb4ANkR-genAqKsggdb5qPAbHkCAfSd0nx7W94_mAVKwWZYc7-CrMvWIS
    kRmzrdjnQ0p2mJrx9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:R1DPX1UZeQb1M5nxK094XQQJi7qW4OT92bpxpPGVFNgFQHrp3qXsCw>
    <xmx:R1DPX1iTkeMW8wkHrybLj1EvKnzvHTuwWm0ec-ct7w52tSnjRZB8_Q>
    <xmx:R1DPX9CQwBC6-G42pRQT_ncW7IMX0xKp4Z7UZrntMB-yr6IBtHXorQ>
    <xmx:SVDPXw4lbEtpOD8p9AL41ROYRip2iei7-OEUJFwE7x333m38Kpp8zA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D0BFD24005A;
        Tue,  8 Dec 2020 05:07:02 -0500 (EST)
Date:   Tue, 8 Dec 2020 11:07:01 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v3 0/5] Allwinner V3 SL631 Action Camera Support and
 Related Fixes
Message-ID: <20201208100701.jjxvyw6mdgwmkjkl@gilmour>
References: <20201206165131.1041983-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="osbx463ykdjxuz6r"
Content-Disposition: inline
In-Reply-To: <20201206165131.1041983-1-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--osbx463ykdjxuz6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2020 at 05:51:26PM +0100, Paul Kocialkowski wrote:
> This series adds support for the Allwinner V3-based SL631 family of
> Action Cameras, starting with the IMX179 fashion.
>=20
> A few fixes to V3 support are added along the way, most notably support
> for the NMI IRQ controller which is necessary for the AXP209 IRQ.
>=20
> Note that some patches in this series may have already been submitted
> (but not yet merged) by others and are included for the series to build.

Queued all patches for 5.12

Thanks!
Maxime

--osbx463ykdjxuz6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX89QRQAKCRDj7w1vZxhR
xQ8aAQDrIomoTT3W9P1RFtDTWRU58uZT8mGzeZcSxVc/mBdqSgD/dWmbv4fD1acn
e7EnEx9ioL3HpoTHFES0qHHsThdmkAI=
=y1hW
-----END PGP SIGNATURE-----

--osbx463ykdjxuz6r--
