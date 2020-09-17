Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B188926E6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIQU2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgIQU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600374509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7OxMKZIqNEdEM5TEzPRdP1euPH2y7ZfEYN9HcA0sw4=;
        b=HgyiF7FZNayBbHECVo+d7+psj2YFwjRFrcWpMTSeM7P4Mqs1A8HxiCZgr41KkDP3+grAqf
        Tzg90XjwdJMdXDzlIQRH5AcYcxZNm/MyZhD9VipaRr1F94YlP3RBRvtFRC5w5dtC1tvycl
        0wU3YcuwEKkaQzRAD3LXMUKG1sR7fLw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-84lizx8uNeiv0f6xiZRKaw-1; Thu, 17 Sep 2020 16:28:26 -0400
X-MC-Unique: 84lizx8uNeiv0f6xiZRKaw-1
Received: by mail-ot1-f70.google.com with SMTP id h96so112256oth.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J7OxMKZIqNEdEM5TEzPRdP1euPH2y7ZfEYN9HcA0sw4=;
        b=CsQOCj60cwEQInaUMv1sDx6xoxjD9B68BmFiH005hcoJdVJBWoPzp4OykIaiXWkG5R
         Zgwb5/Ds7HALHMTOGjkiA6DUFhGxodq1Whnmg2IA2BIkILBJN+MDLFLsNM3OdGVdjpI7
         cp3jHMikACfPtiGPVB/uP8kjzBE0AkEA7wUDqQsbhrIUh2ZtArRjD2l0ncsM1Ft71LLF
         LfIR4QpNbVMKq9r5LihFYoIKoVaeJr5IXsY+9tLTjpL0MN69YNJb18Q02qtOZW5FZG8K
         8fB/addjxlw8Ph4DyNkffu3zPHrYYmiekEtrMP7hR8Pnbj8aQwuS5/tmHoES7WPkRWGu
         DH/Q==
X-Gm-Message-State: AOAM530pIelJEP5k5lHsInpZb3vJ+t4p1pohOh2Di95zkOxC/rSpvsK7
        HDAZJArZIMvwR87IbtQkXHsOC6uXGxccJcDLxEkyZSmqihf/scu2GYA5vSWTGDbHfpLGwD2o6eY
        TDNjjA0FlN1xHfB8wKm4Ppn57
X-Received: by 2002:aca:4d91:: with SMTP id a139mr7037762oib.151.1600374505054;
        Thu, 17 Sep 2020 13:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0aRQtoCZ6WZoH5J3UPN0FdfcptpcU8qZae7ItF8IisXAw0SXW+4lYcuU3eVaWSwgL57SzvA==
X-Received: by 2002:aca:4d91:: with SMTP id a139mr7037750oib.151.1600374504793;
        Thu, 17 Sep 2020 13:28:24 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q15sm775818ooh.44.2020.09.17.13.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 13:28:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200917183219.3603-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7f181203-c164-4e6e-c710-1096b0aa13b8@redhat.com>
Date:   Thu, 17 Sep 2020 13:28:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200917183219.3603-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/17/20 11:32 AM, Russ Weight wrote:
> Port enable is not complete until ACK = 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK == 0.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-afu-error.c |  2 +-
>  drivers/fpga/dfl-afu-main.c  | 29 +++++++++++++++++++++--------
>  drivers/fpga/dfl-afu.h       |  2 +-
>  3 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c4691187cca9..0806532a3e9f 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -103,7 +103,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>  	__afu_port_err_mask(dev, false);
>  

There is an earlier bit that sets ret = -EINVAL.

This error will be lost or not handled well.

Right now it doesn't seem to be handled.

>  	/* Enable the Port by clear the reset */
> -	__afu_port_enable(pdev);
> +	ret = __afu_port_enable(pdev);
>  
>  done:
>  	mutex_unlock(&pdata->lock);
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 753cda4b2568..f73b06cdf13c 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -21,6 +21,9 @@
>  
>  #include "dfl-afu.h"
>  
> +#define RST_POLL_INVL 10 /* us */
> +#define RST_POLL_TIMEOUT 1000 /* us */
> +
>  /**
>   * __afu_port_enable - enable a port by clear reset
>   * @pdev: port platform device.
> @@ -32,7 +35,7 @@
>   *
>   * The caller needs to hold lock for protection.
>   */
> -void __afu_port_enable(struct platform_device *pdev)
> +int __afu_port_enable(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	void __iomem *base;
> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
>  	WARN_ON(!pdata->disable_count);
>  
>  	if (--pdata->disable_count != 0)
> -		return;
> +		return 0;
Is this really a success ? Maybe -EBUSY ?
>  
>  	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
>  
> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
>  	v = readq(base + PORT_HDR_CTRL);
>  	v &= ~PORT_CTRL_SFTRST;
>  	writeq(v, base + PORT_HDR_CTRL);
> -}
>  
> -#define RST_POLL_INVL 10 /* us */
> -#define RST_POLL_TIMEOUT 1000 /* us */
> +	/*
> +	 * HW clears the ack bit to indicate that the port is fully out
> +	 * of reset.
> +	 */
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       !(v & PORT_CTRL_SFTRST_ACK),
> +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> +		dev_err(&pdev->dev, "timeout, failure to enable device\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
>  
>  /**
>   * __afu_port_disable - disable a port by hold reset
> @@ -111,7 +124,7 @@ static int __port_reset(struct platform_device *pdev)
>  
>  	ret = __afu_port_disable(pdev);
>  	if (!ret)
> -		__afu_port_enable(pdev);
> +		ret = __afu_port_enable(pdev);
>  
>  	return ret;
>  }
> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
>  static int port_enable_set(struct platform_device *pdev, bool enable)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&pdata->lock);
>  	if (enable)
> -		__afu_port_enable(pdev);
> +		ret = __afu_port_enable(pdev);
>  	else
>  		ret = __afu_port_disable(pdev);
>  	mutex_unlock(&pdata->lock);
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 576e94960086..e5020e2b1f3d 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -80,7 +80,7 @@ struct dfl_afu {
>  };
>  
>  /* hold pdata->lock when call __afu_port_enable/disable */
> -void __afu_port_enable(struct platform_device *pdev);
> +int __afu_port_enable(struct platform_device *pdev);
>  int __afu_port_disable(struct platform_device *pdev);

The other functions in this file have afu_*  since the __afu_port_enable/disable

are used other places would it make sense to remove the '__' prefix ?

If you think so, maybe a cleanup patch later.

Tom

>  
>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);

