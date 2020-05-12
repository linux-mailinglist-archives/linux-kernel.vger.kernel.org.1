Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3931CF489
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgELMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 08:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELMiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:38:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F78206DD;
        Tue, 12 May 2020 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589287085;
        bh=uDlo9Exmm/b6xQKP3G5CHPi7Uy1tLbtDYkh/Nhxo4Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2thKUjM4ZPlMFVHhrRTOjlAH+a9pqbcg6ruG6LJ9xJo2/xDmqEWdgQPysdu5T/S5
         5j+UiuF2ruXWMcM/esh0PG8xkSDzqz5nhYgaz3Jfl3MzDCzO+nX+Loo6ZJf+kd+gUM
         pbPga4aOzFmFVxGdhMXY+7uiywOg5b0wYCR2SQZI=
Date:   Tue, 12 May 2020 13:38:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_esai: Add support for imx8qm
Message-ID: <20200512123801.GG5110@sirena.org.uk>
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
 <20200501102158.GA5276@sirena.org.uk>
 <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
 <CAA+D8ANK+Sd=nPeDZpd_=fQRFOdLtKgvsCmfQ_fRU3RCjMY+rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANK+Sd=nPeDZpd_=fQRFOdLtKgvsCmfQ_fRU3RCjMY+rQ@mail.gmail.com>
X-Cookie: The only perfect science is hind-sight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2020 at 10:48:41AM +0800, Shengjiu Wang wrote:
> On Wed, May 6, 2020 at 10:33 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
> > On Fri, May 1, 2020 at 6:23 PM Mark Brown <broonie@kernel.org> wrote:

> > > > EDMA requires the period size to be multiple of maxburst. Otherwise
> > > > the remaining bytes are not transferred and thus noise is produced.

> > > If this constraint comes from the DMA controller then normally you'd
> > > expect the DMA controller integration to be enforcing this - is there no
> > > information in the DMA API that lets us know that this constraint is
> > > there?

> > No, I can't find one API for this.
> > Do you have a recommendation?

> could you please recommend which DMA API can I use?

Not off-hand, you'd probably need to extend the API to export the
information.

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl66mKkACgkQJNaLcl1U
h9D3bwf+L1SDbZMmf3kj5H/WHV+WYYcxZvjpF2rx3puuQVDabgoA6GJxeqw/Y+E1
5yyW83wYPDD8fGV58m6XOxoLG3dkr5XC1+TFhPz5R1GuBOnLZ46HiG5C05SbEzZm
LAMKfH73aIsLtKrRk54PhzI2A2NBfO19TVVxWw4qP00k/xe2AuNQXOBNFq8vW+6a
UfgCJuvJFyizBVuid1eYBz4QTgKf/xbrQEfQAPWI72jFFgs8vzHCbPICl62acbOy
ibciDr6vghSxDewz9DyynJ0Q0SminczxTQ8e4xACqE6yz10Jh6WU07ihBjJndIlR
/ttLTH02Vy9Ail0rfr1jNuHIRa9U7w==
=SUbH
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
