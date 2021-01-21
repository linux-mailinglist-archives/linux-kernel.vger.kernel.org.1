Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E467A2FED42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbhAUOo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbhAUOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:43:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:43:07 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z21so1488205pgj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brR+1dZEzhE8ISbtb0SjjMZw/hxFjcuos1tZ/GY2UHc=;
        b=CcAfnCDbMttSn7IoKwPwcQE2alUK7BW7toApaGyz4Xw079cY01HQAmDRE/GCDb25Z5
         MsfMELx/a7wZleVYUtsss98itqxOvy0EU5TtsXAwUUh0d/kl1R0/S200OxwdfgYmVrCQ
         MUQAkQm6bw73M/GlAnb0VdagOc/fr4/W2SGLuLJSrq5YLZcT++7PjM5dXfzwzb0Pk3yd
         3i88HG5ThTWbangBw3SA7VnyZhtd1lECjHBUiee2ZyKMFw9UYqSUhAFnI3yFKeHPWioM
         BHjYqMaDHt2kJaj+gAaJ51YlhndmV248vCX6pw2b/RBObSYTkM8Vg47U0AM6IX0v9Ju9
         QJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brR+1dZEzhE8ISbtb0SjjMZw/hxFjcuos1tZ/GY2UHc=;
        b=t3ZWYV4Q1NJ1hH5YjeiOPkzU10/tsnFMPq6uCfqd0ufSQqupP+2UeGJ7DcCsHicCGx
         qVyVmVu/pTwzfnum56nQ6zL+Z0KR41qqi6Lmspl4xpYHDJXzW33KS0+/QxOqkt9MC1dv
         bOXF/T7MPsbVK8TWX2tXnMeeMqOHESxHb63SYYiqWbEJqjTnt3zLqM+92hc7AjUpu6/y
         UC3+0WRaCWamsO4kcsYomuYTGsp7PB82+s81uA8FtrqEUQ2P4UtyWVh7o3Z13GwcVVyJ
         OSRdHyHHMwgYP7XLHvqAEbU32La4oRZuEy0wcVHCF3So9PyrLauykLtVnX4dKHyDRvBW
         PgWQ==
X-Gm-Message-State: AOAM531X8gwB7LHUbLGh66CTv8O2DujchCep8K2O7Gzh3rGmrwLvsmVa
        UlTKoINqxDukFZwAlLp74FiH
X-Google-Smtp-Source: ABdhPJwXOxw/CDdpSS+LC2AFUa7KBxN6RjcU85Nl1dKC3n4k4/O/po+Rnn0dG1eFFUggTRZvcQoz4g==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr10663351pgs.248.1611240187221;
        Thu, 21 Jan 2021 06:43:07 -0800 (PST)
Received: from work ([103.77.37.184])
        by smtp.gmail.com with ESMTPSA id l13sm6331240pjh.2.2021.01.21.06.43.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 06:43:05 -0800 (PST)
Date:   Thu, 21 Jan 2021 20:13:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v5 3/9] bus: mhi: core: Improvements to the channel
 handling state machine
Message-ID: <20210121144302.GA5473@work>
References: <1610139297-36435-1-git-send-email-bbhatt@codeaurora.org>
 <1610139297-36435-4-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610139297-36435-4-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:54:51PM -0800, Bhaumik Bhatt wrote:
> Improve the channel handling state machine such that all commands
> go through a common function and validation process to ensure
> that the state machine is not violated in any way and adheres to
> the MHI specification.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> ---
>  drivers/bus/mhi/core/init.c     |   6 ++
>  drivers/bus/mhi/core/internal.h |  12 +++
>  drivers/bus/mhi/core/main.c     | 166 +++++++++++++++++++++++-----------------
>  3 files changed, 114 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 03c5786..482b365 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -54,6 +54,12 @@ const char * const mhi_state_str[MHI_STATE_MAX] = {
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
> index 6f80ec3..7e3aac1 100644
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
> +extern const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX];
> +#define TO_CH_STATE_TYPE_STR(state) (((state) >= MHI_CH_STATE_TYPE_MAX) ? \
> +				     "INVALID_STATE" : \
> +				     mhi_ch_state_type_str[(state)])
> +
>  #define MHI_INVALID_BRSTMODE(mode) (mode != MHI_DB_BRST_DISABLE && \
>  				    mode != MHI_DB_BRST_ENABLE)
>  
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index c22d7df..081fdf0 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1250,56 +1250,118 @@ int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
>  	return 0;
>  }
>  
> -static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
> -				    struct mhi_chan *mhi_chan)
> +static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
> +				    struct mhi_chan *mhi_chan,
> +				    enum mhi_ch_state_type to_state)
>  {
> -	int ret;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	enum mhi_cmd_type cmd = MHI_CMD_NOP;
> +	int ret = -EIO;
> +
> +	dev_dbg(dev, "Updating channel %s(%d) state to: %s\n", mhi_chan->name,
> +		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));

Instead of explicitly using the channel name and its id, you should be
able to use `mhi_chan->mhi_dev->dev` so that dev_dbg() can provide that
information for you. For instance,

mhi0_IPCR: Updating channel state to RESET

Do it for all instances below.

> +
> +	switch (to_state) {
> +	case MHI_CH_STATE_TYPE_RESET:
> +		write_lock_irq(&mhi_chan->lock);
> +		if (mhi_chan->ch_state != MHI_CH_STATE_STOP &&
> +		    mhi_chan->ch_state != MHI_CH_STATE_ENABLED &&
> +		    mhi_chan->ch_state != MHI_CH_STATE_SUSPENDED) {
> +			write_unlock_irq(&mhi_chan->lock);
> +			goto exit_invalid_state;
> +		}
> +		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
> +		write_unlock_irq(&mhi_chan->lock);
>  
> -	dev_dbg(dev, "Entered: unprepare channel:%d\n", mhi_chan->chan);
> +		cmd = MHI_CMD_RESET_CHAN;
> +		break;
> +	case MHI_CH_STATE_TYPE_STOP:
> +		if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
> +			goto exit_invalid_state;
>  
> -	/* no more processing events for this channel */
> -	mutex_lock(&mhi_chan->mutex);
> -	write_lock_irq(&mhi_chan->lock);
> -	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED &&
> -	    mhi_chan->ch_state != MHI_CH_STATE_SUSPENDED) {
> -		write_unlock_irq(&mhi_chan->lock);
> -		mutex_unlock(&mhi_chan->mutex);
> -		return;
> +		cmd = MHI_CMD_STOP_CHAN;
> +		break;
> +	case MHI_CH_STATE_TYPE_START:
> +		if (mhi_chan->ch_state != MHI_CH_STATE_STOP &&
> +		    mhi_chan->ch_state != MHI_CH_STATE_DISABLED)
> +			goto exit_invalid_state;
> +
> +		cmd = MHI_CMD_START_CHAN;
> +		break;
> +	default:
> +		goto exit_invalid_state;
>  	}
>  
> -	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
> -	write_unlock_irq(&mhi_chan->lock);
> +	/* bring host and device out of suspended states */
> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);

You are sneaking in a change here. Please add it to the commit description.

> +	if (ret)
> +		return ret;
> +	mhi_cntrl->runtime_get(mhi_cntrl);
>  
>  	reinit_completion(&mhi_chan->completion);
> -	read_lock_bh(&mhi_cntrl->pm_lock);
> -	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
> -		read_unlock_bh(&mhi_cntrl->pm_lock);
> -		goto error_invalid_state;
> +	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
> +	if (ret) {
> +		dev_err(dev, "Failed to send %s(%d) %s command\n",
> +			mhi_chan->name, mhi_chan->chan,
> +			TO_CH_STATE_TYPE_STR(to_state));
> +		goto exit_command_failure;
>  	}
>  
> -	mhi_cntrl->wake_toggle(mhi_cntrl);
> -	read_unlock_bh(&mhi_cntrl->pm_lock);
> +	ret = wait_for_completion_timeout(&mhi_chan->completion,
> +				       msecs_to_jiffies(mhi_cntrl->timeout_ms));
> +	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS) {
> +		dev_err(dev, "Failed to receive %s(%d) %s command completion\n",
> +			mhi_chan->name, mhi_chan->chan,
> +			TO_CH_STATE_TYPE_STR(to_state));
> +		ret = -EIO;
> +		goto exit_command_failure;
> +	}
>  
> -	mhi_cntrl->runtime_get(mhi_cntrl);
> +	ret = 0;
> +
> +	if (to_state != MHI_CH_STATE_TYPE_RESET) {
> +		write_lock_irq(&mhi_chan->lock);
> +		mhi_chan->ch_state = (to_state == MHI_CH_STATE_TYPE_START) ?
> +				      MHI_CH_STATE_ENABLED : MHI_CH_STATE_STOP;
> +		write_unlock_irq(&mhi_chan->lock);
> +	}
> +
> +	dev_dbg(dev, "Channel %s(%d) state change to %s successful\n",
> +		mhi_chan->name, mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
> +
> +exit_command_failure:
>  	mhi_cntrl->runtime_put(mhi_cntrl);
> -	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_RESET_CHAN);
> -	if (ret)
> -		goto error_invalid_state;
> +	mhi_device_put(mhi_cntrl->mhi_dev);
>  
> -	/* even if it fails we will still reset */
> -	ret = wait_for_completion_timeout(&mhi_chan->completion,
> -				msecs_to_jiffies(mhi_cntrl->timeout_ms));
> -	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS)
> -		dev_err(dev,
> -			"Failed to receive cmd completion, still resetting\n");
> +	return ret;
> +

This is not a recommended way to handle error paths. There should be a
single return for all error paths. Please fix it.

> +exit_invalid_state:
> +	dev_err(dev, "Channel %s(%d) update to %s not allowed\n",
> +		mhi_chan->name, mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
> +
> +	return -EINVAL;
> +}
> +
> +static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
> +				    struct mhi_chan *mhi_chan)
> +{
> +	int ret;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +
> +	/* no more processing events for this channel */

Move this comment below.

Thanks,
Mani
