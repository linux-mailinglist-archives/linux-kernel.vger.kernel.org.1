Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF072BB110
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgKTQ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730229AbgKTQ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:56:56 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485FE2225B;
        Fri, 20 Nov 2020 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605891415;
        bh=81bAv9ZK1UGPQKGMPKiVWesuqekUngu9SE7Z5LHy0Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/vJsgLeAOwe6LOvO+cCMxSsaVj3a/1ZKes+N7nx0ftzSl8fv5+P+NfVTS0Gpl3Yl
         dVZfwIIK8fvhMzuS03aYrCVYjYLGuz/XssrW6XljGViUAZQH3v19AFXa2dYdRzGVo3
         rnqNILL8IET5wmwym/g2lSv0ZvnGYCIT3DIacZqQ=
Date:   Fri, 20 Nov 2020 16:56:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201120165202.GG6751@sirena.org.uk>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2020 at 05:16:15PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):

It would be better to fix these by annotating the table as potentially
unused, if nothing else it means if someone wants to add ACPI support
(or it just works on their ACPI system with the plain old I2C ID) then
they don't need to revert this change.

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+39UEACgkQJNaLcl1U
h9CgmAf/TTilda96a36q485f2SyA+IVRXAggLG/0IGEmSeyFkPP8BmZuQnO2upBd
nym7EJHvUPEUn+Fb+Y9CaHG773ncymC/+L695gqlaf4LZNph2FmatHUhQE001ULh
07CC9JJ1CMMRQblKn6wKrLN6D8MvdLXAMI+NOyk+mINvH418nEXRnLZSmhvK2poa
w+gU7sM6xBNc8dcrOXSUB4GeWRSk5e5o3zGIB3CkPQaomoEH81bINbKw1wGbyHuC
r7xRgGrCr2UV2SMQHz74EXvCx9dsGwc7G6nHaN6AqLeyUkHBXojKet8kJsOxwFui
c1rPK+vfugjrmYf7IsLKPizFuqozqA==
=/Bw1
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--
