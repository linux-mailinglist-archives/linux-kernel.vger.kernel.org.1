Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A571F9C24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgFOPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 11:43:30 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52276 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbgFOPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:43:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AEEA11C0BD2; Mon, 15 Jun 2020 17:43:27 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:43:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: 5.8-rc1: new warnings in ext4_mb_new_blocks?
Message-ID: <20200615154327.GA12506@duo.ucw.cz>
References: <20200615073712.GA4164@duo.ucw.cz>
 <20200615112749.104AF52054@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20200615112749.104AF52054@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-06-15 16:57:48, Ritesh Harjani wrote:
>=20
>=20
> On 6/15/20 1:07 PM, Pavel Machek wrote:
> > Hi!
> >=20
> > Booting 5.8-rc1 on x220, I get scary warnings:
> >=20
> > [    7.089941] EXT4-fs (sdb2): mounted filesystem with ordered data mod=
e. Opts: errors=3Dremount-ro
> > [    7.343231] BUG: using smp_processor_id() in preemptible [00000000] =
code: systemd-tmpfile/2788
> > [    7.344052] caller is debug_smp_processor_id+0x17/0x20
> > [    7.344897] CPU: 3 PID: 2788 Comm: systemd-tmpfile Not tainted 5.8.0=
-rc1+ #116
> > [    7.345745] Hardware name: LENOVO 42872WU/42872WU, BIOS 8DET74WW (1.=
44 ) 03/13/2018
> > [    7.346561] Call Trace:
> > [    7.347355]  dump_stack+0x60/0x7a
> > [    7.348170]  check_preemption_disabled+0xb1/0xc0
> > [    7.348951]  debug_smp_processor_id+0x17/0x20
> > [    7.349728]  ext4_mb_new_blocks+0x1f2/0x13e0
> >=20
> > and they continue after boot.
> >=20
>=20
> Below should fix this. I guess it couldn't make it to rc1.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=
=3Dext4-for-linus-5.8-rc1-2&id=3D811985365378df01386c3cfb7ff716e74ca376d5
>=20

Thanks for the pointer. That seems to do the job.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXueXHwAKCRAw5/Bqldv6
8guiAKCi06OakO12Px5x13FW+0WfIKeW0gCgn13UqCbMIIm8oMZbcfkuE5GYl7k=
=cZRe
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
