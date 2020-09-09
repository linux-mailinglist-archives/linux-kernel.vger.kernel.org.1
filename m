Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C089262CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIIKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 06:24:04 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34906 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgIIKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:23:49 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 95BAC1C0B87; Wed,  9 Sep 2020 12:23:46 +0200 (CEST)
Date:   Wed, 9 Sep 2020 12:23:45 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        =?utf-8?B?5ZGo5q2j?= <sernia.zhou@foxmail.com>,
        =?utf-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>, od@zcrc.me,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written to
 HW register
Message-ID: <20200909102345.GA9222@amd>
References: <20200827124308.71963-1-paul@crapouillou.net>
 <20200827124308.71963-2-paul@crapouillou.net>
 <87v9h4i6t5.fsf@kernel.org>
 <PN4QFQ.KWNBY2ZWQ7XC2@crapouillou.net>
 <87bliwi5kx.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <87bliwi5kx.fsf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>  -	reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT=20
> >>> |	USBPCR_TXPREEMPHTUNE |
> >>>  +	return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |=20
> >>> USBPCR_TXPREEMPHTUNE |
> >>>   		USBPCR_COMMONONN | USBPCR_POR;
> >>>  -	writel(reg, priv->base + REG_USBPCR_OFFSET);
> >>=20
> >> not a bug fix
> >
> > Well, if you don't like my bug fix, next time wait for my Reviewed-by.
>=20
> why so angry? Take a break every once in a while. Besides, someone else
> already sent the oneliner before you ;-)

Your behaviour is pretty good explanation for angry people on the
mailing list.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9YrTEACgkQMOfwapXb+vJ8tACgjD/mpcjYY3DfFtCvIm+G/xF4
z9oAoIKgzqrArYXBGniQrGbo/5qKu8n5
=hxC1
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
