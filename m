Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6314268A55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgINLtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgINLq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:46:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F75521973;
        Mon, 14 Sep 2020 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600083984;
        bh=cSiupXUtizg1oV5A0Jw00sC2CIMDO5kVjup5+HKDv1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvFLlAbC6XskGIL9TCSnGq/zQeQTuEeRyjvU/bELMJZbPldw5WcZyOTIDJU5MHYt3
         3W3FsJbK8Qu7eKxS1AFEdKtJcpbSNjpRrUDoOCWEFxEfCTpgRCozZWUD9jG45QZM8W
         nqu9DOeqa7Ws0flMm9MeK5M39bqf94IDXIPM+4dU=
Date:   Mon, 14 Sep 2020 12:45:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2] ASoC: ak4458: Add DSD support for ak4458 and ak4497
Message-ID: <20200914114535.GB4821@sirena.org.uk>
References: <20200911083048.29055-1-shengjiu.wang@nxp.com>
 <20200911104042.GC4895@sirena.org.uk>
 <CAA+D8APvRMXkrYPdGd7H1+hj8AFP7=nvZ0QbpnH8o52-sh50GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <CAA+D8APvRMXkrYPdGd7H1+hj8AFP7=nvZ0QbpnH8o52-sh50GQ@mail.gmail.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2020 at 06:47:10PM +0800, Shengjiu Wang wrote:
> On Fri, Sep 11, 2020 at 6:43 PM Mark Brown <broonie@kernel.org> wrote:

> > What exactly is this pin selection about - is it something that will
> > change at runtime or should it be configured by the board in the DT?

> It is to select which pin group is used for DSD. it won't be changed
> at runtime.  So do you think it is better configured by DT?

Yes, DT is a much better fit if it's fixed by the board design.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9fV98ACgkQJNaLcl1U
h9ADpQf+MaUWPyDgn+Z8C/aWXXNZ1YtpnQhTclVrouZrH+oZt6AtIe6Upc4dyLi0
JJ+wd/07YOes9zIjny4RI/bIXd2XogcYqUzjeDP9yiDbHfyezUSl0IOKJzEpyv/3
zXGXlFyXtEVRfwa/UORLG3gZ1HSW4Qok7L4w9TwraGUYPB7ZjohYFTQqKQHVmPY2
v3995vXRLdYDnxHCpaO5MR/wcxlftbV59xrWAcsZVvzEiQdLdhgl3kOzMeU0iP3v
j1JvLGhVtZTr9rhbiq30wKic2mi39rMoBDZ6zkWve3ejaK799Ev4qWr1K9URY4PB
SpAyT+3Se0+RK7JsLXA2r8icWVIGAw==
=j3Bf
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
