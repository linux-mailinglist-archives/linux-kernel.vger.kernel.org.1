Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4726F9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIRKFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgIRKFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:05:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C487520665;
        Fri, 18 Sep 2020 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600423531;
        bh=h0lkuxqUPtrrUnI9EjvXQhkOT9wfxsfGvLGrRfcRWpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHddCIFCZn4+sdX5R0OHIYUPadPzF8mhaCWTel5RLNX1E0Row0SILO/lOvsav2PCO
         8lc0l0iFGenegjZeJyefH34rt6vrt7hwHMimIz1+tXzsggxE6OsLuf4nfV+aRo639+
         Tb4MRuZx6/tMbSOv9EQ7X/TY2wR3ZrF3p02ZI6Js=
Date:   Fri, 18 Sep 2020 11:04:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alban Bedel <alban.bedel@aerq.com>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (lm75) Add regulator support
Message-ID: <20200918100440.GB5703@sirena.org.uk>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
 <20200917101819.32045-4-alban.bedel@aerq.com>
 <7986c014-b826-bad1-f19c-cdda31d20804@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <7986c014-b826-bad1-f19c-cdda31d20804@roeck-us.net>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 10:33:37PM -0700, Guenter Roeck wrote:
> On 9/17/20 3:18 AM, Alban Bedel wrote:

> > +		err = regulator_enable(data->vs);

> How about device removal ? Don't you have to call regulator_disable()
> there as well ? If so, it might be best to use devm_add_action_or_reset()
> to register a disable function.

Yes, disables should be balanced (and any attempt to unregister the
regulator with references still held should result in a warning).

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9khjgACgkQJNaLcl1U
h9AdDAf/YNuWEsjoIefRmZlEaEFDrFOFf++WJDvAcSCC0fP0VeoLuRhuNjHGdYDM
jmwCuCSjeb0sX74vrLNmK6/SIsny3ffxorGP+OVo2mluxO8VRnLQT/DkgXiZ6eAH
1Tk7/v3jzHDyeRNvXEnGmGTq4BqmSa7LgOozSOJkVWuJvfPDJQyipK4/bYF+taN0
c5I8179rpeBwQXFfT5SywLx1G2MIxg7TfgmBqdftTnc7+dLlJ94iN7twLoprtYt4
ujfCjaEM2+Bq3EZgIFBzIWW+j2x79l95Tm0JGPqVog4c72At13ZjgWdvBQknHzIT
H7hOtmKbybGcenxIEVbo/ebAD8H/3A==
=n9tP
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
