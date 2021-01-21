Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C802FEE38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbhAUPPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732654AbhAUPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:13:11 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40503C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:12:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g3so1460437plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cb5Z7bsSl1bmBwLzaojoyCWOFb6IyGQ9bmQ/EbRwXGQ=;
        b=s8V22bk3Y33KV7SoWQEwm1rqc8PQSFdd0aOMplwcrEZX0rZ57++YbQmbCqf2PGv8k6
         ZfPRj12Wwcn7qAA4EDrGpTrC1BgyE7MIhp7EFiJczAB6+ZVqELoIS0T9Fvt2l4zBNKQx
         rwtC1w4ETc3zpvbMFe4pHESp8XvM7G1X3P0rmOH0r1R9bdNg3h7BL0nnbJU7vxGBbdQa
         2RPJNYc3xiPhXncUYIHN++7lbF6kQVGx1db6DaPIkho/2PA6Z4YAljKjtsAtX62NGH7L
         bCHPi3WRlI6af3T13YBfIT54+3wtHBwFOhgMCVVgEp9v8YWlkDX5m1bFCAFk7jpv2WQ5
         munw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cb5Z7bsSl1bmBwLzaojoyCWOFb6IyGQ9bmQ/EbRwXGQ=;
        b=uGckpGNEIlN1uEoVWRdcoHesTDc5hYcJepRIpn6wRu2mwnIcbgaRKg631iZ+UDO9QF
         Op4dtV9XAgeDgeo/TiE4Ahj5AWKjTRfF5pZ1kWVZRttcCmfWFRHJOm/TBi5/MFlWmhy5
         FY2sJuN425wpvXqxIDXn5Q8AAMUYbRQB2SUf02GnGXBs79FQHXftbZR5tSdWWqzYE/yE
         yQHzF2hpX1WGshXwEgnTYg0MKnEKKkZWDkIK9sABDkaHVuixb5be5qqzzldx4VPEcAwH
         k2a1ze7M46Dt7SVTWaXP7I6nd70ku3oph7nwbOS9KK46VmWXb2A9NWsNVSzsfd+BsNRR
         x6ug==
X-Gm-Message-State: AOAM531BbVi43XSrHOqfa1dMIIBW0ubzm4IAiZ+/WviJxYY+Nl4ub5fq
        kysAD8LDY3MzlJ5MugPmLNS1
X-Google-Smtp-Source: ABdhPJxywIhWfmVunkBhRzgUgXZwY5HmOYL3cQKd4Kqbsc7P7sY6FBWsIIjarzWR4KfS+yf4sDfTlQ==
X-Received: by 2002:a17:90a:f181:: with SMTP id bv1mr12268058pjb.57.1611241950673;
        Thu, 21 Jan 2021 07:12:30 -0800 (PST)
Received: from work ([103.77.37.184])
        by smtp.gmail.com with ESMTPSA id ob6sm5803939pjb.30.2021.01.21.07.12.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 07:12:29 -0800 (PST)
Date:   Thu, 21 Jan 2021 20:42:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v5 6/9] bus: mhi: core: Check channel execution
 environment before issuing reset
Message-ID: <20210121151226.GD5473@work>
References: <1610139297-36435-1-git-send-email-bbhatt@codeaurora.org>
 <1610139297-36435-7-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610139297-36435-7-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:54:54PM -0800, Bhaumik Bhatt wrote:
> A client can attempt to unprepare certain channels for transfer even
> after the execution environment they are supposed to run in has changed.

Just out of curiosity, under what circumstances it can happen? We don't
have any in kernel user for the mhi_unprepare_from_transfer() API :/

> In the event that happens, the device need not be notified of the reset
> and the host can proceed with clean up for the channel context and
> memory allocated for it on the host as the device will no longer be able
> to respond to such a request.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> ---
>  drivers/bus/mhi/core/main.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index a84e6aa..ec720fe 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1351,11 +1351,24 @@ static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
>  	/* no more processing events for this channel */
>  	mutex_lock(&mhi_chan->mutex);
>  
> +	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
> +		dev_err(dev,
> +			"Current EE: %s Required EE Mask: 0x%x for chan: %s\n",
> +			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask,
> +			mhi_chan->name);

Again, use channel's struct dev here.

Thanks,
Mani
