Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F859275D55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIWQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIWQZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:25:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F816206D9;
        Wed, 23 Sep 2020 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600878352;
        bh=PQYW/Ldo+sSZu9IaAFbupZBqQiivjpdGo9B0LIr5t9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZNSI23epCglEhUvEjBMb/94LIn60XKVxEbfxT8eNVWXtsZwRfw4gqnKhkdLH3Utd
         XFXL6/OATz0UZ+F75lQql/cQhwFHr/jt99cRRN0mT+UHIyVB/EWrlN4bk+DSnjd3Rs
         9S/tN0/u3gZ+M1JGYW513NoUv92jPLx4LYDC/V3E=
Date:   Wed, 23 Sep 2020 17:24:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Wen Su <wen.su@mediatek.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: regulator: Add document for MT6359
 regulator
Message-ID: <20200923162458.GE5707@sirena.org.uk>
References: <1600688895-9238-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1600688895-9238-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <1600688895-9238-4-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: This report is filled with omissions.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2020 at 07:48:10PM +0800, Hsin-Hsiung Wang wrote:

> +Required properties:
> +- compatible: "mediatek,mt6359-regulator"

The compatible isn't used by the driver (which is good!) so should be
dropped from the binding document.

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9rdtkACgkQJNaLcl1U
h9AxPwf8CAx/q4PAO9Rp6eYMDBKZmthTsSTtBUgfSC6WahEzOPQypNZI524yMERv
Ds+F2wmVAhQj5GLOi2zLn0TM0oVqF5u9uXewMUjlRR8l56/GBa0ZDNL4LXQlGIKZ
27QHt2czssMevBM3gdGslcDtAGTR7u3PgW8tvUjV3wSab4foD7M1zrgli0P87yEN
QVi0vDcKSybmpC4kCElZo+x5jwF+PXq+rvklMjCNE/o47c1kOSPFsrZAVWBfg09P
1f/0bFbV8XWzrmMSnYiTXn32R5xWQkdD9qdGS+UotFPgtTqpsczXtNB/L0IviDTm
Qr36BUnHbcUoxSc+rLq7PUM7Q7CUYg==
=9PNJ
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
