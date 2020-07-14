Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66D21F98A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgGNSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 14:35:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48932 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:35:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 634131C0BD5; Tue, 14 Jul 2020 20:35:13 +0200 (CEST)
Date:   Tue, 14 Jul 2020 20:35:12 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.19.132-rt59
Message-ID: <20200714183512.GA18816@duo.ucw.cz>
References: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> I'm pleased to announce the 4.19.132-rt59 stable release.
>=20
> This release is just an update to the new stable 4.19.132
> version and no RT specific changes have been made.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v4.19-rt
>   Head SHA1: 1eebf4069aa37e54330cce9a42608517ea6996fe
>=20
> Or to build 4.19.132-rt59 directly, the following patches should be
> applied:

Thanks a lot.

But now I am confused, I completely missed announcements for
v4.19.127-rt55 to v4.19.131-rt58.

And for example -rt56 is not listed in

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.19/older/sha=
256sums.asc

=2E..aha, and the versions do not have signed tags, either:

pavel@amd:~/cip/k$ git show v4.19.131-rt58
fatal: ambiguous argument 'v4.19.131-rt58': unknown revision or path not in=
 the working tree.

Is that because they were created just as quick steps towards -rt59?

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXw364AAKCRAw5/Bqldv6
8rOPAJ9qkGbTCIP1F9HTh+ef752cxTiLZACcCjVOsvnHNrg5exKcv5zgou5X9Xc=
=QjTP
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
