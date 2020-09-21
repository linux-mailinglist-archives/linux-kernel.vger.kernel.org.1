Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30D272436
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgIUMwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:52:40 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47126 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:52:40 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A60241C0B81; Mon, 21 Sep 2020 14:52:37 +0200 (CEST)
Date:   Mon, 21 Sep 2020 14:52:37 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Pavel Machek <pavel@denx.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, johan@kernel.org, gustavoars@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: yurex: Rearrange code not to need GFP_ATOMIC
Message-ID: <20200921125237.GA24776@duo.ucw.cz>
References: <20200920084452.GA2257@amd>
 <1600691092.2424.85.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <1600691092.2424.85.camel@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Move prepare to wait around, so that normal GFP_KERNEL allocation can
> > be used.
> >=20
> > Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> Ehm. Please recheck.

Sorry about that.

> > +++ b/drivers/usb/misc/yurex.c
> > @@ -489,10 +489,10 @@ static ssize_t yurex_write(struct file *file, con=
st char __user *user_buffer,
> >  	}
> > =20
> >  	/* send the data as the control msg */
> > -	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
> >  	dev_dbg(&dev->interface->dev, "%s - submit %c\n", __func__,
> >  		dev->cntl_buffer[0]);
> > -	retval =3D usb_submit_urb(dev->cntl_urb, GFP_ATOMIC);
> > +	retval =3D usb_submit_urb(dev->cntl_urb, GFP_KERNEL);
>=20
> URB completes here. wake_up() returns the task to RUNNING.
>=20
> > +	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
>=20
> Task goes to TASK_INTERRUPTIBLE
>=20
> >  	if (retval >=3D 0)
> >  		timeout =3D schedule_timeout(YUREX_WRITE_TIMEOUT);
>=20
> Task turns into Sleeping Beauty until timeout

Is there way to do the allocations for submit_urb before the
prepare_to_wait? GFP_ATOMIC would be nice to avoid... and doing
GFP_ATOMIC from normal process context just because of task_state
seems ... wrong.

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2iiFQAKCRAw5/Bqldv6
8tnrAJ4yv71+Q+P6ArjsrTPlDQ7nQ+QIrQCdHjymlZ8hQ7EqYgentvBFzwxh0s0=
=RmqP
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
