Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E242F3012BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbhAWDl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbhAWDly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:41:54 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDADC061786;
        Fri, 22 Jan 2021 19:41:13 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DN23V0cSmz9sT6; Sat, 23 Jan 2021 14:41:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611373270;
        bh=0Bk8PAXdPpGaUR83uiG5snZucbQTwM70iFqUMjlN/4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaMFHhgk1Cw90cPZ14YakAtzUQXp5NcsM8znT/von49UPvC119XmIbHtLNu4msQp+
         uiKC/4qEbVNBqrj1a7d2ULZxX6FxEAZ6SIJdkHeCv6RbToEBPmLylZ32EbLGof3Xtj
         U+3YMTO2BK+A5ZEJqZ5k1w8e99gn8kzbSMsfUUuc=
Date:   Sat, 23 Jan 2021 14:07:09 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V6 5/6] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
Message-ID: <20210123030709.GI4400@yekko.fritz.box>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline
In-Reply-To: <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2021 at 04:20:35PM +0530, Viresh Kumar wrote:
> In order to build-test the same unit-test files using fdtoverlay tool,
> move the device nodes from the existing overlay_base.dts and
> testcases_common.dts files to .dtsi files. The .dts files now include
> the new .dtsi files, resulting in exactly the same behavior as earlier.
>=20
> The .dtsi files can now be reused for compile time tests using
> fdtoverlay (will be done in a later patch).
>=20
> This is required because the base files passed to fdtoverlay tool
> shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
> tag).
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
>  drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
>  drivers/of/unittest-data/testcases.dts        | 17 +---
>  .../of/unittest-data/testcases_common.dtsi    | 18 ++++
>  4 files changed, 111 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
>  create mode 100644 drivers/of/unittest-data/testcases_common.dtsi
>=20
> diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unitt=
est-data/overlay_base.dts
> index 99ab9d12d00b..ab9014589c5d 100644
> --- a/drivers/of/unittest-data/overlay_base.dts
> +++ b/drivers/of/unittest-data/overlay_base.dts
> @@ -2,92 +2,4 @@
>  /dts-v1/;
>  /plugin/;

This still makes no sense to me.  Is this data intended as a base
tree, or as an overlay?  If it's an overlay, what are the constraints
on the base tree it's supposed to apply to.

This patch is treating it as both in different places, but that's such
a bizarre usecase it needs detailed justification.  It really looks
like the unittest stuff is doing some very bogus stuff that should be
fixed first, before trying to do this on top.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmALktgACgkQbDjKyiDZ
s5JdTw//ZayM/f75OV69BKFAZfSz1pYOPBRJivYgbz4BiSb4QAFUQx8xR8a6JaYD
YM8Kuj5rg4rC/8W3Cf2oqQhpHaf7gmrYMAFUQrtRL7vekEUcwFGWvBk7YSPMzyNv
rFhr3uJAVBSLCc5oJ7Sd3qMRHdPsrSZgI6I+X5q3zA1y8pjkFrY5PMvCp5HM4yRF
xvwwXHiruV8ncmr1F/xTp8lEwZ49DE54kIhi/y4YIEbOBu26++81Hyc0S7QRA8yz
xgxjDdibGDl9DhfJvH2zhKENT2zlfp2dHB44UZYk7JKFYhErYK7dlrjgMw2bTKW+
hjsbZ92QwyKsk6RwtNSf5wQoGlJV5qhg5D1DRjRIlXxcDTVOE7k9/WnxQAESooWw
AAerOd1Gjf9HnylcQmcWJyVuv4wy/xcQJla05NSqzD7RwXBQvF4dVckcMiU93uG9
reEkGVd8TUU57asM24lAjIrxHmabIYyT3ei8cdelqgzvgFX9srWAYXWRzj+3uYv6
ASS/KLRec7ViDv8pQPUZTlh+uqm3JQbV8J/kxyrgdOmO3rZu9RYlvWUW3inSFAve
cizdm5S6ZKiewlh7UhnQrwy0kWlienuwCY4Da2FpRdXvylyr9IY+8ornL5knWXGi
8BoKLSzbMCviwyi0FDITRgFkMKNNkc1ZEppe0IaN5N4Y2ZnKjNU=
=4p5B
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--
