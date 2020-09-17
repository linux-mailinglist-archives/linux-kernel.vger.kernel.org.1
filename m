Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226FA26DC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIQND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgIQNDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:03:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BECD2083B;
        Thu, 17 Sep 2020 13:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600347805;
        bh=Q6IpJ77FCD9H833/+eXE2yE3D58BO49AZXC7Kjdp4I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYQGVyKqzlRLvhGU3T+FLcyMZBl2qFEDU3MCSqL23dvTSzH2Xb6lkZyfa4degPqdT
         mzgLNEkursN/aKlHBe2FFFaNh5V2xv0lUmwP3LlizICJ7aYwsXtZkr3OiUV2TtDJIL
         qtQ+OhqWZhZkYmMcWOzfyPulF9OKSZGGKesKzxck=
Date:   Thu, 17 Sep 2020 14:02:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, camel.guo@axis.com
Subject: Re: [PATCH 5/6] dt-bindings: tlv320adcx140: Add slot programming
 property
Message-ID: <20200917130236.GA2954@sirena.org.uk>
References: <20200915190606.1744-1-dmurphy@ti.com>
 <20200915190606.1744-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200915190606.1744-5-dmurphy@ti.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2020 at 02:06:05PM -0500, Dan Murphy wrote:

> +  ti,slot-mapping:
> +    type: boolean
> +    description: |
> +      Each channel can be assigned a specific TDM slot for either a left or
> +      right channel. The left channel values are from 0-31d and the right
> +      channel values are from 32-63d. If the right channel value is 32 then the
> +      right channel slot will be slot 31.
> +      The array index is sequential audio channel to be set.
> +      [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8]
> +      If the channel is not to be used then the channel should be set to it's
> +      default value.

This is something I'd expect to be done by the machine driver rather
than in the CODEC specific DT bindings, and apart from anything else
everything involved in the DAI will need to agree on the mapping so this
doesn't look like something that should be done in a device specific
binding.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jXmsACgkQJNaLcl1U
h9C/Rgf+IMC1QTgLSmNF/gJuZlCcieaK8BfTxcfHEBBykWRyvmdqNW9ZPHFXODK/
scOFFkEWwz1YvqreSRdrXXUAJ7RHpUcO3KT1YKyPnRlo7m7dqiyJhePSjkG1rtPQ
1rg7EVnqS8IIKMrr5XDSeqpJrEet2KcRBJ4eqrXotx5t8s8VcK3DDDZO6UNhEyRN
8NKwX+MiUs2b2/d/xkfC3ILN/3bV7K5Mnej2bQS8kzkEArvI4DT4Hr7QtXbBkLsZ
/Vu9XuVXIitkCHq9akNFyJjevgIrMFmm4htRV95YcbfZWLF5BV7uOf5nbwokvZA9
jHGvK8hTXVdF9T/e4D/kiXEGvAJR2Q==
=usXR
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
