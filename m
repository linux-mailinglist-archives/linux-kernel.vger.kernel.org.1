Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF92C89D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgK3QqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgK3QqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:46:16 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961862073C;
        Mon, 30 Nov 2020 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606754735;
        bh=Oh3tU0deY++C3c9fSEU3/i5KpOc3iveL2tcsF2s9Uco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ap9Y4tbjDuDnDzzEGXp19gyhaf74pgh52Qahrg7y2ucf6bdhTiY0aEaIch3eMLJen
         wje+rqRWRXWZPz8Og3Wf+TT/R3zG58O49A1RqyMUAKW1AKLCd4+b7adE2MO5z01RLH
         P2JVW1/yd/j1Els3nybx1fX/egf6/dbj0OsoJEpk=
Date:   Mon, 30 Nov 2020 16:45:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V2 0/9] regulator: da9121: extend support to variants,
 add features
Message-ID: <20201130164506.GD4756@sirena.org.uk>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Space is limited.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 03:42:44PM +0000, Adam Ward wrote:
>   regulator: da9121: add interrupt support
>=20
>  drivers/regulator/Kconfig            |   14 +-
>  drivers/regulator/da9121-regulator.c | 1033 ++++++++++++++++++++++++++++=
++++--
>  drivers/regulator/da9121-regulator.h |  291 ++++++++++
>  include/linux/regulator/da9121.h     |   36 ++
>  4 files changed, 1336 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/regulator/da9121-regulator.h
>  create mode 100644 include/linux/regulator/da9121.h

This adds new compatible strings so needs to update the binding document
too.

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/FIZEACgkQJNaLcl1U
h9CftQf/fl2XdJ8/F5kP1quQjffPcGmM12vnnT1giLEmyB0D5a/tW33woT+4ZAzK
A5ytp9+QXkoUC4OWDk/xu6hFyoX9+Gf8P+nDhJ24fQKlQwK56gb/06bHSE/XiDSY
4qEm4idyExUU5/5QzJk4gSazKD9An9BNeyO6JEBe+dLk4FqPUkOfcsogd1ifyZVP
vK5Z7qhiCa2yNaoUnjjnhmUf4gKdRi3rTkGiiJpTSb+tbrPIAtlJzgQuXm4Kn5BU
K2rJbao2slWNFASutbMzOalF7Ste9Az6+cnfOIq1RWiZIxBsI+wSoo5+O7ktuBW1
yZ9jW/g6SO1R52XiwPgG+HKX+IKxmg==
=5k7c
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
