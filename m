Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF71F6E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFKT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 15:56:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:9278 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgFKT4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:56:01 -0400
IronPort-SDR: nfWxtoU1uuDui8f9jQlA1dJla63QsnCpt3nI+b64xUrZt7b+xElQH3I9ZDTOEVOnCtwIypF5jq
 IKVbdsIY04zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 12:56:00 -0700
IronPort-SDR: 6OGy0HphltOtwPAWMjEvQt1BpdA3Tm2x+SezYJPxYF3MxopRRS+nbZ9Tna88oZmNzyxbVnZasO
 tLzlLb8Tm40A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,500,1583222400"; 
   d="scan'208";a="259693290"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2020 12:55:59 -0700
Date:   Thu, 11 Jun 2020 13:02:24 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Sanity check uapi argsz filled by
 users
Message-ID: <20200611130224.642ddde4@jacob-builder>
In-Reply-To: <20200611110816.4cea7204@x1.home>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200611110816.4cea7204@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 11:08:16 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 10 Jun 2020 21:12:15 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > IOMMU UAPI data has an argsz field which is filled by user. As the
> > data structures expands, argsz may change. As the UAPI data are
> > shared among different architectures, extensions of UAPI data could
> > be a result of one architecture which has no impact on another.
> > Therefore, these argsz santity checks are performed in the model
> > specific IOMMU drivers. This patch adds sanity checks in the VT-d
> > to ensure argsz passed by userspace matches feature flags and other
> > contents.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 16 ++++++++++++++++
> >  drivers/iommu/intel-svm.c   | 12 ++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 27ebf4b9faef..c98b5109684b
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5365,6 +5365,7 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, struct device_domain_info
> > *info; struct intel_iommu *iommu;
> >  	unsigned long flags;
> > +	unsigned long minsz;
> >  	int cache_type;
> >  	u8 bus, devfn;
> >  	u16 did, sid;
> > @@ -5385,6 +5386,21 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, if (!(dmar_domain->flags
> > & DOMAIN_FLAG_NESTING_MODE)) return -EINVAL;
> >  
> > +	minsz = offsetofend(struct iommu_cache_invalidate_info,
> > padding);  
> 
> Would it still be better to look for the end of the last field that's
> actually used to avoid the code churn and oversights if/when the
> padding field does get used and renamed?
> 
My thought was that if the padding gets partially re-purposed, the
remaining padding would still be valid for minsz check. The extension
rule ensures that there is no size change other the variable size union
at the end. So use padding would avoid the churn, or i am totally wrong?

> Per my comment on patch 1/, this also seems like where the device
> specific IOMMU driver should also have the responsibility of receiving
> a __user pointer to do the copy_from_user() here.  vfio can't know
> which flags require which fields to make a UAPI with acceptable
> compatibility guarantees otherwise.
> 
Right, VFIO cannot do compatibility guarantees, it is just seem to be
that VFIO has enough information to copy_from_user sanely & safely and
handle over to IOMMU. Please help define the roles/responsibilities in
my other email. Then I will follow the guideline.

> > +	if (inv_info->argsz < minsz)
> > +		return -EINVAL;
> > +
> > +	/* Sanity check user filled invalidation dat sizes */
> > +	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> > +		inv_info->argsz != offsetofend(struct
> > iommu_cache_invalidate_info,
> > +					addr_info))
> > +		return -EINVAL;
> > +
> > +	if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
> > +		inv_info->argsz != offsetofend(struct
> > iommu_cache_invalidate_info,
> > +					pasid_info))
> > +		return -EINVAL;
> > +
> >  	spin_lock_irqsave(&device_domain_lock, flags);
> >  	spin_lock(&iommu->lock);
> >  	info = get_domain_info(dev);
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 35b43fe819ed..64dc2c66dfff 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -235,15 +235,27 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain, struct device *dev, struct dmar_domain *dmar_domain;
> >  	struct intel_svm_dev *sdev;
> >  	struct intel_svm *svm;
> > +	unsigned long minsz;
> >  	int ret = 0;
> >  
> >  	if (WARN_ON(!iommu) || !data)
> >  		return -EINVAL;
> >  
> > +	/*
> > +	 * We mandate that no size change in IOMMU UAPI data
> > before the
> > +	 * variable size union at the end.
> > +	 */
> > +	minsz = offsetofend(struct iommu_gpasid_bind_data,
> > padding);  
> 
> Same.  Thanks,
> 
> Alex
> 
> > +	if (data->argsz < minsz)
> > +		return -EINVAL;
> > +
> >  	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> >  	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> >  		return -EINVAL;
> >  
> > +	if (data->argsz != offsetofend(struct
> > iommu_gpasid_bind_data, vtd))
> > +		return -EINVAL;
> > +
> >  	if (!dev_is_pci(dev))
> >  		return -ENOTSUPP;
> >    
> 

[Jacob Pan]
