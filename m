Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0829F35A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgJ2RfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgJ2RfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:35:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B4C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:35:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b3so2951388pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=joK9/xt1i7iz0dq3l4VTZXPWOHfArebomq2CqmtCBGo=;
        b=jNQNC3absmFDp8e6f+2KyobCM2TP2xeC3aazgwIfYMSnXxdSyCRwPVgPSBWgjrDztr
         qBjSZ1it3nZxHMDSPtHQmmaf7TYswRQg6mY/cdwA62keKx7ihDVCBVTTxqr0cRcC2phS
         zb4wnUsO+l6773BLk+Pj/lr4820dr4t+Bo3lHr4dn5KzhQnwdG+kw9Jnwnorls7C5AkY
         Dexya13dNopCkTXhoxNeLsa26PdBVxCZAaLw0//sDSSsALeeT0kjZxV9fuGQHh4Uc5QG
         oYuDjZlb568mlCOTXjqilK64LkrlHIkraP0cJafMWFgj4tzEAPF1CIdu19EMhu98P5xv
         B7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=joK9/xt1i7iz0dq3l4VTZXPWOHfArebomq2CqmtCBGo=;
        b=jWeuzV7mcxk4u+5aYIVFlyD0q8rKGwiQ+loxgG4hbwxqIwdqb9cfQAy7wuxBg4HWDt
         IkxdZLgb7pTpIX8MVLNeiz6M6BbHrYOuX3xVckGhl9FHMlPzdHr0whAz3x47kv7UUpY8
         12bH9/MYB9gsYcY7NajZy0Bz3IPDyoCPomtX2/hKFTkxuBCqBPbM6XipRbioFzVa9pMi
         m5Eb5pgyKdK12T+hzcl+/lqu4zR1Fp48QH82d6eucGNwkFOAM4qBcsM/1J2aBLJgEHzn
         XivDRpMR5BsFKPl1sy5jZubeRgv853Q/5slGYIQCcU4JxCxEpMHtImZVNPhAfN4AMrh/
         z9zA==
X-Gm-Message-State: AOAM531oFy74iE8jH20HPhgp/Lk4LYzsQOucQ838j5GPmZ193fr7dyl6
        Yypo9TCQcfH1rLRFMQsMgpcap3UL/TYwRQ==
X-Google-Smtp-Source: ABdhPJwrWRDgtk1/mMnFt2i/Ra3eskdcwsgi6019Un6HP1r6FpmQ17EH5QWl7PBjhwRMTE5Q7fyaDA==
X-Received: by 2002:a63:1849:: with SMTP id 9mr4879836pgy.443.1603992918975;
        Thu, 29 Oct 2020 10:35:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y12sm3483770pfn.172.2020.10.29.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:35:18 -0700 (PDT)
Date:   Thu, 29 Oct 2020 11:35:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] coresight: core: Remove unneeded semicolon
Message-ID: <20201029173516.GB1267404@xps15>
References: <1603938348-53396-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603938348-53396-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Thu, Oct 29, 2020 at 10:25:48AM +0800, Zou Wei wrote:
> Fixes coccicheck warning:
> 
> ./drivers/hwtracing/coresight/coresight-core.c:421:4-5: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index cc9e802..29c83ea 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -418,7 +418,7 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
>  			if (ret) {
>  				coresight_control_assoc_ectdev(csdev, false);
>  				return ret;
> -			};
> +			}

I picked up your patch.

Thanks,
Mathieu

>  		}
>  		csdev->enable = true;
>  	}
> -- 
> 2.6.2
> 
