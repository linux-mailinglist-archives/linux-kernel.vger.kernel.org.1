Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C62FF653
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbhAUUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:51:04 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:60694 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbhAUUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:50:51 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3D4BF1C0B94; Thu, 21 Jan 2021 21:50:09 +0100 (CET)
Date:   Thu, 21 Jan 2021 21:50:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.11-rc4-rt1
Message-ID: <20210121205008.GA7149@duo.ucw.cz>
References: <20210121134509.bagsesi4vdtwmdky@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20210121134509.bagsesi4vdtwmdky@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the v5.11-rc4-rt1 patch set.=20
>=20
> Changes since v5.10.8-rt24:
>=20
>   - Updated to v5.11-rc4
>=20
> Known issues
>      - kdb/kgdb can easily deadlock.
>      - kmsg dumpers expecting not to be called in parallel can clobber
>        their temp buffer.
>      - netconsole triggers WARN.

I noticed... lot of code using in_interrupt() to decide what to do is
making it to 5.10-stable at the moment (and I guess that means
vanilla, too).

I have recollection that that is not okay thing to do. Am I right?

Examples: 8abec36d1274bbd5ae8f36f3658b9abb3db56c31,
d68b29584c25dbacd01ed44a3e45abb35353f1de.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYAnpAAAKCRAw5/Bqldv6
8oEXAKCk0REAiCLqUG6sjFaegqIjAVHSzwCgvxYakzqW93bmD7FsEQNM+yGja8I=
=YJrk
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
