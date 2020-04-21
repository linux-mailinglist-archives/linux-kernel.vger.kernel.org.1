Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B671B2216
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 10:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgDUIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 04:54:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUIy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:54:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38680AC19;
        Tue, 21 Apr 2020 08:54:56 +0000 (UTC)
Message-ID: <3f46cb2631eddda754660586942e31ece27a7f00.camel@suse.de>
Subject: Re: [PATCH v2 0/2] of: property: fw_devlink misc fixes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Apr 2020 10:54:55 +0200
In-Reply-To: <CAGETcx-9VbdgNUUstbrGzoAA=4s+EPCznG9LrDoj+Gz-C5g__A@mail.gmail.com>
References: <20200417165442.1856-1-nsaenzjulienne@suse.de>
         <500e8c46a9b411aed03965b6f9130ccde457193d.camel@suse.de>
         <CAGETcx8EJiLSV8jzrusim6EvyVvX4H8ANvZaJwO72G1=iS-N2Q@mail.gmail.com>
         <1363207183f599732f8bb9c97624886df42ced13.camel@suse.de>
         <CAGETcx-9VbdgNUUstbrGzoAA=4s+EPCznG9LrDoj+Gz-C5g__A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-x/mMMiywm3NLqi84RTEV"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-x/mMMiywm3NLqi84RTEV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-04-20 at 15:37 -0700, Saravana Kannan wrote:

[...]

> On Mon, Apr 20, 2020 at 4:29 AM Nicolas Saenz Julienne
> > Well, long story short, we need to create a relationship between RPi4's=
 PCI
> > bus
> > (which hangs from an interconnect in DT) and RPi4's co-processor, which=
 has
> > a
> > highly unconventional firmware driver (raspberrypi.c in drivers/firmwar=
e).
> > The
> > PCI bus just needs the co-processor interface to be up before probing,
>=20
> I'm guessing it still works fine today by doing a deferred probe and
> you are just trying to avoid having to do a deferred probe? I haven't
> kept track of RPi4's upstream support status.

Yes that's the idea, and here's the patch I'm trying to avoid:
https://lkml.org/lkml/2020/3/24/1508

> > that's
> > all (I'll spare you the details of why). Ideally we want to avoid addin=
g
> > platform specific code into an otherwise generic bus driver as it'll be=
 used
> > by
> > a number of unrelated SoCs, and it's generally frowned upon.
>=20
> Which PCI driver is that specifically (I'm sure I can dig around to
> find RPi4's DT and figure it out, but it's easier to just ask :) ) ?
> Also, can you point me to the DT and the nodes that we are talking
> about here (the PCI and the firmware nodes)?

So the PCI driver is pcie-brcmstb.c, its DT node is available in bcm2711.dt=
si
(search for pcie0), the firmware interface is defined in bcm2835-rpi.dtsi
(search for firmware).

> > There is no generic property to handle this case, and it's very unlikel=
y
> > there
> > will ever be one, since these firmware drivers have very little in comm=
on. I
> > guess this could make an argument for a generic _last resort only_
> > 'supplied-by' property, but I bet this solution won't be very popular.
>=20
> Ha, this was my initial idea for the whole fw_devlink feature. I
> called it depends-on. Rob/Frank convinced me to instead just parse the
> existing bindings -- which was definitely the right call. Otherwise DT
> would have been a mess. Adding support for "depends-on" for one off
> use cases might still be a touchy topic. I myself am on the wall. It's
> useful for some rare cases, but it's also very easy to abuse.

Yes, I agree.

Regards,
Nicolas


--=-x/mMMiywm3NLqi84RTEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6etN8ACgkQlfZmHno8
x/5iawf7BTQw06REeScbP1NwdwiT6Dy4de3QZwZHOpEpGiDMRhpHAFQPAw2GLQZA
IETdrZhYKVlJ0K4b+EiyzsMfHd7pOu2IZxychPH91Z971IVj/PHiEcZKJ/GkXXGJ
7okg3/Y3MOErB7t982rgpZS9wvcrJ4UpvlhRof7kPmq6QmDDd3iBE/mw5cILtiFm
641ceC5ql+p2YU7Ms7na87pc+SCUWrYxEDFTyLShtST1z+l3PZjNCnLPLdiKwFGA
cTQzufwgkon8omKOUWpDiTsBmmdSfVHX7I/voNxmdbj4ARozvrBtCwnXBRAW0u8V
8W8q+Gmd/GeXFYVnHtGu0M/CRzIF1g==
=bcnh
-----END PGP SIGNATURE-----

--=-x/mMMiywm3NLqi84RTEV--

