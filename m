Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0495F1CC49D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEIU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 16:57:53 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:34250 "EHLO
        4.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgEIU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 16:57:53 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2020 16:57:52 EDT
Received: from player795.ha.ovh.net (unknown [10.108.57.150])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2ACC524E0B6
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 22:49:41 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player795.ha.ovh.net (Postfix) with ESMTPSA id 4EB0C120EAF18;
        Sat,  9 May 2020 20:49:35 +0000 (UTC)
Date:   Sat, 9 May 2020 22:49:28 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: Protect INET_ADDR_COOKIE on 32-bit
 architectures
Message-ID: <20200509224928.26d44ac4@heffalump.sk2.org>
In-Reply-To: <20200509210548.116c7385@heffalump.sk2.org>
References: <20200508120457.29422-1-steve@sk2.org>
        <20200508205025.3207a54e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200509101322.12651ba0@heffalump.sk2.org>
        <20200509105914.04fd19c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200509210548.116c7385@heffalump.sk2.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ozF2Wqqx=e8Mz+8zhS.76PK"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 1685753636152364442
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkeehgdduhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeevledvueefvdeivefftdeugeekveethefftdffteelheejkeejjeduffeiudetkeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ozF2Wqqx=e8Mz+8zhS.76PK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 9 May 2020 21:05:48 +0200, Stephen Kitt <steve@sk2.org> wrote:
> On Sat, 9 May 2020 10:59:14 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > What if we went back to your original proposal of an empty struct but
> > added in an extern in front? That way we should get linker error on
> > pointer references. =20
>=20
> That silently fails to fail if any other link object provides a definition
> for the symbol, even if the type doesn=E2=80=99t match...

And it breaks the build if INET_ADDR_COOKIE is used twice in the same unit,
e.g. in inet_hashtables.c.

Regards,

Stephen

--Sig_/ozF2Wqqx=e8Mz+8zhS.76PK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl63F1gACgkQgNMC9Yht
g5z2+w//TodNM/HKRMA5sV27TwJX6hBwq6bKlE85sPnMm2O154OMvD+wj3t9u3US
bN4L4KokUi2YHkxVO1DZ6Cs9aAPnDFe+mBgw6WiD7NDryDF47ZbswD/QQyuN7lRd
G2byAu6QZng/UH+6yDFPpCpMJpRAa0SMD7/gdRlT6U8oXt72CWyGUY5MsocW/0iK
XlKdAJoOD4DVbWC0ePpSDgYC/BkHO1+rb0JmChRY5T/IHC4mkpJUDH7qwpRBGaSb
a3YF6B7K/Q06DGuJ0XhJInle71S/edm2RBYBm12b6LAijS8cYj+Aj533ET/MVfJ2
8o3FMHsTZ/rNyUeaAaN+l7M8t9xBLo5X/0JTDO8d/07FkWNBNnyXFyI0zFp5JBJA
Klxo505Mfb8x1d5qiRIqH0JrJnKiNkajw879cxQdhhXgLTnBuRAhK+mOKbtIMUpd
ztGv3Ct8BkyNSnbou/0F6yGgw0JQioDjs2D/mAnY7JnvM4tLPSrpieUzwB69diZI
l7mMK/Gcl3aOOiD7WxuTbHtcMpuU+lQYdNJoNF/N6DuhKuMDyyWHbtZduEJ/PJgM
DJRMjyhSkTrxLtHX03utsqG0vIFI3pIMN6aGcQibPGutX0UK+c2CGo4uF0YuQrSB
fs1ep0kw9/ovhUuXJkqYUUAXflmVhyG4FljDi1fxvxphmkaaG8k=
=hMUt
-----END PGP SIGNATURE-----

--Sig_/ozF2Wqqx=e8Mz+8zhS.76PK--
