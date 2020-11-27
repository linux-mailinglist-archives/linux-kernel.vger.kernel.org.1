Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353A52C685D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgK0PAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgK0PAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:00:09 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91929221EB;
        Fri, 27 Nov 2020 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606489209;
        bh=TqHr4vlm4AwTGuDILPLWA2nUlqYREaPLWl/OliSvrI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yrtGinx0Fs2hZ5ymTQjLhWU5BiuXhl6Kriveey9sSPnCbnfwyyhT+zW05p3km5B6T
         u6rDyiTtk0i7qFSu1nB+1IBr/WwWhsjTjxdMyZj39vQYK1W4mTDbnsnrVOTXLBmSJi
         oSbbBxQpYryBLI8kKseF8cYlzGJM+uqPFISRNRQU=
Date:   Fri, 27 Nov 2020 14:59:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/9] regulator: Update DA9121 dt-bindings
Message-ID: <20201127145943.GC4845@sirena.org.uk>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <a5a57b416a47c044797d9b669c7e021acd69abae.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <20201120134742.y7bocaok3gcahbxt@axis.com>
 <20201125092137.ehwfytsrr3x5vkiy@axis.com>
 <AM6PR10MB2807F4A8D11B71282BCB3A4CECF80@AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <AM6PR10MB2807F4A8D11B71282BCB3A4CECF80@AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: All work and no pay makes a housewife.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 27, 2020 at 01:01:24PM +0000, Adam Ward wrote:

> This sub-node looks fairly well instituted for devices with multiple regulators.
> There's also the possibility to add GPIO support into another sub-node for all the variants.

> Mark, do you have a preference?

Not really, either is fine.

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/BFF8ACgkQJNaLcl1U
h9AVKwf/QlPl/u+t+ejyQhpPkVn9zA+5b8+WntvdSbC462ZEvZE/ykk2il1j/EKF
jKpnYpwwU80h4s4tM8xAVv7mtLvDsMdqqgTNTPzjTHe+IsnsrvKIMyFVlaJqc6dg
LewK4v9Ah29CswxpaznQSdeFZg01HFlFbNpqZ3wmH3mO93+yxzer4SjCSs8zl/Gs
LPxT9faUdnb+Y76jtLLNbxAT0Ro+j0HbvJkUb+T+KD/bDGeFKxaHpyexOzb4fCsO
ph0jQWeuk5RxtTIyCiOZ/j8LUx70VLT9Iy2T8e34dZ+3IG5TH/JEWpUJjCD/aMpU
9PiOJeOIr/+mSxxRqzO+U2NKXtsoKA==
=mldZ
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
