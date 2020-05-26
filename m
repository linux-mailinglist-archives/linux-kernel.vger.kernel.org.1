Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11F41CBDD6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 07:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgEIFqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 01:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:46:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:46:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so1918660pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKlefTYkYBRq2ILWaYaDodjvhLNEhp2y4FI3p3b3Isw=;
        b=oz0eqB1g0uQwUqumhThKlfvBEw3wpVeMBZAnw5bgJOmcUNIYQSb6fataOOlqgzMmoq
         6J/wPhZ49ClzRE5W7YRSAUON/VH/pw13TQA5gZcamRkYVeoMkm2qFxIwWOk9rLaA0Ej5
         G50J0cvNcyI8D968qsEdYa2HJGphiaLPwVWCxB7nenbJ3UHl/xCS5ne3C5XJoRYN1+TB
         s5rv1BR6fTXtVF6WXPN69Yz6K1MRkXK3dxTvO/8xdYCdGFtOAXR4KKO1gBjzgwYe5VQF
         eb3GCDdgrlfyv/i8roy0mUF0OiyLGBcpumNBqxQHXsN4mswrbQiI+DRE8Odca93IfZ9r
         hCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKlefTYkYBRq2ILWaYaDodjvhLNEhp2y4FI3p3b3Isw=;
        b=oMZT5uvZ5KlTomIbg4r0gKMHQDogy4xNWo9WY0dhw02dUulXAVIeEh79RXnJDF/Kz/
         0fNbG2/Nd+erYXb2ACvMii2rkkZjY2zeE56XUGfkLUcvaEjzsxUOnGOJxJSdYsbkn3bN
         /BfZOv6XlG3d97SR6gpXKLyPfy5CleJhZDt6UqsmHw0YeI609+AyMl/419BGekyndq/0
         cwPlXa9lZiTutIQvYv2jTF6O8LZiMxxwlpuvfdv1POZfVMw/Y9RfjTeYE4ZIAVq1/7oR
         Mx+bNCLDYwAwT+9dpa6kF0qHOd61R1lL744owC5cVA4Uc2whltBbUj3wkgO9vL9OJOCf
         DO5A==
X-Gm-Message-State: AGi0PuaLdnz2tOaM/Om0vwWKIj3CySc/P6EVB0NOuJzrDMBIl7zVf+Y9
        2iS/qKCcDPkTAYCo6B5/N5DW
X-Google-Smtp-Source: APiQypLV/DBpGdEnXXdRYxXSWTme9DlM9e0S4pdalY6sKEiicEXmNsxlHR8uIDKaEzsoKFPnD4MezA==
X-Received: by 2002:aa7:9251:: with SMTP id 17mr6083769pfp.315.1589003211282;
        Fri, 08 May 2020 22:46:51 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e0c:55d2:2cb4:da01:ad1e:6ad9])
        by smtp.gmail.com with ESMTPSA id t12sm2698983pgm.37.2020.05.08.22.46.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 22:46:50 -0700 (PDT)
Date:   Sat, 9 May 2020 11:16:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org
Subject: Re: [PATCH v7 1/8] bus: mhi: core: Refactor mhi queue APIs
Message-ID: <20200509054644.GA5845@Mani-XPS-13-9360>
References: <1588991208-26928-1-git-send-email-bbhatt@codeaurora.org>
 <1588991208-26928-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588991208-26928-2-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:26:41PM -0700, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> Move all the common code to generate TRE from mhi_queue_buf,
> mhi_queue_dma and mhi_queue_skb to mhi_gen_tre. This helps
> to centralize the TRE generation code which makes any future
> bug fixing easier to manage in these APIs.
> 
> Suggested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/internal.h |   3 +-
>  drivers/bus/mhi/core/main.c     | 107 +++++++++++++++++-----------------------
>  2 files changed, 47 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 095d95b..40c47f9 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -670,8 +670,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  irqreturn_t mhi_intvec_handler(int irq_number, void *dev);
>  
>  int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
> -		void *buf, void *cb, size_t buf_len, enum mhi_flags flags);
> -
> +		struct mhi_buf_info *info, enum mhi_flags flags);
>  int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
>  			 struct mhi_buf_info *buf_info);
>  int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index c26eed0..605640c 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -919,9 +919,7 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
>  							     mhi_dev->dl_chan;
>  	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
> -	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
> -	struct mhi_buf_info *buf_info;
> -	struct mhi_tre *mhi_tre;
> +	struct mhi_buf_info buf_info = { };
>  	int ret;
>  
>  	/* If MHI host pre-allocates buffers then client drivers cannot queue */
> @@ -946,27 +944,15 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  	/* Toggle wake to exit out of M2 */
>  	mhi_cntrl->wake_toggle(mhi_cntrl);
>  
> -	/* Generate the TRE */
> -	buf_info = buf_ring->wp;
> -
> -	buf_info->v_addr = skb->data;
> -	buf_info->cb_buf = skb;
> -	buf_info->wp = tre_ring->wp;
> -	buf_info->dir = mhi_chan->dir;
> -	buf_info->len = len;
> -	ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> -	if (ret)
> -		goto map_error;
> -
> -	mhi_tre = tre_ring->wp;
> -
> -	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
> -	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
> -	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
> +	buf_info.v_addr = skb->data;
> +	buf_info.cb_buf = skb;
> +	buf_info.len = len;
>  
> -	/* increment WP */
> -	mhi_add_ring_element(mhi_cntrl, tre_ring);
> -	mhi_add_ring_element(mhi_cntrl, buf_ring);
> +	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
> +	if (unlikely(ret)) {
> +		read_unlock_bh(&mhi_cntrl->pm_lock);
> +		return ret;
> +	}
>  
>  	if (mhi_chan->dir == DMA_TO_DEVICE)
>  		atomic_inc(&mhi_cntrl->pending_pkts);
> @@ -980,11 +966,6 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  	read_unlock_bh(&mhi_cntrl->pm_lock);
>  
>  	return 0;
> -
> -map_error:
> -	read_unlock_bh(&mhi_cntrl->pm_lock);
> -
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mhi_queue_skb);
>  
> @@ -996,9 +977,8 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  							     mhi_dev->dl_chan;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
> -	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
> -	struct mhi_buf_info *buf_info;
> -	struct mhi_tre *mhi_tre;
> +	struct mhi_buf_info buf_info = { };
> +	int ret;
>  
>  	/* If MHI host pre-allocates buffers then client drivers cannot queue */
>  	if (mhi_chan->pre_alloc)
> @@ -1025,25 +1005,16 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  	/* Toggle wake to exit out of M2 */
>  	mhi_cntrl->wake_toggle(mhi_cntrl);
>  
> -	/* Generate the TRE */
> -	buf_info = buf_ring->wp;
> -	WARN_ON(buf_info->used);
> -	buf_info->p_addr = mhi_buf->dma_addr;
> -	buf_info->pre_mapped = true;
> -	buf_info->cb_buf = mhi_buf;
> -	buf_info->wp = tre_ring->wp;
> -	buf_info->dir = mhi_chan->dir;
> -	buf_info->len = len;
> -
> -	mhi_tre = tre_ring->wp;
> -
> -	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
> -	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
> -	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
> +	buf_info.p_addr = mhi_buf->dma_addr;
> +	buf_info.cb_buf = mhi_buf;
> +	buf_info.pre_mapped = true;
> +	buf_info.len = len;
>  
> -	/* increment WP */
> -	mhi_add_ring_element(mhi_cntrl, tre_ring);
> -	mhi_add_ring_element(mhi_cntrl, buf_ring);
> +	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
> +	if (unlikely(ret)) {
> +		read_unlock_bh(&mhi_cntrl->pm_lock);
> +		return ret;
> +	}
>  
>  	if (mhi_chan->dir == DMA_TO_DEVICE)
>  		atomic_inc(&mhi_cntrl->pending_pkts);
> @@ -1061,7 +1032,7 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  EXPORT_SYMBOL_GPL(mhi_queue_dma);
>  
>  int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
> -		void *buf, void *cb, size_t buf_len, enum mhi_flags flags)
> +			struct mhi_buf_info *info, enum mhi_flags flags)
>  {
>  	struct mhi_ring *buf_ring, *tre_ring;
>  	struct mhi_tre *mhi_tre;
> @@ -1073,15 +1044,22 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  	tre_ring = &mhi_chan->tre_ring;
>  
>  	buf_info = buf_ring->wp;
> -	buf_info->v_addr = buf;
> -	buf_info->cb_buf = cb;
> +	WARN_ON(buf_info->used);
> +	buf_info->pre_mapped = info->pre_mapped;
> +	if (info->pre_mapped)
> +		buf_info->p_addr = info->p_addr;
> +	else
> +		buf_info->v_addr = info->v_addr;
> +	buf_info->cb_buf = info->cb_buf;
>  	buf_info->wp = tre_ring->wp;
>  	buf_info->dir = mhi_chan->dir;
> -	buf_info->len = buf_len;
> +	buf_info->len = info->len;
>  
> -	ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> -	if (ret)
> -		return ret;
> +	if (!info->pre_mapped) {
> +		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	eob = !!(flags & MHI_EOB);
>  	eot = !!(flags & MHI_EOT);
> @@ -1090,7 +1068,7 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  
>  	mhi_tre = tre_ring->wp;
>  	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
> -	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_len);
> +	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
>  	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
>  
>  	/* increment WP */
> @@ -1107,6 +1085,7 @@ int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
>  							     mhi_dev->dl_chan;
>  	struct mhi_ring *tre_ring;
> +	struct mhi_buf_info buf_info = { };
>  	unsigned long flags;
>  	int ret;
>  
> @@ -1122,7 +1101,11 @@ int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>  	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
>  		return -ENOMEM;
>  
> -	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf, buf, len, mflags);
> +	buf_info.v_addr = buf;
> +	buf_info.cb_buf = buf;
> +	buf_info.len = len;
> +
> +	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
>  	if (unlikely(ret))
>  		return ret;
>  
> @@ -1323,7 +1306,7 @@ int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
>  
>  		while (nr_el--) {
>  			void *buf;
> -
> +			struct mhi_buf_info info = { };
>  			buf = kmalloc(len, GFP_KERNEL);
>  			if (!buf) {
>  				ret = -ENOMEM;
> @@ -1331,8 +1314,10 @@ int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
>  			}
>  
>  			/* Prepare transfer descriptors */
> -			ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf, buf,
> -					  len, MHI_EOT);
> +			info.v_addr = buf;
> +			info.cb_buf = buf;
> +			info.len = len;
> +			ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &info, MHI_EOT);
>  			if (ret) {
>  				kfree(buf);
>  				goto error_pre_alloc;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
