Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD221ECEB7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgFCLmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 07:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCLmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB0020738;
        Wed,  3 Jun 2020 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591184563;
        bh=TIfw/cANrvleb6jHvANTUGWscgbEhvD0pcSy7/RQYAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsCZ6tqKbRWecCFSn/LSHN1jRnCENNTbqogGNkeSCseQG0/CEOEwI2jJlEeB0HISW
         s4vQFI5lnW+0BBE86acH6ViTn2LnaqLi6qnVBmEuVhweUuBCIyQCJNL1XRznU0wji/
         99vYDogaIDn1m5CJAww0lubymqby2iDYMDdlmMj8=
Date:   Wed, 3 Jun 2020 12:42:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <SteveS.Lee@maximintegrated.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "steves.lee.maxim@gmail.com" <steves.lee.maxim@gmail.com>
Subject: Re: [PATCH] ASoC: max98390: Fix potential crash during param fw
 loading
Message-ID: <20200603114241.GD5327@sirena.org.uk>
References: <20200603111819.5824-1-steves.lee@maximintegrated.com>
 <20200603113145.GC5327@sirena.org.uk>
 <MWHPR11MB2047B58F4B5E395CB76CCB2392880@MWHPR11MB2047.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <MWHPR11MB2047B58F4B5E395CB76CCB2392880@MWHPR11MB2047.namprd11.prod.outlook.com>
X-Cookie: Your supervisor is thinking about you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2020 at 11:37:44AM +0000, Steve Lee wrote:

> > This is now reading the size out of the header of the file which is good but it
> > should also validate that the file is big enough to have this much data in it,
> > otherwise it's possible to read beyond the end of the firmware file (eg, if it got
> > truncated somehow).  Previously the code used the size of the file read from disk
> > so that wasn't an issue.

>  Thanks for quick comment. Can this case cover by below line?
> +	if (fw->size < MAX98390_DSM_PARAM_MIN_SIZE) {
> +		dev_err(component->dev,
> +			"param fw is invalid.\n");
> +		goto err_alloc;
> +	}

No, that doesn't cover all of it - the case I'm concerned about is the
case where we've got enough data for the header but the payload is
truncated.  You need a check that param_size + _PAYLOAD_OFFSET is less
than fw->size as well.

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7XjLAACgkQJNaLcl1U
h9CS4gf3SoiQPyfuvGkPPhzguKoHriVvRp+AFejSxVitcpSHlK+guzMZ7TbsUahq
mT9724QlmWXhv3pWStaiWn5BblXL1cw/jLwbWOB9g6J0JoH21c8LsfnaUe1ez9Lm
xfwqJWF6TXjUIU/EVTsB8U1Ic0Sedxz/+QwDUkkxGNKy9JjfB4BhFsci7v4x0nz4
euUPfTgLFjm9iDUkZeNWkz35EPGmcBTW7PcC+uWTw6WTPamU8ilUzFWvJHJ988WL
FdesETMKsTr06Yr1q8raecZPBmeRcQqpdBYiE8Q9JyC/gGRGXlOpC4V8/zTrMzg4
q0nSFTDhbYsZwNROBUbavgArgCVK
=FYh1
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
