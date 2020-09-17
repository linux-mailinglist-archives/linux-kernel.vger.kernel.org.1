Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B512726DC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgIQNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgIQNFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:05:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B782083B;
        Thu, 17 Sep 2020 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600347923;
        bh=VWZZoKhUjroNLpll2eU5vjUqNxtnR3wkR+uu5Ss0zr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mi3s2YQgpeZZBpneKJuKUPowYJRNqmmOg9EnsuaQ6g7HwF8jYnhjAbFZq+G1I7ATn
         qMvrjkVDAonhONz4GUA8SHPmq0sMe7Jov1R5tPypU7ue+bWqQFozkiUnzir8+uMs9H
         dLNQL6u2z+vGlf08u1vwiMKYG0Z94iXzUizJeZpM=
Date:   Thu, 17 Sep 2020 14:04:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsl: imx-audmix : Replace seq_printf with seq_puts
Message-ID: <20200917130434.GD4755@sirena.org.uk>
References: <20200916061420.10403-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20200916061420.10403-1-vulab@iscas.ac.cn>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2020 at 06:14:20AM +0000, Xu Wang wrote:

> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".

This looks fine but the subject says it's about seq_puts() not
kcalloc().

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jXuEACgkQJNaLcl1U
h9B3BQf/VarUuMPYus5VLpA+zmE+7JqUAcO3omQ6LMqaF7VBOQhDHlE45z4cWL+z
puS/DV1XmM5bSGn+ZwcwBh6GvfamDg5oyGSTs8OkwMeWxCanjvexEE81RTAvzCgT
qkAdheP90NZtRKHJImUV6KfmiTJXB2nokridUP+vC2L98aZjAYbVFuJ5CMkEuKOk
jOzrE81vM69mIfnFnvcHRv7wH+WZszcgxc/WDTFDfYSQB5mMgBvVDT9mUPRJtjkj
NdND/4RmGRSXcQ5l7iHszGwtUBSAGVVycv45pBPcm1z1Z/XXh0R4M9SbrICmDbZM
g6zIaexA3gXNIUwR2p0czzGdbUD3ww==
=AGo/
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
