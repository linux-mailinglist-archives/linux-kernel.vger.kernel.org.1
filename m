Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD82B3CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKPGIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:08:42 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50184C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 22:08:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q28so1782620pgk.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 22:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VOT36GzCBGJk+dkdlNwohM145tIdzBNvZpW+yBCQw1Y=;
        b=CBAXxdsTjnOjus8LcRGYWfuleEzwfBJ8TbpynsFTmelGaHkf7jxoBsUsZ+v088Tp2b
         iWdSGndtk1/4387kGz7aK9jZPDgfv7h9EPBa1H8JSx9tPV97evhN4GFZnYt40YYa8JKi
         d6vGkADPSnwr4WPlbCqN5I3orqnGIOMOPzuoWfHQ27e0foJhUvwbyAYU5quYbQa1mc59
         oeUiGM8KR44VrSoAmuc0X6ABRJrL+aJG67mhnpKIOedaMQdzAxqGvd1oaZdeYOXgY+Gq
         lh+oBmSfcZavWKE39qnf7eVXRwGlnQrShvJsh2e68lb9tXjdFv69ggw/j+Kg1ANUCvw9
         VMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOT36GzCBGJk+dkdlNwohM145tIdzBNvZpW+yBCQw1Y=;
        b=aPBgNR1jf8AX5sYn7Rd2QehxEvy36TQM3ssl76g3XS/PkNDp364EjpLuSSbVNy6Hqu
         PYTjLKynQPGvgnSpqp+BMaPptmFAWjeRZHL1J1LTJrQQr+XnlmuDpe2Gga1jA1M3mEgu
         bb5qmBU81fUrgUM/KwS53YmPrjvWecG0fxDyZkQVd2bZRS4AqxWtCB15OhG7laWsAhvH
         9t4rX3t2OO2RjwhqRm928+TsFeoSAMjyw2AteaAqp7nDUmZBTs6pGA2goRBbV7lV56mb
         Ocyj4C/1pZ6QqFQ81q1opw8XHg8vAKXJ0b69yGDtOuFFfjTaaODOpsKt3nMenQH19lYp
         KoDA==
X-Gm-Message-State: AOAM532Yvt0juq+fu3xFWQQ4oQDaoD4jhrCHeK+egaJuPWGi/Xl8IjEe
        xe5BhK+6ZlN5Y61DVkHowr+j
X-Google-Smtp-Source: ABdhPJz/1G0EorOtbzWI2nqt41SDK38J4rVTEWmr7eJ5XlQ2bXl1Oo9mzqlgDEGaX4Sx2aEBYOVyLg==
X-Received: by 2002:aa7:9409:0:b029:18b:9e20:b9df with SMTP id x9-20020aa794090000b029018b9e20b9dfmr12788867pfo.63.1605506921629;
        Sun, 15 Nov 2020 22:08:41 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:618e:9b0a:75fd:1290:bf5c:a350])
        by smtp.gmail.com with ESMTPSA id w70sm16673392pfc.11.2020.11.15.22.08.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Nov 2020 22:08:40 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:38:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     carl.yin@quectel.com, hemantk@codeaurora.org, sfr@canb.auug.org.au,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.kumar@quectel.com
Subject: Re: [PATCH v2] bus: mhi: core: Add support MHI EE FP for download
 firmware
Message-ID: <20201116060831.GD3926@Mani-XPS-13-9360>
References: <20201102122756.23452-1-carl.yin@quectel.com>
 <9693bd0918956ec489fec9d2b36cb4d6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9693bd0918956ec489fec9d2b36cb4d6@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 08:34:14AM -0800, Bhaumik Bhatt wrote:
> On 2020-11-02 04:27, carl.yin@quectel.com wrote:
> > From: "carl.yin" <carl.yin@quectel.com>
> > 
> > MHI wwan modems support download firmware to nand or emmc
> > by firehose protocol, process as next:
> > 1. modem boot up and enter EE AMSS, create DIAG channels (4, 5) device
> > 2. user space tool send EDL command via DIAG channel,
> >    then modem enter EE EDL
> > 3. boot.c download 'flash programmer image' via BHI interface
> > 4. modem enter EE FP, and create EDL channels (34, 35) device
> > 5. user space tool download 'firmware image' to modem via EDL channels
> >    by firehose protocol
> > 
> > Signed-off-by: carl.yin <carl.yin@quectel.com>
> > ---
> >  drivers/bus/mhi/core/init.c     |  2 ++
> >  drivers/bus/mhi/core/internal.h |  1 +
> >  drivers/bus/mhi/core/main.c     |  5 ++++-
> >  drivers/bus/mhi/core/pm.c       | 13 ++++++++++++-
> >  include/linux/mhi.h             |  4 +++-
> >  5 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> > index ac4aa5c..e34616b 100644
> > --- a/drivers/bus/mhi/core/init.c
> > +++ b/drivers/bus/mhi/core/init.c
> > @@ -26,6 +26,7 @@ const char * const mhi_ee_str[MHI_EE_MAX] = {
> >  	[MHI_EE_WFW] = "WFW",
> >  	[MHI_EE_PTHRU] = "PASS THRU",
> >  	[MHI_EE_EDL] = "EDL",
> > +	[MHI_EE_FP] = "FLASH PROGRAMMER",
> >  	[MHI_EE_DISABLE_TRANSITION] = "DISABLE",
> >  	[MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
> >  };
> > @@ -35,6 +36,7 @@ const char * const
> > dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
> >  	[DEV_ST_TRANSITION_READY] = "READY",
> >  	[DEV_ST_TRANSITION_SBL] = "SBL",
> >  	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
> > +	[DEV_ST_TRANSITION_FP] = "FLASH_PROGRAMMER",
> >  	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
> >  	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
> >  };
> > diff --git a/drivers/bus/mhi/core/internal.h
> > b/drivers/bus/mhi/core/internal.h
> > index 4abf0cf..6ae897a 100644
> > --- a/drivers/bus/mhi/core/internal.h
> > +++ b/drivers/bus/mhi/core/internal.h
> > @@ -386,6 +386,7 @@ enum dev_st_transition {
> >  	DEV_ST_TRANSITION_READY,
> >  	DEV_ST_TRANSITION_SBL,
> >  	DEV_ST_TRANSITION_MISSION_MODE,
> > +	DEV_ST_TRANSITION_FP,
> >  	DEV_ST_TRANSITION_SYS_ERR,
> >  	DEV_ST_TRANSITION_DISABLE,
> >  	DEV_ST_TRANSITION_MAX,
> > diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> > index 3950792..a1e1561 100644
> > --- a/drivers/bus/mhi/core/main.c
> > +++ b/drivers/bus/mhi/core/main.c
> > @@ -422,7 +422,7 @@ irqreturn_t mhi_intvec_threaded_handler(int
> > irq_number, void *priv)
> >  		wake_up_all(&mhi_cntrl->state_event);
> > 
> >  		/* For fatal errors, we let controller decide next step */
> > -		if (MHI_IN_PBL(ee))
> > +		if (MHI_IN_PBL(mhi_cntrl->ee))
> Let's please have this as a separate patch with a fixes tag, as it fixes a
> pre-existing bug. I am sure Mani would want this.

Yes. It is not recommended to club changes like this onto a single patch.

Thanks,
Mani

> >  			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_FATAL_ERROR);
> >  		else
> >  			mhi_pm_sys_err_handler(mhi_cntrl);
> > @@ -782,6 +782,9 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller
> > *mhi_cntrl,
> >  			case MHI_EE_SBL:
> >  				st = DEV_ST_TRANSITION_SBL;
> >  				break;
> > +			case MHI_EE_FP:
> > +				st = DEV_ST_TRANSITION_FP;
> > +				break;
> When do you get this EE event on the control event ring? Does it come by
> after you
> have detected EE as FP from mhi_sync_power_up() and move to ready and then
> M0?
> >  			case MHI_EE_WFW:
> >  			case MHI_EE_AMSS:
> >  				st = DEV_ST_TRANSITION_MISSION_MODE;
> > diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> > index 3de7b16..2d68812 100644
> > --- a/drivers/bus/mhi/core/pm.c
> > +++ b/drivers/bus/mhi/core/pm.c
> > @@ -658,6 +658,12 @@ void mhi_pm_st_worker(struct work_struct *work)
> >  		case DEV_ST_TRANSITION_MISSION_MODE:
> >  			mhi_pm_mission_mode_transition(mhi_cntrl);
> >  			break;
> > +		case DEV_ST_TRANSITION_FP:
> > +			write_lock_irq(&mhi_cntrl->pm_lock);
> > +			mhi_cntrl->ee = MHI_EE_FP;
> > +			write_unlock_irq(&mhi_cntrl->pm_lock);
> > +			mhi_create_devices(mhi_cntrl);
> > +			break;
> >  		case DEV_ST_TRANSITION_READY:
> >  			mhi_ready_state_transition(mhi_cntrl);
> >  			break;
> > @@ -1077,10 +1083,15 @@ int mhi_sync_power_up(struct mhi_controller
> > *mhi_cntrl)
> > 
> >  	wait_event_timeout(mhi_cntrl->state_event,
> >  			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
> > +			   mhi_cntrl->ee == MHI_EE_FP ||
> >  			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
> >  			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
> > 
> > -	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
> > +	if (mhi_cntrl->ee == MHI_EE_FP)
> > +		mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_READY);
> > +	else
> > +		ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
> > +
> >  	if (ret)
> >  		mhi_power_down(mhi_cntrl, false);
> > 
> We should come up with a better design for this later on.
> > diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> > index 6e1122c..4620af8 100644
> > --- a/include/linux/mhi.h
> > +++ b/include/linux/mhi.h
> > @@ -120,6 +120,7 @@ struct mhi_link_info {
> >   * @MHI_EE_WFW: WLAN firmware mode
> >   * @MHI_EE_PTHRU: Passthrough
> >   * @MHI_EE_EDL: Embedded downloader
> > + * @MHI_EE_FP, Flash Programmer Environment
> >   */
> >  enum mhi_ee_type {
> >  	MHI_EE_PBL,
> > @@ -129,7 +130,8 @@ enum mhi_ee_type {
> >  	MHI_EE_WFW,
> >  	MHI_EE_PTHRU,
> >  	MHI_EE_EDL,
> > -	MHI_EE_MAX_SUPPORTED = MHI_EE_EDL,
> > +	MHI_EE_FP,
> > +	MHI_EE_MAX_SUPPORTED = MHI_EE_FP,
> >  	MHI_EE_DISABLE_TRANSITION, /* local EE, not related to mhi spec */
> >  	MHI_EE_NOT_SUPPORTED,
> >  	MHI_EE_MAX,
> 
> Thanks,
> Bhaumik
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
