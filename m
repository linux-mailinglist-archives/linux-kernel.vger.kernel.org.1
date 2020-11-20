Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1E2BAB80
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKTNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:46:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgKTNqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:46:20 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C939022272;
        Fri, 20 Nov 2020 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605879979;
        bh=2Wp+VX93wye7+YwBgkbMeLb2bb3rkd9k4b5sbT//jAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkQLAC85kM3UZO6uognCfcD7YnxnTq+LcCa7OjkABH88bcZmTRcC6XqYwB/rTXrro
         mfbf4m5XJWhVNWJyl9Yqqj0DuSWTVt25sb+8tlCsnUnW0b+NvILwfsfaMi6JDSCK+H
         bYcM+Y0Vz7F+N/61tz6MdOgAm4P/GheBzlUGd0Bw=
Date:   Fri, 20 Nov 2020 13:45:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <adam.ward@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 9/9] regulator: da9121: add interrupt support
Message-ID: <20201120134558.GE6751@sirena.org.uk>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <ef98a01f6281ae6c925f283b51804f7f5194d230.1605868780.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <ef98a01f6281ae6c925f283b51804f7f5194d230.1605868780.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2020 at 12:14:59PM +0000, Adam Ward wrote:
> Adds interrupt handler for variants, and notifications for events; over
> temperature/voltage/current.
> Also handling of persistent events and respective timing configuration.

Again the "also" suggests that this should be multiple changes.

> +	struct da9121 *chip = container_of(work, struct da9121, work.work);
> +	enum { R0 = 0, R1, R2, REG_MAX_NUM };

This enum appears to map the numbers 0, 1 and 2 onto the constants 0, 1
and 2?  It also seems to be repeated in several functions?

> +	int status[REG_MAX_NUM] = {0};
> +	int clear[REG_MAX_NUM] = {0};
> +	unsigned long delay;
> +	int i;
> +	int ret;

> +	/* If persistent-notification, status will be true
> +	 * If not persistent-notification any longer, status will be false
> +	 */
> +	ret = regmap_bulk_read(chip->regmap, DA9121_REG_SYS_STATUS_0,
> +			(void *)status, (size_t)REG_MAX_NUM);

If these casts are needed something is very wrong with what you're
doing.

> +static inline int da9121_handle_notifier(
> +		struct da9121 *chip, struct regulator_dev *rdev,
> +		unsigned int event_bank, unsigned int event, unsigned int ebit)

Why is this flagged as inline?

> +	if (event & ebit) {
> +		switch (event_bank) {
> +		case DA9121_REG_SYS_EVENT_0:
> +			switch (event & ebit) {
> +			case DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT:

The structure of this code seems extremely confusing and hard to follow.
I really don't understand what purpose this function serves at all, it
appears to be factoring out the check to see if the bit is set and then
wrapping that in three layers of unpacking to work out setting the bit
in persistent and which notification to flag.  I don't understand why
the interrupt handler doesn't just directly do these things, this just
seems to be adding a lot of redundant code.

> +			case DA9xxx_MASK_SYS_EVENT_1_E_OC2:
> +				chip->persistent[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_OC2;
> +				notification |= REGULATOR_EVENT_OVER_CURRENT;
> +				break;

> +		regulator_notifier_call_chain(rdev, notification, NULL);

The expectation is that one notification will be delivered per event,
which fortunately as far as I can see is pretty much what happens.

> +	/* 0 SYSTEM_GOOD */
> +	if (!(mask[R0] & DA9xxx_MASK_SYS_MASK_0_M_SG) &&
> +	    (event[R0] & DA9xxx_MASK_SYS_EVENT_0_E_SG)) {
> +		dev_warn(chip->dev, "Handled E_SG\n");
> +		handled[R0] |= DA9xxx_MASK_SYS_EVENT_0_E_SG;
> +		ret = IRQ_HANDLED;
> +	}

If the interrupt is saying that the system is good why are we logging
that as a warning?

> +static int da9121_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct da9121 *chip = i2c_get_clientdata(i2c);
> +	int ret = 0;
> +
> +	ret = da9121_set_irq_masks(chip, true);
> +	if (ret != 0) {
> +		dev_err(chip->dev, "Failed to set IRQ masks: %d\n", ret);
> +		goto error;
> +	}

It would simplify the rest of the code to just unconditionally mask all
interrupts here.

> +
> +	cancel_delayed_work(&chip->work);

This doesn't synchronize with the work being cancelled, the driver may
be unregistered while the work is still running.

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+3yJUACgkQJNaLcl1U
h9CDKAf+L1BtMh2pVEo97p9ZesujkYpcwVEMPum4NaYuMSc5MHTrjNLhhEuPV+no
SGG9YDUL/y6PsSKFW3DlL0bIeg2+q0CxZ/vzrG09ZRWqt1tzg9D3Ir9g14/CdSpo
0LeNtqwJXn+Tl3bFdkfhRWhNt23UloD+T0zTLnw0vtbLdz/90Z8syFgWaWdgXcpk
pvGXBUEkahek+QJQAhaidQhD1FVdvGec3LXG0N+IlPdAUKyC/7GbRL6JnNNS402T
XZGuASMkxHTOanNEo5mm90Cf7mUNeSZ69q1dtpiLBMKB0b0exrkNoSgxP3i3zMaz
pfJzFU2RLEXjfhfv+tsbFKUV9sEu7Q==
=U0F8
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
