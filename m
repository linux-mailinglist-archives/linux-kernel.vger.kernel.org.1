Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392B61F77EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 14:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFLM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 08:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFLM2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:28:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D052081A;
        Fri, 12 Jun 2020 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591964880;
        bh=ncMPaD4x7wzZV+qowE0+m2KtMfiPQApWLlMfwu1FgDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIAsKX4R1LaQNFBFADVYhnWU2IJbUFKqGIuVHtOa+LA1qHWDpyzLyzqZ0gRZe4Uco
         +D5ifAB5o2/KdMAMSf62QbtZFwbRBnmuBGTOqRLax1YbtbLJXjs7pHGY7MgeW8n//y
         O2wEybC585I+qLAvXoAtIHg9CDEYag/Y5zYFATYY=
Date:   Fri, 12 Jun 2020 13:27:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ASoC: ti: Add custom machine driver for j721e EVM
 (CPB and IVI)
Message-ID: <20200612122757.GF5396@sirena.org.uk>
References: <20200612085909.15018-1-peter.ujfalusi@ti.com>
 <20200612085909.15018-4-peter.ujfalusi@ti.com>
 <7f2c4297-3ad9-5b8f-c9a5-5120078120c6@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <7f2c4297-3ad9-5b8f-c9a5-5120078120c6@ti.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 12:27:17PM +0300, Peter Ujfalusi wrote:

> > +	if (IS_ERR(clocks->target)) {
> > +		ret = PTR_ERR(clocks->target);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(dev, "failed to acquire %s': %d\n",

> Looks like I have extra "'" in the prints...

Apart from the issues you pointed out yourself this all looks reasonable
to me.

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jdMwACgkQJNaLcl1U
h9AFuAf/QQTYkt2gQ+jespg63weznQYk0ssXoebt2m9iNQNRFaGLpmqKNn3lj0KG
V0x7spEYXKSbVHrfSY7zAxwsvArrY6W3jbwPBEqCDtnHtCG3tTO3Gy9p3x+iJedU
WUojc8srqGDh70REYmQAhGQNEJECulHW2Ed1/ZTCiz0hERlty1kFx3XbYUkUSvcA
suAVMJAFF2evebQV0r47V7/TqNR08VQoW/8vWDkWfhTILWsK59CjDd3CPPkE5Bt1
1VybBgG/AZp/oV/zX5uceG2toHuNMyzS++qA8XqwGvD7d5r2OyTz2MyJcZ2cIrgX
C6kNGFamvaNBJsUq4Leun5wiL7CxxQ==
=XNBU
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
