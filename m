Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5A297CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 16:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762061AbgJXOji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 10:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762049AbgJXOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 10:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603550375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry89cem/wTBCz8O1darsRTxCLuVRm4xCsyF08Cu2Qe8=;
        b=ZvZG9JrzW2Tpr7+P+EITLoIg1IoQ6537CIuKPIXI2S/EGS+FD+IgXCoU2uJ4VRAhPu+A+7
        rEqMGAIvWQA8l17QdzrKqq4TdnLEXc3F8YFHpzUNAz/O1oP+PtZlKnN/+D3Ibh/fu5sXjj
        mFnqpLAoe+JmINaJQ4mvZVR70mYil8U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-OFznxDOOMJmc_RqxiQFuFA-1; Sat, 24 Oct 2020 10:39:33 -0400
X-MC-Unique: OFznxDOOMJmc_RqxiQFuFA-1
Received: by mail-oi1-f199.google.com with SMTP id j9so3246122oii.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 07:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ry89cem/wTBCz8O1darsRTxCLuVRm4xCsyF08Cu2Qe8=;
        b=gLCGXup//Qpvh2X7qx+ZRB6X++IYITFrWUfOIdyDWcjNDKBTyBOLiKb0qBlhZThAB3
         Xaft4Pv9F30V3/uICCNCVvd/Wo2U0t2+IhTI0eGdBCgfWvPjjIyv9mv6q9Xvy0UvVPUh
         pDGSHSJCnHtQQDPzWlMYr7RErdbloMlOofeH5zFX4P0x8Xl/12wfwf8Tfrrx4PVCd51J
         MvPe0BmvuwuYSoWGhcteTrXtCHGp+ptV3KZDTUvFyvdNN62a2adx6A7S8tfJOD4rrNMt
         Od0cDxKgkxXX88omlfgQ/Apih6JHkoKxuyk6pC2l7mXiCunz07bNideR4omFV9ELd5IK
         MBfA==
X-Gm-Message-State: AOAM532gEgPMqyJ6LPfQPuYBfjfGxW2uIFmYt8utrQW6cI7HK4qKkFzR
        eb65bW94rhnNy+pE261xeboiMf0jn1GgjOn3lzn0ikS9NG9mg9jtGQxYO4vPFgYBWf0cLZ6CahC
        A6nUyc8IqFYUrx857DTmsELF3
X-Received: by 2002:a54:4588:: with SMTP id z8mr6416247oib.147.1603550372504;
        Sat, 24 Oct 2020 07:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo9STt2IooDvh0rYe35QbKRqdfyDKG60v+c/fhEIX+0Tr5CXgeE7ZQwDtyl0G/VLxHkDsaIA==
X-Received: by 2002:a54:4588:: with SMTP id z8mr6416231oib.147.1603550372279;
        Sat, 24 Oct 2020 07:39:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h25sm1225130otj.41.2020.10.24.07.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 07:39:31 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] fpga: dfl: add an API to get the base device for
 dfl device
To:     Xu Yilun <yilun.xu@intel.com>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        mdf@kernel.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        netdev@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1603442745-13085-1-git-send-email-yilun.xu@intel.com>
 <1603442745-13085-4-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <32af36de-3ac5-ea7b-4d81-bccf4de3f11d@redhat.com>
Date:   Sat, 24 Oct 2020 07:39:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1603442745-13085-4-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/23/20 1:45 AM, Xu Yilun wrote:
> This patch adds an API for dfl devices to find which physical device
> owns the DFL.
>
> This patch makes preparation for supporting DFL Ether Group private
> feature driver. It uses this information to determine which retimer
> device physically connects to which ether group.
device is physically
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/fpga/dfl.c  | 9 +++++++++
>  include/linux/dfl.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index ca3c678..52d18e6 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -558,6 +558,15 @@ int dfl_dev_get_vendor_net_cfg(struct dfl_device *dfl_dev)
>  }
>  EXPORT_SYMBOL_GPL(dfl_dev_get_vendor_net_cfg);
>  
> +struct device *dfl_dev_get_base_dev(struct dfl_device *dfl_dev)
> +{
> +	if (!dfl_dev || !dfl_dev->cdev)
> +		return NULL;
> +
> +	return dfl_dev->cdev->parent;
> +}
> +EXPORT_SYMBOL_GPL(dfl_dev_get_base_dev);

This name is awkward. maybe

dfl_dev_parent() or dfl_dev_base()


> +
>  #define is_header_feature(feature) ((feature)->id == FEATURE_ID_FIU_HEADER)
>  
>  /**
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 5ee2b1e..dd313f2 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -68,6 +68,7 @@ struct dfl_driver {
>  #define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
>  
>  int dfl_dev_get_vendor_net_cfg(struct dfl_device *dfl_dev);
> +struct device *dfl_dev_get_base_dev(struct dfl_device *dfl_dev);

Because this is an external interface these should have comments

This is another generic change and should be split out of the patchset.

I believe the generic changes would have an easier time being accepted and could be done in parallel as the harder part of the private features is worked out.

Tom

>  
>  /*
>   * use a macro to avoid include chaining to get THIS_MODULE.

