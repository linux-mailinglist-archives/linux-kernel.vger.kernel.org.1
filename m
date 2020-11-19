Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6982B983D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgKSQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgKSQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:40:10 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2CD2220B;
        Thu, 19 Nov 2020 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605804010;
        bh=IOVe+AC/shQvrZP4K3jnnH+Vv+CBsYUmCFGN/gzv1Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dseIXiv0Gh4VPZppHJn5b/I2ec7D2cdrt43E8Bbd5MG848BsqNNDgZiq7uiwTBUoU
         RSW8yHb004H5gGA03o/Oa70vc3TFZ7EKgG88l21r9JQl93JcSrPDLaynEKYJswoG+g
         deFQtyaoLIalbrYst0vUZFNbKsa88n3kBynyBBuI=
Date:   Thu, 19 Nov 2020 16:39:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 4/5] regulator: add SCMI driver
Message-ID: <20201119163949.GF5554@sirena.org.uk>
References: <20201117123415.55105-1-cristian.marussi@arm.com>
 <20201117123415.55105-5-cristian.marussi@arm.com>
 <20201119161308.xhyohop5fspb4b5l@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <20201119161308.xhyohop5fspb4b5l@bogus>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2020 at 04:13:08PM +0000, Sudeep Holla wrote:

> I was thinking about how to merge this if and when you have reviewed it
> and happy with it. Is it OK to take via ARM SoC with dependent and other
> SCMI changes ? Or we can merge the SCMI part next release and the regulator
> in the following, up to you.

I was expecting you to send me a pull request for the firmware bits once
you've applied them.

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2n9QACgkQJNaLcl1U
h9BNQgf/TXDqtKuU+a9jUTY6+cP8XYV4FUmZac7s1chvbdKzCrT41hp+a5hiXWsj
J0lCk66XcDgB0K0egGwSztrH2ho5v34IMypEJvS60Unug/ssyn0nWVPLuoE59/me
sRWJrcJ1hPmLx8zM2XUOlEbCanmbPAVilr1e6LQ+jblmWNlHK/i4d1hnX4teZi4N
Z808xq7KbAfodu5RuJo3s7kIfA0sxLOvbHI+YSChGYlErt7k+xFD5ybUMCHfLuRE
2V4DkvmgGm9n9Pf/0fGeJJWvrAVBv7We86UQDSn6LYz0bX1oHDrFHjQR/k/xIv52
hUi61K2B/ALY0TgPbqaeQ5Y+E3QuZg==
=o+Pm
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
