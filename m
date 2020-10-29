Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6008B29EFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgJ2P2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgJ2P2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:28:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0567E206F4;
        Thu, 29 Oct 2020 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603985330;
        bh=NWaowLHtNIvhwC7GnZsxb1dI7E4BpTQiaGdCpEZYKPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZ10J/+GvOOceoAC1lHKWTmpr4kt5mp0637m6nytBJJ3WI6RP7gdlMxfxCFCbkzOK
         o0gB7lFpUMMs6cbiFTsPJT8PY/JIpQCjvpC1urKDb/kZmjWnP0RUlP/I9a0FIZFAvC
         gnWuDtPx7VmLtvioWWRl4EzwrmzBJ+98qZmPfcsU=
Date:   Thu, 29 Oct 2020 15:28:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     lgirdwood@gmail.com, support.opensource@diasemi.com,
        kernel@axis.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] regulator: Add support for DA9121 regulator
Message-ID: <20201029152843.GC5042@sirena.org.uk>
References: <20201029151538.23463-1-vincent.whitchurch@axis.com>
 <20201029151538.23463-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <20201029151538.23463-3-vincent.whitchurch@axis.com>
X-Cookie: Monotheism is a gift from the gods.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2020 at 04:15:38PM +0100, Vincent Whitchurch wrote:

> +	config.init_data = of_get_regulator_init_data(dev, dev->of_node, &da9121_reg);
> +	if (!config.init_data)
> +		return -ENOMEM;

Don't do this, the core can do the DT bit for you and there is no reason
not to register the device if there are no constraints.  -ENOMEM would
also be the wrong error code here.

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+a36oACgkQJNaLcl1U
h9ARxwf8CXf5lbcd8taxpgqGlrd3d/ptlRXFz6yXtG+Ger3Qm1YnutDDKI6nuezS
aR1h5MZtVDpfpwPrQDTg7L2SCh+jpbaOd/pC2E0k6QDWOR8nrqbhQgFCMoP7ie1g
g9xHLYPUADiwVZZh7W2OFNYeY7M+RKJD6xLsbhJwpk8zSEoOLCIizTi70Fl1EIey
aPC9AeXfaTzaUsHmA+3/ChOz0vyAUl7avQFnntRGzF0T9V+WV6JP9IouOf6XF/V8
RS6bWUYNzLDFpZkKIzLT1PNMOPOmFmTNWJuXY2nRgpwLmgRnJbegv99KWYoFY7AL
kWDT4oVPJTuvn8pVJ9pVgRgfME7cyw==
=+wTT
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
