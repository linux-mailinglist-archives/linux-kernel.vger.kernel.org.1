Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC82A0670
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJ3N3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJ3N3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:29:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24BC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:29:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c20so5277230pfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ExTHezvn9Sy6laRwgzj3aOhJ09Yd64dHo+tc0qUe4rQ=;
        b=RPTf2Kin/Q0/DnBCi2vqOMQJS6NQbGwg9NI3v001mJqd67C0ChhsEEGvM5XRuytTAM
         voy08aQ1E6uZ/sgNQdQ6/WR3J3lWlkCrcjuhmltxi41t2OR59UicYhOu5OVuIU6wuZxz
         /B9VRvQc6WBqxTfxUU5eqgW1U9AxwTj2jmOS/X2A5npfRG9Eny/5kKNDeykUr3Lgfah2
         UjflkLNNLZcUlB/Adu9Cew4y2oDppCI64cmqITqUVLXo+rnjzucDIw5M8x4I5NJ2IQf7
         9RV0lor0rsoo14va70Ihxbo7iCF9nW39RcT1Fjm+0CNx/FDwGZ+jzbmh7o7ch7Kk9l5X
         6KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ExTHezvn9Sy6laRwgzj3aOhJ09Yd64dHo+tc0qUe4rQ=;
        b=e71Y00aOJtbAx4bcoHq6pf3BXo1r1TWtf6mDci1Jj3oJtOYR87EsQkt6i7bLpjp8aN
         VDHeLmolzr6/9zYRMHRxEq9Yep7fuhkUxXdBbvOYQNbIpp3NJKiHfzJkpSc7y62gnMty
         zs6fgJoKmzF65qlXISsyyLOWrhVGPydN/0VnssMmT7/4UdviaFQYnl5nuw+04mbxSv7L
         8tpLEcOm8kxkYsMZxx9uyO51CXaTXtDSclSB1ii4j66AZqz/L+zL/ZNpLMUKcyqoUx7h
         I/rkKXXdJOtyb+EAZCos1lK/nVzR3AlvQw+sVjkkSI+vQQiwJB3f8pevoxhJaxuSYC4c
         J3+A==
X-Gm-Message-State: AOAM531PigR2QzGStlreO86wUVA/p1MU7iFTTzYYusezwg0RcCq59Nbv
        jaoHBvRIat1pdrgvbsCCsaIjygoU951w
X-Google-Smtp-Source: ABdhPJxxvznJs4QE5lIaufU+cqwHl6xs0Hs/72w28bIvs6b+A0+4b0D42SQUvKoUBMmW3rcGHFWFSQ==
X-Received: by 2002:a63:8bc3:: with SMTP id j186mr2170643pge.303.1604064593940;
        Fri, 30 Oct 2020 06:29:53 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:918:28fe:10d5:aaf5:e319:ec72])
        by smtp.gmail.com with ESMTPSA id jy19sm3896674pjb.9.2020.10.30.06.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Oct 2020 06:29:53 -0700 (PDT)
Date:   Fri, 30 Oct 2020 18:59:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] bus: mhi: core: Use appropriate names for
 firmware load functions
Message-ID: <20201030132948.GE3818@Mani-XPS-13-9360>
References: <1604031057-32820-1-git-send-email-bbhatt@codeaurora.org>
 <1604031057-32820-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604031057-32820-2-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:10:46PM -0700, Bhaumik Bhatt wrote:
> mhi_fw_load_sbl() function is currently used to transfer SBL or EDL
> images over BHI (Boot Host Interface). Same goes with mhi_fw_load_amss()
> which uses BHIe. However, the contents of these functions do not
> indicate support for a specific set of images. Since these can be used
> for any image download over BHI or BHIe, rename them based on the
> protocol used.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 24422f5..7d6b3a7 100644
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
> +	dev_dbg(dev, "Starting image download via BHIe. Sequence ID: %u\n",
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
> +	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
>  		session_id);
>  	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
>  	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
> @@ -446,9 +446,9 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  		return;
>  	}
>  
> -	/* Download SBL image */
> +	/* Download image using BHI */
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
> +		dev_err(dev, "MHI did not load image over BHI, ret: %d\n", ret);
>  		return;
>  	}
>  
> @@ -506,11 +506,12 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  
>  	/* Start full firmware image download */
>  	image_info = mhi_cntrl->fbc_image;
> -	ret = mhi_fw_load_amss(mhi_cntrl,
> +	ret = mhi_fw_load_bhie(mhi_cntrl,
>  			       /* Vector table is the last entry */
>  			       &image_info->mhi_buf[image_info->entries - 1]);
>  	if (ret)
> -		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
> +		dev_err(dev, "MHI did not load image over BHIe, ret: %d\n",
> +			ret);
>  
>  	release_firmware(firmware);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
