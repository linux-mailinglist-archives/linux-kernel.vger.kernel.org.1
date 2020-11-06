Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1262E2A8EEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgKFFaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgKFFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:30:46 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2666C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:30:45 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 1so149208ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 21:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKG6XWMZpWa0fMi+t4pTPwLQ90HwLs3iGBG1/JdBeyU=;
        b=qpqK/rsMyUgERLdTiciWXHbde7O+7hOsVvC67xpIUrkW2w+a47IXSolXNf4E9Evzo2
         Dvd087wi6EjG55EufUKi8w1PzLXnJ5v+ZDrh1UkrWrlrEv1o6CRC2b1AZgL+cqJxJnl1
         mhU3zSorMgd/DOix7z5nvgAfKyZbOwcd49iu3a6Qi9mrVUpk5oGyecMX54WbRKvz9NsA
         Q93Y3hyP6jnTH2WZ/G1HvH5u1/MSyXf0By+XTj197ZCW5GeLBTcskX0HOBErdiWquL4D
         WZ0v9/FSJZy9IDL24YBmudtH7+K/W1xltPpn1KBZJHiobP37BhhH0sUMuGJb9n2tersd
         ALJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKG6XWMZpWa0fMi+t4pTPwLQ90HwLs3iGBG1/JdBeyU=;
        b=rk1gZmZPxbzkexEgtXTLF7DonZ96fXLRL04AATtl+n+C6CiTuWn2jsDtDtzs1SCGf6
         E+USwS5Raj7LBzhMfYgCYQDvD6cqdkEanmRCs2s4QeYuJdqoPvbScaICXNItGf6Uxm9a
         zcAkD4ucmXpvoI9DuAgiTokC4wAVEjFTu6AfclUuw4v5CJNcg09MIDl/JhUdUJe2Oh/h
         5RArxO5kpwqjBKWvkJvFlh0ZWZUskXHcRUksI5qpQqVDBZ1VuAMOfnWWTBDMd/4gqMKv
         2MHPK6BcVvRXPey/y7ffTDWEpoUxc/2rpZU81mOB/JezO9REIeEVWp3BmfsYeKusjaz5
         uWWg==
X-Gm-Message-State: AOAM533xo5QQu9Jijy14NLqvIiBOP8KR+y85QXZLwdT3r+Kr8eiec8gB
        ZMHVyhT0bC926NfAKwV1U64eacZA01S8
X-Google-Smtp-Source: ABdhPJwZRlGd5SjBk6DaKGd1uSqGbaE2SznLMntY1hWxAnSR6F+pCW499TzfbcBeger09fCBUlbZJg==
X-Received: by 2002:a17:902:bc81:b029:d6:ed57:b7c7 with SMTP id bb1-20020a170902bc81b02900d6ed57b7c7mr490202plb.1.1604640645236;
        Thu, 05 Nov 2020 21:30:45 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id h184sm404974pfe.161.2020.11.05.21.30.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 21:30:44 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:00:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] bus: mhi: core: Remove unused
 mhi_fw_load_worker() declaration
Message-ID: <20201106053039.GE3473@work>
References: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
 <1604622869-40212-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604622869-40212-5-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 04:34:27PM -0800, Bhaumik Bhatt wrote:
> The mhi_fw_load_worker() function no longer exists. Remove its
> declaration as part of code clean-up.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/internal.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 7989269..4f8f384 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -614,7 +614,6 @@ int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
>  			       enum dev_st_transition state);
>  void mhi_pm_st_worker(struct work_struct *work);
>  void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
> -void mhi_fw_load_worker(struct work_struct *work);
>  int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
>  int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
>  void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
