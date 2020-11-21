Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CC32BBCB1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgKUDdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgKUDdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:33:37 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F3C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:33:37 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t143so12870130oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0W6xG6y3F3gnH7EIvE3GOz2e53+ghrFEXWYHNYyCC5k=;
        b=HlEY0+cjB7+t/sJ/WxoXZbOxLgtoljIwHI/fkZkk2RxCJdosMVa6DSnTr37LtGk6Bb
         OjZ6LR3dNSX3XWhtBPj8QLofOkWEBVpKZZFE3CgVoA7LUJE3wAarNj5FXbrVy+1sclMF
         mLNunsmTeuuh8d5pPDrcGzPLBYi7Tyb7u8vBxUX5Rt6nFHY9GzY8LxuxrdDe5u+OUTd1
         atgrc/rxb2XI7sAyCkZbOeSn5QEXhBKmwC8yPRZurHLjkvBCJR3ScbvfdRfzMt+MnUdp
         MErnjdA8DFBTQFfeyx9+cxLHhEdiIA8KANfu0/xMhAXKIddTaK8R5OqSACbI7T/fE9HA
         Gm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0W6xG6y3F3gnH7EIvE3GOz2e53+ghrFEXWYHNYyCC5k=;
        b=PIm8EKyKh1pO0IPH3jS4m8UyofpHpsuuCJUayLjm8bP/fw4JKFRhbtvcU4Nf+2PXsF
         H3M8rDgfBZ4pehL0gesW7L4eozXVRgyHLx4jEYht1yX2ABaKy1PpB8JNU7A4cmBvlK4C
         ZW6lgpnMVfQgPtKQtBs1FK9UZPrPTQuuuDocGb9JoIS4P/1+TQzaGsn/+8xF8r+cZZSx
         46PnkRvgqJOsRbMw/u+Cvt0+HFLod42o7uQDNM2jKN8Nk3neK3CKp5EVAiql/RWtpPfp
         /NhIPaQjHPxJxEub3tWvsfFncgiPyjZ8bJ5oPeogsA1xRcQ5IuWxjsgFMAUx7PE8OivW
         /pxw==
X-Gm-Message-State: AOAM532UN6gsDxF+K6+KbHex6L9k5uBl3bWP33HdY5jY9eEGRrVxvhPt
        pNJGL2WJCvwkGXz27pNgHcitng==
X-Google-Smtp-Source: ABdhPJwiOQVYvmMdKWveEETFJf3GhH04fnlmOXe5SgI3pZXTweYwqTTj+UxgsA+ZuGrp7SukJaUgkQ==
X-Received: by 2002:aca:5c82:: with SMTP id q124mr8709268oib.33.1605929616617;
        Fri, 20 Nov 2020 19:33:36 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 1sm2779466oig.16.2020.11.20.19.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 19:33:35 -0800 (PST)
Date:   Fri, 20 Nov 2020 21:33:34 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Add a rproc_set_firmware() API
Message-ID: <20201121033334.GF9177@builder.lan>
References: <20201121032042.6195-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121032042.6195-1-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Nov 21:20 CST 2020, Suman Anna wrote:

> A new API, rproc_set_firmware() is added to allow the remoteproc platform
> drivers and remoteproc client drivers to be able to configure a custom
> firmware name that is different from the default name used during
> remoteproc registration. This function is being introduced to provide
> a kernel-level equivalent of the current sysfs interface to remoteproc
> client drivers, and can only change firmwares when the remoteproc is
> offline. This allows some remoteproc drivers to choose different firmwares
> at runtime based on the functionality the remote processor is providing.
> The TI PRU Ethernet driver will be an example of such usage as it
> requires to use different firmwares for different supported protocols.
> 
> Also, update the firmware_store() function used by the sysfs interface
> to reuse this function to avoid code duplication.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c  | 63 +++++++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_sysfs.c | 33 +-------------
>  include/linux/remoteproc.h            |  1 +
>  3 files changed, 66 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index dab2c0f5caf0..46c2937ebea9 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1934,6 +1934,69 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  #endif
>  EXPORT_SYMBOL(rproc_get_by_phandle);
>  
> +/**
> + * rproc_set_firmware() - assign a new firmware
> + * @rproc: rproc handle to which the new firmware is being assigned
> + * @fw_name: new firmware name to be assigned
> + *
> + * This function allows remoteproc drivers or clients to configure a custom
> + * firmware name that is different from the default name used during remoteproc
> + * registration. The function does not trigger a remote processor boot,
> + * only sets the firmware name used for a subsequent boot. This function
> + * should also be called only when the remote processor is offline.
> + *
> + * This allows either the userspace to configure a different name through
> + * sysfs or a kernel-level remoteproc or a remoteproc client driver to set
> + * a specific firmware when it is controlling the boot and shutdown of the
> + * remote processor.
> + *
> + * Return: 0 on success or a negative value upon failure
> + */
> +int rproc_set_firmware(struct rproc *rproc, const char *fw_name)
> +{
> +	struct device *dev;
> +	int ret, len;
> +	char *p;
> +
> +	if (!rproc || !fw_name)
> +		return -EINVAL;
> +
> +	dev = rproc->dev.parent;
> +
> +	ret = mutex_lock_interruptible(&rproc->lock);
> +	if (ret) {
> +		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
> +		return -EINVAL;
> +	}
> +
> +	if (rproc->state != RPROC_OFFLINE) {
> +		dev_err(dev, "can't change firmware while running\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	len = strcspn(fw_name, "\n");
> +	if (!len) {
> +		dev_err(dev, "can't provide empty string for firmware name\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	p = kstrndup(fw_name, len, GFP_KERNEL);
> +	if (!p) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	kfree(rproc->firmware);
> +	rproc->firmware = p;
> +
> +out:
> +	mutex_unlock(&rproc->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(rproc_set_firmware);
> +
>  static int rproc_validate(struct rproc *rproc)
>  {
>  	switch (rproc->state) {
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 3fd18a71c188..cf846caf2e1a 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -159,42 +159,13 @@ static ssize_t firmware_store(struct device *dev,
>  			      const char *buf, size_t count)
>  {
>  	struct rproc *rproc = to_rproc(dev);
> -	char *p;
> -	int err, len = count;
> +	int err;
>  
>  	/* restrict sysfs operations if not allowed by remoteproc drivers */
>  	if (rproc->deny_sysfs_ops)
>  		return -EPERM;
>  
> -	err = mutex_lock_interruptible(&rproc->lock);
> -	if (err) {
> -		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
> -		return -EINVAL;
> -	}
> -
> -	if (rproc->state != RPROC_OFFLINE) {
> -		dev_err(dev, "can't change firmware while running\n");
> -		err = -EBUSY;
> -		goto out;
> -	}
> -
> -	len = strcspn(buf, "\n");
> -	if (!len) {
> -		dev_err(dev, "can't provide a NULL firmware\n");
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
> -	p = kstrndup(buf, len, GFP_KERNEL);
> -	if (!p) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -
> -	kfree(rproc->firmware);
> -	rproc->firmware = p;
> -out:
> -	mutex_unlock(&rproc->lock);
> +	err = rproc_set_firmware(rproc, buf);
>  
>  	return err ? err : count;
>  }
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index dbc3767f7d0e..6e04b99413f8 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -655,6 +655,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
>  
>  int rproc_boot(struct rproc *rproc);
>  void rproc_shutdown(struct rproc *rproc);
> +int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
>  void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
>  int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
>  int rproc_coredump_add_custom_segment(struct rproc *rproc,
> -- 
> 2.28.0
> 
