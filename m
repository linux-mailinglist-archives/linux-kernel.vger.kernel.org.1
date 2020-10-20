Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAED828500D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJFQkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFQkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:40:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BFE206F7;
        Tue,  6 Oct 2020 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602002446;
        bh=7Kafi3SMR5wUFUKEpxTCLbAGQeHhDJktANYroBfi6As=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esAOhbLYNjHKVB6XxpntZ8n20rm3hLJNEB7/6dx2pGzfPGg33K333ks/65mtGEmwE
         tIKJ6ax7tFOX6yZPuRS9fhopfGdDXuuaQcRC1QKqseQpvQ/3L2xpGj/+AIWaa6ZwBC
         BdgA3S2b2HvadrKup2Ez5dDhYYNGXu2R3iLKFyNw=
Date:   Tue, 6 Oct 2020 17:39:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        ardb@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, dave.martin@arm.com
Subject: Re: [BUG][PATCH v3] crypto: arm64: Use x16 with indirect branch to
 bti_c
Message-ID: <20201006163943.GD5259@sirena.org.uk>
References: <20201006163326.2780619-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <20201006163326.2780619-1-jeremy.linton@arm.com>
X-Cookie: Will it improve my CASH FLOW?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2020 at 11:33:26AM -0500, Jeremy Linton wrote:
> The AES code uses a 'br x7' as part of a function called by
> a macro. That branch needs a bti_j as a target. This results
> in a panic as seen below. Using x16 (or x17) with an indirect
> branch keeps the target bti_c.

Reviewed-by: Mark Brown <broonie@kernel.org>

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl98nc4ACgkQJNaLcl1U
h9CLAwf9FiPQZ/xkGSQroau0bLLgKubdsRTXCnzajbWymLdZcF7NPVkEqC61rY+X
hTAWXCf2S9EtKxSV93rO0ea9HsRomillICgvVTDfk0tn4AOz8d60dTNtMaMuwQZ4
qlOxUBnkMk1XL4QoOiY5X8G9APy/sEIcZas0GqobABxmnRA1DduxLQtfF5x0BRoO
BKhSQ2v3nHThDpOJ5ati6KAq3R3IdAtgzPt02Y6K28RXRXktAUbtcPJFMMCEWPox
XylPKGq4FGqFWGEoeGAdf+6vcT3v1A40fSp9WvX94RO43YuJfJhSjwUVcDApiXSX
BVagPfdEIahk4NrD2q4kDgQW3Z7Tsg==
=eHIP
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
