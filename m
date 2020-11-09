Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488762AB7AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgKIMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgKIMBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:01:44 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD3C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:01:44 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r186so6990651pgr.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9hwnkjw/oYyYqyDnTzFXbjt8eNkH5fqnTEaIrprnsU=;
        b=ASMWy21NXOXvBLyjqXCRv4BIdOANXjzFoqW2phQb2lHltsRJXR/eibkaZX2pSbEvlo
         rGKpssLtEc3xICgIsawktERw+y5oGlX1X1LQZQEntK5gME6O6q2f/nqnY8gdBIU8adqc
         WVLqI31q/MF4picTnLRYueh9ocfWc+FpdlFke2qFYtR+v1QQJl7hhKoPzV5bAFiUAQc+
         Ey99jiMMnC7k1GgFiao80aCW8pmwykbmb5UT4wasP0K7XDoO2YbyS4PjS/e8f5DDBWM3
         T8QABnNDO6Qsm/yB+jaCBKBEGRCqmJRtFS5OCOwF+BMCbhXQi7C9nerQzfBqfu1hbSTU
         3ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9hwnkjw/oYyYqyDnTzFXbjt8eNkH5fqnTEaIrprnsU=;
        b=VdftURDZbfPr569HH2AQ/noc/OflbRZytpZUqeeWKPO+gQM+YumieIyd+lP8ZXYzOW
         O0v34hsWIa5EM52uFrRSNbOB/xXdZBmI9vxLDju6uPWWMm/FejHVfK39otFs7uBSJPtV
         HE/eT2VUYkt5rV/q+dFi4mik79IqoUT+6xUPjz94OMhU/OyClAX5rlesDBRts9+KQF03
         hH10/o7TfwHui9Rjd7HlIYmexwLK9fzJB23zdaJr+URgacgUdZ1raW2q1dNCTra7WF6s
         ZYuDxv5cYjiiSKlScPZd5aStumsChOlM+7moCq3rpmXlMWumywWIMs62N5sI/cAawpgs
         qziw==
X-Gm-Message-State: AOAM530zfoMEwbla0wjg1tJUNUvYNHi+y/6brukPO7bPz+zUJ9/pp+l5
        y40TgcLtZZUVpX5tZrLzUDNC
X-Google-Smtp-Source: ABdhPJxi/e0SV/jqp/Qv4E6tYbAX8FD9rKEMFoTnCmI6GBMNy0517G+YG8EmusAuVHdeTzT7m68KeA==
X-Received: by 2002:a17:90b:1603:: with SMTP id la3mr12835191pjb.135.1604923303499;
        Mon, 09 Nov 2020 04:01:43 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id u24sm7429385pfm.51.2020.11.09.04.01.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 04:01:42 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:31:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     carl.yin@quectel.com
Cc:     hemantk@codeaurora.org, sfr@canb.auug.org.au,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.kumar@quectel.com
Subject: Re: [PATCH v2] bus: mhi: core: Fix null pointer access when parsing
 MHI configuration
Message-ID: <20201109120137.GG24289@work>
References: <20201102122710.23406-1-carl.yin@quectel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102122710.23406-1-carl.yin@quectel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 08:27:10PM +0800, carl.yin@quectel.com wrote:
> From: "carl.yin" <carl.yin@quectel.com>
> 
> Functions parse_ev_cfg() and parse_ch_cfg() access mhi_cntrl->mhi_dev
> before it is set in function mhi_register_controller(),
> use cntrl_dev instead of mhi_dev.
> 
> Fixes: 0cbf260820fa ("bus: mhi: core: Add support for registering MHI controllers")
> Signed-off-by: carl.yin <carl.yin@quectel.com>
> Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 0ffdebd..c6b43e9 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -610,7 +610,7 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>  {
>  	struct mhi_event *mhi_event;
>  	const struct mhi_event_config *event_cfg;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct device *dev = mhi_cntrl->cntrl_dev;
>  	int i, num;
>  
>  	num = config->num_events;
> @@ -692,7 +692,7 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
>  			const struct mhi_controller_config *config)
>  {
>  	const struct mhi_channel_config *ch_cfg;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct device *dev = mhi_cntrl->cntrl_dev;
>  	int i;
>  	u32 chan;
>  
> -- 
> 2.25.1
> 
