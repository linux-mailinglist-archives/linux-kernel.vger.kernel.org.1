Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7672C2C2E15
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403916AbgKXRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390745AbgKXRJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:09:30 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2727820715;
        Tue, 24 Nov 2020 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606237769;
        bh=JE/XKDv219ahc78trmf4QDOLhTKFVqmxBCF2JSioF4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ec4UNRWNLGR6RwTKTnjzLAn4sURi8lQuEvTZcc5zu2R5cYt7qYqJ1PqoDzCIBou3A
         QSsFRyLhD0YI9s58P3nkgWrihKzdGgZdpWIwIOjnVd0U2tQ5se+c11rolL1Cb52mKk
         JzZqtSIpwa6IAxN3t/LD+FBvnBSPb3a4oFIch4Dk=
Date:   Tue, 24 Nov 2020 17:09:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v3 7/8] regulator: mt6359: Add support for MT6359P
 regulator
Message-ID: <20201124170906.GJ4933@sirena.org.uk>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1606103290-15034-8-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/jvaajy/zP2g41+Q"
Content-Disposition: inline
In-Reply-To: <1606103290-15034-8-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/jvaajy/zP2g41+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2020 at 11:48:09AM +0800, Hsin-Hsiung Wang wrote:
> The MT6359P is a eco version for MT6359 regulator.
> We add support based on MT6359 regulator driver.

This and the prior patch look fine.

--/jvaajy/zP2g41+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+9PjEACgkQJNaLcl1U
h9AlNAf8DECrNSbsknU6bM5hQl8m/t6H1PgEtYza1esl6hv+LJ6jpdDeI+jgB7AU
1CuLhu8bgpb8D9JQVkd/IPbmg4CA9LOXCXeSoi4I7F38nc+MURan+m4z5BAwhM1V
NLAb0z472Y3+cPCyLg9qx7w4VP94kKEU0Sq2BNlIjWQPJtcmzWaj6YpWHmGhe9WY
DWFDFuGof7CcNt1DIh0ZiiMXR2QjHQVQKxsRl50zXt0oqpuQMP9Hfc0WVnf9mJ0I
ugQwYbjhA/kK5ehK7kJrfTNlGkVMffPpcYzHgfWICJfGUTz8SkTnAXdcEsyQOasY
youTWPS5qGzgUs4lg0Sg/akO263uCA==
=zKUx
-----END PGP SIGNATURE-----

--/jvaajy/zP2g41+Q--
