Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5402C1453
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgKWTLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:11:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgKWTLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:11:22 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C05C221E9;
        Mon, 23 Nov 2020 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606158681;
        bh=ZgPtggBq7662qaP+vSUrj0ZzeMMWinCUkp0Gk6P70tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqGBBrh4JtzHRUGSNWSmPzHomG+tfMToTGALfgMy6TNsfzZD6ZkitRkSl0odNgExD
         mcjpmQ0BhJBtP1sbJNeEEXI/82IKH7ZsQtVO/nPZMoKjHAAiIHuB+CoeKr7yQ5MSfh
         ZY0RAI7WFF4jkm/UCZcg6YINkXOhuLUfPpHuIxVQ=
Date:   Mon, 23 Nov 2020 19:10:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 5/5] regulator: add SCMI driver
Message-ID: <20201123191057.GR6322@sirena.org.uk>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
 <20201119191051.46363-6-cristian.marussi@arm.com>
 <20201123174941.GM6322@sirena.org.uk>
 <20201123184956.GD56553@e120937-lin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SWsnvgFfkTS2ATo5"
Content-Disposition: inline
In-Reply-To: <20201123184956.GD56553@e120937-lin>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SWsnvgFfkTS2ATo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 06:49:56PM +0000, Cristian Marussi wrote:
> On Mon, Nov 23, 2020 at 05:49:41PM +0000, Mark Brown wrote:
> > On Thu, Nov 19, 2020 at 07:10:51PM +0000, Cristian Marussi wrote:

> > > +	rinfo->num_doms =3D num_doms;
> > > +	/*

> > Several places like this with missing blank lines.

> What do you mean ? a blank before the comment ?
> Sorry but checkpatch --strict does not complain, I was not aware of
> this styling. I'll do (if you confirm that's what you want)

Yes, a blank line between separate semantic blocks.  This is normal
coding style for the kernel, while checkpatch being a very simple script
can't detect it it's surprising that this seems surprising to you.

> How do you prefer these changes (and the DT one) ?=20
> All as followup patches in a V7 series on top of
> sudeep/for-next/scmi-voltage ?

Incremental patches on top of what's applied.

--SWsnvgFfkTS2ATo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+8CUAACgkQJNaLcl1U
h9BZ4Af/eV4omO9GkLwF/B3nMTxaU2yyZNZL1uxq1C6ei6QVzgvURAANTzGb0jfD
lfGHMuKd5oivZiUmavjZBLAtpaT5ZnXYvsLEZR03QOfz/Rjmq0nqjQGERVfYw4V+
NOSwDU3NzScMnJWfN4sxrJ437Gaij24HhySYfoeJR+UV9PbFzu8eF5GrNmhhgbc+
Ji4n+lkHcoiLgzWqq9hv+6mROXjYxh9Pm3MpWpvD+Pfl3S+qLgKg+RZYITsRNH0S
hhdXqJB2FHjsP0TQ+nM+4THgjrsGBC3tQoCpH4Obl1RT6htBMy5zDDqe4M7I5RFr
Ztv1OeE2tR5iUaY/2jjw4Mvkio5BYA==
=kvpc
-----END PGP SIGNATURE-----

--SWsnvgFfkTS2ATo5--
