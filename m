Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30B62D558E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbgLJIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgLJIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:39:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEBCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:39:04 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knHTY-0006CO-Gt; Thu, 10 Dec 2020 09:39:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knHTX-0005ND-OO; Thu, 10 Dec 2020 09:38:59 +0100
Date:   Thu, 10 Dec 2020 09:38:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thorsten Scherer <thorsten.scherer@eckelmann.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] siox: two cleanups
Message-ID: <20201210083859.wqeuf3ijghbwtyuw@pengutronix.de>
References: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
 <20201125144720.5imcc3atcqpegk4i@ws067.eckelmann.group>
 <X9Edf/Fm6umQ7whL@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oorzviuil7wnh32i"
Content-Disposition: inline
In-Reply-To: <X9Edf/Fm6umQ7whL@kroah.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oorzviuil7wnh32i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 07:54:55PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 25, 2020 at 03:47:20PM +0100, Thorsten Scherer wrote:
> > Hello,
> >=20
> > On Wed, Nov 25, 2020 at 10:31:04AM +0100, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > >
> > > compared to v2 sent starting with Message-Id:
> > > 20201124141834.3096325-1-u.kleine-koenig@pengutronix.de:
> > >
> > >  - fix typo in commit log of patch 1
> > >  - add Ack by Thorsten for patch 1
> > >
> > > Uwe Kleine-K=F6nig (2):
> > >   siox: Use bus_type functions for probe, remove and shutdown
> > >   siox: Make remove callback return void
> >=20
> > Successfully ran our siox testcases on v3.
> >=20
> > Tested-by: Thorsten Scherer <t.scherer@eckelmann.de>
>=20
> Are you going to take these patches, or do you need/want me to take them
> through one of my trees?
>=20
> Either is fine for me.

There is no repo for SIOX and up to know you were our upstream. So if
you could take them that would be great.

Given that I expect that the patch volume for SIOX continues to stay low
I see little benefit in establishing a different work flow.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oorzviuil7wnh32i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/R3qAACgkQwfwUeK3K
7AlrPQgAg2VeOtwrmNPnDD2YIFjHWQc4NE8wxCwVRHvP+trX6GgKlciRxmMv+mFo
m6WYBfA3w1HRaWoHxtGTOyzIn2os/a5coT53XIze/HhKf2QZLFAGFaaHLKg9YJRP
vs2lORov85hSkAIjWxfOOUQT7pmsjg9vQ6S8+iDmfJVnJJAS7VfdvPzPGZg/+thm
p8HHX19Kspd87+QpymEmQIzXOlAMKZkDllwKamO5MC1rzk6BuxuI04Dzx+TCwxdD
sDMF2UCjmswUoE9pAeD84f1p2m2Af/1Tsc51bEqbPdu84yvQuhTIyJ5qS4+iqIBV
I2ZjE+9NWXQTyK5KaMKiRWyRZeVrPA==
=hevz
-----END PGP SIGNATURE-----

--oorzviuil7wnh32i--
