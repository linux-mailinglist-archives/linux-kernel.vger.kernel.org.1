Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933401A98EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895555AbgDOJab convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Apr 2020 05:30:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:40276 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895529AbgDOJaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:30:20 -0400
IronPort-SDR: XAGK+kAv//POpVwkO63ovpawwZbOaSJ/iRjeF2SIgL96iLh45I/gl/OfIwEWw2FQnXoriuLEAB
 bC4kupd8OtTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 02:30:17 -0700
IronPort-SDR: yM53F0BqUjgFsaDl9yfqZonlhinnz2Q8mQ5cZVayuk7Ezt98ExL1qraLe7SEXiWUq+pG/+DJBy
 mg7unbdi2o2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="253471562"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 02:30:17 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 02:30:17 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 02:30:16 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 17:30:14 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/7] iommu/vt-d: Save prq descriptors in an internal
 list
Thread-Topic: [PATCH v2 5/7] iommu/vt-d: Save prq descriptors in an internal
 list
Thread-Index: AQHWEubRQl+z5SUG+E2NKgqcVznRXah56kTQ
Date:   Wed, 15 Apr 2020 09:30:13 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D8207B2@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-6-baolu.lu@linux.intel.com>
In-Reply-To: <20200415052542.30421-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 15, 2020 1:26 PM
> 
> Currently, the page request interrupt thread handles the page
> requests in the queue in this way:
> 
> - Clear PPR bit to ensure new interrupt could come in;
> - Read and record the head and tail registers;
> - Handle all descriptors between head and tail;
> - Write tail to head register.
> 
> This might cause some descriptors to be handles multiple times.
> An example sequence:
> 
> - Thread A got scheduled with PRQ_1 and PRQ_2 in the queue;
> - Thread A clear the PPR bit and record the head and tail;
> - A new PRQ_3 comes and Thread B gets scheduled;
> - Thread B record the head and tail which includes PRQ_1
>   and PRQ_2.

I may overlook something but isn't the prq interrupt thread
per iommu then why would two prq threads contend here?

Thanks,
Kevin

> 
> As the result, PRQ_1 and PRQ_2 are handled twice in Thread_A and
> Thread_B.
> 
>        Thread_A            Thread_B
>       .--------.          .--------.
>       |        |          |        |
>       .--------.          .--------.
>   head| PRQ_1  |      head| PRQ_1  |
>       .--------.          .--------.
>       | PRQ_2  |          | PRQ_2  |
>       .--------.          .--------.
>   tail|        |          | PRQ_3  |
>       .--------.          .--------.
>       |        |      tail|        |
>       '--------'          '--------'
> 
> To avoid this, probably, we need to apply a spinlock to ensure
> that PRQs are handled in a serialized way. But that means the
> intel_svm_process_prq() will be called with a spinlock held.
> This causes extra complexities in intel_svm_process_prq().
> 
> This aims to make PRQ descriptors to be handled in a serialized
> way while remove the requirement of holding the spin lock in
> intel_svm_process_prq() by saving the descriptors in a list.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c   | 58 ++++++++++++++++++++++++++++++-------
>  include/linux/intel-iommu.h |  2 ++
>  2 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index a1921b462783..05aeb8ea51c4 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -50,6 +50,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
>  		return ret;
>  	}
>  	iommu->pr_irq = irq;
> +	INIT_LIST_HEAD(&iommu->prq_list);
> +	spin_lock_init(&iommu->prq_lock);
> 
>  	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-
> prq", iommu->seq_id);
> 
> @@ -698,6 +700,14 @@ struct page_req_dsc {
> 
>  #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
> 
> +struct page_req {
> +	struct list_head list;
> +	struct page_req_dsc desc;
> +	unsigned int processing:1;
> +	unsigned int drained:1;
> +	unsigned int completed:1;
> +};
> +
>  static bool access_error(struct vm_area_struct *vma, struct page_req_dsc
> *req)
>  {
>  	unsigned long requested = 0;
> @@ -842,34 +852,60 @@ static void process_single_prq(struct intel_iommu
> *iommu,
>  	}
>  }
> 
> -static void intel_svm_process_prq(struct intel_iommu *iommu,
> -				  struct page_req_dsc *prq,
> -				  int head, int tail)
> +static void intel_svm_process_prq(struct intel_iommu *iommu)
>  {
> -	struct page_req_dsc *req;
> -
> -	while (head != tail) {
> -		req = &iommu->prq[head / sizeof(*req)];
> -		process_single_prq(iommu, req);
> -		head = (head + sizeof(*req)) & PRQ_RING_MASK;
> +	struct page_req *req;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->prq_lock, flags);
> +	while (!list_empty(&iommu->prq_list)) {
> +		req = list_first_entry(&iommu->prq_list, struct page_req, list);
> +		if (!req->processing) {
> +			req->processing = true;
> +			spin_unlock_irqrestore(&iommu->prq_lock, flags);
> +			process_single_prq(iommu, &req->desc);
> +			spin_lock_irqsave(&iommu->prq_lock, flags);
> +			req->completed = true;
> +		} else if (req->completed) {
> +			list_del(&req->list);
> +			kfree(req);
> +		} else {
> +			break;
> +		}
>  	}
> +	spin_unlock_irqrestore(&iommu->prq_lock, flags);
>  }
> 
>  static irqreturn_t prq_event_thread(int irq, void *d)
>  {
>  	struct intel_iommu *iommu = d;
> +	unsigned long flags;
>  	int head, tail;
> 
> +	spin_lock_irqsave(&iommu->prq_lock, flags);
>  	/*
>  	 * Clear PPR bit before reading head/tail registers, to
>  	 * ensure that we get a new interrupt if needed.
>  	 */
>  	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
> -
>  	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
> PRQ_RING_MASK;
>  	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
> -	intel_svm_process_prq(iommu, iommu->prq, head, tail);
> +	while (head != tail) {
> +		struct page_req_dsc *dsc;
> +		struct page_req *req;
> +
> +		dsc = &iommu->prq[head / sizeof(*dsc)];
> +		req = kzalloc(sizeof (*req), GFP_ATOMIC);
> +		if (!req)
> +			break;
> +		req->desc = *dsc;
> +		list_add_tail(&req->list, &iommu->prq_list);
> +		head = (head + sizeof(*dsc)) & PRQ_RING_MASK;
> +	}
>  	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
> +	spin_unlock_irqrestore(&iommu->prq_lock, flags);
> +
> +	intel_svm_process_prq(iommu);
> 
>  	return IRQ_RETVAL(1);
>  }
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index cca1e5f9aeaa..80715a59491c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -590,6 +590,8 @@ struct intel_iommu {
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> +	struct list_head prq_list;	/* pending page request list */
> +	spinlock_t prq_lock;		/* protect above pending list */
>  	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for
> PASIDs */
>  #endif
>  	struct q_inval  *qi;            /* Queued invalidation info */
> --
> 2.17.1

