Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42111B1722
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 22:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgDTUap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 16:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:30:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED04C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:30:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu11so364006pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QxQOha16WOClJyIlyUv3fEO3tDnnZBhJpetgEtW3TMU=;
        b=XMkTHZnDoCmY09Uakw1SuuDzm1l/6MENMxzIlDTiiYBvnl88IVYSESH//9K94r5M5n
         KZcGwITH47DpVvqhSW3fvHzHcdsFbjzMmu9hrYl5O25p+J/GlEQjHMpfP8IPSVdWqK5X
         gBwLvaFEB0O/tgZo4jZi1591aXIJi0pf6vVX5sUvn2i27eGkWxVoNRjWAb/cOQ9L/3gT
         DB/eJ3FGScjlGJI4ID0l6lfY3R20RJIcS4K70ZW6Y/CXVW/+hXeKfC3m9+6nfnQ8G5qB
         sMls1PogCwRbDamBjDmOfvdYR2WcMC7W5j9YAnMNivKx4WZLung4nBfi1YBEcZaHcWDA
         62PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxQOha16WOClJyIlyUv3fEO3tDnnZBhJpetgEtW3TMU=;
        b=nopt5bWUhjSZmo7uBqYbyWa1FFxv30DphjOchgEOz5i57V8nfx65O8jcl19TNgn1hC
         /wJOcoOqPZJVZ+W0eGGNjNe8OHc8pi44pyeuySMpLO15X0en5W/7cpyrc4Dy3u2Lb9OG
         KOZ7nabfhk3TdxG7uucGl7Y1k03lNw3tNpqrymH4653eRVh4rHr9aucYeMAPoD/uYx9B
         UQL0DkkNFi2bShYkpwPBKz2GsyPUVDQNPcBMDJ+xgpQtTsv2+FyoDa9LX9CP5eSmpl1F
         7gPNIqLVMjNZH0WSQ0Z1nBYra0JOAYWVjfhMAbCe3UABOml0qbJyKUaJQWuHXwrfSKR2
         4c7Q==
X-Gm-Message-State: AGi0Pua/sPToYrDGF6bi5nWWEv7b16PTGCHZYmnAx8TJBbUG9MgLW9Om
        tf/8P8nW6n+9kkTBrG/3fXZq6Q==
X-Google-Smtp-Source: APiQypKJ/b0AM77PABim4P//4kMhpZZkBJR/jWMLNAth+dG5mgEtENvbpGj6UR7QzLn76ujR0wGKfQ==
X-Received: by 2002:a17:90a:fd89:: with SMTP id cx9mr1371566pjb.64.1587414643955;
        Mon, 20 Apr 2020 13:30:43 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x66sm336527pfb.173.2020.04.20.13.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:30:43 -0700 (PDT)
Date:   Mon, 20 Apr 2020 13:31:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     agross@kernel.org, swboyd@chromium.org, mkshah@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmh: Dirt can only make you dirtier, not
 cleaner
Message-ID: <20200420203107.GR576963@builder.lan>
References: <20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Apr 14:15 PDT 2020, Douglas Anderson wrote:

> Adding an item into the cache should never be able to make the cache
> cleaner.  Use "|=" rather than "=" to update the dirty flag.
> 

This is correct...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Fixes: bb7000677a1b ("soc: qcom: rpmh: Update dirty flag only when data changes")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/soc/qcom/rpmh.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 3abbb08cd6e1..d1626a1328d7 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -151,10 +151,10 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>  		break;
>  	}
>  
> -	ctrlr->dirty = (req->sleep_val != old_sleep_val ||
> -			req->wake_val != old_wake_val) &&
> -			req->sleep_val != UINT_MAX &&
> -			req->wake_val != UINT_MAX;
> +	ctrlr->dirty |= (req->sleep_val != old_sleep_val ||
> +			 req->wake_val != old_wake_val) &&
> +			 req->sleep_val != UINT_MAX &&
> +			 req->wake_val != UINT_MAX;

...but this logic says dirty "if either sleep or wake has changed and
both sleep and wake are requested".

So what if we have an entry with only sleep wake changed, then the
controller won't be dirty and hence the hardware won't know about this
request - until another "fully specified" request comes in, which would
cause the controller to be dirty and flush out the "partially specified"
request as well.

Is this really the expected behavior?

Regards,
Bjorn

>  
>  unlock:
>  	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
