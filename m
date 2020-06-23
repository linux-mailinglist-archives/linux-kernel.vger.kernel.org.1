Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB17205863
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbgFWRSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732408AbgFWRSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:18:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51A220780;
        Tue, 23 Jun 2020 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592932725;
        bh=cIuJzlalHBnO+2yYEVOVo9FBHnL7aMmBDhMGCrHBgk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNbAWLagG+qxgK2G9CP2wzedwW1br9Q7WF2deT2Qsm3h4cOL5D7x6G2pj8DJgPw4n
         wgZNNzROlt7Mzs9iVEG4t4IHdXIa712oRPL8ew0iHvNwSPhFD6zoCKZAzBuRQNO4+R
         PTAeC8xVB6UycZTKqCVwn9aGhPcqrdy8Lu32BowU=
Date:   Tue, 23 Jun 2020 18:18:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ASoC: tas2562: Update shutdown GPIO property
Message-ID: <20200623171842.GH5582@sirena.org.uk>
References: <20200612171412.25423-1-dmurphy@ti.com>
 <20200612171412.25423-2-dmurphy@ti.com>
 <cfb043e3-77c5-2957-20b6-2814f1445cf0@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <cfb043e3-77c5-2957-20b6-2814f1445cf0@ti.com>
X-Cookie: No motorized vehicles allowed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2020 at 10:59:49AM -0500, Dan Murphy wrote:
> On 6/12/20 12:14 PM, Dan Murphy wrote:
> > Update the shutdown GPIO property to be shutdown from shut-down.

> I have some other patches that go on top of this patchset I am wondering if
> I should re-submit with those patches on top or indicate in a cover letter
> the dependency

If you decide to resubmit please make the YAML conversion the very last
thing you do in your series, there is a considerable backlog on YAML
conversion reviews which slows down any changes that depend on them.

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7yOXIACgkQJNaLcl1U
h9DxlAf+KjPVhJ8fCMl8ps3tTLy8n/19ma5ndPpYF8kS9ZuKTLlBXh6hVWHTBnwq
KMMcn5CPNvDfmKqVKFygogITiYAtAeHc7WZvzX4ywLygdYWPL/gUwdY7ICTi+peL
CS2WAxTuYvUntqJoVld9hJIWfzC7fygA8N+FBsgZVRXrwwDDaJc2GWysUI4C8DX7
gtJ+nqk8DnmnRMAe4oVt0LOR69bNzu2MJNtAmpmBzGz7qXg6iqqnCTeJDkVCn+Ll
HmQIXKDlCbn4qz/4SpN73m9n0TdO8XUHmm6/DC32JviMHtgqqmUWgEn8cnS60Q6o
++jE7wjAKh4RwJdwZ8PDBCyIKbWUXw==
=ytyL
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
