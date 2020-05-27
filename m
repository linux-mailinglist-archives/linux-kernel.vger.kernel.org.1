Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C364F1E4449
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbgE0Nrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 09:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbgE0Nrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:47:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C882078C;
        Wed, 27 May 2020 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590587266;
        bh=qYSYXseydU1Jl/FMCMZsu00a3c88OPa9IaYxEBjkW44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyo9QQOpWhRfR0asYM+i5Txt1or/d7KRnBjpggOx5OgZH0GO2KTu0oxSC6GNNHFp/
         qrKuUj/lWKiq7FUDDHXBkQydTuSyv0FC+3lN5K+UDDtG7V+hR/uu5gMjRVUXOUSfnE
         0aR0jbD0hH0UVzXytvukYJs/6JRmGJZHb+N4Y4x4=
Date:   Wed, 27 May 2020 14:47:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: rt5682: fix soundwire dependencies
Message-ID: <20200527134743.GH5308@sirena.org.uk>
References: <20200527134151.834555-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
In-Reply-To: <20200527134151.834555-1-arnd@arndb.de>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 03:41:26PM +0200, Arnd Bergmann wrote:

> Maybe the SND_SOC_RT5682 driver itself can be reworked so that
> the common part depends on neither soundwire nor i2c and the two
> bus specific options can be loadable modules when the common part
> is built-in.

Yes, please do that.

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Ob34ACgkQJNaLcl1U
h9Au/Af/ToAlo8MIFiY0pB1HedOb/UPzvkcA2KB3IzxEpvf6D/CM9anQAjdbDqYv
RdpDzNNKLxv5msIIMdK2k+T0kRTIaYwCNcqj2n3N3QQrqB2EkneZ8++/J14Sydkc
cZSRseQFFvGOcXkzQE9IKwTUp9b4pkwZ1DlUS+ZUcHtrQIp7EsqK1ji8mtRCzAM1
sK+MNyknZ+mnPgHHEYkjWq1v8lJCID+RQ2HqLZmAiaGbtfb+xM4+GRrQuFPfM1Wq
P6PuCDeIWw0ypRcY702tt2KEoYw7ztu0jER0jpkunDYOybDBStZfOG42+lbsgB94
IsODB/lf4WgAsdbGTa+RT0EZs9NfaQ==
=oGtp
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
