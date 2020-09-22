Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018E4273ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIVJr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:47:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E9A2145D;
        Tue, 22 Sep 2020 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600768078;
        bh=QSNZZdWghjMdTCu5w4Ake1FY6e6LLkyXLp5ObVBEQDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2/VE8EFEaKNzuNRiQoUIiO+pq4+y5hjTRf0wkTJ3CI8QM3xY+TOyDls7xX9Fe0Lr
         lhMNs58CxPhIZDXUIobz6R3AGR4+wm977XWyH/BC6YUI3Thh3A+YO+I0XBMbfIzo+i
         9x9/o/03oSyN1zS8u6RFxrfzgr9B+2OZeydLGx+I=
Date:   Tue, 22 Sep 2020 10:47:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] ASoC: tas2770: Convert bit mask to GENMASK in header
Message-ID: <20200922094705.GM4792@sirena.org.uk>
References: <20200918190548.12598-1-dmurphy@ti.com>
 <20200918190548.12598-6-dmurphy@ti.com>
 <20200921190437.GJ4792@sirena.org.uk>
 <bea218c8-c71d-2ce8-da92-14af73ac4da5@ti.com>
 <2ca0647d-1ebf-1290-0f75-61bb97324165@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75WsOQSofUOhcSOp"
Content-Disposition: inline
In-Reply-To: <2ca0647d-1ebf-1290-0f75-61bb97324165@ti.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75WsOQSofUOhcSOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2020 at 02:19:36PM -0500, Dan Murphy wrote:

> Forgot to ask are you going to take 1-5? If so I can rebase on top of
> for-5.10 and re-submit.

I think managed to apply everything with manual picking things, there
weren't any actual dependencies.

--75WsOQSofUOhcSOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9pyBgACgkQJNaLcl1U
h9DsiwgAgInlwOJ7/tF5NZd+FEFgPUEhP9z0vVk2EZCK7PNy1OQDyroVCdpjBuxb
8vl5D3Tv2AEwwWhjhCch/jCMnlSoju5t/Uf/eGbPHP5nHs91s+6jEP08jDHSS+jB
VJGfyNNc0R8Gzl8Ld8EVgBgC75nhWLe6tWo0aIMTU7JHG31dzM+ZQgVG1EJ+qwm8
XSZOBBoP7Hp3+DhrL7EoXi33GuO3pZjiSChTB8CVzTPjXRisXld/DgZEzuXTUSxP
VC5DkZPgWkIJzHHp3o1mfkH6tZWPq7pMC7dP2cpXtNE2l0hKf/wXNna76puApVxL
9DbZLAgOdYWUPEfY/4UF87Z7mvIpXw==
=g78R
-----END PGP SIGNATURE-----

--75WsOQSofUOhcSOp--
