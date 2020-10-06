Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C080284A90
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFLAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFLAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:00:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3EC2078E;
        Tue,  6 Oct 2020 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601982025;
        bh=iREzPjsEHPNI3lU3AcvahrMEU1xs33I3mtfmo/8BoLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJ4aeKp6l1nHnB7yn4BLonSb/lCd7+QO9nnnfoDCLhAQ8i/V7w+q4eztmVYEbiE/W
         5FX3iZrOk5yNom+9qQrs0RhEQEmaNoLBEUymrQosv5/6rzfL5wN1cETn/+N+/apGmJ
         bkwVDoC4Y8ujV+qv+s7mQtSp8PY3ROp/lS4XeM4U=
Date:   Tue, 6 Oct 2020 11:59:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org
Subject: Re: [PATCH 4/4] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201006105922.GC5259@sirena.org.uk>
References: <20201005222623.1123-1-cristian.marussi@arm.com>
 <20201005222623.1123-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20201005222623.1123-5-cristian.marussi@arm.com>
X-Cookie: Will it improve my CASH FLOW?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2020 at 11:26:23PM +0100, Cristian Marussi wrote:

> +An SCMI Regulator is permanently bound to a well defined SCMI Voltage Domain,
> +and should be always positioned as a root regulator.
> +It does not support negative voltages nor any current operation.

Support for negative voltages is an implementation detail of Linux, IIRC
there's nothing in the generic regulator binding preventing it and even
if there were updates to the generic binding are what are relevant here
- they could start working with no updates to this binding.

> +Optional properties:
> + - regulator-min-microvolt: when defined should be non-negative.
> + - regulator-max-microvolt: when defined should be non-negative.

These are covered by the generic regulator binding, no need to duplicate
the documentation here.

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl98TgkACgkQJNaLcl1U
h9C+JAf+JMaUro63xSXtitN0CbhkrUAXOPif+f76VvSg6FBgT8888W2Lt62+DEg+
EhsYENRFR5TAsA5XJWHoMkVWL8AZ4SAo9OVUlrn3KZmrySb5kP+QYp4gEqPjQnE0
Ufqq/u1lzuAHzerCq4mOAN8asehJv+npW3MnmaLhajiY1GcU4gZKfPUkS2tuOpg2
zbBHiZYaTycRCR3xbZ8gtGmY9DRe/1TNagPzAcZs7i9bkNzsVEFZji+6iuc8xzW1
SXdsZGoCGuzCPE1z5or5T520Q1xUS5CNYo1Ob54IsmpD6OObF61vpqmfSDD83GaU
mSCYAF4n7eUX142LQUe50tNMklKSNg==
=mNmY
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
