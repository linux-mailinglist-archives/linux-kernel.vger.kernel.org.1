Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04ED2E7EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgLaINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 03:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 03:13:24 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEDC061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 00:12:44 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id 75so16776957ilv.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t3sCvs+FLAqfEmFOY3gSWy3C5FD079L2BEMz5q0+2bY=;
        b=OkZtmlJLPwpYGEBhlMTlxC1UNnPNxBb2enYNiFsvCETew052T/SM529w00lcZ0fkU5
         DxiAtfdG8AYnhPcUYDCLhQw30Pb+ngkdcM6cwNWgNn8pByZaN2K3aSG2A9pRE/bJ8/z8
         5qv7tFwZyFVcLOVEXFxINtfell5leVzCMDegQwV63WYi8gfCDuh/Cp1qG/tCa/z+FSwh
         BK5joIczA34jFH5vo97p8k0BzClO9gA1LZSYgRuBJDRZJkkPar5IE905+skQb43AJvoA
         7Etsuhic3bu54GcaoTvgKEG6C8epT7F+fos6MZ/LRuETJImDYOBGc0QFIkj2G4G2FRz5
         3WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3sCvs+FLAqfEmFOY3gSWy3C5FD079L2BEMz5q0+2bY=;
        b=Rg2mBEF5GzM8KOI+UYM7Jck8sVt4O8zfesHqcYTQe3Yua7aOxlOYbNZYb27/60mecW
         xVXbGqEX/7hafUT3JLtzregHsIJssdlNqgDRnyWqE8y0q4RpcCoTDKLA3syIVApNH3mr
         64H43l4jaouFhFilxzAtBcf2yQmrvGCOgSpmZDcjRd0O+Bg5HeFlQK0m/RFbdXq3PauD
         MvFsq3DUzULe+Zucdiknqc6PbHeC/m97UWX9d8Jxj5wJAFfKrDZW8q4kX1oG74HVza1n
         0aJ7vK7oCNcCG0aQ0BH56v/oWlbAZDYA6RkJ1kjLxvN+curJVIQMwRHNa3z6vW5Lg1+W
         0CiQ==
X-Gm-Message-State: AOAM5316wGpMRcl9tTXXjvRi8UBbIbsNeh+lq+kHYCE6x/N5HAKwHzWU
        VFp+IfCSzIPdY3o/agmbVTE=
X-Google-Smtp-Source: ABdhPJzulMTF8nMMBl5A1e/hD/tt98OHBQ06c26gifLgedLyKNUPLiTG4n2V5ZcJIbzuF8Inj5bFxA==
X-Received: by 2002:a92:8404:: with SMTP id l4mr54964892ild.49.1609402363602;
        Thu, 31 Dec 2020 00:12:43 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r10sm32437881ilo.34.2020.12.31.00.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 00:12:42 -0800 (PST)
Date:   Thu, 31 Dec 2020 01:12:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: fsl: fix -Wmaybe-uninitialized warning
Message-ID: <20201231081240.GB1970946@ubuntu-m3-large-x86>
References: <20201230154443.656997-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230154443.656997-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:44:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang points out a code path that returns an undefined value
> in an error case:
> 
> sound/soc/fsl/imx-hdmi.c:165:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsom
> etimes-uninitialized]
>         if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/fsl/imx-hdmi.c:212:9: note: uninitialized use occurs here
>         return ret;
> 
> The driver returns -EINVAL for other broken DT properties, so do
> it the same way here.
> 
> Fixes: 6a5f850aa83a ("ASoC: fsl: Add imx-hdmi machine driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  sound/soc/fsl/imx-hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
> index 2c2a76a71940..ede4a9ad1054 100644
> --- a/sound/soc/fsl/imx-hdmi.c
> +++ b/sound/soc/fsl/imx-hdmi.c
> @@ -164,6 +164,7 @@ static int imx_hdmi_probe(struct platform_device *pdev)
>  
>  	if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
>  		dev_err(&pdev->dev, "Invalid HDMI DAI link\n");
> +		ret = -EINVAL;
>  		goto fail;
>  	}
>  
> -- 
> 2.29.2
> 
