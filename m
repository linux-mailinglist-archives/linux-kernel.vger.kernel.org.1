Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E979C2B53A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgKPVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgKPVTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:19:16 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1053822240;
        Mon, 16 Nov 2020 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605561555;
        bh=SHY23h33dgv8QkmIOXbfR+0ymnh1DApjt1ZFMQXzwTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVAC0WhP2O+fs3GrwV/DVLOTVaTvNFQDQ1YEkTpeW4GpzoHpkC7VzoL5kimjr6EK+
         FbhVQmHdNZwIwtXDDAbZB9xI6bGzJ7wyqkxfnGpw48w5coejnjZJ5kJ6T5b4VVY8e2
         L7+bsvzJs3+ZYjIf1yoYAdUJbiVUz7pwM23hCJJQ=
Date:   Mon, 16 Nov 2020 21:18:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v2] dt-bindings: adau1977: convert text binding to yaml
 format
Message-ID: <20201116211856.GM4739@sirena.org.uk>
References: <20201106102052.32582-1-alexandru.ardelean@analog.com>
 <20201110084754.46756-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wAI/bQb0EMvlZCHl"
Content-Disposition: inline
In-Reply-To: <20201110084754.46756-1-alexandru.ardelean@analog.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wAI/bQb0EMvlZCHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2020 at 10:47:54AM +0200, Alexandru Ardelean wrote:
> This change converts the old device-tree binding for ADAU1977 from text
> format to the new yaml format.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--wAI/bQb0EMvlZCHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+y7L8ACgkQJNaLcl1U
h9BAwgf/YWLXXnZ0TekHKPuo3Pmjs/ILWyySMjpUzT1SzSNT7QyhFeVobu6IaeBP
smT812NxLhwlQFkGneTbOJveZCqfX5qMJQ5CYLnZVyoHFOVhUL2veRA4+JWSwzjJ
/dgf/Oijz5epN5cz20Gh8mNpfjJQoPfia7hpZLO/UeWKcbCIODBr9zWEdZs2IGyR
dfPY5Ha9LbcpJhuAFg0rKu3j15hC1AHhtP+5bT6ilfwMEFnerP+2RS+yEHOJH9NX
/4t7RyOkEGbktOKHNXMYB+Or3j+NyGJP0G814M3UJtGG7QvJIeMQUhg0SEdFbnFV
ZSMy7Ozjlnp5KjN+/Tl3gncoYiOgmw==
=xNKB
-----END PGP SIGNATURE-----

--wAI/bQb0EMvlZCHl--
