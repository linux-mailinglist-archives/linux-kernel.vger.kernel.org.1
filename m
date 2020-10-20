Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E521293F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408719AbgJTPX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408694AbgJTPX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:23:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2DD21D6C;
        Tue, 20 Oct 2020 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603207407;
        bh=O0otWF5hQOpQgAyZOOSz2D2YTrqqjcz/Uss8q1ZITTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsMKyHfirIAjnHn1Zw3AbOdD6wIHu0Mi+qaG1spiZE+OygjSPNIdhKVxiqG0ic6Ba
         N4fvKHoS+gxv0HvnjUOJO00j5lFqVjiwYlyTR4zYiesZbZeHUk0+tlNSdDtrNislSw
         +m29i4UkwfjH86BCw7jLXhryfBSOmURCHMfbcHX0=
Date:   Tue, 20 Oct 2020 16:23:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     trix@redhat.com
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        yang.jie@linux.intel.com, peter.ujfalusi@ti.com, arnd@arndb.de,
        romain.perier@gmail.com, naoki.hayama@lineo.co.jp,
        allen.lkml@gmail.com, kuninori.morimoto.gx@renesas.com,
        srinivas.kandagatla@linaro.org, ranjani.sridharan@linux.intel.com,
        baolin.wang@linaro.org, Julia.Lawall@inria.fr,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: remove unneeded break
Message-ID: <20201020152317.GD9448@sirena.org.uk>
References: <20201019164857.27223-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20201019164857.27223-1-trix@redhat.com>
X-Cookie: The people rule.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 09:48:57AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> A break is not needed if it is preceded by a return, goto
> or break

Acked-by: Mark Brown <broonie@kernel.org>

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+PAOQACgkQJNaLcl1U
h9B6Wwf/WM7+AuONwToF6d5Lw39VWaxRZFC6SH0PW6rtzOUx6rKbQ5eopaTnxA6k
3vpWBmaSVcFfbu0TgoCSgQsbmPORfgesMUCmcniRPBZ3NTUzV9lM1yLs4qo5k1lq
laGIooCjfxEikOsm9QTftZXQCSYlAvqNnFx9tFv7h19wyDn9uzNEiuwZ1thBAhvO
t7U1WGr2cwFLy3kSjWPDD2y82cX+ng+yo/MzWJv68oJ2lFdpV2Gn7iRIJ/koikU8
AS3lrZKlOLufUnir4ex5FFhGCrGKcarEipopKDOdZ5sPaiyBNoAn2FJ2+RvDhPof
oSw9xG5WP2q+6Vl7GC0PqNgmGMrFQQ==
=YldY
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
