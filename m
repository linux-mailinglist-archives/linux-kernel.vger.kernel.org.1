Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6378E2CA1EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbgLALzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388439AbgLALzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:55:52 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1695320770;
        Tue,  1 Dec 2020 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606823711;
        bh=UXTodn20vM340ET6hxCExdQHpdca76oa7j/yUKECCdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqE9vgq/wcYIFSfm8Ip9dxz93DKxhJIfFjYBdC3vhTJndwV3HIASRIG0SD+zHMT7+
         AjlIGO9Qkfcs2qn8O8GSGH+Scv9dUnn3Je2t2RANf8/Yzk/8PUsjy9pvHoHA3E/i0x
         kt3h8LJy/507OzFiOMBSS7ho/6YqMvvrFGUQZiCI=
Date:   Tue, 1 Dec 2020 11:54:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 2/5] regmap/SoundWire: sdw: add support for SoundWire
 1.2 MBQ
Message-ID: <20201201115442.GA5239@sirena.org.uk>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
 <20201130144020.19757-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20201130144020.19757-3-yung-chuan.liao@linux.intel.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 10:40:17PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The SoundWire 1.1 specification only allowed for reads and writes of
> bytes. The SoundWire 1.2 specification adds a new capability to
> transfer "Multi-Byte Quantities" (MBQ) across the bus. The transfers
> still happens one-byte-at-a-time, but the update is atomic.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GLwEACgkQJNaLcl1U
h9A7LQf8C0cXx47sMtn4yjZCjODupEpGS4PJHRdbPVB7s0rRyQQLboBoL+HFcZF0
CWnUBsnOZozy5gLNZw8X/kxCYmxyeReAHyHa2LP2GaP8KDfw0mWfDFRAewsnjMLq
2Ip6nyo3BdNs0V1p9OnlfJFwwUgzrS1x3iep1giFQ7E/6vTDyRatYbgyVaIhbDaW
gG1MvJr5JhpC96EryoKYQom+ed3dWFjCgSZDc6gUQ9aDXPw8/sscDFnzfN2ZW7ZX
W26nbEc7tKU1SLnh9LSevxZk/zE3k5LVNx86fgsd4CbJ6du7BB5tHiEV+Iy8+tFA
HVXqBlYg5rObHac/Y2NtasWW5uNHfQ==
=3cHO
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
