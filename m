Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB09E30045D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbhAVNip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:38:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbhAVNii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:38:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3626422D57;
        Fri, 22 Jan 2021 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611322677;
        bh=GDrFexCY6rqMldX/gTp5asKjoZ+XtN3dkoC9NCCzr64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZA0N9Sd0GbSZgGmQpw0GRhrifsWH9SGyKKq7jnbkeJcACMB0h6pz6vXj++hUFetsf
         +0Iyy0GNHDK1DjZBRNZZ9rhWI4mYDDY9BFg0jASyUhzMzoB6jrgW2ChPyOsYCP1nf4
         h6The8o1PGxiQe6iY8hfHqyYnQCk46SfVNcHgA2L01tB/ahNuI/C1TYrSQQRczlwsk
         B78gUnfQklKofSV2t4UBrKuZ3ZLjuc2En/s0S/56Vw3lzjNjRKPVRK0PeNmuR1PVf+
         g8+QelFIa+C15Kmk/r+xQ6VD++1O0ZnZl0vjhxjmzrMJ13hMBxoTXMXS49epup670s
         Zk+IA+gMHNTZQ==
Date:   Fri, 22 Jan 2021 13:37:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>, lee.jones@linaro.org,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] regulator: Initial commit of sy7636a
Message-ID: <20210122133718.GB6391@sirena.org.uk>
References: <20210117042539.1609-1-alistair@alistair23.me>
 <20210117042539.1609-4-alistair@alistair23.me>
 <20210118123158.GE4455@sirena.org.uk>
 <CAKmqyKMyXk_OjTKD24Qxn4QXJ4FwP4yDQqtmTsxAJMJzy34PcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <CAKmqyKMyXk_OjTKD24Qxn4QXJ4FwP4yDQqtmTsxAJMJzy34PcA@mail.gmail.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2021 at 10:24:10PM -0800, Alistair Francis wrote:
> On Mon, Jan 18, 2021 at 4:32 AM Mark Brown <broonie@kernel.org> wrote:
> > On Sat, Jan 16, 2021 at 08:25:37PM -0800, Alistair Francis wrote:

> > > +static int get_vcom_voltage_op(struct regulator_dev *rdev)
> > > +{
> > > +     int ret = get_vcom_voltage_mv(rdev->regmap);
> > > +

> > Why is this get_vcom_voltage_mv() function not in the regulator driver,
> > and why is it not just inline here?  It also needs namespacing.

> I'm not sure what you mean, can you please explain?

This is a wrapper for a function that has exactly one caller but is not
only a separate function but also in the MFD header, part of a separate
driver.  This seems at best pointless.

> > Why do you need this delay here, and what purpose is this lock intended

> The delay is to allow a power ramp up, I have added a comment.

Use the standard ramp_delay, don't open code it.

> > > +static int sy7636a_regulator_suspend(struct device *dev)
> > > +{
> > > +     int ret;
> > > +     struct sy7636a *sy7636a = dev_get_drvdata(dev->parent);
> > > +
> > > +     ret = get_vcom_voltage_mv(sy7636a->regmap);
> > > +
> > > +     if (ret > 0)
> > > +             sy7636a->vcom = (unsigned int)ret;
> > > +
> > > +     return 0;
> > > +}

> > What's going on here, and if you are going to store this value over
> > suspend why not store it in a variable of the correct type?  In general

> It is part of the vendor's kernel, they specifically added it to
> ensure vcom is set on resume.

"I copied this from the vendor" isn't really a great explanation...  If
the device is likely to get completely powered off and loosing settings
then presumably the entire register map, not just this one value, needs
to be saved and restored instead of just this one value.  If that is the
case it's probably best to use a register cache and just resync it on
resume.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAK1Q0ACgkQJNaLcl1U
h9D4hAf9FBS66gktTS5BALyp68IHI8xJfmorP3OTsPxw2Mxf+PeoGLPBaCo4R8u6
uO0D7WHJ0F/nTsBUwz1ZqDRQusZxrnlcDmVSKw7iO0OY3D0TtBdXU5uAcTUrY75A
pr8Dfoeqekio3ePDMN2LUjhQs9Kd6JzcYGFovUk+FLQoSS2pI0YuTEKGavxULFwO
DRJLcm7rVLgW1ps90NaQgShPdBgurOKsmlwicW8JqMrcGroYW+raCN0Mzp9+gc4/
xnocUimbcIQTV6mXihkBHALgB3Dafkq8v1SLJAxr7zITtI0ZGxsXsa6H5k+HlFub
Truo/r+T1BmRWK/icIOm12NOuK4KIA==
=UFit
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
