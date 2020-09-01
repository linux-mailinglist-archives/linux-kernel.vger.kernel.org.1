Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91317258F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgIANw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 09:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgIANvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:51:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A50B206EF;
        Tue,  1 Sep 2020 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598968300;
        bh=nrvJQoLEDTfHtV5/hqRrKSb9nbwD9I5lVDWOWJimEmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euK5FvAzP0U9LLXo6k3cibYxOhvnPhJzMmFD5V5WK37i7kx0+scO3zaUhu59r0g7N
         DCGpV09HeIjVCF7LNIG0bCXuOmbT4981klzdy/j8oWWi673cH/jx8jvNy+Xn9XiI/H
         hZVVA+gJ1YSnx39tGOLE+KM4ZPU5gdypkgUfGQX0=
Date:   Tue, 1 Sep 2020 14:51:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v4 1/3] ASoC: codecs: soundwire: remove port_ready[]
 usage from codecs.
Message-ID: <20200901135101.GE6262@sirena.org.uk>
References: <20200831134318.11443-1-yung-chuan.liao@linux.intel.com>
 <20200831134318.11443-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <20200831134318.11443-2-yung-chuan.liao@linux.intel.com>
X-Cookie: Equal bytes for women.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 09:43:16PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> port_ready will be changed to a fixed array in sdw.h and all initializati=
on
> work will be done at soundwire side in the following patch. So remove them
> from codec drivers.

Acked-by: Mark Brown <broonie@kernel.org>

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9OUcQACgkQJNaLcl1U
h9B9KQf+PTnsPHfR61V3yh7tnlhzRn3zxze90AINjkpdZ8g3HBYdzKji7+yeL8tr
Z9QkHaZZrv37x6qox0xa3F7V0w1g8n0+QKBoksLFlTtGqdQMexnYuyPOaWH4SkHF
aYQJ64ovRqq9bGCqcU6bNSp6ri4cjqh9SDmmj1t77BNZkGqLHS0pmO+FH5Pfzzo7
cJ0W3NzCGL+CfUFqcS2KHZbnOfpWNa+Evvue6TlSv4V4hYjfKMtg9GLr/tnoSLih
SXxLXhSrkuHYNSqyelgflTGBtVopDsUmMxEhUo1lDWcfpwcXZuvv6EnlbjeWKrH3
ArsXUOk2Uqj9OWEpDZAktI1ybnGdHw==
=xVih
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
