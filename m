Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B9D290FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437052AbgJQGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411778AbgJQGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0262C0613AE;
        Fri, 16 Oct 2020 18:31:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so2466370pfa.10;
        Fri, 16 Oct 2020 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ZC06D0iTTUO33G/T+lGdFmHtlewUgM9PFYLzb4iwrw=;
        b=Xwl7fTXakw+Id+GamJRignbC3wIuvgG4DCZ5BdtMm3nt5spLmoBywf2pjwTIYCZwB9
         Q6wf6g5wn9q//ujl3fgP8S0Y/j77hmpsX4GHZCbSCVX1d7OhJIgCHmqjV96PzfA4FgGE
         RMaNFr/6rdNbBIomEVktNvrwhioUCH5x5IAs6/56kx5FdqYpIOnxG09rYttZVJYXsEsQ
         0IgfprM38tLVQj526n5jQCshEC4qbYe0sPbqjUfwAom+5J5aRThUgOE5WmCCvuXs115m
         Ob2l1rJNAIAQht+Nml/KSb/0QuBX5n27I52MgWgIlbZvoX3v5EATNoXn/UzMsP8KP4nk
         QEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ZC06D0iTTUO33G/T+lGdFmHtlewUgM9PFYLzb4iwrw=;
        b=bl985f/ChhqeRsYTuDLUIgmSrIpkJd/UzNm+OGXaDupLD0s+ZwTHyCsIV1Q2B9satg
         qpyu4i9Pgxy2mM2De0Ql3+Ym0sM0R0yYaubJqzFtYssfS5IX5ztnG5mb9frJFFauQ6jZ
         UDJ50ngreQdcLMTvyvf9JCttSRjbbAJ4Rvp6YqE2DTiPJAv7I79ubv9sh+BgjdzNU8Fu
         DQS2Zw6UTU4vvh56IBfAmFO3WzUfcf8wQ4/un2In9QvAUMqJ8aDzK0VKQx7/o/rPxeg4
         Pk7bNgMOIQrWcfzN2Pi8SYTj1Cj4XwNFzlGTPoD7FSrs9Hham4IXO0NIWcURvUmNMTIR
         qifg==
X-Gm-Message-State: AOAM531ZTub+4HDuiAKSezdthk1x9rpqFjtS3JGWF3cLI5vJD1tMSfLh
        Zg12UV/7FK/hFfRjqykHXIM=
X-Google-Smtp-Source: ABdhPJy9Sq3Gb2gNQVBxCZsnLTyNuwhLGfjeZ3YDfcSBoV/3Kocl9r/EvT9sZigEX7aCkakAlBPdNw==
X-Received: by 2002:a63:3e41:: with SMTP id l62mr5514054pga.419.1602898315175;
        Fri, 16 Oct 2020 18:31:55 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 194sm3958054pfz.182.2020.10.16.18.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Oct 2020 18:31:54 -0700 (PDT)
Date:   Fri, 16 Oct 2020 18:23:26 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_spdif: Add support for i.MX8QM platform
Message-ID: <20201017012325.GB7203@Asurada-Nvidia>
References: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
 <1602739728-4433-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602739728-4433-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 01:28:48PM +0800, Shengjiu Wang wrote:
> On i.MX8QM, there are separate interrupts for TX and RX.
> 
> As the EDMA can't be configured to swing back to first FIFO
> after writing the second FIFO, so we need to force the burst
> size to be 2 on i.MX8QM. And EDMA don't support to shift
> the data from S24_LE to S16_LE, so the supported TX format
> is also different on i.MX8QM.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

One small nit, yet I am okay if you don't resend. So:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

>  /* Check if clk is a root clock that does not share clock source with others */
> @@ -1283,6 +1313,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  	/* Initialize this copy of the CPU DAI driver structure */
>  	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
>  	spdif_priv->cpu_dai_drv.name = dev_name(&pdev->dev);
> +	spdif_priv->cpu_dai_drv.playback.formats =
> +				spdif_priv->soc->tx_formats;

Kernel no longer has strict 80-character limit now, and it seems
to fits 80 characters?
