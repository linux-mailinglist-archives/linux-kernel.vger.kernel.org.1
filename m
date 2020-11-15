Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F612B3726
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 18:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgKORbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 12:31:34 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34846 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgKORbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 12:31:34 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 062001C0B9E; Sun, 15 Nov 2020 18:31:31 +0100 (CET)
Date:   Sun, 15 Nov 2020 18:31:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap
 clear_ack
Message-ID: <20201115173130.GA32085@duo.ucw.cz>
References: <20201111170613.46057-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20201111170613.46057-1-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> With commit 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack
> registers"), the cpcap interrupts are no longer getting acked properly
> leading to a very unresponsive device with CPUs fully loaded spinning
> in the threaded IRQ handlers.
>=20
> To me it looks like the clear_ack commit above actually fixed a long
> standing bug in regmap_irq_thread() where we unconditionally acked the
> interrupts earlier without considering ack_invert. And the issue with
> cpcap started happening as we now also consider ack_invert.
>=20
> Tim Harvey <tharvey@gateworks.com> tried to fix this issue earlier with
> "[PATCH v2] regmap: irq: fix ack-invert", but the reading of the ack
> register was considered unnecessary for just ack_invert, and we did not
> have clear_ack available yet. As the cpcap irqs worked both with and
> without ack_invert earlier because of the unconditional ack, the
> problem remained hidden until now.
>=20
> Also, looks like the earlier v3.0.8 based Motorola Android Linux kernel
> does clear_ack style read-clear-write with "ireg_val & ~mreg_val" instead
> of just ack_invert style write. So let's switch cpcap to use clear_ack
> to fix the issue.
>=20
> Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")

Tested-by: Pavel Machek <pavel@ucw.cz>

Thank you, culomb counter issue is now gone.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7Fl8gAKCRAw5/Bqldv6
8lwCAJ9uJs0Bdz5l5K0mgXtFFqWx/sTcwACfWTMrgo9TLu2B1px+X54+n6zKjRU=
=HTYp
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
