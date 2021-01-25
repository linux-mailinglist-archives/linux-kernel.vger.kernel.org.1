Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658E2302565
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbhAYNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbhAYNKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:10:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6234622D50;
        Mon, 25 Jan 2021 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611580199;
        bh=CIoI4bee4su0waagEjise7oAP9BZHPbX7apg69n7aGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XeltK6WNbANu0LKOJ4LMBRPyIfOb9baP18JlL9TULtnIl+6HAzcfvm8KsbuZBaL4N
         nrjbcLuBeN5KnYjEnDl1zWJaG+ueAu/O9IJoKA4SJHBbgUt3AfBE1XdVjutoYD3OEq
         k96SkOscKH6Agm4uzWKqCyjDljfAgr36e8F0QC/4/o/11Pcqn/oX0PCK7eBMEbW4Cq
         I+9RNLTrro/SQR3lp96lyWnjMi3N+5rHCBgGmwGIPDsNkRJpy4LyTiGpdw12JmzBMr
         nLBVHACkMyPG9DsL6VhVo62ZhFtCiyIPb1Oo/FH/QVE8e+Fe4IVu2EF/vpQb0iZMGN
         e+k5Ran43HxBg==
Date:   Mon, 25 Jan 2021 13:09:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: pf8x00: set ramp_delay for bucks
Message-ID: <20210125130918.GB4510@sirena.org.uk>
References: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
 <1611222152.1561.5.camel@googlemail.com>
 <3753ba4c92fda75e646ccf629bb95e9d692ddbdb.camel@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <3753ba4c92fda75e646ccf629bb95e9d692ddbdb.camel@googlemail.com>
X-Cookie: Drive defensively.  Buy a tank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 25, 2021 at 10:27:00AM +0100, Christoph Fritz wrote:
> This patch sets ramp_delay for bucks to the max value given by the
> datasheet.

Please don't send new patches in reply to old threads, it buries things
and makes it much harder to follow what's going on.  Start a new thread
for new submissions.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAOwv0ACgkQJNaLcl1U
h9ClgAf/YFXClM3qDB2n9SkbV1W8nl6Ok6CNs+fUb0NTNflFZnhVEFCjNxGSIk84
ojGBi1IdK6l3+ykmHI3aikCpciVJCoruO2rlrHSSG+7DnDMnBPOOu4T7TwEhdwXI
718nsNxT/akB7oXdqu/fkymPodACovkl+ggvK90uJAEEg6UaZY1Ml916NxVQjVCQ
1xy8BaBU1+G8+3RHGKARWgdU46P3LEndRDlOXXot6FRFwnsCGFXdkbtN/YEg/1qZ
mGgB2jVIskf4TfI0cpAnrm6uyJKiXjBdz/q6FRPgS333dBOkzY+Qz/yguLv+wxq9
gTGrERFoKMTx8XlwH8GmUSwhX0vJfA==
=5luB
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
