Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662F721A860
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGIUBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 16:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34419 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726771AbgGIUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594324895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G12ohWomnrkg8Oqt/NPeW8Vqi7g3F+tOjv9UH7LVF3o=;
        b=U5apnh1wUDupTobOmdl6NYHoq+i4gdb0GNiMgB65Mgz5TQH7tEMpo4ylcTn4alC6oP/lti
        EH3A8qH1iaGE/yvjHFO7Xmhd05qxjgs2O9Cef5n0rBsX8W+7xYxO2wjvt2Di5DQ3yxjzJ4
        8QjkSn1ZGLo031I8Mabq+D5Yf1DHtfg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Z0XtEYeyOcabRPaz9UEx9g-1; Thu, 09 Jul 2020 16:01:33 -0400
X-MC-Unique: Z0XtEYeyOcabRPaz9UEx9g-1
Received: by mail-qt1-f197.google.com with SMTP id g6so2484008qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=G12ohWomnrkg8Oqt/NPeW8Vqi7g3F+tOjv9UH7LVF3o=;
        b=ZepF4JzjFedESyuMHN0Jb/699Vs3fS97ZwcX6MjU9K1kOHxo2q3O0n4IL7DYeb7Pfy
         tRHBBTWddaa0Gso1sdOnfF2jh0wR7u1nCcGEf19qQo7hDs5uKaN9SSfWoPCBa85/u3IT
         KS39MNfW4bqKDLor7SbjZ+VilmbXQudUEoARS/JoC4v/AelHU7myWPqjG+oiYCAL65GM
         rTgLXeNd8ZPKSkZD4gv1RkmNPfIpaD5hOwmDMV2uCRkLgIBkv25hIkLZOWONWTsbvmdT
         zV1NdZM2Wio2mxELn7aFCfmj4AgqWRWK4yy6RG2CdIJkgpt8nZEKPwk39dXAnwuoBf7N
         JWEg==
X-Gm-Message-State: AOAM531seR/4OFhir+JT+FFKZRHg7+oAt1WaX4nALJmOjhNc4VPTzzk9
        Crf8+pWlHMIkTY5hFe1iAYsegZTTfHbiHWcQwCKDIeCSge7+C3Jowt92XiaODgD3QqJepGeIDWt
        9gjJBGgk0Jbi27CsmGWJgUznW
X-Received: by 2002:a37:aa03:: with SMTP id t3mr64775491qke.152.1594324893278;
        Thu, 09 Jul 2020 13:01:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxACB1C/bMwcxkXUb1YkDL6tCyznoTH5j1W+4eqrGlghyl3xowSDdKoSxD1NHJpbnIvObk73A==
X-Received: by 2002:a37:aa03:: with SMTP id t3mr64775468qke.152.1594324893043;
        Thu, 09 Jul 2020 13:01:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e9sm4586945qtq.70.2020.07.09.13.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 13:01:32 -0700 (PDT)
Subject: Re: [PATCH] fpga: stratix10-soc: make FPGA task un-interruptible
To:     richard.gong@linux.intel.com, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, richard.gong@intel.com
References: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <926c1117-1f31-5b3d-55af-4216db4f1745@redhat.com>
Date:   Thu, 9 Jul 2020 13:01:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly fine, see inline question.

On 7/7/20 9:14 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
> reconfiguration process stops and the user can't perform a new FPGA
> reconfiguration properly.
>
> Set FPGA complete task to be not interruptible so that the user can
> properly perform FPGA reconfiguration after CTRL+C event.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..657a70c 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	if (ret < 0)
>  		goto init_done;
>  
> -	ret = wait_for_completion_interruptible_timeout(
> +	ret = wait_for_completion_timeout(
>  		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>  	if (!ret) {
>  		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>  		ret = -ETIMEDOUT;
>  		goto init_done;
>  	}
> -	if (ret < 0) {
> -		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
> -		goto init_done;
> -	}
>  
>  	ret = 0;
>  	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  		 */
>  		wait_status = 1; /* not timed out */
>  		if (!priv->status)
> -			wait_status = wait_for_completion_interruptible_timeout(
> +			wait_status = wait_for_completion_timeout(
>  				&priv->status_return_completion,
>  				S10_BUFFER_TIMEOUT);
>  
> @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  			ret = -ETIMEDOUT;
>  			break;
>  		}
> -		if (wait_status < 0) {
> -			ret = wait_status;
> -			dev_err(dev,
> -				"error (%d) waiting for svc layer buffers\n",
> -				ret);
> -			break;
> -		}
>  	}
>  
>  	if (!s10_free_buffers(mgr))
> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,

This part is done in an infinite loop, is the loop still needed ?

Reviewed-by: Tom Rix <trix@redhat.com>

>  		if (ret < 0)
>  			break;
>  
> -		ret = wait_for_completion_interruptible_timeout(
> +		ret = wait_for_completion_timeout(
>  			&priv->status_return_completion, timeout);
>  		if (!ret) {
>  			dev_err(dev,
> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  			ret = -ETIMEDOUT;
>  			break;
>  		}
> -		if (ret < 0) {
> -			dev_err(dev,
> -				"error (%d) waiting for RECONFIG_COMPLETED\n",
> -				ret);
> -			break;
> -		}
>  		/* Not error or timeout, so ret is # of jiffies until timeout */
>  		timeout = ret;
>  		ret = 0;

