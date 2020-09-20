Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290492717F9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgITUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 16:51:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43378 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITUvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 16:51:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5EF641C0B7A; Sun, 20 Sep 2020 22:51:12 +0200 (CEST)
Date:   Sun, 20 Sep 2020 22:51:11 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        syzbot+96414aa0033c363d8458@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lihong Kou <koulihong@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] 6lowpan: Add missing locking
Message-ID: <20200920205111.GA31185@duo.ucw.cz>
References: <2325b986-a4ea-9aa3-40ba-702ebe9b519c@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <2325b986-a4ea-9aa3-40ba-702ebe9b519c@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-09-20 16:14:22, Markus Elfring wrote:
> > I believe set_lock should be taken in exit function, too.
>=20
> * Would an imperative wording become helpful for the change description?
>=20
> * How do you think about to add the tag =E2=80=9CFixes=E2=80=9D to the co=
mmit message?

Hi,

This is the semi-friendly notice stolen from Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2fAvwAKCRAw5/Bqldv6
8ojgAJ9etw8H04JUAZoA7SzA9c1syP1y5QCgtou+ksIF2mZDV68WLpZQ5/Chvg4=
=kOI6
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
