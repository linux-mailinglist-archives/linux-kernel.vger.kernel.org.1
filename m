Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30826CA52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgIPTzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgIPRgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:36:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50BDC2076B;
        Wed, 16 Sep 2020 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600252661;
        bh=ADuHLdDwKEFY8lVQd1z684oszPp1C7f05I5QYtp5sjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yF62OYWKAnNPJsrbiaC5MvLbpoGbP62BBVVQlABU4ObSr+8nC4kVz1UHj1TPHtlY+
         1aIz0sZveAvzohaG95tpM9bimsuO9pDSB5w+PLPrP/X/bHLpoey7+vkF2i9ZeyliZk
         x3+XRjTCpKtfp2RkdlwP+4Tc3d8XwzNz4faVY3YY=
Date:   Wed, 16 Sep 2020 11:36:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 0/3] regulator: unexport regulator_lock/unlock()
Message-ID: <20200916103652.GA6374@sirena.org.uk>
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
 <159950194954.52863.7080307258573052895.b4-ty@kernel.org>
 <20200915185506.GA24017@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20200915185506.GA24017@qmqm.qmqm.pl>
X-Cookie: I'm shaving!!  I'M SHAVING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 08:55:06PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Mon, Sep 07, 2020 at 07:05:49PM +0100, Mark Brown wrote:

> > [3/3] regulator: unexport regulator_lock/unlock()
> >       (no commit info)

> It looks like the third one didn't get in? (Can't see it in the
> for-next branch).

It probably didn't apply, please check and resend.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9h6sAACgkQJNaLcl1U
h9BueQf+P7soFv7zUmoI8ovfsbikFoOd0aj7h+4RUwmsm89ygv8dGBLX6XV/3+8y
J6Z2aEJxGNtU7NFeye2jKxxsfyH3KG/yiy3jA20niDrGaN4Uh6rRZqgIhBdTicSg
9BszC505h0xwoXSyDIiE6ziiBlpRi5F3Yk4ug4dTT6A4kJQMjapJZokQgY7SgjwT
tCLNjgCefUoGafQfzQukqgFM1ePwJjM+h1cP6AdxBmyFI8Ph/9srk+8vVJSV13Ok
ziSe0c4gGCuHF7Rr9GdON8D9cQCtUxlgRJNNN1r6aWbpnrAbKOcHC99U3PPLnYEh
EsiOtV5Qjl2H9NND44grnGqDmjLJCg==
=801e
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
