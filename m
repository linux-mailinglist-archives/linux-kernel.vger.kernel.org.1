Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160C02F67A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbhANR2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhANR2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:28:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4826723A5E;
        Thu, 14 Jan 2021 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610645263;
        bh=ITs7F4lqta8MNkgno+KVjF2E/zblSqUUxsnFH+SrTmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6DKp6AX06cKi/42m46sSHa6WUMWFLBsrcK8AopCQsEP3ZoA2ZdBujb04UqwL+y+v
         i9r1gW16WMCtWzpwpYXWtwfiky8cGFMYhSdFMxU7i0y1PtFe6AuIAMvhxYhE6OwGiu
         yspb+meObp+PVa0do2++76a4yZfDG/Ah/gdL32MJdYA33ka4gAJI0YsXdXlMql35Y/
         tArgl+0HSNjXxqHhoAOtpKa8qmJ17nWAY1KbSYKzaI74wacgdGdjdJfyhmmhmEC6Ib
         i05lzhHRfW2WAx2aJ/of4b59PaXo4tsFXAKI48k9CBe3lvPiH0c8sQDSwpy+dVZ7zJ
         UBdPM4cp5IPuQ==
Date:   Thu, 14 Jan 2021 17:27:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     jagan@amarulasolutions.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/6] regulator: dt-bindings: pf8x00: mark nxp,ilim-ma
 property as deprecated
Message-ID: <20210114172710.GJ4854@sirena.org.uk>
References: <20210113222016.1915993-1-adrien.grassein@gmail.com>
 <20210113222016.1915993-4-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Content-Disposition: inline
In-Reply-To: <20210113222016.1915993-4-adrien.grassein@gmail.com>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 13, 2021 at 11:20:13PM +0100, Adrien Grassein wrote:
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> @@ -64,6 +64,8 @@ properties:
>              maximum: 4500
>              description:
>                BUCK regulators current limit in mA.
> +              This property is deprecated, please use
> +              "regulator-max-microamp" instead.

I since found that you can flag things as deprecatedby setting the
property to "deprecated: true" - I think it's useful to keep the text
here since it provides a pointer to what should be used instead though,
please send an incremental patch for deprecated: true.

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAAfu0ACgkQJNaLcl1U
h9AKpwf/dECLRa38dd2us5TPfR3PJJGYVpmNW9uFILRAvVwFJVmBo4DoT/xVzGTL
WeIC6EjrHggrJY+XECsARz0ZhtdV9swSYSYhw/JoL6+EtY+j8k4aYt9jUmmTJaa3
Qr48CkEfQh/JQs/cbq0XQSMWjyPTYO2qXX+UeNqSioewblF5t8P/8uOsRwirNPAl
t6N+TV7oEARe4qbKqeaqFcMNp7Q0g+mT/Q0J9xNf3IteMnBRlgFjEg0609uW9Zjb
M91A6rMddT8qBytdhalqnJGypz7Z16kZRW9wVyvsJbVhQ8w9oabjJNHkaKrhumeI
A3O8hrwzEuu1ZFHpLRU/HSk0qUOAUQ==
=Efv+
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--
