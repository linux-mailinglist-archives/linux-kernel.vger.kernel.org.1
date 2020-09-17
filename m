Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FEA26DD58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgIQN66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgIQNzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:55:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C3121582;
        Thu, 17 Sep 2020 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600350836;
        bh=567iHiAWyDp59eFqXBlSZ8neDwsGf0EzI2aQ/7XzLV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vwu5yG/tAflmeRVU4EIqOy+F2BFwqoi+8IEq1XlAtXHvXk9xEtf7dXFo9/LZWJchF
         xMhgpAfJSsBKYS5wtYDAimNipKBseUZ6JJMiOEqfg2CqHVyRTQf4g/M6dgyFKO1kzG
         lvHDP5TiMBV5wGMsMxb9/j98aew4DjSjNuinmLzQ=
Date:   Thu, 17 Sep 2020 14:53:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver
Message-ID: <20200917135306.GF4755@sirena.org.uk>
References: <1600247876-8013-1-git-send-email-viorel.suman@oss.nxp.com>
 <1600247876-8013-2-git-send-email-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <1600247876-8013-2-git-send-email-viorel.suman@oss.nxp.com>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2020 at 12:17:55PM +0300, Viorel Suman (OSS) wrote:

This looks mostly good, a few smallish things below but nothing major.

> +static int fsl_xcvr_load_firmware(struct fsl_xcvr *xcvr)
> +{
> +	struct device *dev = &xcvr->pdev->dev;
> +	const struct firmware *fw;
> +	int ret = 0, rem, off, out, page = 0, size = FSL_XCVR_REG_OFFSET;
> +	u32 mask, val;
> +
> +	ret = request_firmware(&fw, xcvr->fw_name, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request firmware.\n");
> +		return ret;
> +	}
> +
> +	rem = fw->size;

It would be good to see some explicit validation of the image size, at
least printing an error message if the image is bigger than can be
loaded.  The code should be safe in that it won't overflow the device
region it's writing to but it feels like it'd be better to tell people
if we spot a problem rather than just silently truncating the file.

> +	/* RAM is 20KiB => max 10 pages 2KiB each */
> +	for (page = 0; page < 10; page++) {
> +		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTRL,
> +					 FSL_XCVR_EXT_CTRL_PAGE_MASK,
> +					 FSL_XCVR_EXT_CTRL_PAGE(page));

regmap does have paging support, though given that this is currently the
only place where paging is used this probably doesn't matter too much.

> +static irqreturn_t irq0_isr(int irq, void *devid)
> +{
> +	struct fsl_xcvr *xcvr = (struct fsl_xcvr *)devid;
> +	struct device *dev = &xcvr->pdev->dev;
> +	struct regmap *regmap = xcvr->regmap;
> +	void __iomem *reg_ctrl, *reg_buff;
> +	u32 isr, val, i;
> +
> +	regmap_read(regmap, FSL_XCVR_EXT_ISR, &isr);
> +	regmap_write(regmap, FSL_XCVR_EXT_ISR_CLR, isr);

This will unconditionally clear any interrupts, even those we don't
understand - it might be better to only clear bits that are supported so
the IRQ core can complain if there's something unexpected showing up.

> +	if (isr & FSL_XCVR_IRQ_FIFO_UOFL_ERR)
> +		dev_dbg(dev, "RX/TX FIFO full/empty\n");

Should this be dev_err()?

> +static irqreturn_t irq1_isr(int irq, void *devid)
> +{
> +	struct fsl_xcvr *xcvr = (struct fsl_xcvr *)devid;
> +	struct device *dev = &xcvr->pdev->dev;
> +
> +	dev_dbg(dev, "irq[1]: %d\n", irq);
> +
> +	return IRQ_HANDLED;
> +}

Is there any value in even requesting this and irq2 given the lack of
meaningful handling?

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jakEACgkQJNaLcl1U
h9AOQwf8C2EY+mr/CBR/vucNQj6SnLjTIsUA05x+jItQcyz0JDy2n4lqlPS8RD0b
IbnHx6/L4jBlMMq5IjtDQXLxNX6WeYW6LtMiuWqnWXsB58c9iXZik7MjpZHJ6YcD
rbPPo2PJzuSfo5lsq+AhbomjE1pA+D1svb08dBdNmHzFEtLfdAhf3gqWNGbDYym7
SDoSP88YDa4aX+ZPXx6lhmObJslBveq6Sh4Ue/cIFM82PH733ksR5CQlFTFNcWXm
63cnKl6dC5eq+aJATsV2rKGOQXosb1lVCLwl+nadXle+sUqGl/IR8Il3fGUVTWMR
pVSVqMvsDNIWAiBmP8CbHysZBj3k4A==
=5N/w
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
