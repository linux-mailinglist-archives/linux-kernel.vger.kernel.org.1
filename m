Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2792CA91E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392179AbgLAQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:56:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388184AbgLAQ4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:56:55 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B156521D7F;
        Tue,  1 Dec 2020 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841775;
        bh=ADXYaQ14I9NiCow+1vqfkMHGXmW/crWXzRykvLgTvOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVw7WYjR4J26gBmvfegd2b7QT/Q58zeB1baEF0J6Wrth/LixkqkigJKPc2xQ0C9LO
         CQg1UQhapUZXivsix2WUYxflQL6OjyGqsIoHvbcwcYiUtwTZiKQvTJ7hX/bfVROnfX
         jsuTDL1cv0u/vi7akAIlG1P/MggTBv1JnzlU7DBI=
Date:   Tue, 1 Dec 2020 16:55:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 00/10] regulator: da9121: extend support to variants,
 add features
Message-ID: <20201201165546.GL5239@sirena.org.uk>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
 <160683107677.35139.1688443189294014005.b4-ty@kernel.org>
 <PR3PR10MB4142434AF67B4976D8095ABD80F40@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
In-Reply-To: <PR3PR10MB4142434AF67B4976D8095ABD80F40@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 04:51:43PM +0000, Adam Thomson wrote:

> Was the intention to apply these to the ASoC repo, as this patch set is just
> for regulator? Just wanted to check.

They're actually applied to regulator, b4 had a bug.

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GdZEACgkQJNaLcl1U
h9AMyQf/d+AzpooG4KC/y7IL7EEIHj2Z8uPz8lxGZWJ7LFZtA2whZwL7V6z0QsVP
b/944jF01b7aMqSkt+F5a4Lqu7haFYS4y2eRstleAxS/w5SE8PkYyBKn6wQyktQr
64AzOJsFWL2IfHOgGqxKdf82VMulLYv2T+7tdMHT8tdmqnfTmf1yowuk+XUHG6Bj
FQW65JTLvw2cEtwg73QU9HvuMYLbYOernsp2YkdX/GXUynJ4EFHqfM5WASRwFLyO
9WZ/qG26VXbK644jlOmahdQ9Nfm7RNKOp+xt6iHodYzECXK0ZTurixqRRFee7WRY
BrNc3oWPjLwLixJV9W8mWEWjkZgJ4g==
=agOR
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
