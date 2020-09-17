Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6619E26E5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIQTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgIQTza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:55:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90F522208;
        Thu, 17 Sep 2020 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600371876;
        bh=LYsXBy9sReRqQb5R0+Xnz3acCFNHtMFk7zRgh1xaaw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1drDQVx2rMepCPz0mJg6bq5sI2mBY6sNvGn9Z/f5cAblLwriZfbQeVzMUtCpxy8J
         Y1CPxMehWt5H/+h7QvR9AFBYeHVen7dPxx+WY+wTPMxh4tacR5U4Bw49bh4a51KlKb
         HdOT/BcVQLKiR0Th4LI3BTTlKtnudxuk365OrUq4=
Date:   Thu, 17 Sep 2020 20:43:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: correct interrupt flags in examples
Message-ID: <20200917194346.GI4755@sirena.org.uk>
References: <20200917185531.5767-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <20200917185531.5767-1-krzk@kernel.org>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 08:55:31PM +0200, Krzysztof Kozlowski wrote:

> Changes since v1:
> 1. Add acks

Please don't resend things just for acks, it gets noisy.

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jvHEACgkQJNaLcl1U
h9BRMQf/XzQJgoI2JZ8w3TYpefwva8RNnWE4vFscAEspB7e8/KO/uj733ap3E4c1
4T33seEQS7l+VHjEALZInN+LZub6H/YCak5iJ1gTQQalejVy5W64AXafh7sg58pp
J/0xo7RSTjJ/YcHMPNQtVVMUyOzT58RLddpKSZBe9N0CkAxb96kzC6odgp/rwrh5
lp5O+G286wR6j4Rm0hWLz7/Al5IhA20xOY2Hn5hbMdfjhkKe1hBejKqCSwTJbhI/
kRHdyQapGDJ19AeJeBArysPAf2swCvXUhzFYNgild0RJGmz47dY/RayKeyZoiK4g
I0/pjJ4h8n+iknjMwFHw0+pS8Lao2A==
=QHk9
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
