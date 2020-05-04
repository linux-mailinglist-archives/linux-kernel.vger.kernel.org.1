Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955161C3364
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgEDHNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 03:13:05 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40312 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgEDHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:13:04 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7B34F1C0220; Mon,  4 May 2020 09:13:02 +0200 (CEST)
Date:   Mon, 4 May 2020 09:13:02 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.220-rt196
Message-ID: <20200504071302.GA25605@duo.ucw.cz>
References: <158801696068.26039.9162549222309574579@beryllium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <158801696068.26039.9162549222309574579@beryllium>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's something going wrong with the version numbers:

> I'm pleased to announce the 4.4.220-rt196 stable release.
>=20
> This release is just an update to the new stable 4.4.215 version

> Or to build 4.4.220-rt196 directly, the following patches should be

=2E..
> You can also build from 4.4.215-rt192 by applying the incremental patch:
>=20
> https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.21=
5-rt192-rt196.patch.xz



Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXq/AfgAKCRAw5/Bqldv6
8sfiAJ9seQ3H3hRqPjG3pp3kf5kDrSl9swCgu4QsCbdRs0muOJ6AW118duXE6Sk=
=A98B
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
