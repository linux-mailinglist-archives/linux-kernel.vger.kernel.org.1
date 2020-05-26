Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36441A9BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896795AbgDOLMw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Apr 2020 07:12:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:4674 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896760AbgDOLLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:11:16 -0400
IronPort-SDR: lp4vgQfzitq+QnIdNsjtn7q3whmxBfDuJaXmDocUUqXPPzFDZhQyIVBx2GnqWLzyMms0xnIhHC
 FzN37Ou/0/Uw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 04:10:29 -0700
IronPort-SDR: 0pF2sy3bPnfqaZwBlOTt10X/IMftkiardGKGwHN8D8bpg0GetyRDG70uKPLEjvFzXYVS5YaFss
 fAcOUU7O8qOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="298964942"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2020 04:10:29 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 04:10:29 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 04:10:28 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.214]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 19:10:26 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/7] iommu/vt-d: Add page request draining support
Thread-Topic: [PATCH v2 6/7] iommu/vt-d: Add page request draining support
Thread-Index: AQHWEubS8xobodm1XE6sOT1OPN2bNqh579Xg
Date:   Wed, 15 Apr 2020 11:10:26 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D8209CE@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-7-baolu.lu@linux.intel.com>
In-Reply-To: <20200415052542.30421-7-baolu.lu@linux.intel.com>
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
> When a PASID is stopped or terminated, there can be pending
> PRQs (requests that haven't received responses) in remapping
> hardware. This adds the interface to drain page requests and
> call it when a PASID is terminated.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c   | 90 ++++++++++++++++++++++++++++++++++---
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 86 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 05aeb8ea51c4..736dd39fb52b 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -23,6 +23,7 @@
>  #include "intel-pasid.h"
> 
>  static irqreturn_t prq_event_thread(int irq, void *d);
> +static void intel_svm_drain_prq(struct device *dev, int pasid);
> 
>  #define PRQ_ORDER 0
> 
> @@ -210,6 +211,7 @@ static void intel_mm_release(struct mmu_notifier
> *mn, struct mm_struct *mm)
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>  		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm-
> >pasid);
> +		intel_svm_drain_prq(sdev->dev, svm->pasid);

I feel there is a problem here. If you clear the PASID entry before draining,
in-fly requests will hit unrecoverable fault instead, due to invalid PASID
entry.

>  		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  	}
>  	rcu_read_unlock();
> @@ -403,12 +405,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int
> pasid)
>  		if (!sdev->users) {
>  			list_del_rcu(&sdev->list);
>  			intel_pasid_tear_down_entry(iommu, dev, svm-
> >pasid);
> +			intel_svm_drain_prq(dev, svm->pasid);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> -			/* TODO: Drain in flight PRQ for the PASID since it
> -			 * may get reused soon, we don't want to
> -			 * confuse with its previous life.
> -			 * intel_svm_drain_prq(dev, pasid);
> -			 */
>  			kfree_rcu(sdev, rcu);
> 
>  			if (list_empty(&svm->devs)) {
> @@ -646,6 +644,7 @@ int intel_svm_unbind_mm(struct device *dev, int
> pasid)
>  			 * large and has to be physically contiguous. So it's
>  			 * hard to be as defensive as we might like. */
>  			intel_pasid_tear_down_entry(iommu, dev, svm-
> >pasid);
> +			intel_svm_drain_prq(dev, svm->pasid);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  			kfree_rcu(sdev, rcu);
> 
> @@ -703,6 +702,7 @@ struct page_req_dsc {
>  struct page_req {
>  	struct list_head list;
>  	struct page_req_dsc desc;
> +	struct completion complete;
>  	unsigned int processing:1;
>  	unsigned int drained:1;
>  	unsigned int completed:1;
> @@ -732,9 +732,83 @@ static bool is_canonical_address(u64 addr)
>  	return (((saddr << shift) >> shift) == saddr);
>  }
> 
> +/**
> + * intel_svm_drain_prq:
> + *
> + * Drain all pending page requests related to a specific pasid in both
> + * software and hardware. The caller must guarantee that no more page
> + * requests related to this pasid coming.
> + */
> +static void intel_svm_drain_prq(struct device *dev, int pasid)
> +{
> +	struct device_domain_info *info;
> +	struct dmar_domain *domain;
> +	struct intel_iommu *iommu;
> +	struct qi_desc desc[3];
> +	struct pci_dev *pdev;
> +	struct page_req *req;
> +	unsigned long flags;
> +	u16 sid, did;
> +	int qdep;
> +
> +	info = get_domain_info(dev);
> +	if (WARN_ON(!info || !dev_is_pci(dev)))
> +		return;
> +
> +	iommu = info->iommu;
> +	domain = info->domain;
> +	pdev = to_pci_dev(dev);
> +
> +	/* Mark all related pending requests drained. */
> +	spin_lock_irqsave(&iommu->prq_lock, flags);
> +	list_for_each_entry(req, &iommu->prq_list, list)
> +		if (req->desc.pasid_present && req->desc.pasid == pasid)
> +			req->drained = true;
> +	spin_unlock_irqrestore(&iommu->prq_lock, flags);
> +
> +	/* Wait until all related pending requests complete. */
> +retry:
> +	spin_lock_irqsave(&iommu->prq_lock, flags);
> +	list_for_each_entry(req, &iommu->prq_list, list) {
> +		if (req->desc.pasid_present &&
> +		    req->desc.pasid == pasid &&
> +		    !req->completed) {
> +			spin_unlock_irqrestore(&iommu->prq_lock, flags);
> +			wait_for_completion_timeout(&req->complete, 5 *
> HZ);
> +			goto retry;
> +		}
> +	}
> +	spin_unlock_irqrestore(&iommu->prq_lock, flags);
> +
> +	/*
> +	 * Perform steps described in VT-d spec CH7.10 to drain page
> +	 * request and responses in hardware.
> +	 */
> +	sid = PCI_DEVID(info->bus, info->devfn);
> +	did = domain->iommu_did[iommu->seq_id];
> +	qdep = pci_ats_queue_depth(pdev);
> +
> +	memset(desc, 0, sizeof(desc));
> +	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
> +			QI_IWD_FENCE |
> +			QI_IWD_TYPE;
> +	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
> +			QI_EIOTLB_DID(did) |
> +			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> +			QI_EIOTLB_TYPE;
> +	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> +			QI_DEV_EIOTLB_SID(sid) |
> +			QI_DEV_EIOTLB_QDEP(qdep) |
> +			QI_DEIOTLB_TYPE |
> +			QI_DEV_IOTLB_PFSID(info->pfsid);
> +
> +	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);

the completion of above sequence ensures that previous queued
page group responses are sent out and received by the endpoint
and vice versa all in-fly page requests from the endpoint are queued
in iommu page request queue. Then comes a problem - you didn't
wait for completion of those newly-queued requests and their
responses.

According to VT-d spec 7.10, step (d) mentions when queue overflow
happens, software needs to repeat the above draining sequence to
drain auto-responses.

According to VT-d spec 7.11, the device driver must be notified to
revoke the PASID before this draining sequence happens. When 
does that happen? Possibly can add some comment to explain such
background.

Thanks
Kevin

> +}
> +
>  static void process_single_prq(struct intel_iommu *iommu,
>  			       struct page_req_dsc *req)
>  {
> +	struct page_req *p_req = container_of(req, struct page_req, desc);
>  	int result = QI_RESP_FAILURE;
>  	struct intel_svm_dev *sdev;
>  	struct vm_area_struct *vma;
> @@ -768,6 +842,10 @@ static void process_single_prq(struct intel_iommu
> *iommu,
>  	}
> 
>  	result = QI_RESP_INVALID;
> +
> +	if (p_req->drained)
> +		goto bad_req;
> +
>  	/* Since we're using init_mm.pgd directly, we should never take
>  	 * any faults on kernel addresses. */
>  	if (!svm->mm)
> @@ -868,6 +946,7 @@ static void intel_svm_process_prq(struct
> intel_iommu *iommu)
>  			req->completed = true;
>  		} else if (req->completed) {
>  			list_del(&req->list);
> +			complete(&req->complete);
>  			kfree(req);
>  		} else {
>  			break;
> @@ -899,6 +978,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		if (!req)
>  			break;
>  		req->desc = *dsc;
> +		init_completion(&req->complete);
>  		list_add_tail(&req->list, &iommu->prq_list);
>  		head = (head + sizeof(*dsc)) & PRQ_RING_MASK;
>  	}
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 80715a59491c..714a0df3d879 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -333,6 +333,7 @@ enum {
> 
>  #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
>  #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
> +#define QI_IWD_FENCE		(((u64)1) << 6)
>  #define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
> 
>  #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
> --
> 2.17.1

