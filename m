Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565CC2C2EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbgKXRgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733153AbgKXRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:36:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:36:54 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khcFI-0005wY-Of; Tue, 24 Nov 2020 18:36:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khcFI-0000r4-3J; Tue, 24 Nov 2020 18:36:52 +0100
Date:   Tue, 24 Nov 2020 18:36:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/2] siox: Use bus_type functions for probe, remote and
 shutdown
Message-ID: <20201124173646.axg57qje5gpsi4ze@pengutronix.de>
References: <20201119132311.2604232-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4rz6hprqus7rhppz"
Content-Disposition: inline
In-Reply-To: <20201119132311.2604232-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4rz6hprqus7rhppz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 19, 2020 at 02:23:10PM +0100, Uwe Kleine-K=F6nig wrote:
> The eventual goal is to get rid of the callbacks in struct
> device_driver.

Just for the record: I send a v2, so you can discard this series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4rz6hprqus7rhppz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+9RKsACgkQwfwUeK3K
7Amdqgf8Ccnm8Jzn+5D6GN0YSARg7t15IBoVOryiRqDcOGUcvhnawVwn+hcqRu1D
rE2TjDeKrqcYbribq8NmSTYRUpPI0mBtUyfhonAiNyAn2SQnlxuULIrkM/0g61TQ
+NLF0WPjMefhay/yiPYUVG+XvM302Ny7QFMjHqqjKxo5Q30WD3A58oHzVhd2ayyL
peu2wBnB3VNAWJT0u99jyCbIQxIZNPAR4eOSStdioi92RIJP3ArRg9+EHLJPf/Xg
GNNtb8xvdwMuYm7tbpOcYLRUzOoFVgoJOVwfymK+te5g5Z9/PSHnMGNc5cy4gTyC
2wU71qCovdvc8WQt74GbleqSnr5FBA==
=C7sZ
-----END PGP SIGNATURE-----

--4rz6hprqus7rhppz--
