Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3977F2A078B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgJ3OLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgJ3OLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:11:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:11:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f21so3003060plr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QQc0IVC7h2hq2HRriI7SZgtT+w4D4O0WUc7+YEFXPw0=;
        b=j/gx5kMUlV2Qg0PYPF3s4/LQxgsx4L5ZTYLeMJn6KVexrHtHkNIRLx3mYRQyxLNCRV
         OQleGvPyKAJTPHcJ/T2P4HvFZIC7Cqh2LAYns9r27p/eQ/2iGSppJ3yLDfQMRt7Vx6QL
         OFwpTWLO9h8JkQMoZvAOCQQIgLHMRomcsgOHTEMv4kiWNNuESKckEcYpH9rWarIPF1/Z
         1TFDB/1P/+ACbNsPY7A0ZmCY4LeyEQjEwzG5kixo7xV6wRPqQ3/UP2MTIm73RTH9gBIT
         DHyiyd6oJqDalWyrtEbPP4YjL5gepDlf93Qi02YLF+PoJ+SLOBCzBz6oeWrOu//I0rCH
         FsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQc0IVC7h2hq2HRriI7SZgtT+w4D4O0WUc7+YEFXPw0=;
        b=oLb5Qn5xXh+4asPu1eDQuoD6ECBW7y1aug9K8Wfa0m2TY5rN0b7QXI7xJ7NlrIi87a
         RuVXhtM3i2MM0ZBZLu1riI179QL4uVdMaAY5mprKqPNDApGte4UJmoLGjjoffJjmCHq8
         cfYaJzS0p19sXL9zC/Dk3tDmQlr4ADGdNUHTCWWIHmE7zA5h++ZDrzFYKjgSEVKpoIvJ
         KOvQI7pRwFInnrblvvOPPyX0xBftwB/s1cN5pw77p/MylFefAmJpj0I1XrDyoWVLmFV3
         log01+lv9KqQSCjYCjHPDkyhRQFmi9n2Pq+tlfK3eIAFaJaR0MvzXQR9FA2U9WSld7aH
         1r/w==
X-Gm-Message-State: AOAM531mDkH9FXhDxkyREwhPTv4SbVJ1AUF1SpGCjgrCFB5LxUtqpt7P
        JuXSXfpZ/w+9dDuXfnfNxfDGYrey8YsB
X-Google-Smtp-Source: ABdhPJwNy5d9g2o19zi7HjJ+9FaIXMEskHf9JlZOXX3o7u+U4mz96uLozHQq4NOXod6aKdZjOiCufg==
X-Received: by 2002:a17:902:a517:b029:d5:d09d:f319 with SMTP id s23-20020a170902a517b02900d5d09df319mr9349210plq.15.1604067113852;
        Fri, 30 Oct 2020 07:11:53 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:918:28fe:10d5:aaf5:e319:ec72])
        by smtp.gmail.com with ESMTPSA id k77sm6768359pfd.99.2020.10.30.07.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Oct 2020 07:11:53 -0700 (PDT)
Date:   Fri, 30 Oct 2020 19:41:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/12] bus: mhi: core: Remove MHI event ring IRQ
 handlers when powering down
Message-ID: <20201030141146.GN3818@Mani-XPS-13-9360>
References: <1604031057-32820-1-git-send-email-bbhatt@codeaurora.org>
 <1604031057-32820-13-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604031057-32820-13-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:10:57PM -0700, Bhaumik Bhatt wrote:
> While powering down, the device may or may not acknowledge an MHI
> RESET issued by host for a graceful shutdown scenario and end up
> sending an incoming data packet after tasklets have been killed.
> If a rogue device sends this interrupt for a data transfer event
> ring update, it can result in a tasklet getting scheduled while a
> clean up is ongoing or has completed and cause access to freed
> memory leading to a NULL pointer exception. Remove the interrupt
> handlers for MHI event rings early on to avoid this scenario.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index ffbf6f5..a671f58 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -494,6 +494,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>  		if (mhi_event->offload_ev)
>  			continue;
> +		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
>  		tasklet_kill(&mhi_event->task);
>  	}
>  
> @@ -1164,7 +1165,7 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>  	/* Wait for shutdown to complete */
>  	flush_work(&mhi_cntrl->st_worker);
>  
> -	mhi_deinit_free_irq(mhi_cntrl);
> +	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
>  
>  	if (!mhi_cntrl->pre_init) {
>  		/* Free all allocated resources */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
