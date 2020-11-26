Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE82C5AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404469AbgKZRmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404320AbgKZRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:42:39 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A455EC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:42:39 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id w15so2994695oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PwDJIU1RbPAF8KdUnysNCHImcBiYx+BtiRfnwIFhGoM=;
        b=FEWgJnFsCtFPtuPmkgtltajowksX7dLnc2sLb6gMf7Q/M+liXnEYaiCsPiNmTENy01
         eE3grt0tY3X4WRxeCBjEfhJDKmFkoNVqJEl4hXbbAgkNYMqtE3l340w3xyvjmcWRUHNM
         n3rdopN7+shvnzAylHRY+zOVVYlxId/fL2WHdr2zxaJFdT8GMAbzVP5lSPNn1fTj8jAV
         aBExesrkxwP4uuaSeGL2xgsSbe3F5ikjGE3k61ye0vuIU/LEcPz62umblvgc+5IvQIXf
         xw9wUBh1Lw+mQ0hA3ggnNyZJB/HT2K60SApaTnmBLO3Jgdw9Vpxu1wo830AOj3bf3FyS
         y02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwDJIU1RbPAF8KdUnysNCHImcBiYx+BtiRfnwIFhGoM=;
        b=lp+rA+P5x6SseEA/fpVJ78c3wU0AeTQwEgFcgdYRERWbv2nT/+yy7u59/18PVLv4Er
         x//eTcApPNORHR4MDWfogIDfjGVVc6bzGjFCDgosaqk4tJgGDnUYBQWJZC7cqYyz74F4
         VHWIBeSEuTySoIAYGQuH+20kyGx0OSqsDS23Q+2+2oLSdKaVB0gZ3NlFcZVR2v5gwi9O
         KD2ge/JtY36EU6RBMtRGCY7gdNns5/ZxzzNkbX+WfewNsBDHhaSmjrDx5yLdKnyBRtxK
         +hQxnNvvNT/9+oyHItJVup4IqhVoENnsLDryjL20qgC2k58hk9BGnHlrKvNNj4eOPITS
         yhUQ==
X-Gm-Message-State: AOAM530ySP1tQJFKRSQKSlUIjRp24VOf4d2MEVJzp+fqSQjxJ0GFCqpc
        cMKNjvyyaZ/9wUrABjM3p4r/gg==
X-Google-Smtp-Source: ABdhPJxS6v5c1AUGWtgn4f+ou8nXfFRf0gV4ZsbEpr78uIYiLMklTtSJWTR+qzmzNR6YCkZE5z9R/w==
X-Received: by 2002:aca:c787:: with SMTP id x129mr2756167oif.104.1606412558946;
        Thu, 26 Nov 2020 09:42:38 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t13sm3492181oic.4.2020.11.26.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:42:38 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:42:36 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     andy.gross@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org
Subject: Re: [RESEND] soc: qcom: rpmh: Use __fill_rpmh_msg API during
 rpmh_write()
Message-ID: <X7/pDBFd9E0mG6Pm@builder.lan>
References: <1606379490-4052-1-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606379490-4052-1-git-send-email-mkshah@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Nov 02:31 CST 2020, Maulik Shah wrote:

> Use __fill_rpmh_msg API during rpmh_write(). This allows to
> remove duplication of code in error checking, copying commands
> and setting message state.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index ad1f062..01765ee 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -181,8 +181,6 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
>  	struct cache_req *req;
>  	int i;
>  
> -	rpm_msg->msg.state = state;
> -
>  	/* Cache the request in our store and link the payload */
>  	for (i = 0; i < rpm_msg->msg.num_cmds; i++) {
>  		req = cache_rpm_request(ctrlr, state, &rpm_msg->msg.cmds[i]);
> @@ -190,8 +188,6 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
>  			return PTR_ERR(req);
>  	}
>  
> -	rpm_msg->msg.state = state;
> -
>  	if (state == RPMH_ACTIVE_ONLY_STATE) {
>  		WARN_ON(irqs_disabled());
>  		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
> @@ -268,11 +264,9 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
>  	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
>  	int ret;
>  
> -	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
> -		return -EINVAL;
> -
> -	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
> -	rpm_msg.msg.num_cmds = n;
> +	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
> +	if (ret)
> +		return ret;
>  
>  	ret = __rpmh_write(dev, state, &rpm_msg);
>  	if (ret)
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
