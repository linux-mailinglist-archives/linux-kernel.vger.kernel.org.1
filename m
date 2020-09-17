Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94E26D46F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgIQHR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:17:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3CFC06174A;
        Thu, 17 Sep 2020 00:17:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so666661pld.0;
        Thu, 17 Sep 2020 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=elJEb2l35w0tALnlBgQjk/9l2iBwh6a2tE1YVDZoSvk=;
        b=kfSDwjK/583sxlPWBU4K30L6qY5yFOHg4TaP/g2kKTHVrbUMxPsSo3cr0oNyd9kK/I
         n6Vsy1v7d/rgMZQrlIWuK1z3+RZOa/gSSCG7sYeMKhkJT2JQvSzqbc2e3raCr0dOVN39
         XKMDGl9vfQOTodpBHV1eD8EgozdndmaBbqOAdPaW/2wFZ/f37Bo0XjiDqxgvhN8ddvjp
         KfHvl91euVMXY62y1FCqAbvCidWS9MdrG3Y6DHzHbR8EOFMHVg964SXT9ELd/KN5nttG
         mHb47XyEK+kpFNYeCiT/8Q1sRDO+I1EIjMyYurStOuDBW3epttxcwxSpXCDTkUJOH4lp
         mVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=elJEb2l35w0tALnlBgQjk/9l2iBwh6a2tE1YVDZoSvk=;
        b=MsQM1ydfcDk4sdIw6pUVRNs03DmDhpCVWeVHt7x+L4CeA01t49rMScyeao4gemMGdK
         +cf7iIHut4IHaghcUj7Aapu7Q8bNgbAXqlmblHUeqiBK+jjmNyJpOB9+Qbdt8X1Rik4g
         tAsjCu/QDCs8EwqxXefDuR2YA51wIkDWXxwhkAym02xXY+2dzWYXjUrDzI2lCt32XFJW
         3JhGY1TpqFYIFr4Pmos3hjWCtbyFtgUtZy3L2sgwWeBQWt5TTyk30cUugJ1MPXQgxJxD
         jKWaseloGQJhyIzRAtORk+DOQn8d+9z3CtWQR0pxH1JPmqC2n0z//QY9Sksjd9CukIRg
         zfSg==
X-Gm-Message-State: AOAM532aEyRnT74w/Zj1CCpzBJQgH3Rw0YA5N/Vi0mwSXnqBe4NVBV/N
        DBEgo6QyU8KPsCsm81AR1Mg=
X-Google-Smtp-Source: ABdhPJyA7geCwMU1Brnj82CuOczTA8QY77ieRbYd6gK//+zTtaFvTP+ByLJcIbfYjqJna5Bxk8PXBg==
X-Received: by 2002:a17:90a:6a4e:: with SMTP id d14mr6885754pjm.63.1600327067650;
        Thu, 17 Sep 2020 00:17:47 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 72sm18958272pfx.79.2020.09.17.00.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Sep 2020 00:17:47 -0700 (PDT)
Date:   Thu, 17 Sep 2020 00:14:31 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
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
Message-ID: <20200917071431.GA17970@Asurada-Nvidia>
References: <1600247876-8013-1-git-send-email-viorel.suman@oss.nxp.com>
 <1600247876-8013-2-git-send-email-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600247876-8013-2-git-send-email-viorel.suman@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viorel,

It looks pretty clean to me, though some small comments inline.

On Wed, Sep 16, 2020 at 12:17:55PM +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> XCVR (Audio Transceiver) is a on-chip functional module found
> on i.MX8MP. It support HDMI2.1 eARC, HDMI1.4 ARC and SPDIF.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

> +static const u32 fsl_xcvr_earc_channels[] = { 1, 2, 8, 16, 32, }; /* one bit 6, 12 ? */

What's the meaning of the comments?

> +static const int fsl_xcvr_phy_arc_cfg[] = {
> +	FSL_XCVR_PHY_CTRL_ARC_MODE_SE_EN, FSL_XCVR_PHY_CTRL_ARC_MODE_CM_EN,
> +};

Nit: better be u32 vs. int?

> +/** phy: true => phy, false => pll */
> +static int fsl_xcvr_ai_write(struct fsl_xcvr *xcvr, u8 reg, u32 data, bool phy)
> +{
> +	u32 val, idx, tidx;
> +
> +	idx  = BIT(phy ? 26 : 24);
> +	tidx = BIT(phy ? 27 : 25);
> +
> +	regmap_write(xcvr->regmap, FSL_XCVR_PHY_AI_CTRL_CLR, 0xFF);
> +	regmap_write(xcvr->regmap, FSL_XCVR_PHY_AI_CTRL_SET, reg);
> +	regmap_write(xcvr->regmap, FSL_XCVR_PHY_AI_WDATA, data);
> +	regmap_write(xcvr->regmap, FSL_XCVR_PHY_AI_CTRL_TOG, idx);
> +
> +	do {
> +		regmap_read(xcvr->regmap, FSL_XCVR_PHY_AI_CTRL, &val);
> +	} while ((val & idx) != ((val & tidx) >> 1));

Might regmap_read_poll_timeout() be better? And it seems to poll
intentionally with no sleep nor timeout -- would be nice to have
a line of comments to explain why.

> > +static int fsl_xcvr_runtime_resume(struct device *dev)
> +{
> +	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(xcvr->ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to start IPG clock.\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(xcvr->pll_ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to start PLL IPG clock.\n");

Should it disable ipg_clk?

> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(xcvr->phy_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to start PHY clock: %d\n", ret);
> +		clk_disable_unprepare(xcvr->ipg_clk);

Should it disable pll_ipg_clk?

> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(xcvr->spba_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to start SPBA clock.\n");
> +		clk_disable_unprepare(xcvr->phy_clk);
> +		clk_disable_unprepare(xcvr->ipg_clk);

Ditto

> +		return ret;
> +	}
> +
> +	regcache_cache_only(xcvr->regmap, false);
> +	regcache_mark_dirty(xcvr->regmap);
> +	ret = regcache_sync(xcvr->regmap);
> +
> +	if (ret) {
> +		dev_err(dev, "failed to sync regcache.\n");
> +		return ret;

What about those clocks? Probably better to have some error-out
labels at the end of the function?

> +	}
> +
> +	reset_control_assert(xcvr->reset);
> +	reset_control_deassert(xcvr->reset);
> +
> +	ret = fsl_xcvr_load_firmware(xcvr);
> +	if (ret) {
> +		dev_err(dev, "failed to load firmware.\n");
> +		return ret;

Ditto

> +	}
> +
> +	/* Release M0+ reset */
> +	ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTRL,
> +				 FSL_XCVR_EXT_CTRL_CORE_RESET, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "M0+ core release failed: %d\n", ret);
> +		return ret;

Ditto

> +	}
> +	mdelay(50);

Any reason to use mdelay over msleep for a 50ms wait? May add a
line of comments if mdelay is a must?
