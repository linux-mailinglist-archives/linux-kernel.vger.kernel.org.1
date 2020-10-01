Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBA2803AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgJAQQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbgJAQQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:16:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C02208B6;
        Thu,  1 Oct 2020 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601569010;
        bh=550ObKj0OVd2Etj3DF5vnvAqjxclqiEwkkyg6mAkvxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bmjgy8MqtcupAOak4HQajWBjJUKV8rpBI3XdM4osHD01IKETSd8rwxdCeS/75/EuG
         H7kY85ZIXHs+X6mvxsES9TFFyI9LO/1R07OnfFIWlzEA9jxaC+xKe6slXQQIp42uZ/
         5hyBwsW0PP2KGywPzUm4Uv+Lds9m6D57GvyLaOt4=
Date:   Thu, 1 Oct 2020 17:15:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
Message-ID: <20201001161551.GN6715@sirena.org.uk>
References: <20200930163809.6978-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline
In-Reply-To: <20200930163809.6978-1-dmurphy@ti.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 11:38:08AM -0500, Dan Murphy wrote:

> +  reset-gpio:
> +    description: GPIO used to reset the device.

Even if only a single GPIO is allowed DT properties for GPIOs should be
plural.

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92ALYACgkQJNaLcl1U
h9ArgQf8D8WxeqQaN7IwoEzY6Ot/1JL/mF1DDRlBglnQGCE0NOABnw2x6ugo59YB
wxH6KxdizFIQ8tVWN3sd8lOzEArin9zxKDcaRWSjxyL5NH98nzzEFNrQX3Qf69N4
ziFdb45MaKovNo/tSYiYNglMN+WkCRu6E5PkxErBREcT84yHK5XjNj/FSwmqMnBt
gvlNtojgTNkO0OhzLFiDEA5Ha61i4zir+tKhIGDfeWikc4jV8YIkryjzX0mFUXdE
w8tlELxcaillspGo+HFcyyZ7y8vvAaDaMm1b6AcbQWTM1vNagNxNgPZzJUj/Vqh5
0mBYPVs46434GFpBbcD5r/1oD8efWQ==
=C474
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--
