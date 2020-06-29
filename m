Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088A120DBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbgF2UI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732968AbgF2UIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:08:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F31C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:08:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so8341531pfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dk9Y/T99sdQ3PfvJ9tzS88PlXk+29r6HaUnDmfo2AIs=;
        b=YJBNPwOj22wBFdvzais+fblphrAroRFtJc3OzQ8RRLvsojoV0C3WM/buNqASfskOyT
         zIA4r/pM0/v3TRqNNZxBpcOJGSD29gOelOc2e9T2RgAxFq53QEMhIdN7zA/nBhWS+qmm
         Y8jRoreByc494Td0CMc5wZbjcCS87hohVxhtz7jj6Ix58a1hsPo6sl3iYvyX9dbReAa9
         GDz4K05C9Dmut4rRqMPkKNiBr6X2XbdHSOnGE6PyNHPDAZA/Ck3K6jAQVo/GgatdQdQ4
         L5D2QyfKR42ohh4zzhShlTZSmIgwd7VHZLY0uwIU2hNP0T3rbqObAKV+bA5s46B8iGbO
         OuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dk9Y/T99sdQ3PfvJ9tzS88PlXk+29r6HaUnDmfo2AIs=;
        b=bh6BLFq9Dcmy9m6MNJ5O25XXecoNp1onvhK90CfTL3Ay0NelnRSuMbiQFgZr7M2dE+
         iqLP/0RXlQGqHPspH0XPJ2sHddu4Nqr8bkoYEy7ZuIktzj1clfCruamJDsmvHZVV+Xeh
         ssJms78zX4f9AM35AHI48WPBTx1GTMl9jOlWI+nVh72w5SgBuum7eGttCwb65BxRXkgl
         +mVYHo/I32Esm6hUB5jx6B7iSCxej7Dy1JDpQpkqwO/tBbrwIcw18FBy55OfxCgScGqA
         wQsCfUf7WO2D8snBli3BU+e5ryaaP1zzrtD98sVfMuD/TESzh53P26qNuPLBie/BzDIb
         ujNg==
X-Gm-Message-State: AOAM532oe/Zuv6v4BU2RFD2Xgyyjhb/5q87j2he9TzcvitWZKlmTbtYH
        qL+4IEx+9R/VVSxLMszL9VMj1yJzlrY=
X-Google-Smtp-Source: ABdhPJw9k+cyjMxkvZCZ4AoSCBXsw6VLdn1xIUlzJKIwRHnIfMovFVz5gBkCQyh6fguu6A9iRlF4Gg==
X-Received: by 2002:aa7:9906:: with SMTP id z6mr16229603pff.60.1593461326205;
        Mon, 29 Jun 2020 13:08:46 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 137sm534234pgg.72.2020.06.29.13.08.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 13:08:46 -0700 (PDT)
Date:   Mon, 29 Jun 2020 13:08:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: Add an option to select internal ratio
 mode
Message-ID: <20200629200813.GB27967@Asurada-Nvidia>
References: <1593439115-19282-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593439115-19282-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:58:35PM +0800, Shengjiu Wang wrote:
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.
> 
> For internal rato mode, the rate of clock source should be divided
> with no remainder by sample rate, otherwise there is sound
> distortion.
> 
> Add function fsl_asrc_select_clk() to find proper clock source for
> internal ratio mode, if the clock source is available then internal
> ratio mode will be selected.
> 
> With change, the ideal ratio mode is not the only option for user.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

> +static int fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
> +			       struct fsl_asrc_pair *pair,
> +			       int in_rate,
> +			       int out_rate)
> +{
> +	struct fsl_asrc_pair_priv *pair_priv = pair->private;
> +	struct asrc_config *config = pair_priv->config;
> +	int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
> +	int clk_rate, clk_index;
> +	int i = 0, j = 0;
> +	bool clk_sel[2];
> +
> +	rate[0] = in_rate;
> +	rate[1] = out_rate;
> +
> +	/* Select proper clock source for internal ratio mode */
> +	for (j = 0; j < 2; j++) {
> +		for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
> +			clk_index = asrc_priv->clk_map[j][i];
> +			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);

+			/* Only match a perfect clock source with no remainder */

> +			if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> +			    (clk_rate % rate[j]) == 0)
> +				break;
> +		}
> +
> +		if (i == ASRC_CLK_MAP_LEN) {
> +			select_clk[j] = OUTCLK_ASRCK1_CLK;
> +			clk_sel[j] = false;
> +		} else {
> +			select_clk[j] = i;
> +			clk_sel[j] = true;
> +		}
> +	}
> +
> +	/* Switch to ideal ratio mode if there is no proper clock source */
> +	if (!clk_sel[IN] || !clk_sel[OUT])
> +		select_clk[IN] = INCLK_NONE;

Could get rid of clk_set:

	for (j) {
		for (i) {
			if (match)
				break;
		}

		clk[j] = i;
	}

	if (clk[IN] == ASRC_CLK_MAP_LEN || clk[OUT] == ASRC_CLK_MAP_LEN)

And it only overrides clk[IN] setting but leaving clk[OUT] to
to the searching result. This means that clk[OUT] may be using
a clock source other than OUTCLK_ASRCK1_CLK if sel[IN] happens
to be false while sel[OUT] happens to be true. Not sure if it
is intended...but I feel it would probably be safer to use the
previous settings: INCLK_NONE + OUTCLK_ASRCK1_CLK?
