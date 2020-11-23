Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D682C10FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbgKWQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732945AbgKWQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:43:54 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF7C822202;
        Mon, 23 Nov 2020 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606149833;
        bh=KM4r7MwaPKpXE9JTfWfEWcXBm5bb1qbPQ3X0VvyVd4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPkOfmVshAo49whRlUaSnutvud9KcolrP6aA8eBshzeBmrIrxycJYG2yUxRqe8OSW
         6+Z5vmrxrgY1EX6Ac3CqA2nguHv5JI/QiQ08BSzOSnW7M0ywRc3HK78bL8DqgYKJlI
         NDESmxQh0N+cEAiCsckinP7FvUcf9Luhxd1KfeVQ=
Date:   Mon, 23 Nov 2020 16:43:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123164330.GG6322@sirena.org.uk>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
 <20201123124129.GA170000@kozik-lap>
 <20201123135006.GE6322@sirena.org.uk>
 <20201123145831.GA202597@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
In-Reply-To: <20201123145831.GA202597@kozik-lap>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2020 at 03:58:31PM +0100, Krzysztof Kozlowski wrote:

> Having these of_match_ptr() for OF-only drivers is not the correct way
> but rather something which is copied from existing drivers into new
> ones. This is another reason for removing them - people will stop
> copying this code all over again.

Well, it seems that the issue the PRP0001 people are having is that
they'd rather that there were fewer OF only drivers!  More generally
it is good practice to write things as though there might be non-DT
support even if it's not there at the present time, it's easier to not
have to think if it's strictly needed and it helps anyone coming along
later who does want to use things elsewhere.

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+75rEACgkQJNaLcl1U
h9BiSQf/emZ4fCarHLUI71Hqpc4QJAz+w5gA+DRKeiySta5dIWLLGCzbREL5lUCh
93fxw8vLQKryX71eVTwydSxRLMwPHNi7XHtBWKXwrqFe45byHdVjcE2ggMowivFM
3+lTwB3Gl60GYaSppHfW2wVS3gTCwCCF78Asrao1B4ipJMYdKT1j54n8HHXF4mMT
iP2JBmGkknT9+RJVBA087VYVIzKkflE7H9q4h6JyMIrr9F6Gnwx6Xkawv2NAwPwm
BYDXl90zQQGBHao62BXyw/IPdYSi4KVzUzaL0fiPR8niLaXdcovru7xxHPUabpmn
CX4ANWeN0bn+yvk3ImcJJ04Jpp5SoQ==
=AliB
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
