Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E97030459D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393105AbhAZRpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389692AbhAZIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:09:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39FC061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:08:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a1so15439474wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BWSqUOlk+ak9l1rPunOxQ2onISYRzDG2ZO1186X5oyA=;
        b=IXBf/c5lBUIKWLAQ8uYbXCKxxmJ3j3zwMz7OQg3zcntdzeDmQnseUnpzmlaQPeVlt9
         Ef5wsuGWDykn9x8LKu5ARTRhgy9plfvV0EaXBdQRV6LyFEZo7talwJxywyfdgnOP8Ta8
         2GYzlBg1BABfKo/Zb0zZq4rtRFCDPQiZ3MFtpFpPoDc+1bfmXOwLn7t4+aXf6KoGJfS4
         E8+qmdCnuJvx0Nm3yiBl8RAtiH5CRdYjBcq/EYHQdJRsLobzFJ8/fPO9E6l/E+4RsP9S
         0a2k/jDCBLnYcWsecANrjUmYUo2lETmT8Wux6GcHyBZZJjY0m4/hmHy/SALuj/oEaZsd
         kJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BWSqUOlk+ak9l1rPunOxQ2onISYRzDG2ZO1186X5oyA=;
        b=RgSzKZXlMFvPDWBhaAZITZjZa2ZSQzT1GwYvXuGe49096Ftr2NVmCOQhoPYj1RZtcd
         VHCWP57SZalpzlc7cOCxshawBC6doASieElCw/WPmZwfpvyJdz7VmDv19mCHoUBYW8GB
         cqxhZhT0GoRoiTAczurhuw6nVqyQuFfgLYz3YotC2YheXvED+HOnif8JPzUd0xLE2cEA
         wZBpgA3YepK0ABwgOob74EccPYmiWdoSnyQRH99q16iwuflMYlcl54ApGU1G7D3Aihcd
         PcZitlz3nqERL6m1wGqnk+zz3T9Xy7DevKw5evp5uCtcZpmZLOhnTASsCphY8yLbrphP
         FSpA==
X-Gm-Message-State: AOAM532+bjbj20gzMq23Dfu03C4tt3Ku9Nv8/xHnaoizt91mO+rISTj+
        gkc/uUWbwKaBzs2wpMmEE2iSiA==
X-Google-Smtp-Source: ABdhPJyDgpvS0kgkj37xm4VzfVta2m4pc/X4+3xw+9sizjaotltJFHDD+bUkdUmgXyYftECZLcwM5w==
X-Received: by 2002:adf:decf:: with SMTP id i15mr4616287wrn.405.1611648509408;
        Tue, 26 Jan 2021 00:08:29 -0800 (PST)
Received: from trex (182.red-79-146-86.dynamicip.rima-tde.net. [79.146.86.182])
        by smtp.gmail.com with ESMTPSA id w4sm2027547wmc.13.2021.01.26.00.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jan 2021 00:08:28 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Tue, 26 Jan 2021 09:08:27 +0100
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optee: simplify i2c access
Message-ID: <20210126080827.GA26654@trex>
References: <20210125113758.2430680-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125113758.2430680-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Storing a bogus i2c_client structure on the stack adds overhead and
> causes a compile-time warning:
> 
> drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> 
> Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> open-code the i2c_transfer() call, which makes it easier to read
> and avoids the warning.
> 
> Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")

does fixing stack-frame compile warnings need a 'fixes' tag?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 1e3614e4798f..6cbb3643c6c4 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -54,8 +54,9 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  					     struct optee_msg_arg *arg)
>  {
> -	struct i2c_client client = { 0 };
>  	struct tee_param *params;
> +	struct i2c_adapter *adapter;
> +	struct i2c_msg msg = { };
>  	size_t i;
>  	int ret = -EOPNOTSUPP;
>  	u8 attr[] = {
> @@ -85,48 +86,48 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  			goto bad;
>  	}
>  
> -	client.adapter = i2c_get_adapter(params[0].u.value.b);
> -	if (!client.adapter)
> +	adapter = i2c_get_adapter(params[0].u.value.b);
> +	if (!adapter)
>  		goto bad;
>  
>  	if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
> -		if (!i2c_check_functionality(client.adapter,
> +		if (!i2c_check_functionality(adapter,
>  					     I2C_FUNC_10BIT_ADDR)) {
> -			i2c_put_adapter(client.adapter);
> +			i2c_put_adapter(adapter);
>  			goto bad;
>  		}
>  
> -		client.flags = I2C_CLIENT_TEN;
> +		msg.flags = I2C_M_TEN;
>  	}
>  
> -	client.addr = params[0].u.value.c;
> -	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> +	msg.addr = params[0].u.value.c;
> +	msg.buf  = params[2].u.memref.shm->kaddr;
> +	msg.len  = params[2].u.memref.size;
>  
>  	switch (params[0].u.value.a) {
>  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> -		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
> -				      params[2].u.memref.size);
> +		msg.flags |= I2C_M_RD;
>  		break;
>  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> -		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
> -				      params[2].u.memref.size);
>  		break;
>  	default:
> -		i2c_put_adapter(client.adapter);
> +		i2c_put_adapter(adapter);
>  		goto bad;
>  	}
>  
> +	ret = i2c_transfer(adapter, &msg, 1);
> +
>  	if (ret < 0) {
>  		arg->ret = TEEC_ERROR_COMMUNICATION;
>  	} else {
> -		params[3].u.value.a = ret;
> +		params[3].u.value.a = msg.len;
>  		if (optee_to_msg_param(arg->params, arg->num_params, params))
>  			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  		else
>  			arg->ret = TEEC_SUCCESS;
>  	}
>  
> -	i2c_put_adapter(client.adapter);
> +	i2c_put_adapter(adapter);
>  	kfree(params);
>  	return;
>  bad:
> -- 
> 2.29.2
> 
