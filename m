Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E6A2BAA67
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgKTMqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTMqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:46:14 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391B82222F;
        Fri, 20 Nov 2020 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605876373;
        bh=7hAofjYH5iXNJ02vsuSUoDIPviy3rmTdf1rIte8kiN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUN11mHUsbI++NuPSH4QGPttskzxJGNE9ob1LuLNA5wzeW73nWyVonn9fleaM0oG/
         tmZWKMefluthmTNj00s49zU+FwTYLFn6JG39FG/Bw1ZSvnLV6DKD5wpAs8evnC9T9d
         pfP9o693N57Ogki8HDFJ8HEbLCAomnxlNeNWQiJc=
Date:   Fri, 20 Nov 2020 12:45:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <adam.ward@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/9] regulator: da9121: Add device variant details and
 respective regmaps
Message-ID: <20201120124552.GA6751@sirena.org.uk>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <e3f0e227c099a2dc560af5aae92f13e4d2a112cb.1605868780.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <e3f0e227c099a2dc560af5aae92f13e4d2a112cb.1605868780.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2020 at 12:14:54PM +0000, Adam Ward wrote:

> Add ability to probe device and validate configuration, then apply a regmap
> configuration for a single or dual buck device accordingly.

This looks like it might benefit from being multiple commits - "X then
Y" type commit logs are often a warning sign of this, it's quite
difficult to review as it's doing several different things.

> +static int da9121_i2c_reg_read(struct i2c_client *client, u8 addr,
> +				    u8 *buf, int count)
> +{
> +	struct i2c_msg xfer[2];
> +	int ret;

Why is this open coding register I/O?

> +	name = of_get_property(chip->dev->of_node, "compatible", NULL);
> +	if (!name) {
> +		dev_err(chip->dev, "Cannot get device not compatible string.\n");
> +		goto error;
> +	}

You shouldn't need to query the compatible string as a property, why is
the code doing this?  You know what compatible was used from probe().

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+3un8ACgkQJNaLcl1U
h9ApYgf/WbJsyT3LlJAbon/jHXkpaLqxqEdvDxVjgfCs8gcEKWZODsFuURcmvon4
yOPmr73Mcy00D1eU4QqrbrOdFO3bKzaxQKG3YyhrHRaejN07PYTCUucey5AVNCkF
CXeUGzu6XCMlPSw17REm3byFkc6YITeYA+pMMZgarTW9emfvhJ6Y2lGE+yPlYCls
YjjsSFLyqqMqnN076OHZ/BK2sOrc3WKV8QH/jh804AmDoeLAuFXXRUDlLr4HUDi8
+8gKtzL2RYnCDCit2uSWoVUVE5hehNTdDoPBFNnYf6PO/5LIxcR75ky2kwPkXNvz
RIfK6ML8mqEbpULuZ7PLtP5ma7HqYQ==
=d8wh
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
