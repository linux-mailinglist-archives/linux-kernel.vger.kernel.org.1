Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3F292CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgJSR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbgJSRYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:24:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A6FC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:24:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b23so358224pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DqfFRCqrVOSLRxnsHHHALVeB4MkQYOkvAR6pk7ZJ5hs=;
        b=iG9L1a5azG8pFVMvirbk0r5UPaFLPHzdlEbiIMlPh5+G+iCGH/YTwYnIscLKYQm1Yj
         lrhRwsYELQDE3bedtjEJH1wgCrKbAkLPNh02lyGCByQgXHDqqiAJ7Dkq6ZX321dK3lN7
         yV3oc12puI3Gre/Cd6v7pSUbfqsTrLdVn1AJZpo/pHZG9QQYhEYF/mJMvGtYUXa8UWYk
         eNfH0GJC6JLBcn/tnATKrBHCVCxRrzNr+mDMsqvq/0FoHgVJIJq/1QBXcaqro0gC41cb
         1+7ieSOMYJ4IBMlcjl43/YQUuE1o3dyLBv+4jybflDTmaagOksgAZhtN8Yyxoxi20fHZ
         5yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqfFRCqrVOSLRxnsHHHALVeB4MkQYOkvAR6pk7ZJ5hs=;
        b=Hp5LuFyb0Cm9ZRG+w861mU+A0Bdz7/Fa1MwIpeXEyy0H6deXILnGNQqpSBqsC0Uz04
         qRUVF3BtnrTM9RLmVJo3zZUEHcfX3xMxkVZsLFBdAmJXhAa5toMhDpS+1PoKm7zAbUUt
         dBPkDIqdJsHWQVhmewAf3hROeTqwq4k2Qgc3aDrbYujlNcIqahfZW84Mpb0PrxumZLJ8
         FB74BpcsaMqOmzsv1ZSAJKf1V00Z4l7XyEPd3bCWhnDszoz3zZBh05RvQ3l6WSUnKvjQ
         WdbqM3VUAkcd/IIdv8uuikz2RIwJGHQzjr1VrI+WU0KiZAR0CaIGcnGhWYMe6zvHVGYP
         w0mw==
X-Gm-Message-State: AOAM531fHAdnpuwCCPR2mHvggKWiv73w6FqdtYrnPqeYy2ZbylBwxG7i
        ULDsRc2Q6PNjN5UWbdD4ABHWoQ==
X-Google-Smtp-Source: ABdhPJyY6NwR7VwUAPGkF7wuxxipgggd0W8n+MrvpHT5KMPGQyoetZI8lpo1g5JwTmnid6uTpowDLw==
X-Received: by 2002:aa7:868f:0:b029:155:dcd2:7320 with SMTP id d15-20020aa7868f0000b0290155dcd27320mr1017779pfo.53.1603128291742;
        Mon, 19 Oct 2020 10:24:51 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e10sm131655pjp.26.2020.10.19.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:24:51 -0700 (PDT)
Date:   Mon, 19 Oct 2020 11:24:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     bjorn.andersson@linaro.org, o.rempel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH V2 4/7] remoteproc: imx_rproc: use devm_ioremap
Message-ID: <20201019172449.GB496175@xps15>
References: <20200927064131.24101-1-peng.fan@nxp.com>
 <20200927064131.24101-5-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927064131.24101-5-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 02:41:28PM +0800, Peng Fan wrote:
> We might need to map an region multiple times, becaue the region might
> be shared between remote processors, such i.MX8QM with dual M4 cores.
> So use devm_ioremap, not devm_ioremap_resource.
> 
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index aa5fbd0c7768..48ce09e857ee 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -298,9 +298,10 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		if (b >= IMX7D_RPROC_MEM_MAX)
>  			break;
>  
> -		priv->mem[b].cpu_addr = devm_ioremap_resource(&pdev->dev, &res);
> +		/* Not use resource version, because we might share region*/

s/"region*"/"region *"

> +		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
>  		if (IS_ERR(priv->mem[b].cpu_addr)) {
> -			dev_err(dev, "devm_ioremap_resource failed\n");
> +			dev_err(dev, "devm_ioremap %pR failed\n", &res);
>  			err = PTR_ERR(priv->mem[b].cpu_addr);
>  			return err;
>  		}
> -- 
> 2.28.0
> 
