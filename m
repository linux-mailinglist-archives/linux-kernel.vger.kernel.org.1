Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8628329F2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgJ2RQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:16:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56842 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:16:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4A6E11C0B7A; Thu, 29 Oct 2020 18:16:30 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:16:29 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/33] docs: ABI: unify
 /sys/class/leds/<led>/max_brightness documentation
Message-ID: <20201029171629.GA23031@duo.ucw.cz>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
 <2c95a4d8d1b4be2f839464ebc63bfcee6b70276a.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <2c95a4d8d1b4be2f839464ebc63bfcee6b70276a.1603893146.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-10-28 15:23:31, Mauro Carvalho Chehab wrote:
> This ABI is defined twice, one for normal leds and another
> one for multicolor ones.
>=20
> Ensure that just one definition is there at ABI.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
http://www.livejournal.com/~pavelmachek

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5r47QAKCRAw5/Bqldv6
8s1oAKC0G725MNSzdT2m55zX+va7YYSddwCfZQAimF33+PaK+2UTeBGnISx8DH4=
=pu9C
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
