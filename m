Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A772A94A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgKFKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:47:42 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52745 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgKFKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:47:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 395A65C0050;
        Fri,  6 Nov 2020 05:47:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 06 Nov 2020 05:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=efOLdH3OJYRBZoYDXp92v/+XC9F
        fExr4q9aAP+OoJrM=; b=CTpTZf+2LBspGC5I7d2cH9jtj99e/gcXhoPlVUfBjcG
        YXKgE26gvdzOFK1B2IajtZbkoO5IuBsLCK0q0jPVG3TzKtIdnFhhvbij4WINNRHL
        yJiYY7Z4nPslpBMITZ7I3QpYNmBpt40MptEPhegCd0wumyrPP1KyT46tkLDRZMlq
        WVDtisUoHfhExgfA+6QztCWyAdoAiUqXxnsqDokANjqRKCI4Jp6uuX0aVY2z5pdl
        8Kzn/W+yh0xOTpuS+mRpnUXyiwhQhUXQ8EPrVc/37xw8zTVjOj0xia1k1iDlDv5x
        8pIdM2/44f2vyAkzksJCsZJW1JDmxVX34MyHkG4kcMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=efOLdH
        3OJYRBZoYDXp92v/+XC9FfExr4q9aAP+OoJrM=; b=Yr71J2uVa0tXs+Z4jLSYpy
        RcIQqBkaNJ+u1vzwj2XEx/wCmcGWC/JhEpPhbNDmn7qffgoowjtcKO9yLxHyp0ce
        szZChG8YT/5mWS7NqVVULM4OevWvH6TeaCp4ELQuedcERT6kIRjf+Z450o7AzM2q
        KS/Idn/fjJvfCo7t+Rmbkus9AQavqYU19IS9lh1KK16i9FmW8E3eBFcU8cyKFxiq
        JO/v3HlbMWOxT6z7A/opyIB0PDhJmHvAZOclXjZg3D613IzWub7yOECq0OEAiWmQ
        hAYi7xx5RIMfpsSZtOzcvvE24aLGaqtmyK5pnFYloarPVku4zyhCumbhhHhLcA3A
        ==
X-ME-Sender: <xms:ySmlX8CEfuKrQKv_ir9aN-_nPQjtpBPcnHTVGvVPmxPDwXkq_oohfA>
    <xme:ySmlX-ghGURwvAsrq1rbHyy2lbd-xpORN8aPNKGeJCWTj6GMB4mX_ZlcsZ_eelKPW
    fEIAZ0COKxOqQUtAfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ySmlX_k3avwv3qGENg0L_jnUPlf5xnqoVvhxr3xgdghNstl3xPoRhQ>
    <xmx:ySmlXyz38rP8xPAJGAOVgznRZNZnhYAbWoAk-pk0V458P4R8WInxCA>
    <xmx:ySmlXxSKWClLm66fhlnXsH-B6hDXue8R5hNvwxrrb2uaAbxwR8UHXg>
    <xmx:yymlX8dF228bCDs-zncfXddAG74BAeHhho7SF3Fr4MN-pHzLuwX3bQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 695E7306005E;
        Fri,  6 Nov 2020 05:47:37 -0500 (EST)
Date:   Fri, 6 Nov 2020 11:47:36 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ARM: dts: sun8i: s3: Add dts for the Elimo
 Initium SBC
Message-ID: <20201106104736.4oqqez3tx24n64zw@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201105183231.12952-4-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7epf2xmbfg2bxu4h"
Content-Disposition: inline
In-Reply-To: <20201105183231.12952-4-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7epf2xmbfg2bxu4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 06:32:31PM +0000, Matteo Scordino wrote:
> The Elimo Engineering Initium is an Open Source Hardware Single Board
> Computer based on the Elimo Impetus SoM.
>=20
> It is meant as the first development platform for the Impetus, providing
> convenient access to the peripherals on the Impetus.
>=20
> It provides:
> USB-C power input
> UART-to-USB bridge on the USB-C connector, connected to UART1
> USB-A connector for USB2.0 (Host, Device, OTG)
> Audio Line In/Out
> Pin header to access all signals on the M2 connector of the SoM
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>

Applied all three patches, thanks!
Maxime

--7epf2xmbfg2bxu4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6UpyAAKCRDj7w1vZxhR
xX3PAQCjb3GLgMfChlUubYPcObiWqGIx2lpbH7YGDmSgRpHLewD/Tv0TkITiEz4y
XuvgrNnLrEOXHIxMZ1ctzwhqCzJuhA0=
=hQpF
-----END PGP SIGNATURE-----

--7epf2xmbfg2bxu4h--
