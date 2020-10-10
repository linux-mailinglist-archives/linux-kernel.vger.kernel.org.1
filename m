Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4528A385
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgJJW46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732120AbgJJTkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602358807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lScSHb5GRh2T45yUL3D8Nuv4fLYCBkJXmfkPANcLZ0g=;
        b=NYVIOVV4VW8r9DiQo8/O8YrsGMux6TnhUUlxHzv8wNllMHHM5lxcrVXIIjAQvsy92RjY+Q
        /u1EVrsXchB3feMX4PKHusJpZBzI+44n8pb2qg7FUCLWIQ7bzcTNARR19XrViJ8BopDqLW
        nMFrwF5gJ4wa7bUVpcmlgWRf7TocEDU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-hUw22CS7MwWL2XiF0E2yIQ-1; Sat, 10 Oct 2020 11:07:11 -0400
X-MC-Unique: hUw22CS7MwWL2XiF0E2yIQ-1
Received: by mail-oo1-f72.google.com with SMTP id o74so5269076ooo.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 08:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lScSHb5GRh2T45yUL3D8Nuv4fLYCBkJXmfkPANcLZ0g=;
        b=maaVRz4E7MceuSsocDBW7raOpgkM+8AEgLE6YHuNi2lr0Wx08TsmvBpBKtWs3GWaf3
         WEwyQNzqH6uDlgPeVi34d9K/72dqm1Hwgwa5KWv5OJV0Ue78B7cwRsaRNDDj+H7Szp72
         Vj7SWAM4JLIb0lcOERJlAZyoNnZhsJkKs/gjap86irH3WhZ0C5+P2Gg96bSrKmJ38geL
         ZhWnCE4AU1hoyIIPt81hq6GYDCfZ0R3RqoiNDe9LtxWRQcn2RHbNnlB14Ma5LXDY8zCO
         YX3JsM4G/Q5XNHzmLU/kb6dGasrFia5GVGXCo6vbX8dbLLWwk/4sEA8jKxMEVSNqCp4C
         NPrQ==
X-Gm-Message-State: AOAM5327YmDQ3wNk5GkmOSTw9dLDTw1BQZUHS0qHb5bEznM0C15Lf7lt
        hA/AsArIUGX4wqHrxV2DLmu1rJ7J8WPP0uH+p5p/5OuePjSyqjEn3Usd2rFN4KRlGQGxOjEe3q7
        jzslD8LkjyQXIfLGW9BYElWOC
X-Received: by 2002:a9d:3a64:: with SMTP id j91mr12166063otc.207.1602342430974;
        Sat, 10 Oct 2020 08:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh7nJmECAqmKKTRnHbW9vZsSCDKSoZMOAeBdsZ+p66fOBHFuqLBgjCWEN5eSrDmBz2yZ4aiQ==
X-Received: by 2002:a9d:3a64:: with SMTP id j91mr12166054otc.207.1602342430696;
        Sat, 10 Oct 2020 08:07:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h3sm8936617oom.18.2020.10.10.08.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 08:07:10 -0700 (PDT)
Subject: Re: [PATCH v9 1/6] fpga: dfl: fix the definitions of type &
 feature_id for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8786ca8f-7edd-d7b1-7eca-6447814c6e5e@redhat.com>
Date:   Sat, 10 Oct 2020 08:07:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602313793-21421-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/20 12:09 AM, Xu Yilun wrote:
> The value of the field dfl_device.type comes from the 12 bits register
> field DFH_ID according to DFL spec. So this patch changes the definition
> of the type field to u16.
>
> Also it is not necessary to illustrate the valid bits of the type field
> in comments. Instead we should explicitly define the possible values in
> the enumeration type for it, because they are shared by hardware spec.
> We should not let the compiler decide these values.
>
> Similar changes are also applied to dfl_device.feature_id.
>
> This patch also fixed the MODALIAS format according to the changes
> above.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v9: no change
> ---
>  drivers/fpga/dfl.c |  3 +--
>  drivers/fpga/dfl.h | 14 +++++++-------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b450870..5a6ba3b 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct dfl_device *ddev = to_dfl_dev(dev);
>  
> -	/* The type has 4 valid bits and feature_id has 12 valid bits */
> -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> +	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
>  			      ddev->type, ddev->feature_id);
>  }
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5dc758f..ac373b1 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>   * enum dfl_id_type - define the DFL FIU types
>   */
>  enum dfl_id_type {
> -	FME_ID,
> -	PORT_ID,
> +	FME_ID = 0,
> +	PORT_ID = 1,

This is redundant, why make this change ?

Tom

>  	DFL_ID_MAX,
>  };
>  
>  /**
>   * struct dfl_device_id -  dfl device identifier
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * @type: DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: feature identifier local to its DFL FIU type.
>   * @driver_data: driver specific data.
>   */
>  struct dfl_device_id {
> -	u8 type;
> +	u16 type;
>  	u16 feature_id;
>  	unsigned long driver_data;
>  };
> @@ -543,7 +543,7 @@ struct dfl_device_id {
>   * @dev: generic device interface.
>   * @id: id of the dfl device.
>   * @type: type of DFL FIU of the device. See enum dfl_id_type.
> - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @feature_id: feature identifier local to its DFL FIU type.
>   * @mmio_res: mmio resource of this dfl device.
>   * @irqs: list of Linux IRQ numbers of this dfl device.
>   * @num_irqs: number of IRQs supported by this dfl device.
> @@ -553,7 +553,7 @@ struct dfl_device_id {
>  struct dfl_device {
>  	struct device dev;
>  	int id;
> -	u8 type;
> +	u16 type;
>  	u16 feature_id;
>  	struct resource mmio_res;
>  	int *irqs;

