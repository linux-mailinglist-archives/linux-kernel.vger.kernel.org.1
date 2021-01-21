Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7622FDF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436681AbhAUCYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbhAUAx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:53:59 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC3C061796;
        Wed, 20 Jan 2021 16:51:55 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DLkP40vbhz9sWt; Thu, 21 Jan 2021 11:51:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611190312;
        bh=XCQTcDeBk9ThpWK+HiEI+uHeQVOfoWaAQXNuOfsN0X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESM9gLcLpj0k+xsPlGmWsIoGT1yx5nbmBWFMmdeKU+C95C2jccsyDfBNk2StY8Vwo
         xIFKQIeQijJrNNiY/C2uTbWbTJ7ehYw6lHsbejl62W+41AnhQNFDmPrEK7iDnmr6O+
         PC7BNSezBrk+putfD2/VU1vRHStKxofqree+gw68=
Date:   Thu, 21 Jan 2021 11:51:45 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210121005145.GF5174@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 12:36:47PM +0530, Viresh Kumar wrote:
> Now that fdtoverlay is part of the kernel build, start using it to test
> the unitest overlays we have by applying them statically.
>=20
> Some unittest overlays deliberately contain errors that unittest checks
> for. These overlays will cause fdtoverlay to fail, and are thus not
> included in the static_test.dtb.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/unittest-data/Makefile | 50 +++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data=
/Makefile
> index 009f4045c8e4..ece7dfd5cafa 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -38,3 +38,53 @@ DTC_FLAGS_testcases +=3D -@
> =20
>  # suppress warnings about intentional errors
>  DTC_FLAGS_testcases +=3D -Wno-interrupts_property
> +
> +# Apply overlays statically with fdtoverlay.  This is a build time test =
that
> +# the overlays can be applied successfully by fdtoverlay.  This does not
> +# guarantee that the overlays can be applied successfully at run time by
> +# unittest, but it provides a bit of build time test coverage for those
> +# who do not execute unittest.
> +#
> +# The overlays are applied on top of testcases.dtb to create static_test=
=2Edtb
> +# If fdtoverlay detects an error than the kernel build will fail.
> +# static_test.dtb is not consumed by unittest.
> +#
> +# Some unittest overlays deliberately contain errors that unittest check=
s for.
> +# These overlays will cause fdtoverlay to fail, and are thus not included
> +# in the static test:
> +#			overlay.dtb \
> +#			overlay_bad_add_dup_node.dtb \
> +#			overlay_bad_add_dup_prop.dtb \
> +#			overlay_bad_phandle.dtb \
> +#			overlay_bad_symbol.dtb \
> +#			overlay_base.dtb \
> +
> +apply_static_overlay :=3D overlay_0.dtb \
> +			overlay_1.dtb \
> +			overlay_2.dtb \
> +			overlay_3.dtb \
> +			overlay_4.dtb \
> +			overlay_5.dtb \
> +			overlay_6.dtb \
> +			overlay_7.dtb \
> +			overlay_8.dtb \
> +			overlay_9.dtb \
> +			overlay_10.dtb \
> +			overlay_11.dtb \
> +			overlay_12.dtb \
> +			overlay_13.dtb \
> +			overlay_15.dtb \
> +			overlay_gpio_01.dtb \
> +			overlay_gpio_02a.dtb \
> +			overlay_gpio_02b.dtb \
> +			overlay_gpio_03.dtb \
> +			overlay_gpio_04a.dtb \
> +			overlay_gpio_04b.dtb
> +
> +quiet_cmd_fdtoverlay =3D FDTOVERLAY $@
> +      cmd_fdtoverlay =3D $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
> +
> +$(obj)/static_test.dtb: $(obj)/testcases.dtb $(addprefix $(obj)/,$(apply=
_static_overlay))
> +	$(call if_changed,fdtoverlay)
> +
> +always-$(CONFIG_OF_OVERLAY) +=3D static_test.dtb

The fact that testcases.dts includes /plugin/ still seems completely
wrong, if it's being used as the base tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAI0CEACgkQbDjKyiDZ
s5KWpA//XKFWax5fvZ0Ui8pkT8mN4sCuWFYhph+/TjkzEVRxum+7qL7IqWsoUSsO
2uIodUXlN5SmRiIOsYWzv7dbamIstWsOfX1j2OFVrwrvWdYfG/IqsiDgzjlblqJ2
ejEYv0hFaXzNlkzFfhe5Bg8OGoSOvInSYZo2KLyzTOkTYl93qkSUf13uj4vvy6lK
J5JKuwuGeLGjVxiB0Y4v7Q8fa6KvW5NaspbBi7l1UuwgGHo6DNhFX1MYqGoQuwKc
iVeoMIvE2KK7bXkdgjcwWMcnKswKN1qEf2mQznmfhx/wCfXYb/P2kfYJmd9oyX9j
uFA3SDVSXcNKRJsVNeEiRNu+s+fVSqb3v+kl2nigzH/3wXuseWtyIb8kBHtnls8p
Mp4hUNw/efQSgIguQlVXv9trCnxHXDeoU/MUVE2c1rbQOpR8+et3zO0CALL2xsA5
4HRZZ3+Ld5xuzXgNQxmM0apMmg8VoZtJ9KFuyXdWD+64JaDWexEIOwR3qYHSSm2C
N4Ldcy6hiFChYz+vgMJLvDxGoMvo+FdhfRFe4KTg7G1DSkV2V1tfXsReCSIFdSrR
KTxL2hPny/fUzjmJFr4qavo+z0BUBoYOA2duT21PAwiZ3AMtg0dBWkVhDoz+i3lI
mUiDD6gXw93wNy7Gt2eCnHC7H7t/VyZLDcbpmSRrNDeBcSro4u0=
=8Qsy
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
