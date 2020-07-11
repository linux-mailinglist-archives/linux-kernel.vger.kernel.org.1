Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BB21C46B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 15:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgGKNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 09:30:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34278 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGKNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:30:56 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A696E1C0BD2; Sat, 11 Jul 2020 15:30:53 +0200 (CEST)
Date:   Sat, 11 Jul 2020 15:30:52 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     corbet@lwn.net, Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
Message-ID: <20200711133052.GA6407@amd>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-07-08 00:23:59, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
>=20

> +replacements for 'blacklist/whitelist' are: 'denylist/allowlist' or
> +'blocklist/passlist'.

I don't see what is "non inclusive" about blacklist and whitelist...

Plus, please grep kernel for actual usages. blocklist/denylist is
_not_ suitable replacement for kernel use of blacklist.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8JvwwACgkQMOfwapXb+vKaeACdEuEPBbuseLU7rRRWibY5FYQ8
/BEAnRKhc9QvpKTqxo3q27Du59cpsTcJ
=siog
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
