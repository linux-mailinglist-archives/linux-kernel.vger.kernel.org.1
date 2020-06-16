Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35031FB3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgFPOJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 10:09:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:42810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbgFPOJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:09:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5ACE0ABE4;
        Tue, 16 Jun 2020 14:09:57 +0000 (UTC)
Message-ID: <d3346d7cb9655eb111b4126d72a08499c6254fef.camel@suse.de>
Subject: Re: [PATCH v4 4/5] dm: pci: Assign controller device node to root
 bridge
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Simon Glass <sjg@chromium.org>
Cc:     Matthias Brugger <mbrugger@suse.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
        lk <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Date:   Tue, 16 Jun 2020 16:09:49 +0200
In-Reply-To: <CAPnjgZ2jarQArKN=0h0mNnxE7gAL0juvGhMxMF4a0CehqxWcRw@mail.gmail.com>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
         <20200612164632.25648-5-nsaenzjulienne@suse.de>
         <CAPnjgZ2jarQArKN=0h0mNnxE7gAL0juvGhMxMF4a0CehqxWcRw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hRzj0/dqG4z0PRQp4I9N"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hRzj0/dqG4z0PRQp4I9N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-16 at 07:43 -0600, Simon Glass wrote:
> Hi Nicolas,
>=20
> On Fri, 12 Jun 2020 at 10:47, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > There is no distinction in DT between the PCI controller device and the
> > root bridge, whereas such distinction exists from dm's perspective. Mak=
e
> > sure the root bridge ofnode is assigned to the controller's platform
> > device node.
> >=20
> > This permits setups like this to work correctly:
> >=20
> >         pcie {
> >                 compatible =3D "...";
> >                 ...
> >                 dev {
> >                         reg =3D <0 0 0 0 0>;
> >                         ...
> >                 };
> >         };
> >=20
> > Without this the dev node is assigned to the root bridge and the
> > actual device search starts one level lower than expected.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/pci/pci-uclass.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> Can you update the tests to handle this case please?

I'd be glad to, but I'm not familiar with the test FW in u-booy, coud give =
me
some pointers on where/how to test this?

Regards,
Nicolas


--=-hRzj0/dqG4z0PRQp4I9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7o0q0ACgkQlfZmHno8
x/6vIAgAinbtz9aWXY9OMZDE68tOQOYWeDK5wVp7zlk4hA1VI1QmdSWkZ0KV6f+r
GV+XxzmIAvxhv/G50aP5kqKy7KxB7oWTHCI4usPn3614DBKkxTrpshmmb+QiTCIM
ugTFiw34xaKlSh4MVsiUSp4R737RR5GoX+iajIsLNpITw875SPNn6GdzyL/KWm80
2ho2ptk0k+7o/2BXJpJ4BBcXgBBt74TZ7V/u4+LDbt1ZmRW5EGnxggl4W0vxed4n
xULWrW1ipAI+7E/BDNibGEb8cVbaKBcrDg4hdKBKZWLkavJctCwoWfCXGiNOvPM6
u4lYBsRWWCjDXmjx+rU+UGiVQqDVSw==
=cIdv
-----END PGP SIGNATURE-----

--=-hRzj0/dqG4z0PRQp4I9N--

