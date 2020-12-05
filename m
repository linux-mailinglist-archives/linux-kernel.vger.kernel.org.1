Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0852CFEEE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 21:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLEUtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 15:49:33 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:37890 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLEUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 15:49:31 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 326FA1C0B8D; Sat,  5 Dec 2020 21:48:35 +0100 (CET)
Date:   Sat, 5 Dec 2020 21:48:34 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
Message-ID: <20201205204834.GC8578@amd>
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
 <CAKdAkRRq=GK7N1PDJ4zLfJVSsrd1BB=u69aXtJHh=sW4vn5LOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <CAKdAkRRq=GK7N1PDJ4zLfJVSsrd1BB=u69aXtJHh=sW4vn5LOg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On Fri, Nov 27, 2020 at 12:51 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > >  - Some DT patches for the Rockchip RK3399 platform,
> > >    in particular fixing the MMC device ordering that
> > >    recently became nondeterministic with async probe.
> >
> > Uhhuh.
> >
> > I didn't realize this MMC breakage happened.
> >
> > That's just an MMC bug. Other subsystems have been able to do async
> > probing without making device ordering be random.
> >
> > So this really smells wrong, and I just never realized.
> >
> > Added Douglas Anderson to the cc - the whole PROBE_PREFER_ASYNCHRONOUS
> > behavior appears broken.
> >
> > You basically should do the device numbering synchronously (or better
> > yet - asynchronously, but single-threaded for the subsystem), and then
> > asynchronously probe the actual device details after you've numbered
> > them reliably.
>=20
> Generally speaking it is either unnecessary for a lot of devices where
> we do not care what number they get, harmful (why do I need to probe
> i2c touchscreen and touchpad sequentially if I do not care which one
> comes first but my boot will take 0.5 seconds longer if I serialize),
> or impossible (if device is hit-pluggable). For many years userspace
> has been moving away from static device assignments and we should not
> be going back.

Lets not make userspace's life harder than it should be.

You can't break existing configurations, and people still use
root=3D/dev/mmcblkX. Recently kernel on Droid 4 switched from MMC on
mmcblk0 and mmcblk1 to MMC on mmcblk0 and mmcblk2. Of course that
broke my config.

And I'm fairly sure I'm not alone.

(And it may not be this bug, and I do have workaround now.)

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/L8iIACgkQMOfwapXb+vJiEACgn18v+/EzhNIclf1Mh8seK6kI
JIoAnikMuD1kNbKhB4/JxIujWDxJxAvD
=Ro3a
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
