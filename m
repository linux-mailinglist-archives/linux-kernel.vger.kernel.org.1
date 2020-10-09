Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65C288C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbgJIPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbgJIPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:23:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:23:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q123so7164477pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f03xLBfpCjhpQ8+06VWnlGPHAwyo32pFe58xdhERybU=;
        b=tASVNQ4GLB7cQtH7STDA0zX+iVq+lacXg4nSsNq9uEozGd2a5y6gnJSYYO4Qyx55sa
         KyUIi6CUvUmwKtZEFZNSih6DkaWxv3eqEtc9bcgE7yKfeK5Ot8inKHP2mYnKdkijQegy
         61e2syuq+5Iqq6fuQBkgi/+QXS6QZuZErvOSEVrA6oaYFy8/TmUlwq4NPxT+XzVYrzPV
         INYRpk9g+RS1k4F5tjaJvc4QrXxFIPzZ5NuB3R0nSV7snTwysJhtUtAiAAs+UPlUjmf0
         3SfANa+Wyp/wS0N+Lt1Ssq0oTR2mJJUidgVwP26SywvpmqbT8MsftOb+1FjdBMsyfPWd
         dfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f03xLBfpCjhpQ8+06VWnlGPHAwyo32pFe58xdhERybU=;
        b=T5+KDH2R5gXTdeLIC1KgMEu5DdNNnmpfGy4iQOMt4dg0pOtpGxZ0dVQf4VZY1L5tef
         hEh6l7jcsMhBAEVXFwohXOELDLUI5nbD94T2KxLqE5orp4A74zRcOtkoSWY4Dpfga4Mu
         8PZx7pjyxILOjP2/Tu1FdzkeomNe2zymem7+ZpqTpjf31t9+ftDDRIny4T4iYvWjCghD
         VfEcnQfVkzyn+sP0ApLIkrD7j9trshW/tdI2vbUScdw8G/Xvc9jX2RhGt/5mr763qOZC
         UFFqBdQPpn6LTqivC6g77Tm4pRu7KBSQfuKYTpGA/TVG4Ie/vedf7YxhVBoFCgjfm6jh
         4Jjg==
X-Gm-Message-State: AOAM5315ZTMoNyrde/jnsj97A6eLi74if2LX7/VAM3WY4/VVYXdKfeKY
        y7e2Ccl1+ncyiwYtAZ4q8plAt/TWrjLT
X-Google-Smtp-Source: ABdhPJzUJDjFzUfAnbseHKTwWub7TRcGAYctQvJGBOGUbM6VG7myWd3msQt8fxqaExH52L2zY+CW7g==
X-Received: by 2002:a62:bd0e:0:b029:142:2501:35e7 with SMTP id a14-20020a62bd0e0000b0290142250135e7mr12374530pff.71.1602257002180;
        Fri, 09 Oct 2020 08:23:22 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6292:5a21:d5ff:f3e8:fcf2:ccc7])
        by smtp.gmail.com with ESMTPSA id u22sm10840866pgi.85.2020.10.09.08.23.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Oct 2020 08:23:21 -0700 (PDT)
Date:   Fri, 9 Oct 2020 20:53:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] bus: mhi: core: Use appropriate names for
 firmware load functions
Message-ID: <20201009152314.GB4810@Mani-XPS-13-9360>
References: <1600480955-16827-1-git-send-email-bbhatt@codeaurora.org>
 <1600480955-16827-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600480955-16827-2-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 07:02:26PM -0700, Bhaumik Bhatt wrote:
> mhi_fw_load_sbl() function is currently used to transfer SBL or EDL
> images over BHI (Boot Host Interface). Same goes with mhi_fw_load_amss()
> which uses BHIe. However, the contents of these functions do not
> indicate support for a specific set of images. Since these can be used
> for any image download over BHI or BHIe, rename them based on the
> protocol used.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/boot.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 24422f5..92b8dd3 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -171,7 +171,7 @@ int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
>  }
>  EXPORT_SYMBOL_GPL(mhi_download_rddm_img);
>  
> -static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
> +static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
>  			    const struct mhi_buf *mhi_buf)
>  {
>  	void __iomem *base = mhi_cntrl->bhie;
> @@ -187,7 +187,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  	}
>  
>  	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
> -	dev_dbg(dev, "Starting AMSS download via BHIe. Sequence ID:%u\n",
> +	dev_dbg(dev, "Starting image download via BHIe. Sequence ID:%u\n",
>  		sequence_id);
>  	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
>  		      upper_32_bits(mhi_buf->dma_addr));
> @@ -218,7 +218,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  	return (!ret) ? -ETIMEDOUT : 0;
>  }
>  
> -static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
> +static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>  			   dma_addr_t dma_addr,
>  			   size_t size)
>  {
> @@ -245,7 +245,7 @@ static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
>  	}
>  
>  	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
> -	dev_dbg(dev, "Starting SBL download via BHI. Session ID:%u\n",
> +	dev_dbg(dev, "Starting image download via BHI. Session ID:%u\n",
>  		session_id);
>  	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
>  	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
> @@ -446,9 +446,9 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  		return;
>  	}
>  
> -	/* Download SBL image */
> +	/* Download SBL or EDL image using BHI */

You are mentioning "image" in the debug print but "SBL/EDL" here and below.
Please use "image" for consistency.

Thanks,
Mani

>  	memcpy(buf, firmware->data, size);
> -	ret = mhi_fw_load_sbl(mhi_cntrl, dma_addr, size);
> +	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
>  	mhi_free_coherent(mhi_cntrl, size, buf, dma_addr);
>  
>  	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
> @@ -456,7 +456,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  
>  	/* Error or in EDL mode, we're done */
>  	if (ret) {
> -		dev_err(dev, "MHI did not load SBL, ret:%d\n", ret);
> +		dev_err(dev, "MHI did not load SBL/EDL image, ret:%d\n", ret);
>  		return;
>  	}
>  
> @@ -506,7 +506,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  
>  	/* Start full firmware image download */
>  	image_info = mhi_cntrl->fbc_image;
> -	ret = mhi_fw_load_amss(mhi_cntrl,
> +	ret = mhi_fw_load_bhie(mhi_cntrl,
>  			       /* Vector table is the last entry */
>  			       &image_info->mhi_buf[image_info->entries - 1]);
>  	if (ret)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
