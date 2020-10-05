Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C268284073
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgJEUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729609AbgJEUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601928818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BvD0x1LGXOPbfpL7zHAR3R8a6UNGvp1JCYrSTWMOaE=;
        b=LU8DQhofLh/8sv+KNTsYsZdoho5PGdjKaBdYKtOLtq/krhFb719zkguTV/VQ0umzzLMJH3
        O+uXGY/NfSajwlzbmCUMxJISUGtj51jkhLIuuipdtZqacJTRxmL0F5kPjl9VZBOUWtCF+v
        X/rBtSU0NJW8pNp64SsrbvZynZptIs4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-qQPupEYuNb2jaHRTdn_uXQ-1; Mon, 05 Oct 2020 16:13:37 -0400
X-MC-Unique: qQPupEYuNb2jaHRTdn_uXQ-1
Received: by mail-qk1-f199.google.com with SMTP id m23so7570374qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 13:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5BvD0x1LGXOPbfpL7zHAR3R8a6UNGvp1JCYrSTWMOaE=;
        b=iUZ1kcpYG5Xjfz6FS7+q+CUjJeM9078RFwUx/rylHpTwI/GhwZFKA2S3kC4CDHfRpE
         d21rCA9RzHDa73ZR//SS/x88hSeaz1fDCpnzzM1KiW6+603+xDyh9n8uMIKIoHcCx/Pa
         veKrp3NfGIV4RTOTLBCxtrH1na5H1PTlW2mnOEXVGVET/qbz4NofRBhANMJQvnmHskZ/
         1OqmD88yKeWrhUPacAtpKDN59M7Th4r4AKdCc1ejmaz9JsrnqYxsIqSukhAObD3pq2PN
         6ZwiF0ImguXebW1ilSrEXIf+vem0hleqMrjlJTVdllwr1/j7xa3WK5zoUSPl3gvDgXik
         lv/Q==
X-Gm-Message-State: AOAM530ZmmozzfNekgxAh8wDDaOOD3g/ZMQgCcH0+0UHI/zR7NW86x9Y
        cLWvU2hIp+YTaafeay1Yft7EEbEirGqQ1UOhHExIp+Hed+MBVrx4uAS7c2fbGNSnVqZZCEv4KqG
        NnJ503RU04w/ih0U3w303Cc3z
X-Received: by 2002:aed:2489:: with SMTP id t9mr1658732qtc.358.1601928816600;
        Mon, 05 Oct 2020 13:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIkeczNA3zabL1KGQ5svsN/WDxZgNZb02q2MIfAkohl7n+auh0JUVGTFSaFYKRlVl3FU0Mfw==
X-Received: by 2002:aed:2489:: with SMTP id t9mr1658711qtc.358.1601928816372;
        Mon, 05 Oct 2020 13:13:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z69sm920748qkb.7.2020.10.05.13.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 13:13:35 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify
 registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201005173735.162408-1-mdf@kernel.org>
 <20201005173735.162408-11-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3c9f78f1-a4b0-c1b8-61a1-93e9b7b57999@redhat.com>
Date:   Mon, 5 Oct 2020 13:13:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201005173735.162408-11-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/20 10:37 AM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.

Should change old commit message to something about removing symbol

alt_pr_platform_remove

Otherwise fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Changes from v1:
> - Removed part that removes unused symbol
>
> ---
>  drivers/fpga/altera-pr-ip-core-plat.c | 10 ----------
>  drivers/fpga/altera-pr-ip-core.c      |  4 +---
>  2 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
> index 99b9cc0e70f0..b008a6b8d2d3 100644
> --- a/drivers/fpga/altera-pr-ip-core-plat.c
> +++ b/drivers/fpga/altera-pr-ip-core-plat.c
> @@ -28,15 +28,6 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
>  	return alt_pr_register(dev, reg_base);
>  }
>  
> -static int alt_pr_platform_remove(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -
> -	alt_pr_unregister(dev);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id alt_pr_of_match[] = {
>  	{ .compatible = "altr,a10-pr-ip", },
>  	{},
> @@ -46,7 +37,6 @@ MODULE_DEVICE_TABLE(of, alt_pr_of_match);
>  
>  static struct platform_driver alt_pr_platform_driver = {
>  	.probe = alt_pr_platform_probe,
> -	.remove = alt_pr_platform_remove,
>  	.driver = {
>  		.name	= "alt_a10_pr_ip",
>  		.of_match_table = alt_pr_of_match,
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index 2cf25fd5e897..5b130c4d9882 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -195,9 +195,7 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>  	if (!mgr)
>  		return -ENOMEM;
>  
> -	dev_set_drvdata(dev, mgr);
> -
> -	return fpga_mgr_register(mgr);
> +	return devm_fpga_mgr_register(dev, mgr);
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_register);
>  

