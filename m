Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC730282C97
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJDSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbgJDSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601837251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6A91pVwAgeaoYz6zV+GlM5FMKvind26qqWKHM1z1Y6Y=;
        b=fcItKKlsP9Rj63JZ+RQvWUZEpn3PwyahrIZS/+jstQD5ipo3mCP6ZKkKDLzWEnriEasVh1
        rkQdxAI/iHKacnwAOEvBCT/LrXUJZdnw5tHoHNY/IKEhvdfJKJBV2bRlGdU3iHTQwcAtH3
        89p4rQ295lkcO7HbctN1kDwynQhAXcM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-wnBqD3sgNEOeDztkx_ztdQ-1; Sun, 04 Oct 2020 14:47:29 -0400
X-MC-Unique: wnBqD3sgNEOeDztkx_ztdQ-1
Received: by mail-qt1-f197.google.com with SMTP id t4so912324qtd.23
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6A91pVwAgeaoYz6zV+GlM5FMKvind26qqWKHM1z1Y6Y=;
        b=LLIYspXmGri2ZNc0DWDbUnd637kcfmehxze9Jj+/EjNw8PDMZgbxYhFTWSdHRVoawK
         JXpwlDSKO8AJnd72sSG2R/Ce68ZytXnBQwF4tTkgkgTfW1mvy8c8+iUOekb9/khlNWHf
         cC0EKouHHUxwXzcL4T9y+wBETi4p54kYAAyleLickHzkE1qMLpFQkl2nAKe1kr/Ds/0k
         pcFlPi+bRthFbW2X/PaEMjXiSCQUwvJB8n20UIHk2GUqeL2iKxT5TsmkxYeYsB8xHNqq
         qAD29Th9aUWIhQynP/2KaIYODgtmSvqnpgIoLO0JI71N4TkB8DT2CV9nnU1BS+b3yYUS
         bYAg==
X-Gm-Message-State: AOAM53110dxg0yD+5bmcrUpGbNv/HJvA3Hiy56XtxJ4FDlso76si4t5F
        AqxpqOS74JxJY9KAcv/KTSDH/RWdaSm5r9HN/IC2am3R+pi8z3wY9ZoehelCHp++eXmlMjp1vaA
        FZ19Tx+sygh/zFgm5SuwYdj5w
X-Received: by 2002:a05:620a:95e:: with SMTP id w30mr10991849qkw.403.1601837248823;
        Sun, 04 Oct 2020 11:47:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze76mUl77FL6xMxcU6FHTIo213x/SKyFzCNyRACmRqaDpyiwpYUvw2QbFoE3Fv6YgOc57CNw==
X-Received: by 2002:a05:620a:95e:: with SMTP id w30mr10991835qkw.403.1601837248596;
        Sun, 04 Oct 2020 11:47:28 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o2sm5796485qkk.42.2020.10.04.11.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:47:28 -0700 (PDT)
Subject: Re: [PATCH 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-11-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a49b1d7c-9756-1059-f7a1-25dae460d659@redhat.com>
Date:   Sun, 4 Oct 2020 11:47:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-11-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
> Remove the now obsolete altera_pr_unregister() function.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> We should take another look at this, IIRC correctly the point of
> splitting this up into a separate driver was to make it useable by a
> different (pci?) driver later on.
>
> It doesn't seem like this happened, and I think we should just make this
> a platform driver?
>
> ---
>  drivers/fpga/altera-pr-ip-core-plat.c  | 10 ----------
>  drivers/fpga/altera-pr-ip-core.c       | 14 +-------------
>  include/linux/fpga/altera-pr-ip-core.h |  1 -
>  3 files changed, 1 insertion(+), 24 deletions(-)
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
> index 2cf25fd5e897..dfdf21ed34c4 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -195,22 +195,10 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
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
> -void alt_pr_unregister(struct device *dev)
> -{
> -	struct fpga_manager *mgr = dev_get_drvdata(dev);
> -
> -	dev_dbg(dev, "%s\n", __func__);
> -
> -	fpga_mgr_unregister(mgr);
> -}
> -EXPORT_SYMBOL_GPL(alt_pr_unregister);

Similar to the others, except for removing this symbol.

A patch should do one logical thing.

I'd rather this be split out of the patchset.

Tom

> -
>  MODULE_AUTHOR("Matthew Gerlach <matthew.gerlach@linux.intel.com>");
>  MODULE_DESCRIPTION("Altera Partial Reconfiguration IP Core");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
> index 0b08ac20ab16..a6b4c07858cc 100644
> --- a/include/linux/fpga/altera-pr-ip-core.h
> +++ b/include/linux/fpga/altera-pr-ip-core.h
> @@ -13,6 +13,5 @@
>  #include <linux/io.h>
>  
>  int alt_pr_register(struct device *dev, void __iomem *reg_base);
> -void alt_pr_unregister(struct device *dev);
>  
>  #endif /* _ALT_PR_IP_CORE_H */

