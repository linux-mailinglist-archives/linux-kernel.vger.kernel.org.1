Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6CE1B90F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDZOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgDZOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 10:55:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE7DC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 07:55:47 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jSigo-0004b4-Ao; Sun, 26 Apr 2020 16:55:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 633A2100605; Sun, 26 Apr 2020 16:55:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        iommu@lists.linux-foundation.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
In-Reply-To: <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com> <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
Date:   Sun, 26 Apr 2020 16:55:25 +0200
Message-ID: <87pnbus3du.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> writes:

> PASID is shared by all threads in a process. So the logical place to keep
> track of it is in the "mm". Add the field to the architecture specific
> mm_context_t structure.
>
> A PASID is allocated for an "mm" the first time any thread attaches
> to an SVM capable device. Later device atatches (whether to the same

atatches?

> device or another SVM device) will re-use the same PASID.
>
> The PASID is freed when the process exits (so no need to keep
> reference counts on how many SVM devices are sharing the PASID).

I'm not buying that. If there is an outstanding request with the PASID
of a process then tearing down the process address space and freeing the
PASID (which might be reused) is fundamentally broken.

> +void __free_pasid(struct mm_struct *mm);
> +
>  #endif /* _ASM_X86_IOMMU_H */
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index bdeae9291e5c..137bf51f19e6 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -50,6 +50,10 @@ typedef struct {
>  	u16 pkey_allocation_map;
>  	s16 execute_only_pkey;
>  #endif
> +
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	int pasid;

int? It's a value which gets programmed into the MSR along with the
valid bit (bit 31) set. 

>  extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index d7f2a5358900..da718a49e91e 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -226,6 +226,45 @@ static LIST_HEAD(global_svm_list);
>  	list_for_each_entry((sdev), &(svm)->devs, list)	\
>  		if ((d) != (sdev)->dev) {} else
>  
> +/*
> + * If this mm already has a PASID we can use it. Otherwise allocate a new one.
> + * Let the caller know if we did an allocation via 'new_pasid'.
> + */
> +static int alloc_pasid(struct intel_svm *svm, struct mm_struct *mm,
> +		       int pasid_max,  bool *new_pasid, int flags)

Again, data types please. flags are generally unsigned and not plain
int. Also pasid_max is certainly not plain int either.

> +{
> +	int pasid;
> +
> +	/*
> +	 * Reuse the PASID if the mm already has a PASID and not a private
> +	 * PASID is requested.
> +	 */
> +	if (mm && mm->context.pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
> +		/*
> +		 * Once a PASID is allocated for this mm, the PASID
> +		 * stays with the mm until the mm is dropped. Reuse
> +		 * the PASID which has been already allocated for the
> +		 * mm instead of allocating a new one.
> +		 */
> +		ioasid_set_data(mm->context.pasid, svm);

So if the PASID is reused several times for different SVMs then every
time ioasid_data->private is set to a different SVM. How is that
supposed to work?

> +		*new_pasid = false;
> +
> +		return mm->context.pasid;
> +	}
> +
> +	/*
> +	 * Allocate a new pasid. Do not use PASID 0, reserved for RID to
> +	 * PASID.
> +	 */
> +	pasid = ioasid_alloc(NULL, PASID_MIN, pasid_max - 1, svm);

ioasid_alloc() uses ioasid_t which is

typedef unsigned int ioasid_t;

Can we please have consistent types and behaviour all over the place?

> +	if (pasid == INVALID_IOASID)
> +		return -ENOSPC;
> +
> +	*new_pasid = true;
> +
> +	return pasid;
> +}
> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -324,6 +363,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  	init_rcu_head(&sdev->rcu);
>  
>  	if (!svm) {
> +		bool new_pasid;
> +
>  		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
>  		if (!svm) {
>  			ret = -ENOMEM;
> @@ -335,15 +376,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (pasid_max > intel_pasid_max_id)
>  			pasid_max = intel_pasid_max_id;
>  
> -		/* Do not use PASID 0, reserved for RID to PASID */
> -		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> -					  pasid_max - 1, svm);
> -		if (svm->pasid == INVALID_IOASID) {
> +		svm->pasid = alloc_pasid(svm, mm, pasid_max, &new_pasid, flags);
> +		if (svm->pasid < 0) {
>  			kfree(svm);
>  			kfree(sdev);
> -			ret = -ENOSPC;

ret gets magically initialized to an error return value, right?

>  			goto out;
>  		}
> +
>  		svm->notifier.ops = &intel_mmuops;
>  		svm->mm = mm;
>  		svm->flags = flags;
> @@ -353,7 +392,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
>  			if (ret) {
> -				ioasid_free(svm->pasid);
> +				if (new_pasid)
> +					ioasid_free(svm->pasid);
>  				kfree(svm);
>  				kfree(sdev);
>  				goto out;
> @@ -371,12 +411,21 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (ret) {
>  			if (mm)
>  				mmu_notifier_unregister(&svm->notifier, mm);
> -			ioasid_free(svm->pasid);
> +			if (new_pasid)
> +				ioasid_free(svm->pasid);
>  			kfree(svm);
>  			kfree(sdev);

So there are 3 places now freeing svm ad sdev and 2 of them
conditionally free svm->pasid. Can you please rewrite that to have a
proper error exit path instead of glueing that stuff into the existing
mess?

>  			goto out;
>  		}
>  
> +		if (mm && new_pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
> +			/*
> +			 * Track the new pasid in the mm. The pasid will be
> +			 * freed at process exit. Don't track requested
> +			 * private PASID in the mm.

What happens to private PASIDs?

Thanks,

        tglx
