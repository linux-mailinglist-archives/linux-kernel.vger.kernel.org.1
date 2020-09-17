Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8AF26D9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIQLGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgIQLDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:03:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74522076D;
        Thu, 17 Sep 2020 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600340503;
        bh=aPCEwcIAuMvYoCEBtOQo2eERHoS019qUBYLdVY0/hTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ccLIq0l0KnciBSQeBF5gPuenyxYph0LJQ4FgwgULOzMRDnR8LzMTkkgaclkQ6UOy
         BHB6aUZLthOo8hUIvk2Cgr43XmGm9QSZr1+/9U9L1iBbPajP4pWOXKfFHocssoYmDM
         iXVEVmsro/blj+Bt9nPVVgCsq0g3ZRBa7MDjEk0k=
Date:   Thu, 17 Sep 2020 12:00:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (lm75) Add regulator support
Message-ID: <20200917110053.GA4755@sirena.org.uk>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
 <20200917101819.32045-4-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20200917101819.32045-4-alban.bedel@aerq.com>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 12:18:19PM +0200, Alban Bedel wrote:

> +	data->vs = devm_regulator_get_optional(dev, "vs");
> +	if (IS_ERR(data->vs)) {

Unless the device can work without power you should not be using
regulator_get_optional().

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jQeQACgkQJNaLcl1U
h9B2Jwf9FsOfhx52XRbTX0EQlV1uzHXTjKYKY0f/VVzp1/NtZQjgJW/qzpGIstuH
JgAoa98HRd+Dd7MSfrLgDepC1+7MHNaMlFL4Dv28/V9NkM9atu9dvxduwckp+1sR
sIdeHldh7jw5Tmjz5dmKbKbWn17r5MX4eTR8pv1hZlKfCraIIVMq145NgBiV0q6R
JurB8qhGznwolBc4hHz6X+rAyNo+ZrvE/hsfxtKaXVjziSQwgRopaSbXlD5pTYsD
teudpthwvxrG9lg/HVY+WAaBhpNxHSLKfr7IMV1tptOqxRvnOKn+c+6/CicnpZiZ
fDHkDqIsFPj98T7sHutzo79R6A6xHw==
=XT8Y
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
