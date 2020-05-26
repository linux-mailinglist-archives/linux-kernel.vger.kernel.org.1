Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E988C1A305B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDIHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 03:41:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44047 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbgDIHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586418107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AY4W44eopioVK4PBmnLWSTprcpzi02XUZ1GXUoM+48w=;
        b=fZNhJuayg0MEjK/z3ItAqtnzC5P6hNbyj0L+fcgpqhV00PPKm4bYlgDLr8P1Cu8aecic4l
        Hu4bgL7Cf1aDDjGx1hFVUBDxFeSHMi3GzCT70w8IfPXWRzH8yWzQVkhaQgXof+/OyocPL+
        OH/PzbwClOdxGCHx18mDUYeAWIn5k3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-36RCLuQUNdGCGgSf3LBYCw-1; Thu, 09 Apr 2020 03:41:42 -0400
X-MC-Unique: 36RCLuQUNdGCGgSf3LBYCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6CC91005509;
        Thu,  9 Apr 2020 07:41:40 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C54F85D9CA;
        Thu,  9 Apr 2020 07:41:34 +0000 (UTC)
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Yi L <yi.l.liu@linux.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
Date:   Thu, 9 Apr 2020 09:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/3/20 8:42 PM, Jacob Pan wrote:
> When supporting guest SVA with emulated IOMMU, the guest PASID
> table is shadowed in VMM. Updates to guest vIOMMU PASID table
> will result in PASID cache flush which will be passed down to
> the host as bind guest PASID calls.
> 
> For the SL page tables, it will be harvested from device's
> default domain (request w/o PASID), or aux domain in case of
> mediated device.
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> ---
> v11: Fixed locking, avoid duplicated paging mode check, added helper to
> free svm if device list is empty. Use rate limited error message since
> the bind gpasid call comes from user space.
> ---
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |   4 +
>  drivers/iommu/intel-svm.c   | 206 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |   8 +-
>  include/linux/intel-svm.h   |  17 ++++
>  4 files changed, 234 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index c0dadec5a6b3..94c7993dac6a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6178,6 +6178,10 @@ const struct iommu_ops intel_iommu_ops = {
>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> +#endif
>  };
>  
>  static void quirk_iommu_igfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index d7f2a5358900..7cf711318b87 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -226,6 +226,212 @@ static LIST_HEAD(global_svm_list);
>  	list_for_each_entry((sdev), &(svm)->devs, list)	\
>  		if ((d) != (sdev)->dev) {} else
>  
> +
> +static inline void intel_svm_free_if_empty(struct intel_svm *svm, u64 pasid)
> +{
> +	if (list_empty(&svm->devs)) {
> +		ioasid_set_data(pasid, NULL);
> +		kfree(svm);
> +	}
> +}
> +
> +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +			struct device *dev,
> +			struct iommu_gpasid_bind_data *data)
> +{
> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct dmar_domain *dmar_domain;
> +	struct intel_svm_dev *sdev;
> +	struct intel_svm *svm;
> +	int ret = 0;
> +
> +	if (WARN_ON(!iommu) || !data)
> +		return -EINVAL;
> +
> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> +	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	if (dev_is_pci(dev)) {
> +		/* VT-d supports devices with full 20 bit PASIDs only */
> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> +			return -EINVAL;
> +	} else {
> +		return -ENOTSUPP;
> +	}
> +
> +	/*
> +	 * We only check host PASID range, we have no knowledge to check
> +	 * guest PASID range.
> +	 */
> +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
> +		return -EINVAL;
> +
> +	dmar_domain = to_dmar_domain(domain);
> +
> +	mutex_lock(&pasid_mutex);
> +	svm = ioasid_find(NULL, data->hpasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
> +	if (svm) {
> +		/*
> +		 * If we found svm for the PASID, there must be at
> +		 * least one device bond, otherwise svm should be freed.
> +		 */
> +		if (WARN_ON(list_empty(&svm->devs))) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		for_each_svm_dev(sdev, svm, dev) {
> +			/* In case of multiple sub-devices of the same pdev
> +			 * assigned, we should allow multiple bind calls with
> +			 * the same PASID and pdev.
> +			 */
> +			sdev->users++;
What if this is not an mdev device. Is it also allowed?
> +			goto out;
> +		}
> +	} else {
> +		/* We come here when PASID has never been bond to a device. */
> +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> +		if (!svm) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		/* REVISIT: upper layer/VFIO can track host process that bind the PASID.
> +		 * ioasid_set = mm might be sufficient for vfio to check pasid VMM
> +		 * ownership. We can drop the following line once VFIO and IOASID set
> +		 * check is in place.
> +		 */
> +		svm->mm = get_task_mm(current);
> +		svm->pasid = data->hpasid;
> +		if (data->flags & IOMMU_SVA_GPASID_VAL) {
> +			svm->gpasid = data->gpasid;
> +			svm->flags |= SVM_FLAG_GUEST_PASID;
> +		}
> +		ioasid_set_data(data->hpasid, svm);
> +		INIT_LIST_HEAD_RCU(&svm->devs);
> +		mmput(svm->mm);
> +	}
> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev) {
> +		/*
> +		 * If this is a new PASID that never bond to a device, then
> +		 * the device list must be empty which indicates struct svm
> +		 * was allocated in this function.
> +		 */
> +		intel_svm_free_if_empty(svm, data->hpasid);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	sdev->dev = dev;
> +	sdev->users = 1;
> +
> +	/* Set up device context entry for PASID if not enabled already */
> +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "Failed to enable PASID capability\n");
> +		kfree(sdev);
> +		intel_svm_free_if_empty(svm, data->hpasid);
> +		goto out;
> +	}
> +
> +	/*
> +	 * PASID table is per device for better security. Therefore, for
> +	 * each bind of a new device even with an existing PASID, we need to
> +	 * call the nested mode setup function here.
> +	 */
> +	spin_lock(&iommu->lock);
> +	ret = intel_pasid_setup_nested(iommu,
> +				       dev,
> +				       (pgd_t *)data->gpgd,
> +				       data->hpasid,
> +				       &data->vtd,
> +				       dmar_domain,
> +				       data->addr_width);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "Failed to set up PASID %llu in nested mode, Err %d\n",
> +			data->hpasid, ret);
> +		/*
> +		 * PASID entry should be in cleared state if nested mode
> +		 * set up failed. So we only need to clear IOASID tracking
> +		 * data such that free call will succeed.
> +		 */
> +		kfree(sdev);
> +		intel_svm_free_if_empty(svm, data->hpasid);
> +		spin_unlock(&iommu->lock);
> +		goto out;
> +	}
> +	spin_unlock(&iommu->lock);
> +	svm->flags |= SVM_FLAG_GUEST_MODE;
> +
> +	init_rcu_head(&sdev->rcu);
> +	list_add_rcu(&sdev->list, &svm->devs);
> + out:
> +	mutex_unlock(&pasid_mutex);
> +	return ret;
> +}
> +
> +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> +{
This function's code looks very very similar to intel_svm_unbind_mm()
besides to the mmu_notifier_unregister and the ioasid_free(). Don't we
have means to factorize the code by checking the SVM_FLAG_GUEST_MODE flag?

Please could you explain again what does happen if the guest process
dies/VM dies. How do we make sure the svm get freed. I fail to
understand the whole picture at the moment as you cannot fully rely on
the userspace to call unbind_gpasid.
> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct intel_svm_dev *sdev;
> +	struct intel_svm *svm;
> +	int ret = -EINVAL;
> +
> +	if (WARN_ON(!iommu))
> +		return -EINVAL;
> +
> +	mutex_lock(&pasid_mutex);
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (!svm) {
> +		ret = -EINVAL;
As per the discussion on the VFIO series, shall we return an error in
that case? Same below?
> +		goto out;
> +	}
> +
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
> +	for_each_svm_dev(sdev, svm, dev) {
> +		ret = 0;
> +		sdev->users--;
> +		if (!sdev->users) {
> +			list_del_rcu(&sdev->list);
> +			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
intel_svm_unbind_mm() calls intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
Don't we need to flush the (DEV-)IOTLBs as well?
> +			/* TODO: Drain in flight PRQ for the PASID since it
> +			 * may get reused soon, we don't want to
> +			 * confuse with its previous life.
> +			 * intel_svm_drain_prq(dev, pasid);
> +			 */
> +			kfree_rcu(sdev, rcu);
> +
> +			if (list_empty(&svm->devs)) {
> +				/*
> +				 * We do not free the IOASID here in that
> +				 * IOMMU driver did not allocate it.
s/in/as?
> +				 * Unlike native SVM, IOASID for guest use was
> +				 * allocated prior to the bind call.> +				 * In any case, if the free call comes before
> +				 * the unbind, IOMMU driver will get notified
> +				 * and perform cleanup.
> +				 */
> +				ioasid_set_data(pasid, NULL);
> +				kfree(svm);
> +			}
nit: you may use intel_svm_free_if_empty()
> +		}
> +		break;
> +	}
> +out:
> +	mutex_unlock(&pasid_mutex);
> +
nit : spare new line
> +	return ret;
> +}
> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6da03f627ba3..a5bd53cf190c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -706,7 +706,9 @@ struct dmar_domain *find_domain(struct device *dev);
>  extern void intel_svm_check(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -
> +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_gpasid_bind_data *data);
> +extern int intel_svm_unbind_gpasid(struct device *dev, int pasid);
>  struct svm_dev_ops;
>  
>  struct intel_svm_dev {
> @@ -723,9 +725,13 @@ struct intel_svm_dev {
>  struct intel_svm {
>  	struct mmu_notifier notifier;
>  	struct mm_struct *mm;
> +
>  	struct intel_iommu *iommu;
>  	int flags;
>  	int pasid;
> +	int gpasid; /* Guest PASID in case of vSVA bind with non-identity host
> +		     * to guest PASID mapping.
> +		     */
>  	struct list_head devs;
>  	struct list_head list;
>  };
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index d7c403d0dd27..c19690937540 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -44,6 +44,23 @@ struct svm_dev_ops {
>   * do such IOTLB flushes automatically.
>   */
>  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> +/*
> + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind to a device.
> + * In this case the mm_struct is in the guest kernel or userspace, its life
> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this API provides
> + * means to bind/unbind guest CR3 with PASIDs allocated for a device.
> + */
> +#define SVM_FLAG_GUEST_MODE	(1<<2)
> +/*
> + * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID space,
> + * which requires guest and host PASID translation at both directions. We keep
> + * track of guest PASID in order to provide lookup service to device drivers.
> + * One such example is a physical function (PF) driver that supports mediated
> + * device (mdev) assignment. Guest programming of mdev configuration space can
> + * only be done with guest PASID, therefore PF driver needs to find the matching
> + * host PASID to program the real hardware.
> + */
> +#define SVM_FLAG_GUEST_PASID	(1<<3)
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  
> 
Thanks

Eric

