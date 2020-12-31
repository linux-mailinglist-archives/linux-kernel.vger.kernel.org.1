Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3482E81E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgLaUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 15:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 15:08:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BEBC061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 12:07:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j1so10405056pld.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LUdKDlLlflhborB/8hVdW+VgkZLtdJkIlQCMkULEfnY=;
        b=q4OSIz/JkJT0Z+P9uVNEenQw9LCMicx+csh5V1YclMspc2ubhEGsY9l8aXWn/1o2D2
         tqsq+6zRnIEQMwGOBhYBOR9pibQi2htQPQreoUST292qXMsKVsAGim3LKXZ9E+zMie7M
         52pwQiP+QDRiqEfB5yLl54UhEeUJ60jgAJwDEmxEkbKliBbXL/avFooqe6pFZMd1QB1x
         f3/SsfSySDPPrUOV8ywWsXStpQTqui22/EZnyTuI7YSk7qzrBY3irhTo5l7yn6rfj/Vz
         GGe2OnNRSe4tThPrYvn4loOQr6sb0xPyFqSteoIbplYoQzmBYtJfo/gJZzG5cX1u/qXP
         c+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUdKDlLlflhborB/8hVdW+VgkZLtdJkIlQCMkULEfnY=;
        b=IkV4WO6q6gzIe071KDLCQHh2W/XuIUQYTS7Q2V56WTLiPs/95bJXIdYgmIxb2DJLvE
         bn3I6oZO/7svqV8m9tZZ5rqebmUSSopseLJcJ5+lKUYPlAuCTrj/t2fpQRs659bSNQ37
         c/raN1gcOgZuPv0pnjxJKsbddB2mE1upG0mzkuX0t3FAe+VDTs03+YJuSQQVbXV/bX72
         +oO5EjzYo7a/1RICqUu6+j3ARaNsIEQ8NWAbWJ8jwKI5cCjx+dXy4HICX2NaC/IAd6rF
         OfU3qzUkt/A6rYm/kZ2CuyJLFHSZ8fHqO6YJY6LzSLgFmcqGFoMBNwwhi8VKYjJQWoXR
         +9+A==
X-Gm-Message-State: AOAM5316t10qQvB37D/FnIb9UTVJNjKxqbPGayLR62ofmcu0VWpTPUH4
        QiA1GGNHvTSqPXhBP68m1HI=
X-Google-Smtp-Source: ABdhPJzl+Fbw2ZK/0YW+xvW1opW2piy82XGq/LFQSMQzdbhXDr9nGtRYASFfPXeTVmyCnl65miZT/w==
X-Received: by 2002:a17:902:6b0a:b029:dc:31af:8dc3 with SMTP id o10-20020a1709026b0ab02900dc31af8dc3mr36249199plk.41.1609445265935;
        Thu, 31 Dec 2020 12:07:45 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y189sm44418568pfb.155.2020.12.31.12.07.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Dec 2020 12:07:45 -0800 (PST)
Date:   Thu, 31 Dec 2020 12:07:57 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Timur Tabi <timur@kernel.org>, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: fsl: fix -Wmaybe-uninitialized warning
Message-ID: <20201231200756.GA15207@Asurada-Nvidia>
References: <20201230154443.656997-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230154443.656997-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

I think Mark has already applied a fix :)
https://lkml.org/lkml/2020/12/16/275
