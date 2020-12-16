Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67F2DC0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgLPNGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgLPNGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:06:41 -0500
Date:   Wed, 16 Dec 2020 13:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608123960;
        bh=ALw34jiEl86mBurBzfxl0tOMaimss71WQubD/eersP0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkUlXoUqfH7AMVen7+kTNBZrIT15FrRVQrcoN5uf9vWQUnw52d9M4Lt5EHM2bEiS7
         3yP4jofptHGqnfR4M5ni/8WZgtYE+473sJCEIsUlM4K0JgvccEwd9pQfMoYDeHdUoj
         kDEuscPgpEq2S/Vs3ZgpvNwxwXDM59kzm/JxbT1M+1wqAjrhJxXlWe07qjswpSDzqi
         mMYA27ivgAUesCbBX2nyuh+nJMrxNGRPR0QG03qTcVwKmi8nkYeQ0ymH1BU0F0/LiS
         MZFHClT8P2z6il0AB8DLPniofSq+VFsEKSA61DGmABs/4LIliStdPo1jcirr4lMBUS
         uui2ldL5NpVCQ==
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Wen Su <wen.su@mediatek.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: regulator: Add document for MT6359
 regulator
Message-ID: <20201216130548.GB4861@sirena.org.uk>
References: <1600688895-9238-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1600688895-9238-4-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20200923162458.GE5707@sirena.org.uk>
 <1608093259.2412.1.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <1608093259.2412.1.camel@mtksdaap41>
X-Cookie: Why are you so hard to ignore?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 16, 2020 at 12:34:19PM +0800, Hsin-hsiung Wang wrote:
> On Wed, 2020-09-23 at 17:24 +0100, Mark Brown wrote:
> > On Mon, Sep 21, 2020 at 07:48:10PM +0800, Hsin-Hsiung Wang wrote:

> > > +Required properties:
> > > +- compatible: "mediatek,mt6359-regulator"

> > The compatible isn't used by the driver (which is good!) so should be
> > dropped from the binding document.

> Thanks for your comments, but I have a question about it.
> When I remove the compatible name in the dts, there will be some error
> message:
> [    0.437562] mt6359-regulator: Failed to locate of_node [id: -1]
> [    0.440612] mt6359-sound: Failed to locate of_node [id: -1]

> Do you mean that we don't need any compatible name in dts, mfd and
> regulator driver?

The MFD driver and DT node for the MFD will need a compatible.  The
regulator function doesn't, it can just look things up based on the
parent.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/aBiwACgkQJNaLcl1U
h9BpsAf/ZcnBIEPcD7SDXA0f+nRK2nTgqxGl+ninbflyHQWOCGfH2VqFE0jRLA9k
pZKghp6k+8G/5HthjAqCsEJ4n/5QL2e63D5JolYrBHxlBOdzqP0f5nJvE19fNaXr
+bgOqreW88GYbowu/EsMKV1xtTBeGor0xF/KDrfX5v4eMUp+GZ8a3rQgT8qAuswj
krBGwWaE8KGODbqNqBQj5KpNlI+NC2TrhdpdKd1R5vbtaXAX5uG3thZXHI6TdpFr
nw5GZzINEdcFS9QF9EtGKAEGmuaR3v2QqwTfO3HO9v2i/wz04DTOIRRu9wMI9sfi
4XuWbq1FpiWisM1J7Wcq2yOVPb69kg==
=t2MN
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
