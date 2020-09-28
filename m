Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80B27B148
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1P6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1P6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:58:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:58:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so929234pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Drfr8cQPRu6vi/Z/ofjqU5l1eZ9iQ/5l3NXZPd27g8=;
        b=trR4FhM75wqstK+hBYUiXw6/w22a4SEbz7fRzR0JfaPyMtVdM4yIqlNpQC4iwpTEml
         +H1kSWylMJ4HeBiVq+cHNMtyZyL6xWc9oUSGO7o3m2+8W9c2Z1+iQQUDdwEXJEkrOcUr
         uJ8/jVO4m9fhjwmeToLW3DO4cV+uwFtH7oYjul3hUy2uy4SHvT/cZi56kDrjfSyGXuuN
         q9JANhpfDilN/eMjvJ31f0fYjD6sPIUqyljSNpVPYiLSArgfjipyM4MN4PjPihcRK0RH
         Q0voBQcULDHx0FYnkSNhQpknm4M/tQ28GEgSB20y+3LwZ5mwYVDKVEDSmzPTtCCuxh55
         xxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Drfr8cQPRu6vi/Z/ofjqU5l1eZ9iQ/5l3NXZPd27g8=;
        b=syp3MSFHsE1BtR6wSGYkikBKGPWPnG3jq9M19k5+jCq5sqY4P1T9ArLKp7CLrYbs7l
         ecT+Gjnetbox7/Ablqp2rZAT78PJahszkFSzYrLQfQul5q17aQtId1DXvDyPT1dAgwoi
         JuH9c2aahCaV3HBcMh1dBcfWU2GHyjbdjTKWXYlSrY2ZQBLJM4w+o0FfC67GYtZzwlEM
         bhoSOXGyd6Svx6Rzy0+V/KG0ODeTRnydT78UkXXph2x/bu3RfoAOp1Klude+WcTSFkBk
         oBHbJ2J33h/1+IRgglP3TKq7DpgUoEhoHU6thQaPK2HIsWDRArUavz1HniMLj7xVMkn6
         vgZw==
X-Gm-Message-State: AOAM532lS9Iy4V+pyqq9bW/VRwKq+n+hMHw6/22rmTAWM6ifAHhCbAa2
        q81KYbZKQSA4byQqvDFk3+SnlA==
X-Google-Smtp-Source: ABdhPJwZ585p5qWm9UK9iohPgFC/n1PEFGLiSt/ldERFDdq6EB6yFHDcLam63jpfifxkc1qtV4En5Q==
X-Received: by 2002:a17:90a:46cd:: with SMTP id x13mr1914942pjg.101.1601308691778;
        Mon, 28 Sep 2020 08:58:11 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v204sm2195864pfc.10.2020.09.28.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 08:58:11 -0700 (PDT)
Date:   Mon, 28 Sep 2020 09:58:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 2/2] coresight: etm4x: Fix save and restore of
 TRCVMIDCCTLR1 register
Message-ID: <20200928155809.GA16823@xps15>
References: <cover.1601292571.git.saiprakash.ranjan@codeaurora.org>
 <011321608e06db0a2797d3a0418b81c75438c571.1601292571.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011321608e06db0a2797d3a0418b81c75438c571.1601292571.git.saiprakash.ranjan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:07:09PM +0530, Sai Prakash Ranjan wrote:
> In commit f188b5e76aae ("coresight: etm4x: Save/restore state
> across CPU low power states"), mistakenly TRCVMIDCCTLR1 register
> value was saved in trcvmidcctlr0 state variable which is used to
> store TRCVMIDCCTLR0 register value in etm4x_cpu_save() and then
> same value is written back to both TRCVMIDCCTLR0 and TRCVMIDCCTLR1
> in etm4x_cpu_restore(). There is already a trcvmidcctlr1 state
> variable available for TRCVMIDCCTLR1, so use it.
> 
> Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

I am applying your patch (this one only) - hopefully it can go in the 5.10 cycle.

Thanks,
Mathieu

> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index de76d57850bc..abd706b216ac 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1243,7 +1243,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	state->trccidcctlr1 = readl(drvdata->base + TRCCIDCCTLR1);
>  
>  	state->trcvmidcctlr0 = readl(drvdata->base + TRCVMIDCCTLR0);
> -	state->trcvmidcctlr0 = readl(drvdata->base + TRCVMIDCCTLR1);
> +	state->trcvmidcctlr1 = readl(drvdata->base + TRCVMIDCCTLR1);
>  
>  	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
>  
> @@ -1353,7 +1353,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  	writel_relaxed(state->trccidcctlr1, drvdata->base + TRCCIDCCTLR1);
>  
>  	writel_relaxed(state->trcvmidcctlr0, drvdata->base + TRCVMIDCCTLR0);
> -	writel_relaxed(state->trcvmidcctlr0, drvdata->base + TRCVMIDCCTLR1);
> +	writel_relaxed(state->trcvmidcctlr1, drvdata->base + TRCVMIDCCTLR1);
>  
>  	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
