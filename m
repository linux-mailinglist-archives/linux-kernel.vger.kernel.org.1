Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA692B4109
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgKPKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKPKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:22:31 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966E6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:22:29 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so10078434pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UQ4rFdGoPrcmBJVwkcevWGfqgVSwf8JPLZI9ALscYds=;
        b=kYYIem/AsuHMeVATS0en5HmYlRsfLpcsOlea1WqtAKYDD9B3G3UuYG/K/Ozs9SWGiI
         bG7lZjx0BJAqfJnQ9lv1Fn1Z8P6toWPUhB0M6j11hNt+zhXMyeAbbJRwNC4Qt3/Ja5+5
         CIgFTnNe2MkC1IBjAnjYD/oLOc7xllS7o2IMizFfJVxhVp+b6GKPPsWy+SJUIdlLYr3F
         QJPuo1+RBdr5Kgwj9zmz7UoA1TseRb2kdXVXTj4F0t0WzbBfy2xjungNei901x9lvVY0
         V9p0DcvdN8c0aMw5RwP3ric8tifNL9p3P5W9JFmxF5CYiJDOfDAULG/s0xDrupJyNg5P
         c/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQ4rFdGoPrcmBJVwkcevWGfqgVSwf8JPLZI9ALscYds=;
        b=miukZL4W9kp8TZzFJG/zr2ojGYuvxDYqTWweozGzceEXP0BjO3jujhbnGnT6jQ0zky
         +sEIPPTefufRBRof8U4lY2snLVBDDh1YtFpn4+Wcas1rzDJ/A0IZrkClDs2W+p9y5+L4
         gjFlLmU625XmeI43vcXapsugDENhgO9JXW2sUN4x1/A3E6Lxzref+Rp7B6VuVzqeEfZx
         fciWgothEHvC98Qhrz/dXvMywVX6LCjuomCjTGOSy2DEd+JsFsYa2irSjypRxiD+jpuO
         LQcPB9ibxZPNoEQ8bD569GuQhrll4rVYT73XGngFlVrBbSGGY4XMu1xS3ZU0OpwEQdqZ
         uKmw==
X-Gm-Message-State: AOAM531tSMjxPDawrYk+46jePnnKSqvCNzXi1Kc4H3ugFAquYtCIP563
        yMuP+Svz0BbJo9FBqn7pP6WG
X-Google-Smtp-Source: ABdhPJzKx3C2KuvaFIZkHpisMz1rHnNeu3F7sls2tMP1/9pgaVVKkVFbeOijRlSi2JFNcF1g8N7jpw==
X-Received: by 2002:a17:90a:cb05:: with SMTP id z5mr15554419pjt.216.1605522149087;
        Mon, 16 Nov 2020 02:22:29 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:618e:9b0a:75fd:1290:bf5c:a350])
        by smtp.gmail.com with ESMTPSA id t74sm17594005pfc.47.2020.11.16.02.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Nov 2020 02:22:28 -0800 (PST)
Date:   Mon, 16 Nov 2020 15:52:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, loic.poulain@linaro.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] bus: mhi: core: Improvements to the channel
 handling state machine
Message-ID: <20201116102220.GJ3926@Mani-XPS-13-9360>
References: <1605122473-12179-1-git-send-email-bbhatt@codeaurora.org>
 <1605122473-12179-3-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605122473-12179-3-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:21:09AM -0800, Bhaumik Bhatt wrote:
> Add support to enable sending the stop channel command and
> improve the channel handling state machine such that all commands
> go through a common function. This can help ensure that the state
> machine is not violated in any way and adheres to the MHI
> specification.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/init.c     |   6 ++
>  drivers/bus/mhi/core/internal.h |  12 +++
>  drivers/bus/mhi/core/main.c     | 163 ++++++++++++++++++++++++----------------
>  3 files changed, 116 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 4d34d62..c9b1de8 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -51,6 +51,12 @@ const char * const mhi_state_str[MHI_STATE_MAX] = {
>  	[MHI_STATE_SYS_ERR] = "SYS_ERR",
>  };
>  
> +const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
> +	[MHI_CH_STATE_TYPE_RESET] = "RESET",
> +	[MHI_CH_STATE_TYPE_STOP] = "STOP",
> +	[MHI_CH_STATE_TYPE_START] = "START",
> +};
> +
>  static const char * const mhi_pm_state_str[] = {
>  	[MHI_PM_STATE_DISABLE] = "DISABLE",
>  	[MHI_PM_STATE_POR] = "POR",
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 2df8de5..f4efb15 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -369,6 +369,18 @@ enum mhi_ch_state {
>  	MHI_CH_STATE_ERROR = 0x5,
>  };
>  
> +enum mhi_ch_state_type {
> +	MHI_CH_STATE_TYPE_RESET,
> +	MHI_CH_STATE_TYPE_STOP,
> +	MHI_CH_STATE_TYPE_START,
> +	MHI_CH_STATE_TYPE_MAX,
> +};
> +

As said in previous patch, this needs to be moved to a separate one.

> +extern const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX];
> +#define TO_CH_STATE_TYPE_STR(state) (((state) >= MHI_CH_STATE_TYPE_MAX) ? \
> +				     "INVALID_STATE" : \
> +				     mhi_ch_state_type_str[state])
> +
>  #define MHI_INVALID_BRSTMODE(mode) (mode != MHI_DB_BRST_DISABLE && \
>  				    mode != MHI_DB_BRST_ENABLE)
>  
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index ad881a1..1226933 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1220,56 +1220,120 @@ int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
>  	return 0;
>  }
>  

[...]

> +static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
> +				    struct mhi_chan *mhi_chan)
> +{
> +	int ret;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +
> +	dev_dbg(dev, "Entered: unprepare channel:%d\n", mhi_chan->chan);

Please get rid of these debug prints. We have some of them right now but they
should be removed at some point. For debugging, use ftrace.

Thanks,
Mani
