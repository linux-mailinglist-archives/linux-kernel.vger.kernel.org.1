Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72CB215F36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgGFTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 15:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGFTQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:16:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65C8206CD;
        Mon,  6 Jul 2020 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594062960;
        bh=lKBM6mjAlyQOOZRQ94zKj8zH1QXeriO0lGCwAoymvRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLDvxypLORaBaqqjtL+HTqVtG12GFsIMX+I9gu4FmNoufHk3Jvzdiy9lG1hXMj2xO
         uFNM86ZAA8jDf9GqTJOgECe5mxTKWAfh5XPdRDr/5vTg3Oc/azZSeU71nIYOfkMA7e
         Xv50gVMhFucmDinJSdGIoGe39cFXt+b9FjXO8XR0=
Date:   Mon, 6 Jul 2020 20:15:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706191555.GD6176@sirena.org.uk>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Cookie: You will be married within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:

> +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> +'subordinate', 'replica', 'responder', 'follower', 'proxy', or

I'd second the suggestion of device as an option here.

> +Of course it is around this point someone jumps in with an etymological
> +argument about why people should not be offended. Etymological arguments
> +do not scale. The scope and pace of Linux to reach new developers
> +exceeds the ability of historical terminology defenders to describe "no,

More generally etymological arguments are just not super relevant here
anyway, the issues people have are around current perceptions rather
than where things came from.

> +not that connotation". The revelation of 2020 was that black voices were
> +heard on a global scale and the Linux kernel project has done its small
> +part to answer that call as it wants black voices, among all voices, in
> +its developer community.

This, especially the bit about "revelation of 2020", sounds a little
off to me - I think it's that it's worryingly close to the frequently
derided pattern where people recognise a problem that other people have
been talking about for a while and treat it as something new.  Perhaps a
more neutrally worded reference to current events and/or our desire to
improve instead?

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8DeGsACgkQJNaLcl1U
h9Aq9gf/dCycghXxbYkAwmHrIXKUXYujklMI+fxrZWnArCTij/lGzg0+Tz0TujDs
fLpzSMzF9sBncdB5YTa8hxIPpAV42hj9I5CR3lSToK8j6UWhyt7KK2sbH05sDXf4
BXG5G9Ak6RYXuEYm0rKtJqhh85PKNKN46yZOC63X7KxhAMn5sSoyKHVvVFLe0jr3
NkGfK2RTVNHTiUTavRLRCbF8Pa9AdedRNpTvNcRdqVMVsxXJpXUOKDXebCSnkJKd
66IMS0jl/mpyg99Dj3QKdOteDV8whj8xmd4A8HkHDl34KBnJS5j08BNQKjI/6Uu/
/YXWlRxrNEYNwt/nrML5qjswLBf9Gw==
=hT3Y
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
