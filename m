Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C51D1C51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbgEMRce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 13:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732731AbgEMRce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:32:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC622053B;
        Wed, 13 May 2020 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589391154;
        bh=c5W9rpD2+UW166Uji2V1vo4DwDd8jq/A5/RA+lqaeOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xEvS/dWbRyHtWlK3l/oGbVdx56XevYH1jTt0hMLnyX4/m+Aow4Q38GA3cw5/TY5c3
         k3EPy/1b02NyJiPHWx6bctoA6uFOD9fMnVNzJ3Kc/HCOMrHSugXPypnW2YbhsfqXbp
         cbujCVqTMXaI4vg+JpFD8prueEPyO5ecgFVIpKYI=
Date:   Wed, 13 May 2020 18:32:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320adcx140: Add controls for PDM clk and edge
Message-ID: <20200513173230.GQ4803@sirena.org.uk>
References: <20200513144746.14337-1-dmurphy@ti.com>
 <20200513153243.GO4803@sirena.org.uk>
 <d2e3741e-ba06-7578-b5f3-2af75e1e33c7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5AmtYbcgdBTTPS58"
Content-Disposition: inline
In-Reply-To: <d2e3741e-ba06-7578-b5f3-2af75e1e33c7@ti.com>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5AmtYbcgdBTTPS58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2020 at 12:16:03PM -0500, Dan Murphy wrote:
> On 5/13/20 10:32 AM, Mark Brown wrote:

> > Are these (especially the clock and polarity) things that are going to
> > vary at runtime?  I'd have expected these to come from the hardware
> > rather than being something that could usefully change.

> Some microphone support low power modes that use a slower clock.
> Polarity will probably not change at run-time, but clock speed can change to
> move mics from low power/low-resolution to higher power/high-resolution
> mode.

> So polarity can be made hardware specific but clocks should be configurable.

> I can break these out into separate patches if you want.

Please, and make the bits that can't usefully vary DT properties.

--5AmtYbcgdBTTPS58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl68Ly4ACgkQJNaLcl1U
h9CN9gf+LkILaGICghjpyYtgNi8Z1pw1uWaWndqzZEEguZbVV7lq3S55zJEgKHkG
SEmCM4aDbuFfodDBs0RVwFZMfdCik6RgsT5rZCUev3geNx/uUGF/XiQ9xFCAXuLM
PMuhkRked9SPFeJB0sYEJMkYMJxqkCciMNP33zmgr+zCSQeUPwhBCy0OSi8rf8wn
LViBXCeaSV894LtQGThe+I+KPvI8kQTGW8O1nIZu+fedQqy8bi3YDy0O/Xh/s+7u
qDUpYHACSE4fxtBAWvgEUVKVcd5oCapyixQ46e6RbsGStKUdpHhdF3VpVBOcq6jt
g1i790FIk3cQ/QxupbQEmwo62lvntg==
=tAtH
-----END PGP SIGNATURE-----

--5AmtYbcgdBTTPS58--
