Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D152F392F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392249AbhALSsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbhALSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:48:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB067C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:47:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c132so2025903pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hdo2CjRwL8l2YWwyDwjd6+MgVOQ7mgZAA3i8urJGhbs=;
        b=M7by6JufEKLMDzLaTd9vXvZ011hDGrFfmfhsiu43IfW2HxVOGStBIW9F3E88Xh9/qy
         vzmBj60x2fAxPecxBgOFK94HGWsTVNFT4gNJ12v78cdQIx5sUgnjlh7EhKNlBHhfnfk2
         ADrrAYQwMEwi6Koach7FWR1kahAyBHEbnUttN2ME24++f+NPeIvuq5UwdkqJ10N4U/Yo
         nG7TLaoCZ00uuoEYZ4fPjty3zZuahaNHrpvQSxq/ArnxdMkI5PqStFwk9EFXOJ26/Ffb
         A6HaClwNU2keIsV0oLyUAasROLqWA9HqNo2UrdH71w35DvtxXsc/5874wATh99EjT5j1
         nUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hdo2CjRwL8l2YWwyDwjd6+MgVOQ7mgZAA3i8urJGhbs=;
        b=WOHe3bpCBqZAdW4lBT1Rok65FFHcqGnNaKaJUxePbhUlmGM9gmSGZRERTeny2FWx4V
         +sh560aKf1Hh7Zk+amW1daQ3akm6TwZdKgZX5+vgxa2cWSoA7T6JGFaqOD4L9yMy/6wx
         KzUrtFWq0iRuCfvEGE6cuSOVVY0/gIv1iXBQuehgUreIq5HqSw+lmzKaWDemMAY/Afpt
         JvLJtylMGNmDXLa4656FQNwkVATToYezi1Y6cbufq6LRysOOE5rkbG2MUha/cQMKPqya
         4D4wpX9PDMztaUkWtvocbnqfJk3I+R3uL2G6XrO7gvKRMpvPdzssPvCBLCMq90hQcwHl
         2SVg==
X-Gm-Message-State: AOAM532iqZ0FFn0xvgHJAyvV2XDQTSi0vDpo8ltwLXeyCH2MqXKNKe7N
        I4oQEjpLNwTUjjw2+tO6kijl8g==
X-Google-Smtp-Source: ABdhPJx3WV1fspkF5IuWOsxX9UJmiyz/NBcYcrWSuy8EAXWCwzWIutcGrOHywQxiPAJQNi5fPb/lgQ==
X-Received: by 2002:a63:e:: with SMTP id 14mr410657pga.426.1610477241277;
        Tue, 12 Jan 2021 10:47:21 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 32sm4498081pgq.80.2021.01.12.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 10:47:20 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:47:18 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com
Subject: Re: [PATCH V6 05/10] remoteproc: imx_rproc: correct err message
Message-ID: <20210112184718.GB186830@xps15>
References: <1610444359-1857-1-git-send-email-peng.fan@nxp.com>
 <1610444359-1857-6-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610444359-1857-6-git-send-email-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 05:39:14PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It is using devm_ioremap, so not devm_ioremap_resource. Correct
> the error message and print out sa/size.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

That was a finger problem on my side, no need to add my RB twice.

> ---
>  drivers/remoteproc/imx_rproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
