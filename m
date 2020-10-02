Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB26E2816E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbgJBPmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:42:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3CF02074B;
        Fri,  2 Oct 2020 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601653327;
        bh=v5iehWcOX0VLo1AP99P9bUun2tqq3LWKlFh9oC0pM6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vlFOtcqOxfyc22WCafJBSQo1lA+ZbQIvpliVp5g+LacQS99cqT50bn3+vFDF+rpbf
         9O0c5qNtP/fwlvgZ9oVP7lGlhLbedjAsUNUFgwBzyndZI4MgINYQI4itJqbXsFbSBC
         77+q/QTtoD8VTqtvt7RQsUcbtA/ANEIvZN+tL8ic=
Date:   Fri, 2 Oct 2020 16:41:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alexandre.torgue@st.com, arnaud.patard@rtp-net.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: cs42l51: add soft dependency declaration
Message-ID: <20201002154107.GC5527@sirena.org.uk>
References: <20201002152904.16448-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20201002152904.16448-1-olivier.moysan@st.com>
X-Cookie: Words must be weighed, not counted.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2020 at 05:29:04PM +0200, Olivier Moysan wrote:
> When configured as module, CS42L51 codec driver uses two modules
> snd-soc-cs42l51 and snd-soc-cs42l51-i2c.
> Add soft dependency on snd-soc-cs42l51-i2c in snd-soc-cs42l51,
> to allow smart module dependency solving.

Doesn't the userspace tooling usually manage to figure this out from
symbol usage?

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl93ShIACgkQJNaLcl1U
h9AfMgf/bO5iRl+FHKAa69Dt5NyALR5rJ9EhOt2FrK6Ql/DPOjT4GJE2wWdt/fKD
H9c2EU6rY0lAp4X7M5PNZJrq4gOcyWdGaHfIOfXBf2qiEzN3L6AvX6iA5oBi1s3O
eECGQmaRqcwv/nSuoOnzpkoKyywBq9+o9lkHWu1jBg7uhYU1kjp4kJmifrl1aeFU
QrxFCjLwGSjmNFfm7v3N/33M/aNRwvhyrG9ct+19u1GabgzXBQpLqVj/7Qf1R4Ab
4Wx8zbP9UI9kW+NLwFewr2wDMP4+WC86biyvT8yU2RYGfxzU3l5U6GtawF+TDhpR
yBPJ2eIvTmHz66uX7dvMIHlzF2V+GA==
=ioD8
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
