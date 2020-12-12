Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5902D8A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407958AbgLLVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 16:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgLLVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 16:14:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D1CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 13:14:12 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koCD9-0001B1-QP; Sat, 12 Dec 2020 22:13:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koCD6-0006qK-Fu; Sat, 12 Dec 2020 22:13:48 +0100
Date:   Sat, 12 Dec 2020 22:13:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Qian Cai <qcai@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 3/3] driver core: platform: use bus_type functions
Message-ID: <20201212211348.jnx5sac4nvtb3ic2@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dc4jdbq6u3zipapq"
Content-Disposition: inline
In-Reply-To: <48759bfa-bd21-f28f-043f-7b866d1b7e04@samsung.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dc4jdbq6u3zipapq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Fri, Dec 11, 2020 at 05:12:16PM +0100, Marek Szyprowski wrote:
> On 19.11.2020 13:46, Uwe Kleine-K=F6nig wrote:
> > +static void platform_shutdown(struct device *_dev)
> > +{
> > +	struct platform_driver *drv =3D to_platform_driver(_dev->driver);
> > +	struct platform_device *dev =3D to_platform_device(_dev);
> > +
> > +	if (drv->shutdown)
> > +		drv->shutdown(dev);
> > +}
>=20
> This will be called on unbound devices, what causes crash (observed on=20
> today's linux-next):
>=20
> Will now restart.
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address fffffff4
> pgd =3D 289f4b67
> [fffffff4] *pgd=3D6ffff841, *pte=3D00000000, *ppte=3D00000000
> Internal error: Oops: 27 [#1] SMP ARM
> Modules linked in: usb_f_ecm g_ether usb_f_rndis u_ether libcomposite=20
> brcmfmac sha256_generic libsha256 sha256_arm cfg80211 brcmutil=20
> panel_samsung_s6e8aa0 s5p_csi
> CPU: 0 PID: 1715 Comm: reboot Not tainted=20
> 5.10.0-rc7-next-20201211-00069-g1e8aa883315f #9935
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at platform_shutdown+0x8/0x18
> LR is at device_shutdown+0x18c/0x25c
> ...
> Flags: nZCv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0 ISA ARM=A0 Segment no=
ne
> Control: 10c5387d=A0 Table: 4348404a=A0 DAC: 00000051
> Process reboot (pid: 1715, stack limit =3D 0xd050391e)
> Stack: (0xc3405e60 to 0xc3406000)
> [<c0a38bfc>] (platform_shutdown) from [<c0a34f78>]=20
> (device_shutdown+0x18c/0x25c)
> [<c0a34f78>] (device_shutdown) from [<c036d3cc>] (kernel_restart+0xc/0x68)
> [<c036d3cc>] (kernel_restart) from [<c036d680>]=20
> (__do_sys_reboot+0x154/0x1f0)
> [<c036d680>] (__do_sys_reboot) from [<c03000c0>] (ret_fast_syscall+0x0/0x=
58)
> Exception stack(0xc3405fa8 to 0xc3405ff0)
> ...
> ---[ end trace f39e94d5d6fd45bf ]---

Dmitry Baryshkov already proposed a fix, see
https://lore.kernel.org/r/20201212011426.163071-1-dmitry.baryshkov@linaro.o=
rg

I expect a v2 soon.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dc4jdbq6u3zipapq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/VMokACgkQwfwUeK3K
7AmrRQf/TRRpNGykkOWHKe+wzdzJCzozfdikmQtK2Hb0LdgYYYn7hKEj3uvfTQf3
bGMWIKthBNJKymSwot2s+AgdFbwoidaVObScBjPnlzg9USv/32fjmtbMpxR3l1cs
ue04HovwaVQNbHwWmi84xqFqwKtwE9UUiUW502YATAo9ePEzDpVSOVG8EX400aB+
xO/54TlAINOMbKMVZhkuN3A6On2HMEeSNftNhyBbQAitkkTuZ6FGptGmXYexen4R
xiUo0DZv1mtfxj1eY1Zd1wmJseFljnsRzT2z1XpveIHB5MFSfh+Us29Rh5CAmANJ
CEi6r+Z2JJ+ruI/8O+CVfa6rZAkhbw==
=5fwq
-----END PGP SIGNATURE-----

--dc4jdbq6u3zipapq--
