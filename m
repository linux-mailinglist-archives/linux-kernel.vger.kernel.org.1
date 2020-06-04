Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F165A1EE285
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFDKeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 06:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgFDKeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:34:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835622074B;
        Thu,  4 Jun 2020 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591266841;
        bh=ml0TSme6cwPJFcsMzPbSkhZNqOuWYZXZIbIdkDTqu0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ib7SHA56hnoNxXEB3RVG+tQ4oeiz2yi+hrv6ZKVV+AWSJx+cpfoz+WeKC4o4na5LR
         ZT4TZ+MzCY2GnYNX1KDwgvV+6vBj5/QnFBLwnHEmU5vxPKOwVWU+lfdl7dqqa317dq
         4k6cEBdwgIjmijZ6EdTn8Rk2Joecbln7Eg2V3q1g=
Date:   Thu, 4 Jun 2020 11:33:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        steves.lee@maximintegrated.com, alex.huangjianhui@huawei.com,
        dylix.dailei@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98390: fix build warning detected by -Wformat
Message-ID: <20200604103358.GA6644@sirena.org.uk>
References: <1591260574-12717-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <1591260574-12717-1-git-send-email-nixiaoming@huawei.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2020 at 04:49:34PM +0800, Xiaoming Ni wrote:
> Fix build warning:
> 	sound/soc/codecs/max98390.c:781:3: warning: format '%ld' expects
> 	argument of type 'long int', but argument 4 has type 'size_t {aka
> 	const unsigned int}' [-Wformat=]

Thanks but this was already fixed.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7YzhMACgkQJNaLcl1U
h9A53wf8DLWNHAYxxJtyck1M+jV6nQK+GVYUrVtteiTM0qIor6RzV2EFpLde1I1P
gWa5qE5gs36x9WZRwUVfqrRyxATRWNDBDXVGr1yi1Nr1uRiMxRa2OBH6AIUeeKVQ
Py5pUwDCLokOkWu5OoMraUubXIBC7mMTDO639djf4TLUdN3iVo7ZvNZuzYPWzLPd
siuQIuJR0slgTIRVrv4ILKKQnFUvfoGZ7E1n/h0327qhZsSDzofHO1E2b/h5vKuE
jJ7raMnK1kS6tzy0ekKYAOHb8xR+B7hBUDlPox83eAKbIKJk+6J/kFFtE6VOr+Jy
ypnhcWmJymrH7PP7xd7tbJfD0zCn5w==
=mHCk
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
