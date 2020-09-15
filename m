Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4226A952
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgIOQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgIOPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:18:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E551C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:18:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so3390504qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HppPKgC5RTB1pHQaCQK7PTr1sh6hJlNgeHDMeLxU9Co=;
        b=hPGZKnEYtz6Fi+Z3jak+pMkNRlyIq329o5LzsaYZCDD3GCdidRik0I5wt6pM71S5ov
         r5y7KoS4D2DsDP2erYwWKqZT/rdwO6CwzgFZBsVwDjRaRxrGGK+pxq7Z7aDg5CWlM13g
         cA3SjxpzczmA/D2HH7O1SX7RC76+0bYSbka8HsUpTSs9vS2M0LaBe+jtWg+jsu9hdGSz
         ZT6mVyklkXrw278Gdgl21Ib1+QcVjjQCYSyJP4GU1s+v4Pca8fl+P9B8SUFfhDGbXZNd
         Av/Rn/YIG2Ueyc8m4gMEdkVPNLgAd0mxpBFNpFXvV4ZjxJJnptv5KRgQr8s0gec7Bx1v
         ggCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HppPKgC5RTB1pHQaCQK7PTr1sh6hJlNgeHDMeLxU9Co=;
        b=ZTELPJgrGpIr3EPbkX9N8z0Ni7uoAqbL329lPNC3o3Xydo1lXmEhj9tRCauXkhLvcg
         z6TCSrCJ4TflF7SsgWK9sNHmJG3YPehXClz6RxIQZXN9D/NS6YjYiX6SGSgXu4kFU5+z
         ODpg5AweYWRmbm6imakPTbzYrRe8Coxy4ZFDMDlxim0ml0dZJnBNJICTRDVlbItQpIeM
         UheCOXvxHox8qGIL5Ik1BBKBTrQ532pBQcAuItLapirO6zVIiZ8idtgOcoXLKyi082qT
         0NJ86SD2UvHQEu2mr2JsWR9d5c6TKDtjWgjqnwonr/kGwhz97tirtUEynT/aR1zth6It
         qGIw==
X-Gm-Message-State: AOAM530roysplCBXU0LX2gptjsmMMrYfFtEP7bwXuJ5V18tAvLlHM0c5
        eSGn7Na/FlnJm9hbtYYyaTLXGA==
X-Google-Smtp-Source: ABdhPJwEScs8pyK7BhkglGWQM4EvvVqJqUyNIi8N4BMtIjU88HefmksOthfAZsczpD70V/livF++bg==
X-Received: by 2002:ac8:3ac4:: with SMTP id x62mr6216721qte.279.1600183119936;
        Tue, 15 Sep 2020 08:18:39 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id u55sm18409673qtu.42.2020.09.15.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:18:39 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:18:37 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     mathieu.poirier@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com,
        rishabhb@codeaurora.org
Subject: Re: [PATCH] remoteproc: Fixup coredump debugfs disable request
Message-ID: <20200915151837.GC478@uller>
References: <20200915073416.20864-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915073416.20864-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Sep 07:34 UTC 2020, Sibi Sankar wrote:

> Currently the coredump debugfs entry takes in "disable" to set the
> coredump state to "disabled". Let's just accept the expected state
> instead.
> 

I like this patch, but rather than arguing that it should match the name
of the internal state I think you should either argue that when read you
get "disabled" back or that "disabled" would make it consistent with the
recovery.

Regards,
Bjorn

> Fixes: 3afdc59e43904 ("remoteproc: Add coredump debugfs entry")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 2e3b3e22e1d01..7ca823f6aa638 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -94,7 +94,7 @@ static ssize_t rproc_coredump_write(struct file *filp,
>  		goto out;
>  	}
>  
> -	if (!strncmp(buf, "disable", count)) {
> +	if (!strncmp(buf, "disabled", count)) {
>  		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
>  	} else if (!strncmp(buf, "inline", count)) {
>  		rproc->dump_conf = RPROC_COREDUMP_INLINE;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
