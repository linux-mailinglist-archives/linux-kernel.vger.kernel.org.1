Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39DB2BAAF7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgKTNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbgKTNRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:17:31 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C70F22253;
        Fri, 20 Nov 2020 13:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605878250;
        bh=rtOED4qPnHtlqOXdq++1WQa4Hs4l0j3poOyqvCSIwmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDZqqXrFipm1AKPKg1qO47oFmMwWYvWqeeZMZyxMvdXBsFuVBbFPQCIxc3rU1j3jo
         /EHP1tBHvDRUoYr/HZhijgNUeado3QoTELqccNgcczh3/uomaDe/JIVUHNcI5n5iJF
         L8SCoIOnr1u+LZ1afKUMzDcRCn4nKW/e/AxkMXso=
Date:   Fri, 20 Nov 2020 13:17:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <adam.ward@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/9] regulator: da9121: add current support
Message-ID: <20201120131708.GD6751@sirena.org.uk>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <a9b30f4aa8813bf262fd0eb8e007253582f61602.1605868780.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <a9b30f4aa8813bf262fd0eb8e007253582f61602.1605868780.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2020 at 12:14:57PM +0000, Adam Ward wrote:

> +static bool da9121_rdev_to_buck_reg_mask(struct regulator_dev *rdev, bool mode,
> +					 unsigned int *reg, unsigned int *msk)
> +{
> +	struct da9121 *chip = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +
> +	switch (id) {
> +	case DA9121_IDX_BUCK1:
> +		if (mode) {
> +			*reg = DA9121_REG_BUCK_BUCK1_4;
> +			*msk = DA9121_MASK_BUCK_BUCKx_4_CHx_A_MODE;
> +		} else {
> +			*reg = DA9121_REG_BUCK_BUCK1_2;
> +			*msk = DA9121_MASK_BUCK_BUCKx_2_CHx_ILIM;
> +		}
> +		break;

This is really not an easy interface to understand, the boolean flag
saying which register set to pick is not particularly obvious to read
and won't scale.  The usual pattern with things like this is to store
information in driver data at probe time.

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+3wdQACgkQJNaLcl1U
h9Bn1Af9FuF9ys/sn2TZvRURJfqm5qEe3i1LvRd7itxeGjwjgobCpHhlmepxVTor
/2W8aaXb5IF/2sKwNFYESIQspNCjgheRSqI/K8x96FPR23blnmasuGahuz51zsv2
uJNakSbRWxGtXdWg/C5PUD3GfNoZYjqjHP/h0RhSeHGkgN84xTJ06Dr100g9wDIQ
2wgQR5wJJQHya+L0tmsYomzM3vt0kXyHu4qq8sLabmvyJSC1WjznMO5UpjTuLJJ5
p/VjYgP7hV0drJ5gJfmHrecE0KFpFmCCSAtzfuVZo80LlL/93LimAkEIDkC6VQZi
fnKCeYF5xKc8Cz08EMWwKXYj/HZykQ==
=TshY
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
