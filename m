Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC32F1BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbhAKRLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389160AbhAKRLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:11:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5E1422ADF;
        Mon, 11 Jan 2021 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610385025;
        bh=CEM7dWzMTZuxYjhc/Lygx2LFgOg7zUdaVa/zDijfNlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9eH3AxO7Fh+siVkFuTRbL8j6l+0YCjRRQDEPVwHjgar6D3uTJGYuWluSUKUOHH1a
         hisFI0n230ev7Rh/ohDw4CVPj9kHU7WCF2rTS4qUKF/TFUQn628wtkdqcetARVstqr
         nK3pjXHuGCPgFeURPLlSFoRrAfr0fbhQxjejFXMIWy01KYiiW39KamCDTOU8qbHKXi
         xzeGy7CZNfpY0S7mdPEFW3cuzIvuYW2qS/qgP7oqjgCs46614L9dxfisxj9lHoXCX9
         EIy6Dp5wX89vR/9WLaVTkUuMIWg28xf2pbNkIURy6/UTBmiucJNzUsG5zwgZ6fFgOl
         xhKTjxC0ZuLoQ==
Date:   Mon, 11 Jan 2021 17:09:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: soc-pcm: Fix uninitialised return value in
 variable ret
Message-ID: <20210111170952.GG4728@sirena.org.uk>
References: <20210108123546.19601-1-colin.king@canonical.com>
 <20210111163551.GA33269@sirena.org.uk>
 <02666c81-5b0b-fe48-5d9d-63f2f007bfba@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <02666c81-5b0b-fe48-5d9d-63f2f007bfba@canonical.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2021 at 05:07:46PM +0000, Colin Ian King wrote:
> On 11/01/2021 16:35, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> Just to double-check, which tree should I be working against?

The ASoC tree.

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8hl8ACgkQJNaLcl1U
h9Bd+gf7B9+Ph85InD2rpWWb23HJjI+fduw0QnvHs/tGyW/s6PcLryEZxMiDxxE/
b88tUAdO4VNP7ut/maZKSE2M7t7seO3bNJABfV7FIdu63EWbh5kRcY5Qjgv5tpPe
GR8cH+Pjj5XLiB0EuxOhLVSIYx0Cu4qCWrBc+9YUA6zHQcuYHtuCW4D0MCTxcyrA
oMB+38Q6QKYDoaaE+znyJ5AzMSPHWreQBFjKAXify5/yaRNw1kdenyt+dguGD2Po
u2OwUqcruMy8kVvU0bXJDo5iUIyybmCYLXPkpLnBsFLmDS0qq+aLjqq8QMrjWY2M
9tKAmVqv4FsN0BbKfhkT5rhKCJx37Q==
=3HiQ
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
