Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F412E67D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633609AbgL1Q3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633593AbgL1Q3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:29:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88697221F0;
        Mon, 28 Dec 2020 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609172909;
        bh=VxLb1NE5v3gUQB+uN9sYmxNLNiDC+v0OejAmpaBY2jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxsD43eSjbT4RSvYseAjen0QXSJvvyGe5XMmO00tHelZvwDBYwKhZGEyE6okn2CLT
         DSOFVu0whrMHOwy6aV2OnxgULNod+u6ADc/2f23hC1O8gYd8fdUjzGKHo701kmMc6t
         qL6vUIbLJEqTkAHsFuf/dhQhhIExQpENU+W9aH65+bxoizh2amiGp7doti9aw/TiCt
         kinZxltZ+xUyXri1L/OOIbPC1xIKm6bTqv6bATeMFyeEPeqRyjn1hwsEXBFxQkBvHk
         cgmcu4aFoVPo/HyCCCxk4pNTD8ozsUsV2o+FALQaBUNvpNRJgqpfqfQ+R3EF5hT7x0
         NqD2cfNioV5EA==
Date:   Mon, 28 Dec 2020 16:28:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
Message-ID: <20201228162807.GE5352@sirena.org.uk>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
X-Cookie: To see you is to sympathize.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 28, 2020 at 02:16:04PM +0100, Hans de Goede wrote:

> And more in general AFAIK extcon is sort of deprecated and it is
> not advised to use it for new code. I would esp. not expect it to
> be used for new jack-detection code since we already have standard
> uAPI support for that through sound/core/jack.c .

Has Android been fixed to use the ALSA/input layer interfaces?  That's
why that code is there, long term the goal was to have ALSA generate
extcon events too so userspace could fall over to using that.  The basic
thing at the time was that nobody liked any of the existing interfaces
(the input layer thing is a total bodge stemming from it having been
easy to hack in a key for GPIO detection and using ALSA controls means
having to link against alsa-lib which is an awful faff for system level
UI stuff) and there were three separate userspace interfaces used by
different software stacks which needed to be joined together, extcon was
felt to be a bit more designed and is a superset so that was the
direction we were heading in.

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/qB5YACgkQJNaLcl1U
h9DqBwf9HlPB/OmyZntM7voe64geHoxkfPxY7efoEImrcbnYvzdEY/pdORxcLO00
98rT1ezO5jFJHAbH3sO8fz0m/93Yk0z3IDSuLexoQhtP9bK3hDs5u5jWrYlHMOFz
3OFcOctzSUSfOapMPJFQXzxjEiSnNyAdJterGKhHAB+qDkxi29C6iLl7fW7k7ymT
lHgKGSNor058sVZbrajgw2J8iG0aXrEvW9Tau4/pAt1TVF6FmQLj0pQXjo7r/9ga
gkp6C2bsLSeCx3WSujI/MllT94v48jbPZY1801oxseN7c68+gNF2m2lEmvIr03LS
eAdKVMt/V2KU2wSqSn6Z2iWJj7aHvA==
=/OaN
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
