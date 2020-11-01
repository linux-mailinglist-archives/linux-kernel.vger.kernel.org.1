Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63FA2A1F85
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgKAQ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:28:40 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50554 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:28:40 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 946CB1C0B8D; Sun,  1 Nov 2020 17:28:38 +0100 (CET)
Date:   Sun, 1 Nov 2020 17:28:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201101162838.GA24370@duo.ucw.cz>
References: <20201101092614.GB3989@xps-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20201101092614.GB3989@xps-13-7390>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm getting the following lockdep splat (see below).
>=20
> Apparently this warning starts to be reported after applying:
>=20
>  e918188611f0 ("locking: More accurate annotations for read_lock()")
>=20
> It looks like a false positive to me, but it made me think a bit and
> IIUC there can be still a potential deadlock, even if the deadlock
> scenario is a bit different than what lockdep is showing.
>=20
> In the assumption that read-locks are recursive only in_interrupt()
> context (as stated in e918188611f0), the following scenario can still
> happen:
>=20
>  CPU0                                     CPU1
>  ----                                     ----
>  read_lock(&trig->leddev_list_lock);
>                                           write_lock(&trig->leddev_list_l=
ock);
>  <soft-irq>
>  kbd_bh()
>    -> read_lock(&trig->leddev_list_lock);
>=20
>  *** DEADLOCK ***
>=20
> The write-lock is waiting on CPU1 and the second read_lock() on CPU0
> would be blocked by the write-lock *waiter* on CPU1 =3D> deadlock.
>=20
> In that case we could prevent this deadlock condition using a workqueue
> to call kbd_propagate_led_state() instead of calling it directly from
> kbd_bh() (even if lockdep would still report the false positive).

console.c is already using bh to delay work from
interrupt. But... that should not be neccessary. led_trigger_event
should already be callable from interrupt context, AFAICT.

Could this be resolved by doing the operations directly from keyboard
interrupt?

Best regards,
								Pavel
--=20
HTTP://www.livejournal.com/~pavelmachek

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX57iNgAKCRAw5/Bqldv6
8q64AJ9ySHeDJIbc0UtT7/FudduzVYeDZgCcCDzwb2D9psrvx8E6Kk6GTLRG1oA=
=ggM2
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
