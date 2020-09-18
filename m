Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6ED26FE8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIRNcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRNcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:32:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A2F206DB;
        Fri, 18 Sep 2020 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600435972;
        bh=7hSwap25GA/Oqj6EwHSwuf9ZnYrwESdX+SdscU52A/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYYfC+obikaqOheGC8najvfwzxvdJlg83XySo0o42UNQCvEiTknnak9ifvGjFH213
         5Cj60G9Oqb01lt0SVOdj9Oq2JEOD/we6NIhMI2/IoWAGDpFKzq6L6AhFuhP+ejlLo/
         Av1PuCER2V9qQ3umUUe2CkfWJl7d0vvBVrtgsGUc=
Date:   Fri, 18 Sep 2020 14:32:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu
Subject: Re: [PATCH] ASoC: fix kconfig dependency warnings for SND_SOC_WM8731
Message-ID: <20200918133202.GH5703@sirena.org.uk>
References: <20200918131257.5860-1-fazilyildiran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <20200918131257.5860-1-fazilyildiran@gmail.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 04:12:58PM +0300, Necip Fazil Yildiran wrote:
> SND_SOC_WM8731 was made visible and dependent on other symbols with commit
> 1291e14175e6 ("ASoC: codecs: Make OF supported CODECs visible in Kconfig").
> To this respect, the symbols selecting SND_SOC_WM8731 turned out to be
> overlooking its dependencies.

> Switch reverse dependencies on SND_SOC_WM8731 to normal dependencies.

No, this is very user hostile - users shouldn't have to know exactly
which chips a given machine driver needs to figure out how to get the
config option visible.  Please fix the selects in the machine driver
instead.

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9kttEACgkQJNaLcl1U
h9CkYAf9Ej630ZUjUIRfV2vJy5PY4LKnfppP92Ok6d+55eRBEh96EpC32AtBpzjw
J8fpK7kY+iamF25PKb0SJ/VZmMn9VleExTrT8v36f31FQIrcHpK0kmut8gdyI2oO
RccdBojyI5NQMpkj8rW7DFuPhj9d+lLemlToyRrCFyA8zBv8wyJKGiVzuZ3yPqLH
QZgwULLoeFpTH5nLmZw/MP3RBrOYJ95iFvcTGwKjY9PjmtEHnXtHj58RpThTqYEU
XS9qyLfH66TqHXrs0JKBgGu8GcDsvVtU6Zgc4qDSHzY8teYA+9nzntFDEQpDo34a
9+KfrurcST827/JyTd/SyWNVJoJjvQ==
=WAW4
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
