Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC132C0CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgKWODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:03:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbgKWODf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:03:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F2B2075A;
        Mon, 23 Nov 2020 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606140214;
        bh=RzgILadYdEd3PlSUUMcqcJb6KA8AWxsdQs514YcE3H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0nU0nRHlW82jyYk/FyfXA2oaAOdF/nnrr6wsnFI9AlIbSKV3bJO3J1i/AcslTpNyu
         t3BrSuwKMKpiCnY9hbm4ykngDLZc27RfVYt307hEz+mgD3+ZUwlUQ93W6Mub1DO1xw
         PsL+TbRRjwEXasXnsa6BBaA6miSA0SIo1XIPrQ7Y=
Date:   Mon, 23 Nov 2020 14:03:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 1/4] iommu: Move def_domain type check for untrusted
 device into core
Message-ID: <20201123140328.GA10730@willie-the-truck>
References: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
 <20201121135620.3496419-2-baolu.lu@linux.intel.com>
 <20201123120449.GB10233@willie-the-truck>
 <5f6f0d5e-0cfc-2274-b186-180f50b8b1df@linux.intel.com>
 <20201123130335.GD10233@willie-the-truck>
 <c75c2981-11bd-74c0-289b-c2eb198bb5ab@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75c2981-11bd-74c0-289b-c2eb198bb5ab@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 09:54:49PM +0800, Lu Baolu wrote:
> Hi Will,
> 
> On 2020/11/23 21:03, Will Deacon wrote:
> > Hi Baolu,
> > 
> > On Mon, Nov 23, 2020 at 08:55:17PM +0800, Lu Baolu wrote:
> > > On 2020/11/23 20:04, Will Deacon wrote:
> > > > On Sat, Nov 21, 2020 at 09:56:17PM +0800, Lu Baolu wrote:
> > > > > @@ -1645,13 +1655,10 @@ struct __group_domain_type {
> > > > >    static int probe_get_default_domain_type(struct device *dev, void *data)
> > > > >    {
> > > > > -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> > > > >    	struct __group_domain_type *gtype = data;
> > > > >    	unsigned int type = 0;
> > > > > -	if (ops->def_domain_type)
> > > > > -		type = ops->def_domain_type(dev);
> > > > > -
> > > > > +	type = iommu_get_mandatory_def_domain_type(dev);
> > > > 
> > > > afaict, this code is only called from probe_alloc_default_domain(), which
> > > > has:
> > > > 
> > > >           /* Ask for default domain requirements of all devices in the group */
> > > >           __iommu_group_for_each_dev(group, &gtype,
> > > >                                      probe_get_default_domain_type);
> > > > 
> > > >           if (!gtype.type)
> > > >                   gtype.type = iommu_def_domain_type;
> > > > 
> > > > so is there actually a need to introduce the new
> > > > iommu_get_mandatory_def_domain_type() function, given that a type of 0
> > > > always ends up resolving to the default domain type?
> > > 
> > > Another consumer of this helper is in the next patch:
> > > 
> > > +	dev_def_dom = iommu_get_mandatory_def_domain_type(dev);
> > > +
> > > +	/* Check if user requested domain is supported by the device or not */
> > > +	if (!type) {
> > > +		/*
> > > +		 * If the user hasn't requested any specific type of domain and
> > > +		 * if the device supports both the domains, then default to the
> > > +		 * domain the device was booted with
> > > +		 */
> > > +		type = iommu_get_def_domain_type(dev);
> > > +	} else if (dev_def_dom && type != dev_def_dom) {
> > > +		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
> > > +				    iommu_domain_type_str(type));
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > 
> > > I also added the untrusted device check in
> > > iommu_get_mandatory_def_domain_type(), so that we don't need to care
> > > about this in multiple places.
> > 
> > I see, but isn't this also setting the default domain type in the case that
> > it gets back a type of 0? I think it would be nice to avoid having both
> > iommu_get_mandatory_def_domain_type() and iommu_get_def_domain_type() of we
> > can, as it's really not clear which one to use when and what is meant by
> > "mandatory" imo.
> 
> Yes, agreed. I will remove iommu_get_mandatory_def_domain_type() and
> keep iommu_get_def_domain_type() as the only helper in the next version.

Great, thanks!

Will
