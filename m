Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8FA2C463D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgKYRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbgKYRDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:03:47 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7B0206D8;
        Wed, 25 Nov 2020 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606323826;
        bh=wwsWXrdFdlQE2+Ad92bmUfiywgfcOkqNr4RoEZTzSHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDUHzAQq+/GNdH2Y+RmCSG5TIwTxzVGj4vmAQ9m8ym8L7KXD3Lf+K1b3J7NsN68rB
         5vQq2g/rFi/GEAjn0J77d/rSKp8x/zSPPd5e/KCkD9s3Ir2s7Os/zD7/D7oMKHw8rO
         JIro40BsxkvCPOCgdeCnmylUxjtByDlX34vwTCdk=
Date:   Wed, 25 Nov 2020 17:03:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com
Subject: Re: [PATCH] regulator: core: return zero for selectors lower than
 linear_min_sel
Message-ID: <20201125170321.GB4489@sirena.org.uk>
References: <20201124141136.GD4933@sirena.org.uk>
 <1606304043-3227-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <1606304043-3227-1-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: No foreign coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2020 at 01:34:03PM +0200, Claudiu Beznea wrote:
> Selectors lower than linear_min_sel should not be considered invalid.
> Thus return zero in case _regulator_list_voltage(),
> regulator_list_hardware_vsel() or regulator_list_voltage_table()
> receives such selectors as argument.

Please don't send new patches in reply to old threads, it buries things,
makes trying to figure out what current versions are harder and breaks
tooling.

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl++jlgACgkQJNaLcl1U
h9BuCwf/R2+ApNuHDVTdQ2qfT3V/IZdWba3PhdVsSD0Q+JdOLst6YRulW7k/yF7W
ptQFBATHIm25W76O5OC64UT2AO94PjVC+EN5qAhUuzg9QNkme/C9hqcdiPbE5scC
vZJ4BHh8CTV5jc0lnA0QPOV34qTgRpPXweMjzcEs7OHUR0x2XHjtXBhhAlDFZ/eJ
jTPa4zkJG+d1mc+u40j8kB1ndAcSJeXJcY40S+5Lo1aS/L9BBMnS9DnYep7LgiGn
qShPr7h3Mfgpd0plJbeV5rRVttzF7vv8CoihMGP/uEoHvEKVtHIKoAry99OYRYVc
WjYZezcHR6ivM2KKiJNUf3XhP6hrKA==
=aJar
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
