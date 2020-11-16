Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D463F2B506D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 19:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgKPS7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 13:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgKPS7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:59:22 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA562225E;
        Mon, 16 Nov 2020 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605553162;
        bh=smOxAXwlGOhb8VxRKmDFNCcS//qtmuvu8c06NvzMAbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceCWswZhVr4xmHaJHLg0PlaCuSw9Vj6kFAH+DPWUIY4oILI6o4/jHrRcgeZJuOvgE
         74/FQt5yaKsTqG1W4BuqsAbUfMe/1TFEysqDF7NXenoby8ahqWc5YUgI4FuqQIyjoV
         Yo8XTB26k2U6VtEb3kIbMh2fjM37T5GS8UfOAiec=
Date:   Mon, 16 Nov 2020 18:59:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        open list <linux-kernel@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap
 clear_ack
Message-ID: <20201116185903.GD4739@sirena.org.uk>
References: <20201111170613.46057-1-tony@atomide.com>
 <20201113102134.GI3718728@dell>
 <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0T0qS282MU-FRy8zNLgjnvF=+-5k=XxxXhZw6k2cgASw@mail.gmail.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2020 at 02:06:29PM -0800, Tim Harvey wrote:

> asserted? I'm also wondering if my issue is that I currently have the
> interrupt registered as such:

> ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
> IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_FALLING, 0, &gsc_irq_chip,
> &irq_data);

> Perhaps this should be IRQF_TRIGGER_LOW as the device will not
> de-assert its IRQ# until all source bits are cleared.

That's clearly an active low interrupt, it will break things if it's
registered as edge triggered.

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+yy/YACgkQJNaLcl1U
h9BXzwf/fEV8IYsyXwfhsDE4zvAPyzuUj3rhfRfOdaJsizrVyWt2TSZyq25Qug5L
RvD4Ya65vKAg2Hrzvw6EegS9Yg8FVhMq1wYQLXFd9q4L8+01ea3WaSP4nYdoNvAI
u8rDlLs264IM7ge6a1kVF5OKjj5fYM/PnOwpJFgxyFPtie/1wOPxxfkkvU2/T9yE
gdmLHBBGuZgo1hfWi2Lm6y0zxgIio7vYytwVrpbEvB62SyxePmTVPZJqyjbBFfNw
MYpAozg5UUHFu4qgBVHwijOI/4c0VwiU3nUkmTv7lhVMtVEO5De7c6CeIqMoqv1g
25bgrb+eCOf4Jb9Q/IoB3gBx1I52vQ==
=dCaT
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
