Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B412927D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgJSNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJSNDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:03:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFC222283;
        Mon, 19 Oct 2020 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603112622;
        bh=cqF7TYS+3s0vkYfvkAxCv00WvkrIIfSih7URN3Qul8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l24sJaGjidXhXBm2OBM3hZz1mKIoxujmjvUqZUZhnTWSSvdzip5WiUxeDP1B8o7GU
         C/RoePxFTquy9tFGAx7AZsrEpEwREYtz2EbOWF4uk5R/x32XJ0+pZlB+ef8hlenTqW
         +GtsXW0ACDEDh8BnRIKjmPzCJKNqCaXd5t5Sf7XY=
Date:   Mon, 19 Oct 2020 14:03:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, lars@metafoo.de, nuno.sa@analog.com,
        perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH] ASoC: adau1977: remove platform data and move micbias
 bindings include
Message-ID: <20201019130331.GA4904@sirena.org.uk>
References: <20201019105313.24862-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20201019105313.24862-1-alexandru.ardelean@analog.com>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2020 at 01:53:13PM +0300, Alexandru Ardelean wrote:
> The change removes the platform_data include/definition. It only contains
> some values for the MICBIAS.
> These are moved into 'dt-bindings/sound/adi,adau1977.h' so that they can be
> used inside device-trees. When moving then, they need to be converted to
> pre-compiler defines, so that the DT compiler can understand them.

This is missing an update of the binding documentation for the new
property.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+NjqMACgkQJNaLcl1U
h9AOtQf/Xp1fnxzE3EaB3q6cfcLQ/wqiYsF9GVcIOOw5jd6ouidERA5TYt/bovep
DUvbLQW+R0TcAZcHG+OzGcjhHETO7OsQZoD5uPi0DAQwrceFh1xI3GcZNDRa+Qqd
jdgHV50BK20Kwx83U0D1h0DFHdE2mJM7cow0S4yRMv5TZ5JZ4B7i/84Yvuu8vlT2
K6ckEdrZL2P+u3nyXFIsBjtbrw+YcH5v0F1AAAAlkSiPoyltTbQ4tdkWVpk9R+AO
FdwyuVH7NU5WCMkz7DuR7FNAmZFjzvDVZYYJPsgwJRqtXqq3dQk6VS5H82hk94d4
enqPA9aKp8ywBz2S3ZS7pszUKUs1/g==
=J4FR
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
