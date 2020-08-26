Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C261252ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgHZJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 05:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgHZJ4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:56:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B216E2067C;
        Wed, 26 Aug 2020 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598435797;
        bh=Du92FRhluqAO2AfdX7nuJTjVbvuW6hgvo/vP+lWSr24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdfWy0/QaWPFtQjk2lXSEtNgQqysT5/WhksLCOpQllp9p4OOtV7AP/mzQ5vFDWHlD
         sLUtEGwkdKj9uLYZOrPFtQ+iGre0kpZEzY2CIznSxdCpVKuYPRtR5OoB5n6qgoQPey
         0ln0FMJ6Ge1RBMERGg4vOwjJ2wuPY0FYYohFLmU4=
Date:   Wed, 26 Aug 2020 10:56:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Message-ID: <20200826095600.GA4965@sirena.org.uk>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 05:08:55PM -0500, Pierre-Louis Bossart wrote:

> > > -ENOTSUPP is not a valid error code, use recommended value instead.

> > What makes you say this - it's what regmap uses internally for
> > unsupported operations?

> This was flagged by scripts/checkpatch.pl (must be a new addition).

checkpatch is broken.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GMa4ACgkQJNaLcl1U
h9A/SQf9HoAkYdbr7u7FlIMWhzgxCUW+PydJy4E0E+RX1QXJxu5obdTE/47MxSIb
bQ2qLl9g1OyqblmHty4BJSGCH/8mHqiNbnidixs3X1jUGkKepC/MWLPNDNTLRNMG
67ckWqo71U4tODQcO2gEdmY4ADZo1b93YkataMFExkVYs+tcZ+0h88gzrxE6DKLM
lIDq+0U3SL0V0i3kp+OJ5e8CU2Lku7cal/+EK8yGsLAe+4o8QVc2p2w1C9VZ6KUG
PDcSyqQq/jTcjio3WnrDzFv54keLw4yh0nyDeQ5liWQYM2m6hwRaWPc7JZT5UxYe
4x1gBq/4qbM70bYgCwcZilMV2T3UaA==
=dXb/
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
