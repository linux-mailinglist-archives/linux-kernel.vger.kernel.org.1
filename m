Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F76248899
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 17:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHRPC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 11:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgHRPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:02:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F985206B5;
        Tue, 18 Aug 2020 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762976;
        bh=/Au42xAltT4UIkIAu/0BCAbvou4lntMo5L1yDg87RPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gb+VTDOyjTUgtk3IQY10NgidC0k5bHEanm05OxqNw+2FD/GDTn3v6Zin6FqFGq/RO
         22eOA+toA6ryOWhnLbiKhlqe0YvhboXwQ38lMHCYKsAu/uQeEW6sUG12uftGtfp/4s
         Ov/N2VwdXqVu8XlYzXih7O7ErdO+/PnzQgZlnfDg=
Date:   Tue, 18 Aug 2020 16:02:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: hdac_hdmi: support 'ELD' mixer
Message-ID: <20200818150225.GC5337@sirena.org.uk>
References: <20200818004413.12852-1-brent.lu@intel.com>
 <20200818143632.16539-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20200818143632.16539-1-brent.lu@intel.com>
X-Cookie: You're at Witt's End.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2020 at 10:36:32PM +0800, Brent Lu wrote:
> Add a binary mixer 'ELD' to each HDMI PCM device so user-space can
> read the ELD data of external HDMI display.

Please don't send new patches in the middle of existing threads, it
makes it hard to keep track fo what is going on.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl877YAACgkQJNaLcl1U
h9ALXgf8COAHlHSEiVOtPyp/q80RUFjIinu+Fl/Ici/1rbVn2e6HfyoKPntkcdsN
/MnEHoNs/YceorJgRS27MLtYuH/d7UcuVoaswd52DMV3Jat2VrBE18B4y9xdLgk3
3sAlOgMpfmfvlnCGs1LMtxMjZXML3Ld8cXYAJNr4Eio1+ovXYnZ2ihNtoVXpEhMW
zC9EShuuu0FatftsHxGvHo2wpxxoEeMYSSAQY9lR9Wq1LPQRib4zRubsjsshGp/Q
i2Id2nM7bTrkSfhGtW9MXqNUr7rztZt9YyG/LkEGsUyzCZHBeYIrOKX4M9eZUQNR
epCsSSEFOadhYuaoT+z5P+pxt1CMAA==
=NwDr
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
