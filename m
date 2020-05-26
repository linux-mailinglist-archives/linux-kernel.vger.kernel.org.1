Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B261C54C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgEELwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 07:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEELwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:52:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A52206A4;
        Tue,  5 May 2020 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588679526;
        bh=+W25fWjjIElfaFBfwXQQ4/jdiZqC9/tRp6Gt1kz/k0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIK7FXRVr+hksOuJLHiSX61NBHds4hEmdl3b6bVZr+2T0Odto68Xjp1cdmcGXcBk+
         f4tTzVtPvZ1dbqx4Gt9GZC7wbtYHTDjPEFUNgEH1M99Ibbsiz4ZbYtD5VOXfYMtPqS
         inN2bdaQ31jL1rH3voc6ww5AQl7L3g8dY2TIGWp0=
Date:   Tue, 5 May 2020 12:52:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd :High hw_level while simultaneous capture
Message-ID: <20200505115203.GE5377@sirena.org.uk>
References: <20200505114023.251409-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <20200505114023.251409-1-akshu.agrawal@amd.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 05:10:20PM +0530, Akshu Agrawal wrote:

> cat /proc/asound/card2/pcm?c/sub0/status
>=20
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati=
@amd.com>

Also if you're sending a patch for someone else you need to add your
Signed-off-by - see submitting-patches.rst for details on what that is
and why it's important.

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xU2IACgkQJNaLcl1U
h9BubQf/YxQpGN3BHlleYVroHYHD02IOy8p8FiYMC3hCjAnNObrEiroZgbZq2RYJ
Vt6M2KV9oaznpgZ6/SNA9vA92wThkG1lcM6hVLSp1cJkZT1Bgi2WLgTDABLCLaQH
fi1BdFpI5iVVxw4esxje/8XbgDBxm1ZYq8TtpzhOf1TG+NOPJFDmeNRTFzcQsaxw
RosxqdVYSZYi/HulUtfIgIM+7iIdtloGI9sd01+0DyzDClOTmrcs3fvX7YhjVqGG
GHeZe1omLbID68vrv/NuHRCk5Gi1p+glD76TePZidcbIWCcgKcfWijTVWOtsF4ia
Yr7IE2bKGihz+gKSIoNyCq/3LuS4Sg==
=04SK
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
