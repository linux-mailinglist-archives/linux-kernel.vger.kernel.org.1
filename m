Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C32B0AED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKLRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:05:54 -0500
Received: from foss.arm.com ([217.140.110.172]:54358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgKLRFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:05:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DD6F139F;
        Thu, 12 Nov 2020 09:05:53 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D8543F73C;
        Thu, 12 Nov 2020 09:05:52 -0800 (PST)
Date:   Thu, 12 Nov 2020 17:05:46 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        baolin.wang7@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] arm64: PCI: Validate the node before setting node id for
 root bus
Message-ID: <20201112170546.GA26282@e121166-lin.cambridge.arm.com>
References: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
 <20200928140054.GA11500@willie-the-truck>
 <20200928144957.GA90366@VM20190228-100.tbsite.net>
 <20200928152326.GA15640@e121166-lin.cambridge.arm.com>
 <26284ca5-ea05-0496-629d-9951f49dda8f@linux.alibaba.com>
 <20201001085538.GA5142@e121166-lin.cambridge.arm.com>
 <c9afea6a-4026-05ca-cb6b-9ab7cb513140@linux.alibaba.com>
 <fd8b8138-c3f8-59f6-d57f-704ef5d28d46@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8b8138-c3f8-59f6-d57f-704ef5d28d46@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Jonathan]

On Mon, Nov 09, 2020 at 08:27:09PM +0800, Baolin Wang wrote:

[...]

> I did some investigation for this issue. I am sorry I made some
> misleading description in the commit message. The issue is, when we
> want to disable the NUMA from firmware, we usually just remove the SRAT
> table from the BIOS. But the devices' proximity domain information is
> still remain in the ACPI tables.

I understand and it should not.

> For example, the IORT table still contains the proximity domain
> information for the SMMU devices, so in this case, the SMMU devices still
> can get incorrect NUMA nodes if we remove the SRAT table. But
> the SMMU devices will validate the numa node in
> arm_smmu_v3_set_proximity() to avoid this issue.
> 
> static int  __init arm_smmu_v3_set_proximity(struct device *dev,
> 					      struct acpi_iort_node *node)
> {
> 	struct acpi_iort_smmu_v3 *smmu;
> 
> 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> 	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> 		int dev_node = pxm_to_node(smmu->pxm);
> 
> 		if (dev_node != NUMA_NO_NODE && !node_online(dev_node))
> 			return -EINVAL;
> 
> 		set_dev_node(dev, dev_node);
> 		pr_info("SMMU-v3[%llx] Mapped to Proximity domain %d\n",
> 			smmu->base_address,
> 			smmu->pxm);
> 	}
> 	return 0;
> }
> 
> So similar with SMMU devices, the DSDT table will still contain the PCI
> root host devices' proximity domain though we already remove the SRAT
> table. So I think we still need this validation in
> pcibios_root_bridge_prepare() to avoid this issue like other devices did.
No. The right thing to do is to fix the PXM handling and that's what
Jonathan did:

https://lore.kernel.org/linux-mm/20200818142430.1156547-2-Jonathan.Cameron@huawei.com

Can you try booting with v5.10-rc* and report back the *full* boot log
please ?

> I can update the commit message in next version if you think this is
> reasonable. Thanks.

See above.

Thanks,
Lorenzo
