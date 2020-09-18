Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5C270296
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgIRQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgIRQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:51:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F4C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:51:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k14so3801776pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i626wvoZabMUjQF03JmQZni3WGRHoiP51qRJmlnUzb0=;
        b=YKmu7ZR3YGw2pkUc7qAyLWNw1ToEY5uahh0b1nu5RQvb8S4pY4wcQ13TxT6CgW+j/R
         oj0K1BKhmkewY/6A75ltzB50km/zgemL/2F/PdATuq6vmOoX6n4qWeIg4UPMgL/pWA9p
         9FYHn/c4Yr9+fcznMotxQqSKu59kwSATZgMMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i626wvoZabMUjQF03JmQZni3WGRHoiP51qRJmlnUzb0=;
        b=isUhCLNmeik1OgOUcPOW5efSwUdf1ptlpxkbkLzixzcQzi7y/wNs28cQcZaMsVesf6
         SOgpruTnkO2GN9ZS/8hA7k5cyI679XZK8q1MaD7cF2uAxNKOgBRG1vKLs29iXOvdjCqP
         7NkeW/8imf2QB/yEFKpMjbKxPrnd2br0sAQ9a1MQo/F1KjHnYeBtL1nAqg/zy82PkYCS
         q62rm9k082xBwaFLP+9hQmoRUSrV+LfBjY0M8JxCkZySE+iwCtoJkTH6RyTkQo6RYY/d
         h+nRR7aNkGmxztg47xU1dPXtWH41z4wq2Xo7sxd3pQaLF37OQRn598sgXCc+EVK2lOS0
         Uozg==
X-Gm-Message-State: AOAM532f+B52X07+w66r+UFIuRjhhG4oygKq1r8j6fwyoooRrV9/SJCI
        rQMuSU0FNXZuVsicR1/1bnCjaGX8X0vSPrJ0PqbG8+EocZa4pJRm37CVPskFWzw36jQ8uhjwYpH
        drS0YMzOnm7rtiMt7X1m6MU8ItFYXAJ/DEae4RrOzKG6M22fcrBNm9AbWRi6WsSRWXM+oE2E/6k
        /FAzWNRw==
X-Google-Smtp-Source: ABdhPJz3HEhhD/ld3oY53TTJk0XHUv+g7pkTSJgO1zGCpQBObxHFfuD8bItjZA2V95MR/YmpiFIoKQ==
X-Received: by 2002:a65:4689:: with SMTP id h9mr27004067pgr.50.1600447859418;
        Fri, 18 Sep 2020 09:50:59 -0700 (PDT)
Received: from [10.136.8.253] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a14sm3274806pju.30.2020.09.18.09.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 09:50:58 -0700 (PDT)
Subject: Re: [PATCH -next] PCI: iproc: use module_bcma_driver to simplify the
 code
To:     Liu Shixin <liushixin2@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200918030829.3946025-1-liushixin2@huawei.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c990bc93-b5f4-2464-faf2-9b6893fc5dae@broadcom.com>
Date:   Fri, 18 Sep 2020 09:50:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918030829.3946025-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 8:08 PM, Liu Shixin wrote:
> module_bcma_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pci/controller/pcie-iproc-bcma.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
> index aa55b064f64d..56b8ee7bf330 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
> @@ -94,18 +94,7 @@ static struct bcma_driver iproc_pcie_bcma_driver = {
>  	.probe		= iproc_pcie_bcma_probe,
>  	.remove		= iproc_pcie_bcma_remove,
>  };
> -
> -static int __init iproc_pcie_bcma_init(void)
> -{
> -	return bcma_driver_register(&iproc_pcie_bcma_driver);
> -}
> -module_init(iproc_pcie_bcma_init);
> -
> -static void __exit iproc_pcie_bcma_exit(void)
> -{
> -	bcma_driver_unregister(&iproc_pcie_bcma_driver);
> -}
> -module_exit(iproc_pcie_bcma_exit);
> +module_bcma_driver(iproc_pcie_bcma_driver);
>  
>  MODULE_AUTHOR("Hauke Mehrtens");
>  MODULE_DESCRIPTION("Broadcom iProc PCIe BCMA driver");
> 

Looks good to me. Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>
