Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CACE252CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgHZLrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 07:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgHZL0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:26:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C04420786;
        Wed, 26 Aug 2020 11:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598441126;
        bh=wFUB08BUg8SWjdZRvkVyDKbV1IBYIvlbVUh6QQnqQsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udMBUUQJbciMyjzDoSa4fAr30tZPobLQ9Ay97hFwAFahfGPMZxkIB0TMaV3/n9ub0
         zsOuk9pCOv7OrFUPS7yEyVuPDGxcyk+D7F2DsO8r5pMkNVSkHL3qHoh0esSk99+PUg
         PhJU7iNIou1pV5alTRgUSZMxdWQS0v3O+1sIxYO8=
Date:   Wed, 26 Aug 2020 12:24:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Clean kernel log from deferred probe error
 messages
Message-ID: <20200826112450.GF4965@sirena.org.uk>
References: <20200826111826.3168-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <20200826111826.3168-1-akshu.agrawal@amd.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 04:48:05PM +0530, Akshu Agrawal wrote:
> While the driver waits for DAIs to be probed and retries probing,
> avoid printing error messages.

This means that if there is a problem with deferred probe no diagnostics
will be available, there should be something at least at debug level.

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GRoEACgkQJNaLcl1U
h9CtQgf8DcKeUebIDKsNWTFjupmBGMJZReu7jz5tCWYwj8WPQ7y8Pw4tFaXeGvSg
L8bDD/+t/Q2pbW0CVzaij67lcMyVKPAMv6E/9+1RB3DfqjJnzK262gFy63nGS38E
YQmpDZquUgl8f+p052/S7wr7AA0aEoBbcgYM7OkwY1SZoIbRjLjF1sXKjpKult+r
EAYSjIcgr6Z0e4QAE3QYDg3Lo/x8Exe/avmm6TV3M3KzkSuXMXU2a796wVHVJXYM
guqUvzDZxjy2rMYI5jBcxbzHwXhQzhmBiAWAzFFRatPqTn9FeYJXZsc7JXxqYFO5
zgZF2XqUGNIzLZVRCOnTiA1kpH+FAg==
=ClSk
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
