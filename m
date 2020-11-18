Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7257B2B7AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKRJs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKRJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:48:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91749C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:48:28 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK4g-0002p3-IV; Wed, 18 Nov 2020 10:48:26 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK4f-0007s8-4o; Wed, 18 Nov 2020 10:48:25 +0100
Date:   Wed, 18 Nov 2020 10:48:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lai, Poey Seng" <poey.seng.lai@intel.com>
Subject: Re: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Message-ID: <20201118094823.3a4usmbzvkbeaavg@pengutronix.de>
References: <202011160303.qi5aRChY-lkp@intel.com>
 <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
 <DM6PR11MB4250E11A47E3B45FE0BEDC26FBE20@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6qmur6a5afhc4yc"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4250E11A47E3B45FE0BEDC26FBE20@DM6PR11MB4250.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e6qmur6a5afhc4yc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 05:29:01PM +0000, Ayyathurai, Vijayakannan wrote:
> Hi Uwe,
>=20
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Monday, 16 November, 2020 5:08 PM
> > Subject: [PATCH RFC] pwm: keembay: Fix build failure with -Os
> >=20
> > The driver used this construct:
> >=20
> > 	#define KMB_PWM_LEADIN_MASK             GENMASK(30, 0)
> >=20
> > 	static inline void keembay_pwm_update_bits(struct keembay_pwm
> > *priv, u32 mask,
> > 						   u32 val, u32 offset)
> > 	{
> > 		u32 buff =3D readl(priv->base + offset);
> >=20
> > 		buff =3D u32_replace_bits(buff, val, mask);
> > 		writel(buff, priv->base + offset);
> > 	}
> >=20
> > 	...
> > 	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> > 					KMB_PWM_LEADIN_OFFSET(pwm-
> > >hwpwm));
> >=20
> > With CONFIG_CC_OPTIMIZE_FOR_SIZE the compiler (here: gcc 10.2.0) this
> > triggers:
> >=20
> > 	In file included from /home/uwe/gsrc/linux/drivers/pwm/pwm-
> > keembay.c:16:
> > 	In function =E2=80=98field_multiplier=E2=80=99,
> > 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at
> > /home/uwe/gsrc/linux/include/linux/bitfield.h:124:17:
> > 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to
> > =E2=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfiel=
d mask
> > 	  119 |   __bad_mask();
> > 	      |   ^~~~~~~~~~~~
> > 	In function =E2=80=98field_multiplier=E2=80=99,
> > 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at
> > /home/uwe/gsrc/linux/include/linux/bitfield.h:154:1:
> > 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to
> > =E2=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfiel=
d mask
> > 	  119 |   __bad_mask();
> > 	      |   ^~~~~~~~~~~~
> >=20
> > The compiler doesn't seem to be able to notice that with field being
> > 0x3ffffff the expression
> >=20
> > 	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
> > 		__bad_mask();
> >=20
> > can be optimized away.
> >=20
> > So use __always_inline and document the problem in a comment to fix
> > this.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thank you for spending time in resolving this build failure.
>=20
> I shall prepare and share the next version of patch with your approach.

I don't understand this last sentence. IMHO there is currently nothing
you have to do for this problem. You can send an Ack however if you want
to.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e6qmur6a5afhc4yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+07eQACgkQwfwUeK3K
7AlXwAf9HCcjIkTxZugxzljdkpc6g8PIMuarduv7uS3R4yaP6gvzKeGMqm5IMqPw
obUrg7bugfRqDiTRGYj0Zq5Ch9X/k0SbDPF1NlkI7SiVWq8MvCtmJw7/U4w8Eifq
Zw5KcBNJlacC7lctM5i9HO6KuMzQBnfLZRqaLU6CWQ9off9/mGjJRmsmCfZQaxxJ
3qH7q3vaGzLUa7n4CuMPZXnFFn+0LYSATRp1N2+PLpILMtv5klfxQhGVZBP+39P2
je8sauIryt9Cyfxk1CX1phkHuLDFSR17Mw8d8fYZlYTGyRbIVArtgn+Z7Tqm3Il1
1qGfgaf8Vq+uaJawK/pjxI7WxoPOYQ==
=UTaj
-----END PGP SIGNATURE-----

--e6qmur6a5afhc4yc--
