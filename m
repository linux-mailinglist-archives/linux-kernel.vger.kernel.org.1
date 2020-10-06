Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D18284A85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJFK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFK5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:57:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F291A2078E;
        Tue,  6 Oct 2020 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601981860;
        bh=60zeaRU1xit+wfcrdW2n7n9Bnz/m2UEBztYIili/YWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYgtM85Xh4loYAUINwZRp0Dm+EX59Z63wDtLYbNg9sJqfcn5aEZW8MQvukrFVbza+
         cAIlw9dMARhK0fj3b3yyj3J6XDUpPXzN2S8OuF5RRWV6fXqZWmreMCcrPuqFLxmd1c
         wr+qHeIO8A6vTrMMDvjnLzpvzrdIdg6sh1WZ7pRg=
Date:   Tue, 6 Oct 2020 11:56:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org
Subject: Re: [PATCH 3/4] regulator: add SCMI driver
Message-ID: <20201006105637.GB5259@sirena.org.uk>
References: <20201005222623.1123-1-cristian.marussi@arm.com>
 <20201005222623.1123-4-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20201005222623.1123-4-cristian.marussi@arm.com>
X-Cookie: Will it improve my CASH FLOW?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2020 at 11:26:22PM +0100, Cristian Marussi wrote:

> - .get_voltage / .set_voltage: routed via SCMI Voltage Domain Protocol
> - .get_voltage_sel/.set_voltage_sel: using regulator framework helpers

You should not be implementing both of these interfaces, pick one.  It
looks like the direct voltage operations are the redundant ones here,
while the protocol uses actual voltages to communicate with the firmware
which makes the direct voltage operations a better fit it seems like the
expectation is that only a limited set of voltages is supported (as is
normal for the underlying physical regulators) so you want selectors.

> +	sreg->name = devm_kasprintf(dev, GFP_KERNEL, "%s", vinfo->name);
> +	sreg->desc.name = devm_kasprintf(dev, GFP_KERNEL,
> +					 "Vscmi.%s", sreg->name);
> +	if (!sreg->name || !sreg->desc.name)
> +		return -ENOMEM;

Why are we using different names here?

> +	num_doms = handle->voltage_ops->num_domains_get(handle);
> +	if (num_doms <= 0) {
> +		dev_err(&sdev->dev, "number of voltage domains invalid\n");
> +		return num_doms ?: -EINVAL;

Please write normal conditional statements to improve legibility.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl98TWQACgkQJNaLcl1U
h9D+0wf/Ubh37zBd01Ip/uAlyqHQxeRSTr8vkFYb/cvjhQDqfkBRpeSLyJqEEnQB
RWd3mf3UN05rIxmZ54qpwCLc7uNJNJ+jx57FmDYFI6GgAbNHt5c3A6ZoiTIT9Obs
KLMDKtz5/ncww8bIcKDkt/Y0FPYnU7mtkji8JQZ/IqLAL4W0Af6W7329I7kOYelg
MxQq+8JuU8itRYYcx8EJ5BaTGdz8YTcXpgxDQc1Uvj2CtivibdqrSfY0GbMtCjRL
09WPrusKFYLAHlvnaPV8nmFM0PKFesPblyRv/QKHF7cm6DyszDm9HE9gzB059vbO
goUYheBD4knkWzJQRp98E4PprszmzQ==
=gIit
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
