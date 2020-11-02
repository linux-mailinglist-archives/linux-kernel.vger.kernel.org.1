Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77392A2676
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgKBI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:57:02 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46170 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:57:02 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B132F1C0B7D; Mon,  2 Nov 2020 09:56:58 +0100 (CET)
Date:   Mon, 2 Nov 2020 09:56:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201102085658.GA5506@amd>
References: <20201101092614.GB3989@xps-13-7390>
 <20201031101740.GA1875@boqun-laptop.fareast.corp.microsoft.com>
 <20201102073328.GA9930@xps-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20201102073328.GA9930@xps-13-7390>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I'm getting the following lockdep splat (see below).
> > >=20
> > > Apparently this warning starts to be reported after applying:
> > >=20
> > >  e918188611f0 ("locking: More accurate annotations for read_lock()")
> > >=20
> > > It looks like a false positive to me, but it made me think a bit and
> > > IIUC there can be still a potential deadlock, even if the deadlock
> > > scenario is a bit different than what lockdep is showing.
> > >=20
> > > In the assumption that read-locks are recursive only in_interrupt()
> > > context (as stated in e918188611f0), the following scenario can still
> > > happen:
> > >=20
> > >  CPU0                                     CPU1
> > >  ----                                     ----
> > >  read_lock(&trig->leddev_list_lock);
> > >                                           write_lock(&trig->leddev_li=
st_lock);
> > >  <soft-irq>
> > >  kbd_bh()
> > >    -> read_lock(&trig->leddev_list_lock);
> > >=20
> > >  *** DEADLOCK ***
> > >=20
> > > The write-lock is waiting on CPU1 and the second read_lock() on CPU0
> > > would be blocked by the write-lock *waiter* on CPU1 =3D> deadlock.
> > >=20
> >=20
> > No, this is not a deadlock, as a write-lock waiter only blocks
> > *non-recursive* readers, so since the read_lock() in kbd_bh() is called
> > in soft-irq (which in_interrupt() returns true), so it's a recursive
> > reader and won't get blocked by the write-lock waiter.
>=20
> That's right, I was missing that in_interrupt() returns true also from
> soft-irq context.
>=20
> > > In that case we could prevent this deadlock condition using a workque=
ue
> > > to call kbd_propagate_led_state() instead of calling it directly from
> > > kbd_bh() (even if lockdep would still report the false positive).
> > >=20
> >=20
> > The deadlock senario reported by the following splat is:
> >=20
> > =09
> > 	CPU 0:				CPU 1:					CPU 2:
> > 	-----				-----					-----
> > 	led_trigger_event():
> > 	  read_lock(&trig->leddev_list_lock);
> > 					<work queue processing>
> > 	  				ata_hsm_qs_complete():
> > 					  spin_lock_irqsave(&host->lock);
> > 					  					write_lock(&trig->leddev_list_lock);
> > 					  ata_port_freeze():
> > 					    ata_do_link_abort():
> > 					      ata_qc_complete():
> > 					        ledtrig_disk_activity():
> > 						  led_trigger_blink_oneshot():
> > 						    read_lock(&trig->leddev_list_lock);
> > 						    // ^ not in in_interrupt() context, so could get blocked by C=
PU 2
> > 	<interrupt>
> > 	  ata_bmdma_interrupt():
> > 	    spin_lock_irqsave(&host->lock);
> > 	 =20
> > , where CPU 0 is blocked by CPU 1 because of the spin_lock_irqsave() in
> > ata_bmdma_interrupt() and CPU 1 is blocked by CPU 2 because of the
> > read_lock() in led_trigger_blink_oneshot() and CPU 2 is blocked by CPU 0
> > because of an arbitrary writer on &trig->leddev_list_lock.
> >=20
> > So I don't think it's false positive, but I might miss something
> > obvious, because I don't know what the code here actually does ;-)
>=20
> With the CPU2 part it all makes sense now and lockdep was right. :)
>=20
> At this point I think we could just schedule a separate work to do the
> led trigger and avoid calling it with host->lock held and that should
> prevent the deadlock. I'll send a patch to do that.

Let's... not do that, unless we have no choice.

Would it help if leddev_list_lock used _irqsave() locking?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+fydkACgkQMOfwapXb+vKf+wCfdYwRtTj2PLSkRhQL6soc71om
CnwAnAkbcvu35FFbYEAURUuG1ZIvbjp4
=OOW/
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
