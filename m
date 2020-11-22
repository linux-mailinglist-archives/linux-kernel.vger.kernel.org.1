Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F92BC55F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 12:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgKVLcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 06:32:33 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:37914 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbgKVLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 06:32:32 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B9E071C0B8D; Sun, 22 Nov 2020 12:32:30 +0100 (CET)
Date:   Sun, 22 Nov 2020 12:32:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     john.stultz@linaro.org, bjorn.andersson@linaro.org,
        kvalo@codeaurora.org, gregkh@linuxfoundation.org, will@kernel.org,
        agross@kernel.org, kernel list <linux-kernel@vger.kernel.org>
Subject: QCOM_SCM: config option with useless prompt and no help text
Message-ID: <20201122113230.GA445@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

commit d0511b5496c03cdbcda55a9b57c32cdd751920ed
Author: John Stultz <john.stultz@linaro.org>
Date:   Fri Nov 6 04:27:10 2020 +0000

    firmware: QCOM_SCM: Allow qcom_scm driver to be loadable as a permenent=
 module

You made this into user-visible config option, but what user sees is
this:

Qcom SCM driver (QCOM_SCM) [N/m/y/?] (NEW) ?

There is no help available for this option.
Symbol: QCOM_SCM [=3Dn]
Type  : tristate
Defined at drivers/firmware/Kconfig:237
  Prompt: Qcom SCM driver

Which is pretty sad. Please fix.

							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7pMTgAKCRAw5/Bqldv6
8iVLAKCOerX85CeevA6uE4iYPNt/nd2iHgCggmTHsV/hjGxwyuk5K2bhnjSim9k=
=wZea
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
