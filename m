Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F426CDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIPVCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgIPQPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF8622581;
        Wed, 16 Sep 2020 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600272908;
        bh=dUQHH1t0Kjwwdng4izGf7es7NVC9nSokJNE32ljW3nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbnIXCqoyU5dinvxyoYd47BNrw0bJMlLOxP+YR+Cwg1Cr0Pye++SYNL9gqJDL1np/
         MThFzvMvO2d4tCLmEcRH1XrQSGQH8TnZyphNBV846gPMUTNKU0kVUZBK/n35Y5mH8K
         IWeYEyDtXVX3E5r7SlVB8oGCI9wrAnP2pfLlsc8Y=
Date:   Wed, 16 Sep 2020 17:14:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] regmap: debugfs: Duplicate name string if delaying
 debugfs init
Message-ID: <20200916161418.GB6374@sirena.org.uk>
References: <20200916154433.7003-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20200916154433.7003-1-ckeepax@opensource.cirrus.com>
X-Cookie: I'm shaving!!  I'M SHAVING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2020 at 04:44:33PM +0100, Charles Keepax wrote:

> -		node->name = name;
> +		node->name = kstrdup(name, GFP_KERNEL);
> +		if (!node->name) {

Two things here - one is that this should be kstrdup_const(), the other
is that we already took a copy of the name in __regmap_init() so the
thing to do here is to change the regmap_debugfs_init() call there to
use the copy we just made rather than the copy in the config.

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9iOdkACgkQJNaLcl1U
h9CBfgf9GnSQpLoP4qudoLYN/FrsuHwdxt6zQlQIetYNPWVvc3qW4uLw73sq7YEc
EPqMamq2nd82vDJbtzEv7LqEoCd7OVwJn37OgBXjSNzW/l7TWuCx/Y4xNlYHYhS7
sRcStyG/jRrgM5xILP5Iw2AstYo6EFWmC+QE0BRW1VxicPwlA+3DDEi6keyiwZNB
KZp8u9Zh7+/w2VBuqDpyCmnnZ55OCxAZktEej6E2rsG9jWVhWDnLswFew3IzVlwL
zU993Z7kBGAv/o8osXHcbLTgRZh4dwmbB8L4s7zkhCepgY63APamWMgMb3EyewwN
JOKpnJk+4RzMNrmsr8csxtyO5EC/yQ==
=5+Pm
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
