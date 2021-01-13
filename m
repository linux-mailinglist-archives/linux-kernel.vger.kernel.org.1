Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6B2F4D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbhAMOkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhAMOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:40:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6CAC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:39:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so3354956ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MYW+JMIK7fbk+eC8H+33Jw+zQ8og6pivFWEN9pAGGvI=;
        b=JgTn1qguYkoyOmMS7BgdF9CRqU5nyFFiTfB79OeJKVhn7Aox9Xi6q9gGXG/CUtjHOj
         ZVkHUkW+oc1QUP6eHO1Qe4uNikQTslBnBlckfTialBEYv4NRzxBr+IijNbaG+VrV/CwP
         fwpBfInle+o20TPRXDCrvt7uQiMgwDqMHU7EnRd5u0Ut/ppm3YrtM/yxRb8RwtxT90wS
         AqodCIV5BHFVm1HjS44e0pidpZRsQTNeqttRw0FMwwgIWXq2Dd8fLcj93+Ea1kfOSAiP
         nDp7rf3CZlES17XO+h5DPHKddn1jM5j0OKVthznHCSH45ih41rHhPirFsPPrReOJOzqU
         tBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MYW+JMIK7fbk+eC8H+33Jw+zQ8og6pivFWEN9pAGGvI=;
        b=ThABIhigXiMwtvEOC2q5SlH1YYCBV/AfhubaEfEkPrnlnzqDvwOWBoQ7X9Ub0KebjV
         JSAjNsJmsxRYN/OFf08CoGL5GTwEgyhlFIzNz6Ifc1LwJv5K6CklKMfzhsNTkW46toMQ
         +hNC2LvU7ySi831kB7zqaFQP62MRKe4pmBQzihUx5c+w0tgOyy1fSl7P5sBViIHKEi00
         mdp90G9JZGmVXimfEXFXRJJGvLWJpZowRBnHs2Nn7BRRYWaDu6wECXqKh3SU9xYqfMFY
         Lt+2tYPnQs5E43ZRmomLOhlnm5efcNilw86lShFOxh5dEHV+JYssWNSI+V8gAUaRRnp0
         S/PQ==
X-Gm-Message-State: AOAM530Ib7ugbrexUEuutP0WaxQdQHiqbxi8vTTT73zDSxyZm1NGAZni
        cPuDNqfyQXlpSXAG1d2RO6VlcQ==
X-Google-Smtp-Source: ABdhPJyd7xGYYqpY3tuNEwx5BCsP64NxMEafUFL8S5uIhIPMfrg5AAKTtWE6o3+wINjogXVmOHDrsA==
X-Received: by 2002:a17:906:d146:: with SMTP id br6mr1749655ejb.331.1610548764267;
        Wed, 13 Jan 2021 06:39:24 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id z1sm957095edm.89.2021.01.13.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:39:23 -0800 (PST)
Date:   Wed, 13 Jan 2021 15:39:05 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, kenneth-lee-2012@foxmail.com,
        wangzhou1@hisilicon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH] PCI: Add a quirk to enable SVA for HiSilicon chip
Message-ID: <X/8GCc9e/2GmYOyz@myrica>
References: <20210112170230.GA1838341@bjorn-Precision-5520>
 <b9fd8097-85f9-408d-f58c-b26dd21f3aa0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9fd8097-85f9-408d-f58c-b26dd21f3aa0@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 08:05:11PM +0800, Zhangfei Gao wrote:
> > > +	/* Device-tree can set the stall property */
> > > +	if (!pdev->dev.of_node &&
> > > +	    device_add_properties(&pdev->dev, properties))
> > Does this mean "dma-can-stall" *can* be set via DT, and if it is, this
> > quirk is not needed?  So is this quirk basically a workaround for an
> > old or broken DT?
> The quirk is still needed for uefi case, since uefi can not describe the
> endpoints (peripheral devices).

Yes, this comment isn't very clear. How about
	/*
	 * Set the dma-can-stall property on ACPI platforms. Device tree
	 * can set it directly.
	 */ 

> > 
> > > +		pci_warn(pdev, "could not add stall property");
> > > +}
> > > +
> > Remove this blank line to follow the style of the rest of the file.
> > 
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
> > > +
> > >   /*
> > >    * It's possible for the MSI to get corrupted if SHPC and ACPI are used
> > >    * together on certain PXH-based systems.
> 
> How about changes like this
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 68f53f7..886ea26 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2466,6 +2466,9 @@ static int arm_smmu_enable_pasid(struct
> arm_smmu_master *master)
>      if (num_pasids <= 0)
>          return num_pasids;
> 
> +    if (master->stall_enabled)
> +        pdev->pasid_no_tlp = 1;
> +

From the SMMU perspective there is no relation between stall and pasid, so
I don't think this makes a lot of sense. Could we instead set pasid_no_tlp
for the list of device IDs above?

I agree with splitting the patches. PASID support for SMMUv3 is upstream,
but the introduction of dma-can-stall, which this depends on, is still
pending on the list.

Thanks,
Jean
