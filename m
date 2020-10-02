Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EC2812FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgJBMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:42:52 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44332 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:42:52 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5041D1C0BA5; Fri,  2 Oct 2020 14:42:50 +0200 (CEST)
Date:   Fri, 2 Oct 2020 14:42:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     poeschel@lemonage.de
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 33/33] auxdisplay: add a driver for lcd2s character
 display
Message-ID: <20201002124249.GA10628@duo.ucw.cz>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-34-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200921144645.2061313-34-poeschel@lemonage.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lars Poeschel <poeschel@lemonage.de>
>=20
> This driver allows to use a lcd2s 20x4 character display from modtronix
> engineering as an auxdisplay charlcd device.

Is there userland interface documenteted somewhere? I tried to grep
through Documentation and did not find anything useful :-(.


pavel@duo:/data/l/k$ grep -ri charlcd Documentation/
pavel@duo:/data/l/k$ grep -ri auxdis Documentation/
Documentation/admin-guide/auxdisplay/ks0108.rst:For example, check Document=
ation/admin-guide/auxdisplay/cfag12864b.rst
Documentation/admin-guide/auxdisplay/cfag12864b.rst:Check samples/auxdispla=
y/cfag12864b-example.c
Documentation/admin-guide/index.rst:   auxdisplay/index
Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml:$id: http://d=
evicetree.org/schemas/auxdisplay/hit,hd44780.yaml#
Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml:    auxdispla=
y {
Documentation/translations/zh_CN/admin-guide/index.rst:   auxdisplay/index
pavel@duo:/data/l/k$=20

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX3cgSQAKCRAw5/Bqldv6
8kEpAKCHq5SElD3JzNsIwZpgs1YMwUyDcACgu6BCR6u8tSOGc9CB9Xiqbapgdlo=
=ugYe
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
