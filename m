Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78C72A4DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgKCR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgKCR76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:59:58 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0F42072D;
        Tue,  3 Nov 2020 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604426398;
        bh=myiQSetuaOVY2s00Fw/HJY7NZtbPqFtWMR2GOqq7LaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qn8i76ftYKltphxPFhL0h2ueDmWQjCB5rcjfkGmf4Hhkm05JYR4/MDmKXGFRtL19i
         aAE56pxgcBMBelLc4jTt8qmjRFWUv2vl4JdklTbY5+6/OpLPfh+Z6XCnPyJt/c37r/
         yEPlke3ifo1+5OU7XlvqY90kzlZXu0RAkM9co3Is=
Date:   Tue, 3 Nov 2020 17:59:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        Limonciello Mario <Mario.Limonciello@dell.com>,
        linux-kernel@vger.kernel.org, tiwai@suse.com
Subject: Re: [PATCH] ASoC: rt715:add Mic Mute LED control support
Message-ID: <20201103175948.GF5545@sirena.org.uk>
References: <20201103125859.8759-1-Perry_Yuan@Dell.com>
 <20201103131253.GA5545@sirena.org.uk>
 <5f2c1282-4401-276a-8dad-127fa1f449fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <5f2c1282-4401-276a-8dad-127fa1f449fd@linux.intel.com>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 10:13:03AM -0600, Pierre-Louis Bossart wrote:
> Somehow this patch was filtered by alsa-devel servers?

It'll be a post by a non-subscriber I guess, in which case it will
appear later.

> Actually thinking more about it, having two controls for 'mute LED' and
> 'capture switch' could lead to inconsistent states where the LED is on
> without mute being activated.  we should really bolt the LED activation to
> the capture switch, that way the mute and LED states are aligned.

Yeah, it's just asking for trouble and seems to defeat the point of
having the LED in the first place - aside from the general issues with
it being software controlled it'll require specific userspace support to
set it.  Users won't be able to trust that the LED state accurately
reflects if they're muted or not.  Your proposal is more what I'd expect
here, I'm not sure we can do much better with something software
controllable.

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hmpMACgkQJNaLcl1U
h9BVjgf8C+njK++aKY8qtGeUcVwFtnGUeFxLFhVMNutmVvWC2xEtIe1hUP04ocd2
PVluV1HkQ9jWqMrlzRZHMI7Lc+4SuEYVEwWfya6u1s8ne6nLCOJ8vRD9mnYg9GIu
ad2RaisvjaxMca3wt+i1sQgr9ueXrE6t0M6mZbWUWDQLSepxRa0P8gY7JkSpH8nP
D/qm9xT72CS5wKVZ1fvNMLmtPdS937lkN0U71cvh5/1Dwmk9F9kLyTgwrgFh4UK7
ZchgT2sXjrQvItBF662cJS5dfYbOPFzfwnfpjg25+NxWt4sVrU1gWRlVQ+3rVWOg
JGrr9f+rbcbGze2XHLx359CgILZEow==
=rkbx
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
