Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728932F9F17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbhARMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403874AbhARMEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:04:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E4AD224B8;
        Mon, 18 Jan 2021 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610971442;
        bh=5JIZNpOAuXjudU6ZQ7N4iBY+T/rnQaQAjKMQnYWoePw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/y1YPLsE9UFBFBA7q92Oa50xV98nkfD56zidQK28kcnH9LdVVPmjGH7MOCWLCa5W
         GbNRs7ZtZO4+y+IXTF4AfX5eJxBUBu0ZjvQwHNCnXEQYsR6LmI8IVpx/NHMOuQxk9f
         yGlJy7Hy7utlv5oVu61EKnEyr1Jb7RMYIyEHZ3BMfH0WZqVH8CoKXnskpetpWyV6XM
         +Vk8g3/n0HlMRhpmb0Rmz+KxRkLZ7wtdq9aEh/GMBMyls78bpL8Cy08jLabipCsO5o
         HauiH6xMzlPMYMtlXYsvj48WrZ8n5c/Lr9k9Zu1imT3jFjOn8EXjpLtHGJdq3CvSay
         sUWaLp7icxyCQ==
Date:   Mon, 18 Jan 2021 12:03:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Perry Yuan <perry979106@gmail.com>
Cc:     Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
Message-ID: <20210118120325.GB4455@sirena.org.uk>
References: <20210112171814.5404-1-Perry_Yuan@Dell.com>
 <20210112175406.GF4646@sirena.org.uk>
 <bd2aea87-2f91-2748-424b-50b3b6feb22b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <bd2aea87-2f91-2748-424b-50b3b6feb22b@gmail.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 16, 2021 at 11:50:31PM +0800, Perry Yuan wrote:
> On 2021/1/13 1:54, Mark Brown wrote:

> > > +	bool micmute_led;

> > What is this for, it never seems to be read except for in the function
> > where it's set?

> Do you mean i can use a local micmute_led var in the function?

Yes.

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFeQwACgkQJNaLcl1U
h9Bi/gf/a1axKJapuFhHFDtl+4V48j7+sPO2o2ca2rzuf5frVz4W4s27sxUvhgr2
t0CPGS0wrR3P15AlEGaMhlBvZbv8KZUA8FAGI3F98fgcxzwWOaWZmDUb/tLrnr3X
QQVcX8sCWqz64o/WyBIEqSvKwxkDIgK19RjCHC64Q+JQz5hpPLkdO7uTAbqslLqD
AMHP9m5rXkt4p395mENABsxV/fN0i3NESe4sbBR3J4iblIMQ1OTC8Q4/0gmG/mYz
5wy5KjCfT8v4QPMcbp8LjDsg4M0hs2+LdxA2DijSlQyIGgOuhzjB92WcA9Yprfog
loUeGuAuZ+Yx88zu3XVDEUmVfcqjxA==
=0TFr
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
