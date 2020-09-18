Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0025826F9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRKEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:04:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4627F208B8;
        Fri, 18 Sep 2020 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600423460;
        bh=rHX2SJofq2IV2gFxJYFKOzylhVaYmIes7RqnZSio3jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kG8rJC4Cp3hvPot3IGhEDxr/XcztZKD0zBEoAcGY/UDvmDIIJspf24TsdjkIGywuC
         zSbCqfERK3B448QOXLpaLB45J6Tl3VodqOmJvcVMwMEsg5OO6S6oEzLyXS/PNKoz0l
         wPU+1g6T84vkWW85jwFPbT0tY9oOlsmRulj+eVfQ=
Date:   Fri, 18 Sep 2020 11:03:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alban Bedel <alban.bedel@aerq.com>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (lm75) Add regulator support
Message-ID: <20200918100330.GA5703@sirena.org.uk>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
 <20200917101819.32045-4-alban.bedel@aerq.com>
 <20200917110053.GA4755@sirena.org.uk>
 <e5863e71-2531-b0de-c432-4bc2967d56c8@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <e5863e71-2531-b0de-c432-4bc2967d56c8@roeck-us.net>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 07:04:51PM -0700, Guenter Roeck wrote:
> On 9/17/20 4:00 AM, Mark Brown wrote:
> > On Thu, Sep 17, 2020 at 12:18:19PM +0200, Alban Bedel wrote:

> >> +	data->vs = devm_regulator_get_optional(dev, "vs");
> >> +	if (IS_ERR(data->vs)) {

> > Unless the device can work without power you should not be using
> > regulator_get_optional().

> The driver works today without regulator, and needs to continue
> doing so.

And it will continue to do so if it uses the normal regulator API, it
will as ever ensure that if no regulator is provided by the firmware a
dummy is provided.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9khfEACgkQJNaLcl1U
h9Bepwf9EYuxEZIeHPaK2Y0tAjFZp9YXlbTfjm444mUIeGVycPVpixaad4WmaFfx
GwhiOO9mbYjzskCaeTjuY365KEofDOqY68qR1D1PmX0inyYE6WQfS+gYhDaS/JFd
LKLOM6oSst+LamCt4GljU5hPd8khylSGriDqAZey/HArmFsjiMjf/P/+kHoe6NHy
hhDqj2FY47DZq5OfJgHnOHGWZckVlJhzprcBhXJI1fbgzsWrwN/D0yDdBNj2c6LE
P3fPIoM4nTZCfBLydMrMoDDeSmhYb7xAeMFeeaXAVUAfbo6JJjOXb1FySeThLvAv
H+r0E+jRWuNtHjjSZli7ckZzBOZ0eQ==
=dCm7
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
