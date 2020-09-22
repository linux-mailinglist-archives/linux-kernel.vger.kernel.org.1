Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0D2746C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIVQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:39:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ACFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:39:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so18777340lfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jEYTUxgXf40ffFyDS+gnGY/I2xLCtPOv98IxbY5PcTE=;
        b=vOV/OC35IQit1BTLpem91agoDvtw5gjPaKc/7lAUwUYI0y07sEIztMRGiFKE6LeF2u
         eT7t0L3xzRw3jDW4lXZ/yaDOlhSfz67HXlxnue8IPa0cgbvRv5BrmuZTKyCvlAS7mSw3
         9iTm75vXDy507oA69frPL/F/2zSY/lqWXoo+/g+GoMrl8vatMmeelpw+RwS2w+v0XHJb
         s50kW/BU+DCtxU3JvAbzT7W/zcfa4T64mzMuJ5xyF2BN9qHRQKdIMXKmGGjJ3qsOGtjU
         xXLSDQi17w3dFe4bEUH+S3y6KXIySyI6/Igw9+kY7l6IA8kxfc5duL41rENxCNAWcumF
         IQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jEYTUxgXf40ffFyDS+gnGY/I2xLCtPOv98IxbY5PcTE=;
        b=SDteUrij3RqliQ8VWtOnVwB6Ft98IS8K5w0qWG1rtv6LqLa6o/H/uYTd0GqFTZd4zd
         2ok92BEYL0cRSTL5k5Ls4YGtF6MpyXbjxHlfKnovy6xVwd/zvcIsk4tu/SFT/Hg3bazB
         brgoMt6kQ3stFCrcFAc/i21tbf5vx93s2ocdxjXj73xYqntGZujU47wA/fn63fh1CdNC
         jxSFRGvPGhHm0qYBgeEk6NyaUL4dIROEnoEnjTEYqSfjsg1W5VLF/T24FGE9Z8/MuOZ9
         kEmm0TGHOsBtLuOgKgb45IqI2R6qYIuNZ8Mtz1Dp3v4QZpdTlNp18XQ5MWDqeyqDPyZI
         qu0w==
X-Gm-Message-State: AOAM531ybcqNe/j5YK60i3/0EEiPFYPNvrFlzrYmPgHqzQ/LNzRwAmTB
        dJU445t+apK8c2kjb8VS2v1e6g==
X-Google-Smtp-Source: ABdhPJwe51281cmBUhyqJO54eaqY8oLkb7qacqZy1e2LOCYbeZm+HGuE34uHDPz5CWSqywUWX6D6cA==
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr2092932lfk.13.1600792742314;
        Tue, 22 Sep 2020 09:39:02 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id 21sm3636499lfg.263.2020.09.22.09.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:39:01 -0700 (PDT)
Date:   Tue, 22 Sep 2020 18:38:59 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: i2c: add bus retry configuration
Message-ID: <20200922163859.GA1518183@jade>
References: <20200916152732.23604-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916152732.23604-1-jorge@foundries.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:27:32PM +0200, Jorge Ramirez-Ortiz wrote:
> Allow OP-TEE to specify the number of retries in the adaptor.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  drivers/tee/optee/rpc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 1e3614e4798f..2d46a9ecb1de 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  	struct tee_param *params;
>  	size_t i;
>  	int ret = -EOPNOTSUPP;
> +	int retries = 0;
>  	u8 attr[] = {
>  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> @@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  	client.addr = params[0].u.value.c;
>  	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
>  
> +	/* cache the current value */
> +	retries = client.adapter->retries;
> +
>  	switch (params[0].u.value.a) {
>  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> +		client.adapter->retries = params[1].u.value.b;
Do we need to take any locks befor this?

Cheers,
Jens

>  		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
>  				      params[2].u.memref.size);
>  		break;
>  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> +		client.adapter->retries = params[1].u.value.b;
>  		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
>  				      params[2].u.memref.size);
>  		break;
> @@ -126,6 +132,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  			arg->ret = TEEC_SUCCESS;
>  	}
>  
> +	client.adapter->retries = retries;
>  	i2c_put_adapter(client.adapter);
>  	kfree(params);
>  	return;
> -- 
> 2.17.1
> 
