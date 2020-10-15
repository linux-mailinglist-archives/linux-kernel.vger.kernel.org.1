Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D933C28EFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbgJOKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:12:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45042 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389117AbgJOKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:12:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 920741C0B77; Thu, 15 Oct 2020 12:12:23 +0200 (CEST)
Date:   Thu, 15 Oct 2020 12:12:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de
Subject: 5.10-rc0: build error in ipi.c
Message-ID: <20201015101222.GA32747@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting build problems in 5.10-rc0 in config for n900. ARM board.

CONFIG_SMP=3Dy
CONFIG_SMP_ON_UP=3Dy


  CC      net/devres.o
  kernel/irq/ipi.c: In function =E2=80=98irq_reserve_ipi=E2=80=99:
  kernel/irq/ipi.c:84:9: error: implicit declaration of function
  =E2=80=98__irq_domain_alloc_irqs=E2=80=99; did you mean =E2=80=98irq_doma=
in_alloc_irqs=E2=80=99?
  [-Werror=3Dimplicit-function-declaration]
    virq =3D __irq_domain_alloc_irqs(domain, virq, nr_irqs,
  NUMA_NO_NODE,
           ^~~~~~~~~~~~~~~~~~~~~~~
	            irq_domain_alloc_irqs
		    cc1: some warnings being treated as errors
		    make[2]: *** [scripts/Makefile.build:283:
  kernel/irq/ipi.o] Error 1
  make[1]: *** [scripts/Makefile.build:500: kernel/irq] Error 2
  make: *** [Makefile:1775: kernel] Error 2
  make: *** Waiting for unfinished jobs....
    CC      net/socket.o

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+IIIYACgkQMOfwapXb+vKZZQCeLEfZOC9LaVWo9DUj5JCpC8J3
nPIAnj6c3FLYocdbOyrdByiz1w3qrtSC
=E2QX
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
