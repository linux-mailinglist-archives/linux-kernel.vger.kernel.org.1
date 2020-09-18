Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD2E26F955
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIRJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRJbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:31:22 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655DDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:31:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 764C2293; Fri, 18 Sep 2020 11:31:19 +0200 (CEST)
Date:   Fri, 18 Sep 2020 11:31:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 2/3] iommu: amd: Add support for RMP_PAGE_FAULT and
 RMP_HW_ERR
Message-ID: <20200918093117.GO31590@8bytes.org>
References: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
 <20200916135549.146468-3-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916135549.146468-3-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Wed, Sep 16, 2020 at 01:55:48PM +0000, Suravee Suthikulpanit wrote:
> +static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
> +{
> +	struct pci_dev *pdev;
> +	struct iommu_dev_data *dev_data = NULL;
> +	int devid     = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
> +	int vmg_tag   = (event[1]) & 0xFFFF;
> +	int flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
> +	u64 spa       = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);

Please write this as:

	struct iommu_dev_data *dev_data = NULL;
	int devid, vmg_tag, flags;
	struct pci_dev *pdev;
	u64 spa;

	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
	vmg_tag = (event[1]) & 0xFFFF;
	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
	spa     = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);

Same applied the the next function.

> +
> +	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
> +					   devid & 0xff);
> +	if (pdev)
> +		dev_data = dev_iommu_priv_get(&pdev->dev);
> +
> +	if (dev_data && __ratelimit(&dev_data->rs)) {
> +		pci_err(pdev, "Event logged [RMP_HW_ERROR devid=0x%04x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
> +			devid, vmg_tag, spa, flags);

Printing the devid is not really needed here, no? Same issue in the next
function.

Regards,

	Joerg
