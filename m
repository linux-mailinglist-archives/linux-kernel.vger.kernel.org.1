Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D452227E781
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgI3LPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbgI3LPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:15:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66393206F7;
        Wed, 30 Sep 2020 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601464523;
        bh=Dx48eemxBOQq/y7doof3FJxv2soD2ItY88WYKLl7ITk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Oe4uM4eipo/DeLJjz2v9ndUi5zs5jO6Lss9YfbM+zC6WkHdKl3eqfDs2bdotyKRK
         iyOIBd1wukCk5zzoj+TduPUnaFFCDK1MrHslNQYCz2fBHm1ycrS2idRqio0h/r7zcU
         X0v9pt/5s4Env9ZEM6g8k6NpLER1Mni9idoHfhvA=
Date:   Wed, 30 Sep 2020 12:14:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com,
        cy_huang <cy_huang@richtek.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: rtmv20: Update DT binding document and
 property name parsing
Message-ID: <20200930111424.GF4974@sirena.org.uk>
References: <1601460480-4259-1-git-send-email-u0084500@gmail.com>
 <20200930110508.GE4974@sirena.org.uk>
 <CADiBU39Y-WVCy=8p80fGupB+=68exAY-Oik5Kwap1_jyCR=PTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <CADiBU39Y-WVCy=8p80fGupB+=68exAY-Oik5Kwap1_jyCR=PTA@mail.gmail.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 07:11:51PM +0800, ChiYuan Huang wrote:

> Do you want me to divided the patch into binding document update and
> driver update?

You should've done this but it's OK, I'll apply.

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90aJAACgkQJNaLcl1U
h9C4bwf/T+MaxzKkzwTV4whDVkZ+jMPzfHI6XKViK1LRoULRwF/G8Zf9uxNxyUig
A8VcmaKY2PzesWpJTf4AJdKMQdAYsTv7l0YwDJ/tK8GNiq5eN1fCCTK1lzl0qTqP
FLmmxPj7NRR6A07+2Sxkj/PJlQpZFUmByUu3V8ACRf6iOvgtkO5huWiX7BTIpfjL
/8TQxKtpzMb0lC29hUUtBqumnQtKjhmyN7ba/OnTumoqlKwLVVW1cop4erhwRKQ5
6G6nA2IxkRL+BC2NlGU8Pn5yvbXs9DOmUF7PwxPtpeowwwqYqxUY4oUCt+/LrqDW
abURa7CIvrmibirJwb1sbrGiNpZPPw==
=TYra
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
