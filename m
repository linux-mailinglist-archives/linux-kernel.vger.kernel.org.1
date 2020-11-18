Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2692B8399
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgKRSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRSHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:07:49 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6420320872;
        Wed, 18 Nov 2020 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605722869;
        bh=G3eNmrElpyk/JxdBz4ZxECjisMtQTh/y/4ve+046iDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+KKNmpy9vshVC7uON3rYNM2VC3nQSETkj1ls4ywL6YkZbRUIQGr2DtRsZkx8cgjS
         aHZRGqKRltau/tixcju0xTJw9aIYQ5MgpdWWDeNRi1+3nq2e7hA2Si7uIs+v4jl2md
         wl7Ar/XTUBMOenMKU0EuziYi+9AFzdOztNvbx97g=
Date:   Wed, 18 Nov 2020 18:07:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     matthias.bgg@gmail.com, tzungbi@google.com,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shane.chien@mediatek.com,
        Trevor.Wu@mediatek.com
Subject: Re: [PATCH] dt-bindings: mediatek: mt8192: revert "add audio afe
 document"
Message-ID: <20201118180728.GF4827@sirena.org.uk>
References: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
X-Cookie: A nuclear war can ruin your whole day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 04:05:20PM +0800, Jiaxin Yu wrote:
> This reverts commit 1afc60e00de3abbb6c559da409c5c1bb8c1d98ec.
>=20
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  https://mailman.alsa-project.org/pipermail/alsa-devel/2020-November/1768=
73.html
>  These dependency are continuing to upstream, I will revert this patch fi=
rst.
>  After the dependencies are merged, I will send 'mt8192-afe-pcm.yaml' aga=
in.

This description of what the commit does should be part of the
changelog, reverts are just normal patches and should have changelogs
describing what they do just like other changes do.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+1Yt8ACgkQJNaLcl1U
h9AhLAf/TGSE24nfALfss97iOQLpBN2TcEUOBzg/RRtpuWtwvSMYV4B6YSoNojIr
FMcDlZWyPnv+3y3iht5s5jNy278L2Dobyj10ncVofPIdIZ4duv5CRsxcuSb5bde+
4IKJ8om4SM+CEovLSNYLTclqEeu621cTX6dTklSi4cW5SOHxir9DqSKHlR973TRb
XihhxBmTMMIpUKIEYHqULed6nhHQ1nWPV2JvThXh4C51gO+PI9ixrLtGjSssfMtI
p2jSsO6qgJi4MyAPA7zZ1N/KLK/IUiL4jPE1qj5QfPtZOjOXp9uwAAJ2Y+jsRQDs
o7HKVJGxnso4TH365eWAQrexXZV6tw==
=g11E
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
