Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0212F211A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbhAKUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbhAKUrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:47:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C337EC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:47:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so424719pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0850ujLUfr+Sd4YSpOl+ae9e9f2P4z33sSNVJYhmzJ4=;
        b=VPDJpyC63ZR2U+NpeH3KcOwIOYJ2F1z9dCldBbuMpQqwMqrwLpmInTFrlmFR/qfKIX
         bLx6JtkmwibrAJbjDHssAuKqjihgT3I/GsuoRhQ4L5RcP5lw7LyXi+svMTHJYjaJIPLh
         AAx+c2X5JjcUAc0T2U5H7N9qcb6v6foWerrgnQytDaBpWLo7guAPm/l0dk0YJxGHjrek
         YzCs01T6eDZ7Hrs+yyvin+j14rLd7vTU24o0IjueKeigmfSL9jrLD0jRuTn/G7QbRf78
         niRYqXmDAHyxes61Y0QY26rz2b9TDuknHXYzvORNzfkpGXYnTGqLueu5Pq8Xai7ODrTF
         e+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0850ujLUfr+Sd4YSpOl+ae9e9f2P4z33sSNVJYhmzJ4=;
        b=XpzWA8+Rj+np4mkTjIW7SsfdSd2PGuy+SYhYX5egxUsDDiL6YLMl8y+nPCBQR2/vtw
         QgylkRPJnEuKZRgH1btkRs0W89ZM6RHx/MAFQVk9SNHTPKmjaplM3scoGfQ9SBBrjfmV
         z5D8zpS2J+VeUGnfHWZ+KQQPsOpQyJR/a9xUFrBFwNaWLx/YysJcgX254Vr03hboR2L8
         uWfqrXG/+Tdd0CZbZVuP6K78KflokyKoCbu+3GlSl774fQJsDsj5gV+M/6JbHYKrrTji
         /vt7gCfljp/+D/gsBIMXaNhGzsDgDustbgb7e7CB/KgtQip5PM845HVDfMjKgfVuivlD
         V+ug==
X-Gm-Message-State: AOAM531sA7dQt2OPYq2bltwn1fMyPELOkeq+iDChMnYeWLmOpAaoDMTK
        NilgB7WfqtYi64FrhKWtOmzRcg==
X-Google-Smtp-Source: ABdhPJzuh+bFsDFldPJKqcfzJx+5Ttv5Iz7raUusESoXKN0qXz4dFPkLC91Sn+XQ7UTdODzVkn0p9Q==
X-Received: by 2002:a65:4983:: with SMTP id r3mr1326949pgs.288.1610398022258;
        Mon, 11 Jan 2021 12:47:02 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id mw15sm259868pjb.34.2021.01.11.12.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:47:01 -0800 (PST)
Date:   Mon, 11 Jan 2021 13:46:59 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, agross@kernel.org,
        patrice.chotard@st.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH V5 4/8] remoteproc: imx_rproc: use devm_ioremap
Message-ID: <20210111204659.GH144935@xps15>
References: <20201229033019.25899-1-peng.fan@nxp.com>
 <20201229033019.25899-5-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229033019.25899-5-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:30:15AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> We might need to map an region multiple times, becaue the region might
> be shared between remote processors, such i.MX8QM with dual M4 cores.
> So use devm_ioremap, not devm_ioremap_resource.
> 
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 2a093cea4997..47fc1d06be6a 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -296,7 +296,8 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		if (b >= IMX7D_RPROC_MEM_MAX)
>  			break;
>  
> -		priv->mem[b].cpu_addr = devm_ioremap_resource(&pdev->dev, &res);
> +		/* Not use resource version, because we might share region */
> +		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
>  		if (IS_ERR(priv->mem[b].cpu_addr)) {
>  			dev_err(dev, "failed to remap %pr\n", &res);
>  			err = PTR_ERR(priv->mem[b].cpu_addr);
> -- 
> 2.28.0
> 
