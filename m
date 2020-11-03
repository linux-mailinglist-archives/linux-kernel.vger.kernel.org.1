Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332B32A4EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgKCScF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCScE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:32:04 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9572820757;
        Tue,  3 Nov 2020 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604428324;
        bh=S2+luEP224P+V/hzB3++cIuASCQaK+Zan4ukNr60FLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boO/t5WPwDC2rtjnrpDDrySYTJ54UOhL5I4DexdZlMxZAjotXoQcqJWvEDtUHIpvy
         itMm7CILtwBPyiIzWomE0p2o7c7WXlFQPgMAorx7AFVo1yv3Si8z8725aNH07I3Ik5
         OMgokN5QMIbnkG0fGDV1cHqAnjjedWX+mEOUF8mA=
Date:   Tue, 3 Nov 2020 18:31:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Yuan, Perry" <Perry.Yuan@dell.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: rt715:add Mic Mute LED control support
Message-ID: <20201103183154.GG5545@sirena.org.uk>
References: <20201103125859.8759-1-Perry_Yuan@Dell.com>
 <20201103131253.GA5545@sirena.org.uk>
 <5f2c1282-4401-276a-8dad-127fa1f449fd@linux.intel.com>
 <20201103175948.GF5545@sirena.org.uk>
 <DM6PR19MB26368B60076D049F009B75A3FA110@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <DM6PR19MB26368B60076D049F009B75A3FA110@DM6PR19MB2636.namprd19.prod.outlook.com>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 06:04:49PM +0000, Limonciello, Mario wrote:

> I don't think it came through in the commit message, but I wanted to mention
> in the system that prompted this software does not control the LED.  The LED
> is actually controlled by hardware, but has circuitry to delay the hardware
> mute until software mute is complete to avoid any "popping noises".

Ah, this doesn't correspond to the description at all.

> The flow is:
> User presses mute key, dell-wmi receives event, passes to dell-privacy-wmi.
> This emits to userspace as KEY_MICMUTE.  Userspace processes it and via UCM
> switches get toggled.  The codec driver (or subsystem perhaps) will use LED
> trigger to notify to change LED.  This gets picked up by dell-privacy-acpi.

> dell-privacy-acpi doesn't actually change LED, but notifies that SW mute was
> done.

> If none of that flow was used the LED and mute function still work, but there
> might be the popping noise.

With a timeout so that if things get lost somewhere then the mute button
is still functional, or can userspace block mute?  Also what happens if
userspace tries to set the state without having done anything about
muting, will it trigger the hardware level mute as though the key had
been pressed?

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hohkACgkQJNaLcl1U
h9B3+Qf/UodcwIVMP/9TkttH3uazJZfOQxj0EUuJOB5eFsOxCxEHaKKck7sPY5ng
PNpXfwWbGXkEngU8k3cmIEfM4aUML+t09MuDXxn96f8jc1TIb5Ypesy8UwI0Rh/S
pYAK3fBL9sXS93LQ8VnRHEiFGWJHyHrTtEBYWN4Et1FCsASNxzZ7QQlLqNcVixvH
KthGIT1k3Iazal43/EUxDvXj7W25qfxNqcHeulBI3WuABKit1P8pM5TCqrLDcyvc
bDObV1mofCmq1Iq/o5MVI2yr1U8YSMAsZb+uzRzonnKxCPM+jIbI7UWKG61+zn2J
4waYK8+afP34SjbeG4P7E24RO/rz/g==
=timC
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
