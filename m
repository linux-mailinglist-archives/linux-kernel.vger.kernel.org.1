Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446752F2110
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391193AbhAKUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391134AbhAKUp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:45:27 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33121C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:44:47 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id i5so451832pgo.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=htaXQZSG0QXBfUKmA/4BqSl5HPobFjCxlJW4yk2E5ns=;
        b=O3N5mg9bdze7Ib2ynKPcRncsWq4DeRqKXai+5tqZT6vC3AXXoCwYrSPHkNTvmet9Iq
         1WFZ43d9O+L1KRgshF4eGm2hf5cpBZgHk7qGEIfG/CXt6BCo+vY6EwTxjCAN+FvqYfuM
         Sxp4IgTW+sJ7kjHDfPTk1AJ8WAg8K1bh0WZkmIHkjYnaWIx6i0aSbmEvZlupHGjFkpJm
         RftTtJJYX1EA4PPw4yim0yhw/Wo4oNe/NSLtFNGDz+g/MGPLPdKfNObrl0XGK1AqP0TS
         ZqKkdtAbmfw58yoMaAVNb0e2H3/eMRig8foXXdm4A1TSiwbm5Q+ZY7DYBu0rGAdVzXUN
         zNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=htaXQZSG0QXBfUKmA/4BqSl5HPobFjCxlJW4yk2E5ns=;
        b=uCBRGwOAnBEI/tF2G6bFhmdIv0JCXccSW+r14qXQcXoULIG/HJLJF8WY0fHUfyR4Rt
         +PKa2CmGemw6uCv2xBXnM6Qsfirr+MxIQ0Gez0w5hEZi0Webhk6d6tPl0IrLeaq1Zt8h
         xw7GjrWLEql6T7kCcDKI6C5EO15QYR2ug1GxJtYp/xa+HaSgYrx79XAJrtasNGMihEXD
         guXqY5tU9IPYSEuB3UpPXdMDP6PzDd9mHra9ekud+3u6VGbUI4jz6/OR3fp3CMdnMyIi
         6JYP3j5YvR2W/K/1ctcavv60ckwRaS1MFbNFxgk5WGNJyMG8EA1FHc9LRl4aQT3Ze/y8
         520Q==
X-Gm-Message-State: AOAM532F7/B7HFGjVYxKycEzF5CN0XotWjOs22VrxA9Y3S1xHRkSjICF
        7m3at9aLbquoDq0PSE7UHTa4og==
X-Google-Smtp-Source: ABdhPJzKPAhhrZdX5YzDSRv6fxW723f9nT86WDJoB9QWXDuU2iIS1gUxmnqTlT9GlzyBHBi4S76Dtg==
X-Received: by 2002:a62:c312:0:b029:1a9:19c7:a8e with SMTP id v18-20020a62c3120000b02901a919c70a8emr1143762pfg.74.1610397886774;
        Mon, 11 Jan 2021 12:44:46 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b13sm499319pfi.162.2021.01.11.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:44:46 -0800 (PST)
Date:   Mon, 11 Jan 2021 13:44:44 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com
Subject: Re: [PATCH V5 3/8] remoteproc: imx_rproc: correct err message
Message-ID: <20210111204444.GG144935@xps15>
References: <20201229033019.25899-1-peng.fan@nxp.com>
 <20201229033019.25899-4-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229033019.25899-4-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:30:14AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It is using devm_ioremap, so not devm_ioremap_resource. Correct
> the error message and print out sa/size.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 6603e00bb6f4..2a093cea4997 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -268,7 +268,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev,
>  						     att->sa, att->size);
>  		if (!priv->mem[b].cpu_addr) {
> -			dev_err(dev, "devm_ioremap_resource failed\n");
> +			dev_err(dev, "failed to remap %#x bytes from %#x\n", att->size, att->sa);
>  			return -ENOMEM;
>  		}
>  		priv->mem[b].sys_addr = att->sa;
> @@ -298,7 +298,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  
>  		priv->mem[b].cpu_addr = devm_ioremap_resource(&pdev->dev, &res);
>  		if (IS_ERR(priv->mem[b].cpu_addr)) {
> -			dev_err(dev, "devm_ioremap_resource failed\n");
> +			dev_err(dev, "failed to remap %pr\n", &res);
>  			err = PTR_ERR(priv->mem[b].cpu_addr);
>  			return err;
>  		}
> -- 
> 2.28.0
> 
