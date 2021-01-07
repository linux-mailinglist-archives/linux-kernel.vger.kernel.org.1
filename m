Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D922ED136
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbhAGN4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGN4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:56:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FB3C23142;
        Thu,  7 Jan 2021 13:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610027729;
        bh=LXnYFuO/m7yLkPaglBXr1YjV5t1JasbH7WmOzsST9Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL/Xgu59loQzasBhYzsuRuw5qW96vjuHKF6R7TV68gC7h09S8Pjnxe1wp/UjouzSQ
         Wbz8oGvH+SsrVkZ6BXlbw625mlWaSMdhelst/hsQhEVn3pGNrSL/eAZ/d4CBw3anNA
         SxFybFDAO+wcReIEx8xiIglNfdv5VqRLzTcOQqqODyTOKrW4ISNpmnQb1J/CJ8E0AE
         q4Ruhu2Rwe1CJ+2F+42Drum5jt47YG1oAi4OFusucNgJP66s3gDGVxZ/ZH4lRpeYtL
         jeZ/lrfRoW1mJ5O2q6GgTr7H4eE9rskovRPyKq5pOse1mNDg/2ETBqjS99sPI5xg+M
         ipPpoTxeJpVWQ==
Date:   Thu, 7 Jan 2021 13:54:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Message-ID: <20210107135459.GB4726@sirena.org.uk>
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20210107085942.2891525-1-yuhsuan@chromium.org>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 07, 2021 at 04:59:41PM +0800, Yu-Hsuan Hsu wrote:
> Add the new command EC_CODEC_I2S_RX_RESET in ec_codec_i2s_rx_subcmd,
> which is used for resetting the EC codec.

I think the request was to sync over all the commands that are supported
in the EC rather than just split this one addition into a separate
patch.

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3ErIACgkQJNaLcl1U
h9AuIQgAhsn5doavvuB2jUYoY2Vgy/KRdrB0f0S4BCUso6u8B5NBsKVudkZGYy2N
UCNkXPtEnMnMR+hvvxw+b1Ntj80HbL26Ih/ZgtFAzWFkMg+DLf8QOIQIBaI9cK1r
YC7IW1f3XZ+U81xyLncWZTXBJ0LI3mJMJ6TNnxWiYaa+ebFEsCS/wqUMtjUFOKjw
en5ZSZpAa/KebHEmLU4q/cL8nF/xN9H/dNLuxGYJR30oQsdX8N69+fQRU24A717/
KkGl2QXHlmOIS5+po6YTFC8auuuU6LEcsKVU1uEJ2w7asaklubUO71AaohFt4uT7
UDghAbNdmHDXvrV7Dd6bCBqWLr4mtA==
=zhj3
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
