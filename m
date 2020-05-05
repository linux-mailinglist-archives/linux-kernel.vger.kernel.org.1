Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967C81C5557
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgEEMWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 08:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgEEMWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:22:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2108420735;
        Tue,  5 May 2020 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588681368;
        bh=fJLPF1B84qgnQ44zWI2Ou20CmHcAw3Np9P7BmOuy1EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksv8mqPT1MaAXmpgZcjclfcgnuDxL+fif4Y59dh56w0vvUcfTb+3O6upXL9TbMEX9
         GJM+Pq3kZdgH7WbDQrCZ/RB7FNIfdWxKFh6jmiBcEwRY2fFqpaW3MzXWyfszT+imss
         DAPh3UEF+kAUcFRp0GmKVeGr1JqDy9ztRISFS9dk=
Date:   Tue, 5 May 2020 13:22:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd :High hw_level while simultaneous capture
Message-ID: <20200505122246.GF5377@sirena.org.uk>
References: <20200505114023.251409-1-akshu.agrawal@amd.com>
 <20200505115107.GD5377@sirena.org.uk>
 <CY4PR12MB182949DC53DCCCDAC02112E7E7A70@CY4PR12MB1829.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <CY4PR12MB182949DC53DCCCDAC02112E7E7A70@CY4PR12MB1829.namprd12.prod.outlook.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 12:18:45PM +0000, RAVULAPATI, VISHNU VARDHAN RAO wr=
ote:

> > Simultaneous capture on dmic and headset mic is having issue with high=
=20
> > hw_level being reported.

> Actual issue is :

OK, this is information that should be in the changelog so someone
looking at git history in future can understand what the change was
doing.

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xWpUACgkQJNaLcl1U
h9DPwwf/e+0pjKHNtp9v5sem2RW277rv77fuAh4hmF0Egqfd1N2SaCixeSX8Jjpb
8LC3fQCexbSIOlQY4V6W9/lylqyL+jq+8XKPS37FR4KWbtHWFqFIGzIxO5ySfFZr
8zLQlLcHJftxlgWfdoE1gPzueigS+S5SsAvRmcQmPvF1Kp+LO5/l5YLTm5zEvNBa
jYvem3tZBfKpc7UzolX009RJj1iiP4PUeMpJ69yYs6B0anwW40EQ6yAAS/jl0EXS
gP8kTeWiFg5Ww9aO3RnmgW6gOvNhQI45vNIp09qr/GXyEBbrRvV22/A8eJhQNDpu
pfYnRWvirdDNyeTyKP132njYtiYOgg==
=EL4P
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
