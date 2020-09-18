Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1526FB1A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIRLCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRLCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:02:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E825D20795;
        Fri, 18 Sep 2020 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600426963;
        bh=0tKGZr5/vrAQyDu0Cn//xVY743MCuS1oNdrrqUZ6gTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJpg4jZsRPL+6FDKr7kwSETGu+Rcj2GdPYu3N9Hq2NXFTv13W/6f8zSMiKYmdBi6n
         mAw5PSkDiBVPWdC1qpfGiRuTe2dIYz8CS2lyA9a/48P5fbAsvXd2Sk8WucKyVFOK9r
         9wJYOrCZMgsgqJm+6b2H+gHLGUomRZa/Kp73EvOQ=
Date:   Fri, 18 Sep 2020 12:01:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shane Chien <shane.chien@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        jiaxin.yu@mediatek.com, eason.yen@mediatek.com
Subject: Re: [PATCH] ASoC: Use memset_io to access I/O memory
Message-ID: <20200918110152.GD5703@sirena.org.uk>
References: <1600423219-29058-1-git-send-email-shane.chien@mediatek.com>
 <1600423219-29058-2-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <1600423219-29058-2-git-send-email-shane.chien@mediatek.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 06:00:19PM +0800, Shane Chien wrote:

>  	/* clear the buffer for avoiding possible kernel info leaks */
>  	if (runtime->dma_area && !substream->ops->copy_user)
> -		memset(runtime->dma_area, 0, runtime->dma_bytes);
> +		memset_io(runtime->dma_area, 0, runtime->dma_bytes);

This is regular RAM that will be accessed by the devices rather than
memory mapped regions provided by devices, the _io variants are normally
for memory mapped regions on devices.

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9kk6AACgkQJNaLcl1U
h9Be2Af/ffqM7prFiaL+Z/QmnZkIWcCC8wYoVek1jBUmixkWC7+M3rnd18MzhcPb
lL5tNIGaILMczUu1ZlvVJt1c+ForvJv+iMdq4UFAvcSDnjwNW6nlHtZWZc6WyPU9
vOT8Xuee4vWZ3u6QbDX2nVuIkMci/R6ehH7z9i0fZY/9IqDl1tMyzw8rmYoBSJ88
GT7QnIZOeZgjdMj1p4iFRF051hw3tX3YWcRQtF+2IAvOemeiAQ53zkHek4E05AH9
WCb0R8JnnS6X2TLVWnf6gnKLSyZcYzTO0EM1ZpXCb46vvjeD2KlG9wq3t8FK3pMo
X8I7lwE1V3OaRXtwGXPaEYkMvFC+1w==
=96HM
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
