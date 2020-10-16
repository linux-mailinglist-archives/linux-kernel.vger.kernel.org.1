Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54872908A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436481AbgJPPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:39:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408467AbgJPPjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:39:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9B58B20E;
        Fri, 16 Oct 2020 15:39:09 +0000 (UTC)
Message-ID: <4c7821270385ff8e0ff62b3089937c66b0cddb61.camel@suse.de>
Subject: Re: [RFC] of/platform: Create device link between simple-mfd and
 its children
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, f.fainelli@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Oct 2020 17:39:08 +0200
In-Reply-To: <CAGETcx9OxQKtYwYtHS7brKpUxfbcbd+VWju3tB1MSPR4dUYxQg@mail.gmail.com>
References: <20201015114346.15743-1-nsaenzjulienne@suse.de>
         <CAGETcx9OxQKtYwYtHS7brKpUxfbcbd+VWju3tB1MSPR4dUYxQg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rZftYOS0Ip3+xweUCmyU"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rZftYOS0Ip3+xweUCmyU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana, thanks for your comments.

On Thu, 2020-10-15 at 09:52 -0700, Saravana Kannan wrote:
> On Thu, Oct 15, 2020 at 4:43 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > 'simple-mfd' usage implies there might be some kind of resource sharing
> > between the parent device and its children. By creating a device link
> > with DL_FLAG_AUTOREMOVE_CONSUMER we make sure that at no point in time
> > the parent device is unbound while leaving its children unaware that
> > some of their resources disappeared.
>=20
> Doesn't the parent child relationship already ensure that? If not,
> maybe that's what needs fixing?

Well as Rob puts it, we're not using simple-mfd as it was intended. So that
pretty much settles it for generic solutions.

>=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[...]

>=20
> > - If applying this to all simple-mfd devices is a bit too much, would
> >   this be acceptable for a specific device setup. For example RPi4's
> >   firmware interface (simple-mfd user) is passed to consumer drivers
> >   trough a custom API (see rpi_firmware_get()). So, when unbound,
> >   consumers are left with a firmware handle that points to nothing.
>=20
> You can always create device link between the real suppliers and consumer=
s.

RPi's firmware consumers use a custom API to get a handle to the firmware
interface itself, rpi_firmware_get(). So no trace of the relationship is
expressed in DT. If the firmware interface device, the supplier, is unbinde=
d,
that firmware handle now points nowhere and consumers will end up triggerin=
g
kernel panics. Would it make sense to make a device link between the two in
that case? Or I'd be, again, abusing the concept?

Regards,
Nicolas


--=-rZftYOS0Ip3+xweUCmyU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+JvpwACgkQlfZmHno8
x/5UyQgAg2qA6h5GtHZ+l6l3bTzOL5CqncsfgCr4C4Q2JLyYdE2FDnWJCVCHkrPY
KsANnx3naPvcu8PpA3HKFQp184RdDTSKKQjdA8bkbWoMka4yNloQgfeflLvRicKJ
7KFw+70SZAjf8j9UpgbVKLDodIjo9RuFXPqI7SAz4nv6FFgeQPGyCDQlyZ/R2MCR
+dkKLI1W/bV54BmHl8jTiUJXkNXxRJg87b5l7gC9nYLa4YDRjkpcpfjNlBLqo4tk
Ow2PFS68yxh0L4cy5qjsSQ1ZWpmjdyFlyHUAYn4BUEkGtQRdPirzr7OS5bBhP0zH
6ODnCnDgM08HtaTpf5Zyba2NqKyp1w==
=IIUC
-----END PGP SIGNATURE-----

--=-rZftYOS0Ip3+xweUCmyU--

