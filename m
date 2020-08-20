Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8483324B915
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHTLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 07:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbgHTLax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:30:53 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16321204EA;
        Thu, 20 Aug 2020 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597923048;
        bh=0zMYJ5oh5YMdX4pO293LF39UhxSYtvTe+EEHCB8h2oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3iLBpGFiwiloH/TS9/0Rd657qBi5S3FKwoNOZHTEHHpXKuJzRwGAwMhI/BBvYzDt
         cb486WvZEEZELB18sEf6e5LV89N12ykeAr7RdHoszbAsJoXc5OsKZ7RWCqFCEyTqNr
         fFOmEtNwtxyjRdBv1EYnFHIKQOHtwNbEVUgAFQJI=
Date:   Thu, 20 Aug 2020 12:30:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH v3 2/2] regulator: mt6360: Add DT binding documentation
Message-ID: <20200820113015.GB5854@sirena.org.uk>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 03:53:42PM +0800, Gene Chen wrote:

> +properties:
> +  compatible:
> +    const: mediatek,mt6360-regulator
> +
> +  LDO_VIN3-supply:
> +    description: Input supply phandle(s) for LDO3
> +

Only LDO3 needs a supply?

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+XscACgkQJNaLcl1U
h9AlBAf/Rg+0tMXV5si2xJ024erGWC2hIyYtwI3+xCyY9sHhRgfsHGL0OavnQmH1
XrzrHV2HlLPBpDOAsKc9FlToTqLxXHp6mWHlyl0AUgadrSqjIJKXKk53jrbAbWIo
fx5TFc4o+WblH6MYd5sXUo5l5yzwESjU1zoT67WS4rIt/oVKOn5+e2VRUA+Y3nsy
ThaA4Y1uYFRnH0IMEjw6TrHwWCHmDsSPoiNhcmt1GyQYrbVuroV3Nz4iQNS8MJDN
zntnN8oAuDDVkPHkrSyY33fmOfKO+p7myQ+M/fR7E7gZvCNWU0f2D0hBTTLOmwXJ
skfkHi2rhY3HPyKehk56JaL72atI7Q==
=vywJ
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
