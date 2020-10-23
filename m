Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239DE296C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461737AbgJWJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:51:19 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49648 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461674AbgJWJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:51:19 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C47371C0B77; Fri, 23 Oct 2020 11:51:14 +0200 (CEST)
Date:   Fri, 23 Oct 2020 11:51:14 +0200
From:   Pavel Machek <pavel@denx.de>
To:     jslaby@suse.cz, gregkh@linuxfoundation.org, jhovold@gmail.com,
        kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
        phone-devel@vger.kernel.org
Subject: gsm muxing for Droid 4
Message-ID: <20201023095113.GA18590@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

a579767c1 interferes with gsmmux patches for Droid 4.

Reverting it gets the stuff to compile again in 5.10-rc0.9.

Best regards

							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+Sp5EACgkQMOfwapXb+vL4FwCaAw1tOTm7NESzUdBI3j3l2AJY
dH0AoKZeT90ELKYjHKezi407t6BH5DEJ
=HBzT
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
