Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6212A2D66BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbgLJTkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390194AbgLJTkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:40:10 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2DCC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:39:30 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id j12so6024567ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yHzvb2sgyrs64+/rhHq/tafMxJLiYEjE09CUgIMJcQ0=;
        b=wxgHsjQy52z3s3rniJvqnVXsR8jFNDXeviwLD2pFPDVmPRCOEtnESHY46RNyvHS1LA
         FFADQOD0OQKz6PWR6lqnZwssfNwrcFER3DH2qmyE5I9J7Nc+ysXNo4qhPxjTjX8h3Q5l
         wKzY9q2vMQMoiGkR0iSshcsWBxJHlrCG3guICfuQaeCa4L+gGbuaGRdv8/dBWK6nXT0v
         xR3B+K4ti4crdQfjU0C2KjC4AHK0upAUrGpvUHVtiV9IfJgo5A3PhX3c0+EFwCBxiJwH
         I/NmGenXqRbLlaqJbfNij2iZd+2ckuvtHrDjIN2bgGfUEa8PAnPvP79SMiv2IUFmiuDI
         sA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yHzvb2sgyrs64+/rhHq/tafMxJLiYEjE09CUgIMJcQ0=;
        b=X+1aEqdPP/PtyO7WeqVWcrmksJFgPYDg11ARVDwZt4740fpIr51nxl6wSouTO+gjyF
         8zMpOklKOb+K5XPW2VqqZfgskgKh/xDOVifCtD12WnXvNnlgcx+PoWJNPpYxVI4qnS2S
         lbaD798cQzOim/gf19uHwPplN9l1NME89VYCGw2GDW71R81pNHeyhkFyTYG4yPIZYZ3f
         viKicGTxf6ponwP5nTEVznzuS0UXeuQl0k8gA9uNh5IeswArnmFTSK87V+a1rMYhpGZK
         hlWOpxWwP7pxT/xUTK+mfPCEn4kM/7eUw0ju/4dAV/pHY5yPetnlV9YmjTqFbVNOHxH0
         BsUw==
X-Gm-Message-State: AOAM533YsJWRClQyUxS/EdO2orSc/pFugPC/5x31Sn5vSuxII8x8RKIo
        285w6xwy7S3WEHxq6lQMBZpuwMVy5EVMgg==
X-Google-Smtp-Source: ABdhPJyARyz6Uv2FqxNvjikZOjkC6dD1pbICaNS8YPWWFBTuVD1T357vgbLbnn8hMA3bgW9BT+gDVg==
X-Received: by 2002:a9d:27ea:: with SMTP id c97mr6862385otb.173.1607629169438;
        Thu, 10 Dec 2020 11:39:29 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h2sm1290612otn.15.2020.12.10.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 11:39:28 -0800 (PST)
Date:   Thu, 10 Dec 2020 13:39:27 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        vbadigan@codeaurora.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sc7180: Use floor ops for sdcc clks
Message-ID: <X9J5b8G6qh8ojmkM@builder.lan>
References: <20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Dec 12:22 CST 2020, Douglas Anderson wrote:

> I would repeat the same commit message that was in commit 5e4b7e82d497
> ("clk: qcom: gcc-sdm845: Use floor ops for sdcc clks") but it seems
> silly to do so when you could just go read that commit.
> 
> NOTE: this is actually extra terrible because we're missing the 50 MHz
> rate in the table (see the next patch AKA ("clk: qcom: gcc-sc7180: Add
> 50 MHz clock rate for SDC2")).  That means then when you run an older
> SD card it'll try to clock it at 100 MHz when it's only specced to run
> at 50 MHz max.  As you can probably guess that doesn't work super
> well.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
> ---
> Taniya: can you please update whatever process is used to generate
> these clock files to use floor for SD card clocks.  I hope you can
> also scour through these files looking for similar problems on other
> SoCs and submit patches for them.
> 
>  drivers/clk/qcom/gcc-sc7180.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> index 68d8f7aaf64e..b080739ab0c3 100644
> --- a/drivers/clk/qcom/gcc-sc7180.c
> +++ b/drivers/clk/qcom/gcc-sc7180.c
> @@ -642,7 +642,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
>  		.name = "gcc_sdcc1_ice_core_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = 4,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> @@ -666,7 +666,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>  		.name = "gcc_sdcc2_apps_clk_src",
>  		.parent_data = gcc_parent_data_5,
>  		.num_parents = 5,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
