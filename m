Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98794283404
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJEKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:35:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbgJEKfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:35:43 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 966FAD6551D65A98996D;
        Mon,  5 Oct 2020 11:35:41 +0100 (IST)
Received: from localhost (10.52.124.175) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 5 Oct 2020
 11:35:41 +0100
Date:   Mon, 5 Oct 2020 11:33:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <robin.murphy@arm.com>
Subject: Re: [PATCH v3 14/14] iommu/amd: Adopt IO page table framework
Message-ID: <20201005103357.000062d9@Huawei.com>
In-Reply-To: <20201004014549.16065-15-suravee.suthikulpanit@amd.com>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
        <20201004014549.16065-15-suravee.suthikulpanit@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.175]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Oct 2020 01:45:49 +0000
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Switch to using IO page table framework for AMD IOMMU v1 page table.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

One minor thing inline.


> ---
>  drivers/iommu/amd/iommu.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 77f44b927ae7..6f8316206fb8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -32,6 +32,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/percpu.h>
>  #include <linux/iova.h>
> +#include <linux/io-pgtable.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/io_apic.h>
>  #include <asm/apic.h>
> @@ -1573,6 +1574,22 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
>  	return ret;
>  }
>  
> +struct io_pgtable_ops *
> +amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
> +			       struct protection_domain *domain)
> +{
> +	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
> +
> +	domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +		.ias		= IOMMU_IN_ADDR_BIT_SIZE,
> +		.oas		= IOMMU_OUT_ADDR_BIT_SIZE,
> +		.iommu_dev	= &iommu->dev->dev,
> +	};
> +
> +	return alloc_io_pgtable_ops(AMD_IOMMU_V1, &domain->iop.pgtbl_cfg, domain);
> +}
> +
>  /*
>   * If a device is not yet associated with a domain, this function makes the
>   * device visible in the domain
> @@ -1580,6 +1597,7 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
>  static int attach_device(struct device *dev,
>  			 struct protection_domain *domain)
>  {
> +	struct io_pgtable_ops *pgtbl_ops;
>  	struct iommu_dev_data *dev_data;
>  	struct pci_dev *pdev;
>  	unsigned long flags;
> @@ -1623,6 +1641,12 @@ static int attach_device(struct device *dev,
>  skip_ats_check:
>  	ret = 0;
>  
> +	pgtbl_ops = amd_iommu_setup_io_pgtable_ops(dev_data, domain);
> +	if (!pgtbl_ops) {

Perhaps cleaner to not store in a local variable if you aren't going to use it?

	if (!amd_iommu_setup_io_pgtable_ops(dev_data, domain)) {

> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	do_attach(dev_data, domain);
>  
>  	/*
> @@ -1958,6 +1982,8 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
>  	if (domain->dev_cnt > 0)
>  		cleanup_domain(domain);
>  
> +	free_io_pgtable_ops(&domain->iop.iop.ops);
> +
>  	BUG_ON(domain->dev_cnt != 0);
>  
>  	if (!dom)


