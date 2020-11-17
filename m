Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE5E2B5AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKQIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:01:45 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:47918 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgKQIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:01:45 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B7CFD1C0B8D; Tue, 17 Nov 2020 09:01:42 +0100 (CET)
Date:   Tue, 17 Nov 2020 09:01:42 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hussam Al-Tayeb <ht990332@gmx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion: Lengthen the review period for stable releases from
 48 hours to 7 days.
Message-ID: <20201117080141.GA6275@amd>
References: <17c526d0c5f8ed8584f7bee9afe1b73753d1c70b.camel@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <17c526d0c5f8ed8584f7bee9afe1b73753d1c70b.camel@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-11-14 17:40:36, Hussam Al-Tayeb wrote:
> Hello. I would like to suggest lengthening the review period for stable
> releases from 48 hours to 7 days.
> The rationale is that 48 hours is not enough for people to test those
> stable releases and make sure there are no regressions for particular
> workflows.

You should probably cc stable list and Greg with this.

And yes, I believe that would be good idea.

Plus the period is very often shorter than advertised, which might be
also good to fix.

Best regards,
								pavel

--=20
http://www.livejournal.com/~pavelmachek

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+zg2UACgkQMOfwapXb+vKrlACgomu7nU34UBIpGCwSQQmDxDa9
yVwAoMOapnFqF2qGAVGJFZ43JRMDnHXd
=6cR1
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
