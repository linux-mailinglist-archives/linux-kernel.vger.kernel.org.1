Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BCC2F323C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbhALNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbhALNxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:53:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2C9723109;
        Tue, 12 Jan 2021 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610459570;
        bh=ybnUi5z0HlJzczbJA/zh6uzuqgX4GFPAw52BtZ5QGco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLTEal0MLhseZ2IUmbvd6fG9MhUsW6e92TBqhjx1uAIGDHX2UsTV1hQZRCbp5Txu5
         QHs/MV2EA3E7JwjqrfdktJOsNMkey2/bQVi5YOtoBljF0nbYgHlX1sKo2JKvr/ACAV
         80I94tDJbAe4I/s7jwiyJziWwNiB9tWt/h+jcGF+0925g0I52Hp81YKnbtkya37EFC
         i0a4xs8wO4Y8oe2aL5I6iNDL9g7Buy/lMgAaINOKxiIE6Pg7JoGjakPWlC8uvxzU4B
         FdeIyB3smoGIz4FJ1JCKC4Addiz95vElWTJKXbXngHtYwsqrFLksQg1ZMkPY02B8J1
         1s5AeLoRWCSJg==
Date:   Tue, 12 Jan 2021 13:52:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Axel Lin <axel.lin@ingics.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Gene Chen <gene_chen@richtek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v3 1/2] regulator: mt6358: Add OF match table
Message-ID: <20210112135217.GB4646@sirena.org.uk>
References: <20210112100659.19350-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20210112100659.19350-1-matthias.bgg@kernel.org>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2021 at 11:06:57AM +0100, matthias.bgg@kernel.org wrote:

> The binding documentation mentions that a compatible is required for the
> MT6358 device node. But the driver does not provide a OF match table.
> This way auto-loading is broken as the MFD driver that registers the
> device has a .of_compatible set which makes the platform .uevent
> callback report a OF modalias, but that's not in the module.

As previously discussed it'd be better to fix the binding document to
deprecate the requirement for the compatible and remove the usage from
the MFD.

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/9qZAACgkQJNaLcl1U
h9AvHQf/dZnoemzOHIqA+LE6lhqqLgw9NX1cTsb4oncHJaYArCHM3ThlY46CGnLD
Syjh2P+iIa92uQfKgQ+MT6m0mUbAsm+tCf73biTyC1pklvnQm3gxwGLkOAWLngI1
QQxwoHfK8y/KLSg9ZS4w0m4zygVA2QP+BwVv0XbfHI7yd3ZTWDHOU61hSACdjDM8
b6D2UvgsPDHhMOygohWy3N9hlZaRN6oU85vqKBmM4JnlkRtk3+XaVZEj+gmpl+tw
zi9wc42wGDkCcaCGDWOEAKKY/a5ZalRdOfooNvU1zyUtndiEUbzHb4bLnFZVTkYJ
J/GpwTyz30GmsTOmFVCeoH2dtnFzdA==
=+RD0
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
