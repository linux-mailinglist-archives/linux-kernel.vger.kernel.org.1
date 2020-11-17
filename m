Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655812B6F80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgKQUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726685AbgKQUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605643285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ND73jfjt6Cg0vVbxjFwNhOqlMoziW1VRnPfbZwD42HI=;
        b=M/d5ylnaZDn9cCuDsU3Cfo+WX4sGGAa4/9bAdQJM5QbyPUZGzYyLvPystTz2ugb27MyxhC
        ammyqoAgQYmLhNRhAXsxtL6uVfwRTmT8WKOwOtT1jI/iubIP2gJf3wOW8OHA6k46KvdyOz
        szKoGBZZbs9wwDiACE+8Uyl0jmz3Y0s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-gqkescO-NWaIulJGxCcy4g-1; Tue, 17 Nov 2020 15:01:23 -0500
X-MC-Unique: gqkescO-NWaIulJGxCcy4g-1
Received: by mail-qv1-f70.google.com with SMTP id c18so1273254qvm.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ND73jfjt6Cg0vVbxjFwNhOqlMoziW1VRnPfbZwD42HI=;
        b=GQiTSwV4MlFFl1P2kjUoBJBEu/7j3dLXMXYvxpCxfGCXrbs/a1IZak5bJO0HOzWM//
         YFSgduNPilMMCBWRrDIkOBKhAHQVBr++81gCbXDanWPZWo7GiEAfNDwGOgAIy7DbGAYR
         9I9rDK17wP/577vtaRZqI910d0jVSQElLYUuemCgHV02GlhujGEl1+wJ9BkLJ7Ye9Xk6
         mPCtd4fd9aYKJ0eMR7RfKe08fLXBMQMxTWDWYcWkmCGSs9+coeFQglQA93BDHamDf9e+
         CVgUObhCMeT3DHvO0kib4vd/B5GCHVswHEgmImpIsEkp8FBT536MPrYWno1z7gE86AH6
         NSfA==
X-Gm-Message-State: AOAM532gXkrnYux18fiYdxB843zL3NbenLo85lbEMSvP1nWCIes9zJAK
        71Wvv7QbIlelyLlFKufNBGviPIdFJAdVNWs8YufZZeQqk3U07OZR1uNwjf5BAvqeQwgyX2AXI6/
        SKlUk8pjJx16ou/0dE8ASjCgx
X-Received: by 2002:ac8:425a:: with SMTP id r26mr882715qtm.294.1605643283261;
        Tue, 17 Nov 2020 12:01:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpFqI4NgZYCgW6oTJavU4GxsEw9QFGdZkruOuOOSrq41bMODuFBbrl9IVKUKQjUfPCI/qpgg==
X-Received: by 2002:ac8:425a:: with SMTP id r26mr882686qtm.294.1605643282988;
        Tue, 17 Nov 2020 12:01:22 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c14sm15069168qko.29.2020.11.17.12.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 12:01:22 -0800 (PST)
Subject: Re: [PATCH 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
To:     matthew.gerlach@linux.intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-2-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <82385a1c-66c6-c311-e504-068be13bbf0e@redhat.com>
Date:   Tue, 17 Nov 2020 12:01:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117012552.262149-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 5:25 PM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> In preparation of looking for dfls based on a vendor
> specific pcie capability, move code that assumes
> Bar0/offset0 as start of DFL to its own function.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 86 ++++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index a2203d03c9e2..b1b157b41942 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -119,49 +119,20 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>  	return table;
>  }
>  
> -/* enumerate feature devices under pci device */
> -static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> +static int find_dfl_in_bar0(struct pci_dev *pcidev,
> +			    struct dfl_fpga_enum_info *info)
>  {
> -	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> -	int port_num, bar, i, nvec, ret = 0;
> -	struct dfl_fpga_enum_info *info;
> -	struct dfl_fpga_cdev *cdev;
>  	resource_size_t start, len;
> +	int port_num, bar, i;
>  	void __iomem *base;
> -	int *irq_table;
> +	int ret = 0;
>  	u32 offset;
>  	u64 v;
>  
> -	/* allocate enumeration info via pci_dev */
> -	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
> -	if (!info)
> -		return -ENOMEM;
> -
> -	/* add irq info for enumeration if the device support irq */
> -	nvec = cci_pci_alloc_irq(pcidev);
> -	if (nvec < 0) {
> -		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> -		ret = nvec;
> -		goto enum_info_free_exit;
> -	} else if (nvec) {
> -		irq_table = cci_pci_create_irq_table(pcidev, nvec);
> -		if (!irq_table) {
> -			ret = -ENOMEM;
> -			goto irq_free_exit;
> -		}
> -
> -		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> -		kfree(irq_table);
> -		if (ret)
> -			goto irq_free_exit;
> -	}
> -
> -	/* start to find Device Feature List in Bar 0 */
> +	/* start to find Device Feature List from Bar 0 */
>  	base = cci_pci_ioremap_bar0(pcidev);
> -	if (!base) {
> -		ret = -ENOMEM;
> -		goto irq_free_exit;
> -	}
> +	if (!base)
> +		return -ENOMEM;
>  
>  	/*
>  	 * PF device has FME and Ports/AFUs, and VF device only has one
> @@ -208,12 +179,53 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  		dfl_fpga_enum_info_add_dfl(info, start, len);
>  	} else {
>  		ret = -ENODEV;
> -		goto irq_free_exit;
>  	}
>  
>  	/* release I/O mappings for next step enumeration */
>  	pcim_iounmap_regions(pcidev, BIT(0));
This ws was already commented on.
>  
> +
> +	return ret;
> +}
> +
> +/* enumerate feature devices under pci device */
> +static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> +{
> +	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +	struct dfl_fpga_enum_info *info;
> +	struct dfl_fpga_cdev *cdev;
> +	int nvec, ret = 0;
> +	int *irq_table;
> +
> +	/* allocate enumeration info via pci_dev */
> +	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* add irq info for enumeration if the device support irq */
> +	nvec = cci_pci_alloc_irq(pcidev);
> +	if (nvec < 0) {
> +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> +		ret = nvec;
> +		goto enum_info_free_exit;
> +	} else if (nvec) {
> +		irq_table = cci_pci_create_irq_table(pcidev, nvec);
> +		if (!irq_table) {
> +			ret = -ENOMEM;
> +			goto irq_free_exit;
> +		}
> +
> +		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> +		kfree(irq_table);
> +		if (ret)
> +			goto irq_free_exit;
> +	}
> +
> +	ret = find_dfl_in_bar0(pcidev, info);
> +
> +	if (ret)
> +		goto irq_free_exit;
> +
>  	/* start enumeration with prepared enumeration information */
>  	cdev = dfl_fpga_feature_devs_enumerate(info);
>  	if (IS_ERR(cdev)) {

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

