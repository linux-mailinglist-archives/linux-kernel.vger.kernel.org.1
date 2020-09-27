Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88B279DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgI0DMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0DMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:12:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D8C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:12:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id v14so1601945pjd.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DcLFy45aJ1dojeOg6m9cm4hJQ4RA1hO34dYnxlEqMMs=;
        b=Ay95vNzZnLgsxMMnV0+jDP93YfiAN/5MKSmPbbqbrXFV/BxUp/2bhcOLvVLk0vkbJw
         D9IuA38+FlDMk2VM7FechUhOgt6MaEhB0v8LsEDvvXIlFnt9sDjo2QhzbjGC30fYy8KK
         u4XzZQG2VyURy3xHbgCGCcwJBG5l+GWEhp2/D6urC4CsNVsE+Cn8sCNoQ6yqhdXBoj88
         4pTJrl+RuzoHN68TjHnSlBaApNpZdslKTaiycWBWNSbMGam0Yx8DBQxshitD+uA/ij21
         PnvtfeIjJ0flqUTNGLlOMJ75xgi14yZknsLoWknISBt7Ix0BMHIOQbMHHa67AtMfMnmL
         c0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DcLFy45aJ1dojeOg6m9cm4hJQ4RA1hO34dYnxlEqMMs=;
        b=bG/yiRAkNr2etSvb4VCbutgwB7uiG3ll0kkhSODURHFQ4VYdSCJnpN+fMd7CiQXBRQ
         l/oMjgzB4fsuMiCHiFpqTPyhEREwwHSW0qD4I2LHhUGlhTyyswlIYpNaqKS7P49fs4JQ
         zh14BgvJjtthjy7dXwMEn7dwTArbPJRfEAYgHpWgxzDy1lTte4ynSHUISJp1rSrmxvNc
         V46x0lo4O74kCkiLHEJivb7QMG8/N0F7uubY2wY8lNjiiI1xPQHxvyZidijkUvdBud46
         aNmii723Monfyyh9/X/ROIh8GrD2+nHyCY4hDQz2hZahCAtQyXUbxari6poUtyT7sucJ
         j9tQ==
X-Gm-Message-State: AOAM530aMy/QLH5fYwh3YmbJRlQdnMM+xEvDazQzG/FkjTxrljN8rOk3
        549/L4Ypa065X9olNRHjC0ig
X-Google-Smtp-Source: ABdhPJxPRsomfxnafyvL2kOp2w1ggyU8sHr5P2UYeo/aA6azjFVw8D9asNXNk1uNy2Lr+y4ym5OIGA==
X-Received: by 2002:a17:90b:209:: with SMTP id fy9mr4018429pjb.189.1601176370604;
        Sat, 26 Sep 2020 20:12:50 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:198:cd53:8f:5b5c:829a:cfde])
        by smtp.gmail.com with ESMTPSA id q190sm7065351pfc.176.2020.09.26.20.12.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 20:12:49 -0700 (PDT)
Date:   Sun, 27 Sep 2020 08:42:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org
Subject: Re: [PATCH v6 1/4] bus: mhi: core: Add helper API to return number
 of free TREs
Message-ID: <20200927031243.GD3213@Mani-XPS-13-9360>
References: <1600286167-4432-1-git-send-email-hemantk@codeaurora.org>
 <1600286167-4432-2-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600286167-4432-2-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:56:04PM -0700, Hemant Kumar wrote:
> Introduce mhi_get_no_free_descriptors() API to return number
> of TREs available to queue buffer. MHI clients can use this
> API to know before hand if ring is full without calling queue
> API.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> ---
>  drivers/bus/mhi/core/main.c | 12 ++++++++++++
>  include/linux/mhi.h         |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 2cff5dd..0599e7d 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -258,6 +258,18 @@ int mhi_destroy_device(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
> +				enum dma_data_direction dir)
> +{
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
> +		mhi_dev->ul_chan : mhi_dev->dl_chan;
> +	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
> +
> +	return get_nr_avail_ring_elements(mhi_cntrl, tre_ring);

Hmm, so this is essentially a wrapper for get_nr_avail_ring_elements().
Why can't you call this API directly?

> +}
> +EXPORT_SYMBOL_GPL(mhi_get_no_free_descriptors);
> +
>  void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
>  {
>  	struct mhi_driver *mhi_drv;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index a35d876..6565528 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -600,6 +600,15 @@ void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl,
>  void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason);
>  
>  /**
> + * mhi_get_no_free_descriptors - Get transfer ring length

mhi_get_nr_free_descriptors?

> + * Get # of TD available to queue buffers
> + * @mhi_dev: Device associated with the channels
> + * @dir: Direction of the channel
> + */
> +int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
> +				enum dma_data_direction dir);

Align enum with start of "("

Thanks,
Mani

> +
> +/**
>   * mhi_prepare_for_power_up - Do pre-initialization before power up.
>   *                            This is optional, call this before power up if
>   *                            the controller does not want bus framework to
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
