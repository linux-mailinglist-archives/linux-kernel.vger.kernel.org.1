Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D2F2A27BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgKBKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:08:36 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39537 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728387AbgKBKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:08:35 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 52F1EE2F;
        Mon,  2 Nov 2020 05:08:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=wINfzHaxXzQ8jIBMOSyRz1H4FRf
        sD1RrGLsMG0I/ZHM=; b=UAjNO9ekdsfb+BRuqnR5xIwoDXazKycj5SebG61I0hK
        1rGoV5Pn5TXPJV+CsGX9+lM6Ijq6WXfqKELSEGkPudjEvPDJ21DmT084spQ+yvNX
        5iwfyd0XdpF3ecuxEsrzntdXaAUDwVTkjo7NYvMJbeynGFyOe9Ov0YAZWA0Q8PUG
        47nCdMlxJOhgHzpuehERI4jcAPHwzU6i0GC4lMHQoFQZwlXZTJ3ieTPwtF7V5GYj
        i4odb3R0YBuszgbWHlAqMhzf98MsbWisRQsBvtVmHDgLnRHnv2u6zAEWKc5N9u3Y
        SCj3VdCkEGlVo8VvNLVNgMQcXGr4Fh5ncbMunl7eRbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wINfzH
        axXzQ8jIBMOSyRz1H4FRfsD1RrGLsMG0I/ZHM=; b=CsvVXc63wfFKV0LpzvMOoQ
        uJbqgYietrdaUHTJXfzV9vSdQXCBSiRYiLbAJbXfV+vQoZfBtqtamoDjP2NZfQAO
        2vYXy7jtfKH2DHW7tSwa7ghY9uwLZi99WlcLttVAUpMvWAYF960mOTfEYL7fb/U+
        xOk9UnpGaVqY200mUQRrVjKPDotXZADyDn5J2/3B3/3nBxDrNsBcSRluGZk7CVml
        BHwtNj6LozPSzpD5cg0zPJMa4iiMzKtYrW1yZcuATt6HZwNIPFVg3pMb8r3KM+Yq
        pfbVm01bNTQa8Sk1Vay9Q0w24jtFatQPpkBQw2raED3+LMf7KYoU43ssf5kp/jwg
        ==
X-ME-Sender: <xms:odqfX7L164JG0lWHx_J4FxUNLvmQUUjtIvhNLKGB-jj0-kgGt7Ct1w>
    <xme:odqfX_KkQ-E6-KYywA-QP0aZB4K5nc9dcf0qaNBKlABd3nw6sypj_6nBXTa2eSXVR
    7L2zZ3L0sEhDPMsAN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:odqfXzv_dpJy166jt1NWdXkx_56BabPGQaoV7XiX1n_gHZn4re28tg>
    <xmx:odqfX0YaQf9Rl7ZvdoUFtLuaoT0Dmdbdx0yF0PgsnKGuXeIiieRO6g>
    <xmx:odqfXybYHlUQAYA_ZRYUKLTlWX_aTB8kDRMqkYqkFktGPPA462_Wzg>
    <xmx:odqfX5xYtsmHyp6J_nxe9_Afxf0Sr0Ae4XX4_5pVpqiLcdUvCqTFjg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04E233064683;
        Mon,  2 Nov 2020 05:08:32 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:08:31 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 3/9] ARM: dts: sun8i-v3s: Add I2C1 PB pins description
Message-ID: <20201102100831.fhuhsn6qzw7aasvg@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-4-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7hhntwrmplkufuao"
Content-Disposition: inline
In-Reply-To: <20201031182137.1879521-4-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7hhntwrmplkufuao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2020 at 07:21:31PM +0100, Paul Kocialkowski wrote:
> I2C1 can be exposed through PB pins in addition to PE pins on the V3s.
> Add the device-tree description for these pins.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Applied, thanks!
Maxime

--7hhntwrmplkufuao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/anwAKCRDj7w1vZxhR
xeUAAP4+u6ICdSeg6HYUBbn33XoSweHePZtGOxExwLsrWdBxwAD/Yw3eTc0hqt/Y
XnNEK3sxQ0Lm/OCv8HUBZLSxyHfjnwk=
=pQxA
-----END PGP SIGNATURE-----

--7hhntwrmplkufuao--
