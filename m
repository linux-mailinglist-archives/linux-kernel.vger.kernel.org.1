Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D192A020F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgJ3KDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:03:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47383 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3KDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:03:30 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CMyYr3Vlvz1qsZq;
        Fri, 30 Oct 2020 11:03:28 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CMyYr2Yqhz1qsX6;
        Fri, 30 Oct 2020 11:03:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id nIvhleJi1drz; Fri, 30 Oct 2020 11:03:26 +0100 (CET)
X-Auth-Info: gud4iyWn4GyHtz0vQS4y9GXSDNbsg+3/gBpY/WHjLF4=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 30 Oct 2020 11:03:26 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:02:29 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     GNU C Library <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support
 plans in Linux time namespaces
Message-ID: <20201030110229.43f0773b@jawa>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/gUM4x0hyt5rpW=rxvYzDQjJ"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gUM4x0hyt5rpW=rxvYzDQjJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrei, Dmitry,

I do have a question regarding the Linux time namespaces in respect of
adding support for virtualizing the CLOCK_REALTIME.

According to patch description [1] and time_namespaces documentation
[2] the CLOCK_REALTIME is not supported (for now?) to avoid complexity
and overhead in the kernel.

Is there any plan to add support for it in a near future?

Why I'm asking?=20

It looks like this kernel feature (with CLOCK_REALTIME support
available) would be very helpful for testing Y2038 compliance for e.g.
glibc 32 bit ports.

To be more specific - it would be possible to modify time after time_t
32 bit overflow (i.e. Y2038 bug) on the process running Y2038
regression tests on the host system (64 bit one). By using Linux time
namespaces the system time will not be affected in any way.

Thanks in advance for your help.

Links:

[1] - https://lkml.org/lkml/2019/10/10/1329
[2] - https://www.man7.org/linux/man-pages/man7/time_namespaces.7.html


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/gUM4x0hyt5rpW=rxvYzDQjJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl+b5LUACgkQAR8vZIA0
zr1a2QgAynsCmxwHIDmCgKM0PFeeoyjn0GKD95l4r4q0uDbbQ5tjwP4nf+MdRW4l
8DPo11i2OKobdU2W+uM4Zs+tLFVa+nRIvOekStIkWoImkhyzLki0TPcYGv8axCD0
33Wow5Z9psNBt0FALbPz1AJA+mjiqHjuKzzSeylB+ZixaK8VexS+j9yprUU9Cdh0
xjDvePVkW5YZm/TuUEonchpfiZ9WuuBqC79tmpLZt+L/ShE0eC755sCKpNGG0/rb
Zt6zAQlM7CDnqVYKdBJLqBiSzQLNkX8N+8upDPmlyFjLQzQNvpZptV6EfmhgMYcj
7QSL7fsrEqC350QLcSDDm99weaIXrw==
=6zOG
-----END PGP SIGNATURE-----

--Sig_/gUM4x0hyt5rpW=rxvYzDQjJ--
