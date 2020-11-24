Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDA2C2B70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbgKXPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbgKXPe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:34:59 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B8A206D9;
        Tue, 24 Nov 2020 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606232099;
        bh=45SlmfsmIMOXv8O0QZwjwZBCGy0E7RVMW2NesSV/47k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtn8AkPm7NLigf+bab535CzSZDXbvQYiNvl1bCqgn6CyaE4vavdPmj0+Pd13qa6BB
         mvMoDajDD5YYUur52dexhzH5Vdr48tEREGqHDd1udWnFygoLLj7zdf2eL2funm4V+M
         fz6njgbbS82csEYRaK5TeB9sQOUSE2Yilm40QSbs=
Date:   Tue, 24 Nov 2020 15:34:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Philippe Duplessis-Guindon <pduplessis@efficios.com>
Cc:     linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tracing: Remove duplicate `type` field from
 regmap `regcache_sync` trace event
Message-ID: <20201124153118.GE4933@sirena.org.uk>
References: <20201124135730.9185-1-pduplessis@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Content-Disposition: inline
In-Reply-To: <20201124135730.9185-1-pduplessis@efficios.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 08:57:30AM -0500, Philippe Duplessis-Guindon wrote:

> Fixes commit 593600890110c ("regmap: Add the regcache_sync trace event")
>=20
> Signed-off-by: Philippe Duplessis-Guindon <pduplessis@efficios.com>

Please follow the format for Fixes: tags documented in
submitting-patches.rst and existing usage in the kernel.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+9KAsACgkQJNaLcl1U
h9AeFwf+JlXde7alJC/swGRwNTmn9y0Jb1g6/ogpQSusfwXQ1TP0JiKtmfNHUr3f
aTQv5OTg24HLheO+kO5tc1jniV9c2Gq5Gb+Xi1770xopmhcsu6peAh5mi1PZ9J5U
jkXHn3OoNCeps1WX1ImQN2AEAOC5iwpqXSeNS6CMqL1BVLr74Uxp5qBbYhnxi7PR
tzoxDd7xSJzULh6r6a67LfaUjMvnKRGCZEb/UWNKcxWfpyOxQnK1HNO7a4NJDgfF
ss+AxfhzjitHruncRZCTL1xfUK5pqw/f4GZyxiaE44vWZ0TWocNEmNddUE4RcD1Z
fCge+hNbXxg0hGVdEWx+JImpG5MVhg==
=EHsQ
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
