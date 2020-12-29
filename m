Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263E2E70A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL2Mlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgL2Mlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:41:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2C95207B8;
        Tue, 29 Dec 2020 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609245655;
        bh=qdL1uB6B1UXV2TxgliugspF/mrGeSPiZnH8ZtIXseis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5Al3s7pH/Q2gOLjsJl5bUsGE93nP8II2zubSheoULmZ7ACPrddQSEXGRysWmfayY
         kiXLjIBOniPt3RCgQTNgCNLmHKjceAk+7iDr1RuApuiFICzA+kJmNbD0GNE3F79puW
         /PRcgr313b2H0BS0vI4UwmCOi+0u+eJVNKQD/8Lrxx4BUugCxc8s9jRXIMuB9aD67M
         CPNH7s525WPl19lVhIAH/juY1Yqrx3ipec8Ps09MyBN0xZcwKoxmKbmijCQKFcXMDZ
         2QCzq0RVKEJzQTjbBVLCIqwIsr9/nJkJ2dMPsezHx/YO4fs84olRzA+IcmoBorRc6t
         lVZ/mh7yR3Ltg==
Date:   Tue, 29 Dec 2020 12:40:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Perry Yuan <Perry.Yuan@dell.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Limonciello Mario <Mario.Limonciello@dell.com>
Subject: Re: [PATCH v2 2/2] ASoC: rt715:add Mic Mute LED control support
Message-ID: <20201229124033.GC4786@sirena.org.uk>
References: <20201228133831.17464-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20201228133831.17464-1-Perry_Yuan@Dell.com>
X-Cookie: Mother Earth is not flat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 28, 2020 at 09:38:31PM +0800, Perry Yuan wrote:
> From: Perry Yuan <perry_yuan@dell.com>
>=20
> Some new Dell system is going to support audio internal micphone
> privacy setting from hardware level with micmute led state changing

I'm missing patch 1 of this series - what's the story with dependencies
and so on?

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/rI8EACgkQJNaLcl1U
h9AfVAf9EwDCDp+92vwJSYVphVfeIPziIaQ9i80zg0jLhzFjnxBt8t0xA34rJync
vGk2dgIgwe5mi+E5hTtNx3rpKQ0YjXrCxUPFnrk284ZsiFpufuUVwbixnzYQpth9
mxPp5lgkOChpYf5n6kYm9gGvW8r6Ijt9CI1SbXV/pUvpbrzN4QP2OPymSyGGvXO9
JUx+FTZOXRVnDs3NqFWQW4T1oaipvOkXTqYAJshBaDsNqn+6/2UaRLQtR1yhet3V
78kMpk0/BjBqrkofsIO/3nUzEgOCX5HwUviCAoqrtmhLmrT97luF/eHlV8k9SjA3
Rf02r7CedzVvZrS+zho8fKD2X4btoQ==
=d8Jt
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
