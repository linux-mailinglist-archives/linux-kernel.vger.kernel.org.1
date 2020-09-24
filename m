Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC56277651
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgIXQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIXQMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:12:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D695206C3;
        Thu, 24 Sep 2020 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600963928;
        bh=5hMSrwvauzemCr0mQMAhDBZz1CnzK2mIo4fTx/Nv3fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLnW8TjR+lZY9yDkFEUKqCxi+Ou1h1OPBcNoc/nXx5i2mFk+EdRUzKzHXVKUV4Jta
         OioNkMcS2DWj5Bh3+d1jKU5xDVxCZS05mSiPrc9T21qmZCzvjgFYC0o5vqMOUOfec4
         pa+/yDU0Lw2mlgIFlYzvc6xWx40afaiT+bEbNYrU=
Date:   Thu, 24 Sep 2020 17:11:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] regulator: rtmv20: Adds support for Richtek
 RTMV20 load switch regulator
Message-ID: <20200924161113.GF4754@sirena.org.uk>
References: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2020 at 11:04:50PM +0800, cy_huang wrote:

> +static int rtmv20_apply_properties(struct rtmv20_priv *priv)
> +{
> +	const struct {
> +		int offset;
> +		int len;
> +		unsigned int reg;
> +		unsigned int mask;
> +	} props[] = {
> +		PROP_REG_DECL(ld_pulse_delay, RTMV20_REG_PULSEDELAY, RTMV20_DELAY_MASK),

I can't help but feel that this looks like a register cache would be a
simpler way of achieving this.

> +		switch (props[i].len) {
> +		case RTMV20_2BYTE_ACCES:
> +		case RTMV20_1BYTE_ACCES:

It feels like this should all be abstracted in the regmap with custom
reg_read() and reg_write() operations - or have two regmaps for the two
different register sizes.  Having the register sizes and endianness
handling outside of regmap code seems like an abstraction failure.

> +	/* If chip is not enabled, only kept the value, instead */
> +	if (!priv->is_chip_enabled)
> +		return 0;
> +
> +	return regmap_update_bits(priv->regmap, rdev->desc->csel_reg, rdev->desc->csel_mask, sel);

This sort of stuff works a lot better with a register cache.

> +static int rtmv20_lsw_enable(struct regulator_dev *rdev)
> +{
> +	struct rtmv20_priv *priv = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	gpiod_set_value(priv->enable_gpio, 1);
> +	/* Wait for I2C can be accessed */
> +	usleep_range(RTMV20_I2CRDY_TIMEUS, RTMV20_I2CRDY_TIMEUS + 100);
> +
> +	/* If enable gpio from low to high, the whole registers will be reset, applied here */

Please keep to 80 columns.

> +	ret = regmap_read(priv->regmap, RTMV20_REG_LDIRQ, &val);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to get irq flags\n");
> +		return IRQ_NONE;
> +	}
> +
> +	if (val & OTPEVT_MASK)
> +		regulator_notifier_call_chain(priv->rdev, REGULATOR_EVENT_OVER_TEMP, NULL);
> +
> +	if (val & OCPEVT_MASK)
> +		regulator_notifier_call_chain(priv->rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
> +
> +	if (val & FAILEVT_MASK)
> +		regulator_notifier_call_chain(priv->rdev, REGULATOR_EVENT_FAIL, NULL);
> +
> +	return IRQ_HANDLED;
> +}

It looks like this is clear on read but shouln't there be at least some
display of unknown values?

> +	/* After chip check, keep in shutdown mode for low quiescent current */
> +	gpiod_set_value(priv->enable_gpio, 0);

Don't do this, the driver should not adjust the system state unless
explicitly told to do so - we don't know if any state changes are safe
on a given board.

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9sxSAACgkQJNaLcl1U
h9Atjwf7Bqc3I5eWnljtHCna2HtTU5ytva8SwMQKpW2yOcKm/gvcbhxp++bRk8vu
0bjhhm5liu4VCvL+WwD8ql2WYlki311rTikZxCfvzgW3P5rjQAeKYMw36AqRGHU+
APfmb7rtDFckAzuA3bvjkXUqIL8nfMkIPzLq7zvTQOYZZKt9SdgTK11cIaIx21Vi
tZdN6srzS8D3ytA6ryGxGzTXoOznLLtomcbq+l0UY/RQwf/KQUAYL3KBCyTxLTSm
NukG6T+UeP0++xmopTyZUnw5VTp9z6IkeO6xTHZZUS1qpDfsNJZwh6ClKs5Tcsqg
Y2M0KgznJCV/oe7ByiJmgWYirSv8sA==
=MkFr
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
