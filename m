Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC452E0369
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgLVA10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLVA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:27:24 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0CCC061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:26:44 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id d203so13143659oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CZlWxDu0IGcpbm5IJlrVcGywiVsBKMfEDTAOQYhNOLk=;
        b=QCrzxkUIKUnVtc5CraxckDbuKVj9GmBKTf3rz+Ot0kcu5FWSMmUbPhJbuLiK86DKIw
         9qlRcShYAPMfpDJK+ICq1Dl0qaPwksIVAySKG/CcILk5MbTcSOF6YRpCekiQLlfLjJxL
         Ku9GncLABOtQNHmHvlAKhvhmXeLUGFU4vxjmAYnTAopWzYOVL1blLYgqEGgVT7pMMrAb
         b3hPF1l3lxkxYDk+HtxhPFNruAxYzaKdO21C26+5AxCEO4mwHBruIaTsBzsbC9vgTC2m
         u87fjfSYehD8XOvCoy1i6o5zyGXnY2SSJGHFebiuty7wMpgmG9im4Fc209ForSQwFtXa
         A6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CZlWxDu0IGcpbm5IJlrVcGywiVsBKMfEDTAOQYhNOLk=;
        b=ZmQXKGDNWJVYT7Camypueh+g5x8aYZ5dBMQdI+/dG4hHsAn5iT5ysbXQL0Lmka7Dg9
         qFtqcY0lNxPBX1IvYbN9x2m0i4iHBtkrGhHVYYRrFM2h7ejmNtLuZfmiegSUUW8hQP1O
         hLSM8/SuS7qnVoXsjzH2Wm0N/9PBCitIQKF2ZBitYGSO3ghXFnK3QkhUwkkRbWBbxEDM
         GEul+IxBg5dUDE7DkNFyHRapD1ik1a2+FxDkfxpFCEO5JTHXmeyCW85MsAouroJqScq5
         tydgpSSsbRNXeKH1PRgtOdxmFz1AAMT/NwCtOcUjxGIAcddH5slMkAOKVdOw3acRTi9+
         Gv0A==
X-Gm-Message-State: AOAM530OleFi/OFgxBoPxBlJtaBuwWQ70JwdwNheUtIH+GdCDbFvR9jJ
        0QDEt58/+yQy1I7eijESxt4v5Q==
X-Google-Smtp-Source: ABdhPJzLmchhEzmN14SJse+/UNka4tEcHY3ZrGiBwD5TZF7SjSdcJ69v46VQd/UbAH8zqnq9PBYZwA==
X-Received: by 2002:aca:3b03:: with SMTP id i3mr12694199oia.170.1608596803929;
        Mon, 21 Dec 2020 16:26:43 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 11sm4136721oty.65.2020.12.21.16.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:26:43 -0800 (PST)
Date:   Mon, 21 Dec 2020 18:26:41 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/8] remoteproc: imx_rproc: correct err message
Message-ID: <X+E9QfqsMQEFkIPE@builder.lan>
References: <20201221100632.7197-1-peng.fan@oss.nxp.com>
 <20201221100632.7197-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221100632.7197-4-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Dec 04:06 CST 2020, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> It is using devm_ioremap, so not devm_ioremap_resource. Correct
> the error message and print out sa/size.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V4:
>  Drop the R-b tag
>  Follow Bjorn's comments, correct/update the err msg.
> 
>  drivers/remoteproc/imx_rproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 6603e00bb6f4..fab772b02c9f 100644
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
