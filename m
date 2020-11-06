Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCD2A9623
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKFMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgKFMU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:20:26 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 572EC20715;
        Fri,  6 Nov 2020 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604665225;
        bh=rLaHZxkEJ3Zmxvf7Vr/Cg2Fpa7pJbEhWMmYIrGjNiDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRCZ2+/cofyw6fph+5dlIP29UiohmyXjfx6p9tNxQNp5k/ZV/y34+S5VB2DEHoG70
         sFFdWNb3uc4gS+3Y1lPvkzhicINNnzDiJp+2xjQdsIrwwtQ57qCzowH3Wl+ikTDQOU
         v0OScxZ0Nii410PVCbhI+keeL8HMGaPGBC+RZRFE=
Date:   Fri, 6 Nov 2020 12:20:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        Xiubo.Lee@gmail.com, festevam@gmail.com, robh+dt@kernel.org,
        nicoleotsuka@gmail.com, timur@kernel.org, tiwai@suse.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
Message-ID: <20201106122013.GB49612@sirena.org.uk>
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
 <160466365499.22812.9217467877032314221.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <160466365499.22812.9217467877032314221.b4-ty@kernel.org>
X-Cookie: When does later become never?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 11:54:23AM +0000, Mark Brown wrote:
> On Mon, 2 Nov 2020 09:52:26 +0800, Shengjiu Wang wrote:
> > AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> > IP module found on i.MX8MP.
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next

Sorry, looks like me queueing this raced with the review comments coming
in.  I think the review commments are small enough that it'll be OK to
fix incrementally?

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+lP30ACgkQJNaLcl1U
h9BMbAf/YYxCzCGH2GbmfLoYjyffvTAUGO8REEj9IgCKa9pyWNJowu4KCdjlXYvJ
ZeGTKytpKJqcqogSuKAWzQceby4N7aRa/Lzm12q/0GSP+TvoG9YnAr4J9w+IjxWx
GW/TwSJlPQCfFKGcRN+JYhkTQ35l7TsApa/8snkWdCwcS004xJ2AhEqzySXZojY7
zno2JFvQsaGgpXXCoRrO4rAJLlR/t74o8iobg19mbTbOWUa+h8Ul+UHANvnqOSml
QORlFFFTjaFDovqs09Q9n4mGXiMCGJJU8v5FRaVtMNafoiYjM4V3uwIrt6fjt81k
lP3Hz9pwhUC+SLgRLapwIPKTYo6ZlA==
=bxj9
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
