Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850F32F20EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbhAKUgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbhAKUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:36:09 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7216C0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:35:28 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id i5so437012pgo.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=htaXQZSG0QXBfUKmA/4BqSl5HPobFjCxlJW4yk2E5ns=;
        b=yVqF7D9PXxJAUy23VKH2SpkjDpvitkAQ1NY3aYG76avArTGssg+rOGCA4fXn6QHxm0
         1DvfF8tEu1vx7/KPfPvmcId0e5K2doyNffVelPnul5R8nIacp6+/JXhhSDFDz2w7uhDa
         mekTvarZZW9rLcOsiwEZY6Ec92/scs2ym/GaUG7LZDsM3klU6ip/+fsZ81mURynYbnfm
         23WTHIQ3tEy7pRMiTGck3Iim+i1zRncYgtWcFlQ0u6m0/4NBffSa1ZKAeXKVsXiguDrm
         d5qG+oqQCiJNuLa58kKocYk2Ewo4zCMCfhXmnQTS5FIyVsD6fqy0VdrIm/FjYmyWEb6D
         Q5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=htaXQZSG0QXBfUKmA/4BqSl5HPobFjCxlJW4yk2E5ns=;
        b=XlUpHUrsshlDCTGBB8wRe6nfAGb7RoD6VHQxRu1mpv44c1guFUCvnhzhY9mGcOXt85
         wKExbk7n7PTq8pP7mZFeA32qa8TWOvJDboODcWmGxGQklCKBTGRQrZyI6lYmGLw469a7
         j8pXsZImb4Ov5xyWuywl3ZvvXAPOvqa6Z2Lf7EV0GgLS28bvSnWIBWC17s8DCxBRsTwQ
         BNy+QFul3Pgj8rn+ZqjZbI/bL7rGjJp08DVHFBljTvDkiQFSHJXFJMu/msSZLjWVa/+Y
         C2bBgqAMnT0m3jScRaAMLYMr1YhSsZUPGCZ3Kn4Pwt8Kn/iyOZTG7axu+oQUQC1SdorL
         FexQ==
X-Gm-Message-State: AOAM533nyHTJaa0YKqhjCGNzztN75JZgSYyZ8bstC7peUeYiI026Ih0d
        fhIchGZOzy4EcYIK6sHE67CE6g==
X-Google-Smtp-Source: ABdhPJyDzUPDWrOXZop7ttJxWaDIJwqu/yOCE8pdt99yLt+u0R1+06rNosUhfC7KvCFTWf1cDG7Dcw==
X-Received: by 2002:a63:4746:: with SMTP id w6mr1201346pgk.377.1610397328503;
        Mon, 11 Jan 2021 12:35:28 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b10sm611038pgh.15.2021.01.11.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:35:27 -0800 (PST)
Date:   Mon, 11 Jan 2021 13:35:25 -0700
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
Message-ID: <20210111203525.GF144935@xps15>
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
