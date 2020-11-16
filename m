Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECC2B3CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKPGM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgKPGM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:12:58 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A588C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 22:12:57 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so12270925pgg.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 22:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zlxljpJjOMdQdTb0djYLQeopi06JNRaksxTWFJarvos=;
        b=JBKxTEcuJv7AU/kEVtLaL/7uJSFJxMrd8qm4HnPQyzx2qS72Ia3baY/9Uf61aPafkW
         +qSYWgIVhWB+svpb4rqAidWpjIgzWiwDYrmfdC2p5TnGLRxLUtRsToO0zIbksmGHxe9s
         uYx96jukhFrPvhWT/4BvkEVzxZjiCpK1AbxaRZ+MTemFriXqPatju/YTifNWcIgvYi7g
         ctlMqGEEKEzTn31EW9YSSXyeXyvElfISrZWUwPCSqwM1VOydVhAUnVybyFPj4x/DI9Hi
         sCtRkwuWnLWJTHY3UZH5tgfU160oclKYc24eet2Zk3nW5aCrvx0St0KL7KvU4gSe/E/b
         hOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zlxljpJjOMdQdTb0djYLQeopi06JNRaksxTWFJarvos=;
        b=E/UVPK09fwNEAsVbMTF/tOx9aAIA7xtGQLqwgmVViJeBSGqjcGXIpqZBGE1L2io9So
         ksqerUcystQTJMrTPuukWSVi+1n5UlS89rqp81IjT4aQIGupLekjlwfVBSwvoWK6lVZO
         py29mdIhoXDDOFiXB2rl4FA21YAVhi/UlpPchapiazb0tWiCYeRQIdGwgocRsQdbFXtg
         ir4Cg05ubXs/ft/I80dqR3+SPXItZRyWCQaepavYgSGsrF2hAl2g4KbX8dsFzUtPLB5E
         Li+NHVe3H9ZthdeIoQixquI0YRpzdnsSn1/IQCwTSnb3BDvmR1ywTknGy3VOzNWg8ZV4
         DUdw==
X-Gm-Message-State: AOAM531ZhIReaZyBwpQ+z/bd51Wgw19gAc880Pvq9mU0hLwza12fDI5B
        vc9DwVebGSHlmpEze1+XeHlc
X-Google-Smtp-Source: ABdhPJxxDnQROz9CQ8p8PwAiT2iUNax9XQ83lBu/ItuH0ckHRFPNOkNVri7zOK4jIlYbRK3r5nPbDw==
X-Received: by 2002:a63:485:: with SMTP id 127mr11029156pge.29.1605507176590;
        Sun, 15 Nov 2020 22:12:56 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:618e:9b0a:75fd:1290:bf5c:a350])
        by smtp.gmail.com with ESMTPSA id p127sm17028469pfp.93.2020.11.15.22.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Nov 2020 22:12:55 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:42:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/12] bus: mhi: core: Move to SYS_ERROR regardless of
 RDDM capability
Message-ID: <20201116061248.GE3926@Mani-XPS-13-9360>
References: <1604954851-23396-1-git-send-email-bbhatt@codeaurora.org>
 <1604954851-23396-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604954851-23396-5-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 12:47:23PM -0800, Bhaumik Bhatt wrote:
> In some cases, the entry of device to RDDM execution environment
> can occur after a significant amount of time has elapsed and a
> SYS_ERROR state change event has already arrived. This can result
> in scenarios where MHI controller and client drivers are unaware
> of the error state of the device. Remove the check for rddm_image
> when processing the SYS_ERROR state change as it is present in
> mhi_pm_sys_err_handler() already and prevent further activity
> until the expected RDDM execution environment change occurs or
> the controller driver decides further action.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index f953e2a..91f8b8d 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -737,11 +737,6 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  			{
>  				enum mhi_pm_state new_state;
>  
> -				/* skip SYS_ERROR handling if RDDM supported */
> -				if (mhi_cntrl->ee == MHI_EE_RDDM ||
> -				    mhi_cntrl->rddm_image)
> -					break;
> -
>  				dev_dbg(dev, "System error detected\n");
>  				write_lock_irq(&mhi_cntrl->pm_lock);
>  				new_state = mhi_tryset_pm_state(mhi_cntrl,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
