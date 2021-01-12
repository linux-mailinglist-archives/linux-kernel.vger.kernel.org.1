Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8106B2F3930
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392707AbhALSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbhALSuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:50:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F14B022B4B;
        Tue, 12 Jan 2021 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610477361;
        bh=+wilW7PR6EUwuOxtL99UfUGxy2Y3s4HM648aqDLGvwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiSTIs/5MU3rCUxPQxxY/GuKYx1VicPZeMoEfe9QgXpL6SNF2KfL2sxOGcKTFPnvq
         zSCMSDbeHOt2/UyUpwPt6m4obluPhqZKH2mSGyEEhnrhSrgiLfRv6NvM2AjZIjMEjE
         fyPy8uYlPfq+CHXXns6yleUqwKsP6nalVhu2sA/4+8GTGuve3q6C4yyKSmG0GIw4x1
         LkysKVr0ypvfhDlGvovfK0QGiTRV84Q7LFIbaeIB6z4cvj89h4xteLNFfb8mhPptqF
         BMHPGvKmpBVsqnpUyan7x5MjXsyJyqeXkKjANBcLIcqkEMIWjvMcLF0j+JX4Ujry4N
         XsSS0/5UigVPw==
Date:   Tue, 12 Jan 2021 18:48:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20210112184848.GG4646@sirena.org.uk>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
 <20210112181949.GA3241630@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Content-Disposition: inline
In-Reply-To: <20210112181949.GA3241630@ubuntu-m3-large-x86>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2021 at 11:19:49AM -0700, Nathan Chancellor wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> >
> > Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---

> I still see a warning in v5.11-rc3 that is fixed by this patch, is it
> not going in this release cycle? It is a regression fix, seems like it
> should.

This is a random warning fix, why would you expect it to be sent as a
bug fix?  This is the first indication I've seen that anyone is seeing
it in mainline, in general the people who report and fix warnings are
doing so based on -next and the patch seems to be from a month ago.  I
don't have this in my inbox so I assume it's applied already or needs to
be resubmitted anyway.

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/97w8ACgkQJNaLcl1U
h9C44Qf/bxW+CXB4DwJTofrPuzVBuAQ6vUrmIqtZSde3b3oZ60V4fS3Weuw63ihH
QkztqOp+rn7uoHY3X1+XDUwi4+suPoag7X04Q8EKvLyhtovjOZP0Tp+gC+FXEPad
SM9gdRlMJLyJoVQSvjzJueO9vkXLy9OZoq73zH444VcmzTzGXP6Bz5wug2m9LHC2
rMEMY3mbhLDLD9zGqL/CVE5OOsFHRfAlqWb+QMJaa9QY+IrPri8XqO72mNceYFbg
grmrNQjES0IvzOa+7mxrK58M/L6iT+m9LybUHxxxINucdDdEYMV5hIY1OLzretHi
4BhzHK5m28Q8w3p+a7ZXY2D59aZbOg==
=DgaF
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--
