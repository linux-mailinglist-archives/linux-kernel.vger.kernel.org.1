Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB482EB14F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbhAERYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbhAERYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:24:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C6C722CF6;
        Tue,  5 Jan 2021 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609867434;
        bh=i2IODYjn+i46NdlesxUj5wRKx0YQu7Fw4OMe/pz2JfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWJxiJ78LfdEAThnVcRgqOg66D3pynto5T0vZBQ5bd76QQgE118KlI6FpwgLaTKll
         B+7EPkOg/AI5KvnI7cGoy3FUzmzlNcaKXYcWyQlcR22U7BZ1BV4briTr3AmHczSI9V
         uBFc00HE75Sd3YTyjyJiPe5YtZF+zQm2dhrn4JgDtUvA+snsHUDuvq7v+D/sfa6BJp
         X7vp4xSEx4kTz+zLcBwK+c8jpItKeQoy1BL6NHiDdapALG9dz5p2T+3InxjB7vjaVc
         nEvzOYUVF4Mmvy05D4sE+ZYkJqTXPpse2qcPXYlIbL0gPQfOFe8P/FLb9m0sxaEiS+
         phyRCu2chmn8w==
Date:   Tue, 5 Jan 2021 17:23:49 +0000
From:   Will Deacon <will@kernel.org>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Message-ID: <20210105172348.GA12032@willie-the-truck>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-4-yi.l.liu@intel.com>
 <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
 <DM5PR11MB1435E814408F19A947263C07C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435E814408F19A947263C07C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 05:50:22AM +0000, Liu, Yi L wrote:
> > > +static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
> > > +				    u64 addr, unsigned int mask)
> > > +{
> > > +	u16 sid, qdep;
> > > +
> > > +	if (!info || !info->ats_enabled)
> > > +		return;
> > > +
> > > +	sid = info->bus << 8 | info->devfn;
> > > +	qdep = info->ats_qdep;
> > > +	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > > +			   qdep, addr, mask);
> > > +}
> > > +
> > >   static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> > >   				  u64 addr, unsigned mask)
> > >   {
> > > -	u16 sid, qdep;
> > >   	unsigned long flags;
> > >   	struct device_domain_info *info;
> > > +	struct subdev_domain_info *sinfo;
> > >
> > >   	if (!domain->has_iotlb_device)
> > >   		return;
> > >
> > >   	spin_lock_irqsave(&device_domain_lock, flags);
> > > -	list_for_each_entry(info, &domain->devices, link) {
> > > -		if (!info->ats_enabled)
> > > -			continue;
> > > +	list_for_each_entry(info, &domain->devices, link)
> > > +		__iommu_flush_dev_iotlb(info, addr, mask);
> > >
> > > -		sid = info->bus << 8 | info->devfn;
> > > -		qdep = info->ats_qdep;
> > > -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > > -				qdep, addr, mask);
> > > +	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> > > +		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
> > > +					addr, mask);
> > >   	}
> > 
> > Nit:
> > 	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> > 		info = get_domain_info(sinfo->pdev);
> > 		__iommu_flush_dev_iotlb(info, addr, mask);
> > 	}
> 
> you are right. this should be better.

Please can you post a v4, with Lu's acks and the issue reported by Dan fixed
too?

Thanks,

Will
