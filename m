Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3A2537A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHZSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgHZSyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:54:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FDA207BC;
        Wed, 26 Aug 2020 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598468044;
        bh=ebwKmGdOeprx83MyYGND4GRTRQNsNOFyBpZtZgqs8Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+fivWevpE6qI2mGFxVpJafBnuZ/slTzfAFWOdQKtHUr/6ZUUkMVX06ZKTMteu6dt
         0+prpbTseOZt2HYXQ0RZN/tccmGACVzYmzdgOWvd5mJFNLWfCJ6vcJ8GyHHWth7Cjy
         1EtbxnjeIdjs2CDqa9sCQjJDPchTyyvQ8oOSIDcQ=
Date:   Wed, 26 Aug 2020 19:53:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] dt-bindings: sound: Remove unused 'linux,hdmi-audio'
Message-ID: <20200826185328.GS4965@sirena.org.uk>
References: <20200826184851.3431531-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BuGwuXnZwGGQ9GEc"
Content-Disposition: inline
In-Reply-To: <20200826184851.3431531-1-robh@kernel.org>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BuGwuXnZwGGQ9GEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 12:48:49PM -0600, Rob Herring wrote:
> The binding was added in 2013 and has had no driver since 2015.

There is the hdmi-codec driver that covers such hardware and would be
compatible with the binding.  Of course there are no current users so...

--BuGwuXnZwGGQ9GEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Gr6cACgkQJNaLcl1U
h9Afowf/f/hzqNG+gezOm3/ICeb8uOkUWWmnaFDqY8sTo9Wx3WnTo73L+Yt0L4jj
MGJY2mPDjnpsL0CvNm+tLxCECxBJ/tXf7uXnDTj6xcGEMsFPZ9MXpyUwXsuoYXCT
rkm7PZv8Lnl1RkgCxY/ZOgGc9Kx3vKPb9ty1svN46ZQyWTxaZIw4n5Nbic6F5M+W
G/e/7SLtCNaKFt+hPIsijGW1R4aATIuk4YUDwt/oOUWrp8oAYnb1mRxoUsDR5sbx
RQYAR4ta8Ax7GdU849N+IShcGqpC9AwjBB7J84IRM6R0ZBB7xhyTgYqjfeXfkGIA
xDNkUiqUwl7VpZB2JhXOSA+D0Pqf8Q==
=nMG4
-----END PGP SIGNATURE-----

--BuGwuXnZwGGQ9GEc--
