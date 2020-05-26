Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0911C96B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 18:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEGQlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 12:41:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:21292 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgEGQlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:41:01 -0400
IronPort-SDR: V+EVhH54npwUFooFSyBXESkwVRG1IV/ZUbtx9PuskHbq5ySbJf3W9vTlFNTzY0wYYsad+tWjz4
 PiHm4gSFQPoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 09:41:00 -0700
IronPort-SDR: y/fdpHUpuRWavjaCIWw/VG9lnFOMSx4/mDNd/RiY3KqeeUtX9aU7JBbcyzHWw5kNUzNIfcmL29
 7V3gnCOklWRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="407699732"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2020 09:40:59 -0700
Date:   Thu, 7 May 2020 09:47:06 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 2/5] iommu/vt-d: debugfs: Add support to show inv
 queue internals
Message-ID: <20200507094706.6f6a605f@jacob-builder>
In-Reply-To: <20200507005534.3080-3-baolu.lu@linux.intel.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
        <20200507005534.3080-3-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

Very helpful feature, thanks for doing this. Just a small suggestion.

On Thu,  7 May 2020 08:55:31 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Export invalidation queue internals of each iommu device through the
> debugfs.
> 
> Example of such dump on a Skylake machine:
> 
> $ sudo cat /sys/kernel/debug/iommu/intel/invalidation_queue
> Invalidation queue on IOMMU: dmar1
>  Base: 0x1672c9000      Head: 80        Tail: 80
> Index           qw0                     qw1                     status
>     0   0000000000000004        0000000000000000
> 0000000000000000 1   0000000200000025        00000001672be804
> 0000000000000000 2   0000000000000011        0000000000000000
> 0000000000000000 3   0000000200000025        00000001672be80c
> 0000000000000000 4   00000000000000d2        0000000000000000
> 0000000000000000 5   0000000200000025        00000001672be814
> 0000000000000000 6   0000000000000014        0000000000000000
> 0000000000000000 7   0000000200000025        00000001672be81c
> 0000000000000000 8   0000000000000014        0000000000000000
> 0000000000000000 9   0000000200000025        00000001672be824
> 0000000000000000
> 
Head and Tail shows the offset, and queue is dump with index. Would it
be nice to mark where the Head and Tail is in the list?
In your example, the queue is empty (H=T), would be nice to see where
the previous entry is if there were any faults.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu-debugfs.c | 62
> +++++++++++++++++++++++++++++ 1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu-debugfs.c
> b/drivers/iommu/intel-iommu-debugfs.c index
> 3eb1fe240fb0..e3089865b8f3 100644 ---
> a/drivers/iommu/intel-iommu-debugfs.c +++
> b/drivers/iommu/intel-iommu-debugfs.c @@ -372,6 +372,66 @@ static int
> domain_translation_struct_show(struct seq_file *m, void *unused) }
>  DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
>  
> +static void invalidation_queue_entry_show(struct seq_file *m,
> +					  struct intel_iommu *iommu)
> +{
> +	int index, shift = qi_shift(iommu);
> +	struct qi_desc *desc;
> +	int offset;
> +
> +	if (ecap_smts(iommu->ecap))
> +		seq_puts(m,
> "Index\t\tqw0\t\t\tqw1\t\t\tqw2\t\t\tqw3\t\t\tstatus\n");
> +	else
> +		seq_puts(m, "Index\t\tqw0\t\t\tqw1\t\t\tstatus\n");
> +
> +	for (index = 0; index < QI_LENGTH; index++) {
> +		offset = index << shift;
> +		desc = iommu->qi->desc + offset;
> +		if (ecap_smts(iommu->ecap))
> +			seq_printf(m,
> "%5d\t%016llx\t%016llx\t%016llx\t%016llx\t%016x\n",
> +				   index, desc->qw0, desc->qw1,
> +				   desc->qw2, desc->qw3,
> +				   iommu->qi->desc_status[index]);
> +		else
> +			seq_printf(m,
> "%5d\t%016llx\t%016llx\t%016x\n",
> +				   index, desc->qw0, desc->qw1,
> +				   iommu->qi->desc_status[index]);
> +	}
> +}
> +
> +static int invalidation_queue_show(struct seq_file *m, void *unused)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	struct q_inval *qi;
> +	int shift;
> +
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		qi = iommu->qi;
> +		shift = qi_shift(iommu);
> +
> +		if (!qi || !ecap_qis(iommu->ecap))
> +			continue;
> +
> +		seq_printf(m, "Invalidation queue on IOMMU: %s\n",
> iommu->name); +
> +		raw_spin_lock_irqsave(&qi->q_lock, flags);
> +		seq_printf(m, " Base: 0x%llx\tHead: %lld\tTail:
> %lld\n",
> +			   virt_to_phys(qi->desc),
> +			   dmar_readq(iommu->reg + DMAR_IQH_REG) >>
> shift,
> +			   dmar_readq(iommu->reg + DMAR_IQT_REG) >>
> shift);
> +		invalidation_queue_entry_show(m, iommu);
> +		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> +		seq_putc(m, '\n');
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(invalidation_queue);
> +
>  #ifdef CONFIG_IRQ_REMAP
>  static void ir_tbl_remap_entry_show(struct seq_file *m,
>  				    struct intel_iommu *iommu)
> @@ -490,6 +550,8 @@ void __init intel_iommu_debugfs_init(void)
>  	debugfs_create_file("domain_translation_struct", 0444,
>  			    intel_iommu_debug, NULL,
>  			    &domain_translation_struct_fops);
> +	debugfs_create_file("invalidation_queue", 0444,
> intel_iommu_debug,
> +			    NULL, &invalidation_queue_fops);
>  #ifdef CONFIG_IRQ_REMAP
>  	debugfs_create_file("ir_translation_struct", 0444,
> intel_iommu_debug, NULL, &ir_translation_struct_fops);

[Jacob Pan]
