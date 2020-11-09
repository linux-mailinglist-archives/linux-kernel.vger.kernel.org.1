Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9D2AB7C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgKIMIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbgKIMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:08:33 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29993C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:08:32 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c20so7981493pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 04:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYZlhxozQgEvlS+NNVIJ/aB7eGsfKrhfyl/qVNIo11E=;
        b=z8cwZptV/a7LEfyiMbIZrV6S/mtNo0uR8gM9D4quJp5aa+TxpTW24tFfuZ4ALf8uE4
         34zdgtpxrr65iQMUFNbS5VZumGtDjAnCWxNlgf9lDxTpLSxkaYGq9qndpHkj4CgyI2tp
         enSPNx+QQ6+2bfd2xhsKAoUuNxZaXgYHtdwmSl2GXI5MiHUO0gFZKBuqE5C7MW1RjQ9k
         b2DojHZcDSpGeYsirwQqvWLtGInlzELYvbzjHGEoa1z0yb7LadUzkWLh/HZDtfwcjs1U
         +rKKSMYBRmSrnHaPlmZK0Lrh9zKp2vZktzk1OQ74Hq1TuX0faF0ADRJOuMCMAfUAsgfc
         8xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYZlhxozQgEvlS+NNVIJ/aB7eGsfKrhfyl/qVNIo11E=;
        b=OdRA5/ijdxUy99hpkJyG9JsYzMLvj5rlqZEFvFIC+O6hrfcmmAJQVRaYa7eMYMZgIU
         bLwXaKQGL9p4q0DGYR9Ip6ushhzcEWa0hYOZoHUkcfoTydLIUcaICZ8Ge2dJPsZaMGJT
         TMyMd5RDVR9fheT0Y5S5fBlOQjLvxEUfZvC7Hg0ueM+y/8/AZ2qRQ2C72ZT9avlQITog
         n3b/zwYUE3CQqzBmvJz5V3YQ3LnFdjhrfVuZI7xR3WEx3mGDqshg2a3iU+nGAMHPL0Lx
         XaKj+mR1xGiTydTtig3Wm1tCjsPx1J74hzF5fI8AFGFG9RTTZubvPSU9E2z71DQ03DV+
         iWrQ==
X-Gm-Message-State: AOAM5310BD/h8zLcoqI2XV1xHVKuqPVN9oFWOoaYqNkHusk1n2nQOVuC
        zDsdeDogfTbPYPNn5x/NXLLS
X-Google-Smtp-Source: ABdhPJxY4xS6lDh4ZRNTEFYmxOtjt5t4JTvxZ9W5QEcXk9D2n6sJ/WF5r6bPqKFetF5lKheJLMT6pg==
X-Received: by 2002:a17:90a:8b08:: with SMTP id y8mr12438935pjn.5.1604923711702;
        Mon, 09 Nov 2020 04:08:31 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id a24sm11377928pfl.174.2020.11.09.04.08.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 04:08:30 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:38:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] bus: mhi: core: Skip RDDM download for unknown
 execution environment
Message-ID: <20201109120825.GJ24289@work>
References: <1604684690-31065-1-git-send-email-bbhatt@codeaurora.org>
 <1604684690-31065-7-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604684690-31065-7-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:44:50AM -0800, Bhaumik Bhatt wrote:
> If MHI is unable to determine the execution environment during
> the panic path, host must skip the RDDM download. This can happen
> if the BHI offset read or the BHI_EXECENV register read fails
> indicating that the underlying transport is unresponsive. Hence,
> there is no need to trigger an RDDM using SYSERR or request an
> SOC reset.
> 
> Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 16244cc..6f0cfb9 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -92,6 +92,9 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  	 * image download completion.
>  	 */
>  	ee = mhi_get_exec_env(mhi_cntrl);
> +	if (ee == MHI_EE_MAX)
> +		goto error_exit_rddm;
> +
>  	if (ee != MHI_EE_RDDM) {
>  		dev_dbg(dev, "Trigger device into RDDM mode using SYS ERR\n");
>  		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
> @@ -139,10 +142,12 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  	ee = mhi_get_exec_env(mhi_cntrl);
>  	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
>  
> -	dev_err(dev, "Did not complete RDDM transfer\n");
> -	dev_err(dev, "Current EE: %s\n", TO_MHI_EXEC_STR(ee));
>  	dev_err(dev, "RXVEC_STATUS: 0x%x\n", rx_status);
>  
> +error_exit_rddm:
> +	dev_err(dev, "RDDM transfer failed. Current EE: %s\n",
> +		TO_MHI_EXEC_STR(ee));
> +
>  	return -EIO;
>  }
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
