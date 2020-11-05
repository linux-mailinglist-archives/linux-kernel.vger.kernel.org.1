Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A142A750A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbgKEBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEBre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:47:34 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539AC0613CF;
        Wed,  4 Nov 2020 17:47:33 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so57323pfb.10;
        Wed, 04 Nov 2020 17:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OCTxfpsphzxslAOqNQCh/cdk0CoQXDuv6GMoNdJRd5A=;
        b=C3KFKDSkz8PewNH1jl/sP84lpxdqfKrg0VJoTP1+puWG7ySV+gTJkxexOQcONJq9sN
         Ov6tBqvITJXazba66PI2+9AiQBbWk92CPcuz7+OVt+u1DM77atUE+KM7qEfwKuoEh/Pq
         H57luRoyXAlMC8uEH9u3ey10S4uAlnK5rTU3PPiEnLuhwiBi2ggPPrUuA6Nf03bM88mW
         D7iUUAW667Xzea/DmvPtbnxA/KgQ8p6pplYmOwtv+YUUfQMcaq0N/98pi2Dgqlb5rNho
         C0aZjwD1+QDlEvSHqiHsdWdueHDChaBsOmXYmcZLY1pkLm/kmMH8RreeSIYLrV/7OHF2
         GXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OCTxfpsphzxslAOqNQCh/cdk0CoQXDuv6GMoNdJRd5A=;
        b=jrh5LcpRlIBB3xIOUtcasI9tYBd00Zlh8Jz8YquFlOkYG76ANsHTl4N67K7dNcjhQU
         wNuPszmaFsW4xtqKKa6JaIv1fhrjVsrwjbG2SfyIHYD1uKvamxY51i/jUHW7a5HawLTX
         zAPE/Ja5ERraMyZCkkEZG+WJFG/MJwmVvg5rBoBeaPE55SGK2BShWukGIpITM4rn8y6l
         /wlbuk/KWA3mlfa/+uivOK8/1RSD2rrDJqoGCiRGGiPeBCNfBq2YUePM/mkv9ckcxPX2
         beATpyrEtdLetZltVgsnTsUQ9E0pMfo1u1wzv49s2JQy8i4r63fK6lue0x2Sk7GydQwQ
         jsGg==
X-Gm-Message-State: AOAM531/g46xbkArb8K/lv64yUMAiNV6qhoJKIMx0BlMf/ylE0cl9vF8
        YAf5ucjddn9hE3C3aNYLbEk=
X-Google-Smtp-Source: ABdhPJzYRJ54bpr7y5aGP5sXGN6tDVE4C64FR/ZVNJa5T6GGER3l/r0hcDTBiMTAovWtsz5k9zEixA==
X-Received: by 2002:a17:90b:1011:: with SMTP id gm17mr346pjb.73.1604540852758;
        Wed, 04 Nov 2020 17:47:32 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b3sm132830pfd.66.2020.11.04.17.47.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 17:47:32 -0800 (PST)
Date:   Wed, 4 Nov 2020 17:35:40 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
Message-ID: <20201105013539.GA16459@Asurada-Nvidia>
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
 <1604281947-26874-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604281947-26874-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:52:27AM +0800, Shengjiu Wang wrote:
> The AUD2HTX is a digital module that provides a bridge between
> the Audio Subsystem and the HDMI RTX Subsystem. This module
> includes intermediate storage to queue SDMA transactions prior
> to being synchronized and passed to the HDMI RTX Subsystem over
> the Audio Link.
> 
> The AUD2HTX contains a DMA request routed to the SDMA module.
> This DMA request is controlled based on the watermark level in
> the 32-entry sample buffer.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Despite some small comments inline.

> +static int fsl_aud2htx_dai_probe(struct snd_soc_dai *cpu_dai)
> +{
> +	struct fsl_aud2htx *aud2htx = dev_get_drvdata(cpu_dai->dev);
> +
> +	/* DMA request when number of entries < WTMK_LOW */
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_DT_MASK, 0);
> +
> +	/* Disable interrupts*/
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_IRQ_MASK,
> +			   AUD2HTX_WM_HIGH_IRQ_MASK |
> +			   AUD2HTX_WM_LOW_IRQ_MASK |
> +			   AUD2HTX_OVF_MASK,
> +			   AUD2HTX_WM_HIGH_IRQ_MASK |
> +			   AUD2HTX_WM_LOW_IRQ_MASK |
> +			   AUD2HTX_OVF_MASK);
> +
> +	/* Configure watermark */
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_WL_MASK,
> +			   AUD2HTX_WTMK_LOW << AUD2HTX_CTRE_WL_SHIFT);
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_WH_MASK,
> +			   AUD2HTX_WTMK_HIGH << AUD2HTX_CTRE_WH_SHIFT);

If there isn't a hard requirement from hardware, feels better to
combine all the writes to AUD2HTX_CTRL_EXT into one single MMIO.

> +static irqreturn_t fsl_aud2htx_isr(int irq, void *dev_id)
> +{
> +	return IRQ_HANDLED;

Empty isr? Perhaps can drop the request_irq() at all?

> +static int fsl_aud2htx_probe(struct platform_device *pdev)
> +{
> +	struct fsl_aud2htx *aud2htx;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret, irq;
> +
> +	aud2htx = devm_kzalloc(&pdev->dev, sizeof(*aud2htx), GFP_KERNEL);
> +	if (!aud2htx)
> +		return -ENOMEM;
> +
> +	aud2htx->pdev = pdev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs)) {
> +		dev_err(&pdev->dev, "failed ioremap\n");
> +		return PTR_ERR(regs);
> +	}
> +
> +	aud2htx->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
> +						&fsl_aud2htx_regmap_config);
> +	if (IS_ERR(aud2htx->regmap)) {
> +		dev_err(&pdev->dev, "failed to init regmap");
> +		return PTR_ERR(aud2htx->regmap);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq for node %s\n",
> +			dev_name(&pdev->dev));

dev_err() already prints dev_name, so not necessary to print again.
