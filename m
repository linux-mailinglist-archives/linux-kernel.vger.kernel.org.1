Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91A32CF7F9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgLEA05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgLEA05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:26:57 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DDDC061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:26:10 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s75so5155002oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qOGIn6XgIjkM7jRRGqXrjtA4GUnaVDyVp5HpjIpLBeQ=;
        b=cspoud3vzZ21kG9yq7HVX14L34/4y0sCDfxSomzTpfqz0uDLEsUBY4YOMDCtRRp3N1
         r9KOpbpiILwKjd20qFbK08ymxr6RU6Ea8Q03AKwhoMUx2kvlXTzhjef9rAaJJDgOEKZ1
         l8+ZMS9f3WNriFCGFf4IXG/jbu1dCWHK3v2UIlxEgyLB4F0ipahdJ9HP0opCJOhQeMFq
         qa2Hftj8LuD6/9usXLXcL6Ee97bv3EzSQovbj9KI1QvlJ4A35CSxbh6/+zlivadP/9cs
         vCN8V1kK9zEY84k/+klNF6uQ47Nd8op5S1fGFbjW4wDB/Hp8LcTNqz7ODiqb6Wnm/emt
         XR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qOGIn6XgIjkM7jRRGqXrjtA4GUnaVDyVp5HpjIpLBeQ=;
        b=e13TnzXBzSm5r1xSZJ+78tfr+7nAI6pX+DWGJh+fk3EsQ8DSqUqJpCD9Nci5z6TtXZ
         4YKz5vHSRjnDXVi6eLoBwdHGoBFvkfgWFo5clDfzsILSrXKqGvx5QislR0IGkcAIvhoD
         sXxEqh4tr6waKKgj2TRQSUn4gSjU8W9Y7XXTaB8Zu7kF4aVAD6FRl16TBHEDfOCIs2e7
         7J/cbGyZ8SLJa9Py1SqyjBo6LJnjkZG9/k0WgVEu9okk+6QLlv5LzNJl2nXJKPZznDI9
         M38jvnmoW4Da6WEEOlyckOqCAfF0PJ807EUw4yBw1cB25mIYY+JCpR18sm2Pqg34uGSA
         gPGg==
X-Gm-Message-State: AOAM530iazjm2aJeFQ+Br6hsf8wVPL6VnX2VjeV23WFSyyTYuCoseEs0
        M9PQ4cci09LfqAm95WTZo8vk3Q==
X-Google-Smtp-Source: ABdhPJyMefuSvFZG9IsAQncafN3zL56HOZm/awMd79vg1THW6ginWeewzZoZQ/jHvS9NBMwc5lpq9A==
X-Received: by 2002:aca:f089:: with SMTP id o131mr5098170oih.88.1607127970239;
        Fri, 04 Dec 2020 16:26:10 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r7sm1018595oih.21.2020.12.04.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 16:26:09 -0800 (PST)
Date:   Fri, 4 Dec 2020 18:26:07 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH V3 3/7] remoteproc: imx_rproc: correct err message
Message-ID: <X8rTnx/lQIxcuEXf@builder.lan>
References: <20201204074036.23870-1-peng.fan@oss.nxp.com>
 <20201204074036.23870-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204074036.23870-4-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Dec 01:40 CST 2020, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> It is using devm_ioremap, so not devm_ioremap_resource. Correct
> the error message and print out sa/size.
> 
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index d1abb253b499..aa5fbd0c7768 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -270,7 +270,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev,
>  						     att->sa, att->size);
>  		if (!priv->mem[b].cpu_addr) {
> -			dev_err(dev, "devm_ioremap_resource failed\n");
> +			dev_err(dev, "devm_ioremap failed\n");

I would prefer if this was expanded to a proper sentence, and I really
like the second part of the commit message to be included in the change.
So something like:

			dev_err(dev, "failed to remap %#x bytes from %#x\n",
				att->size, att->sa);


And similarly below if mapping a memory-region fails.

Thanks,
Bjorn

>  			return -ENOMEM;
>  		}
>  		priv->mem[b].sys_addr = att->sa;
> -- 
> 2.28.0
> 
