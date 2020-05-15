Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70B71D5040
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgEOOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 10:20:51 -0400
Received: from 8bytes.org ([81.169.241.247]:43486 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEOOUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:20:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 792053C3; Fri, 15 May 2020 16:20:49 +0200 (CEST)
Date:   Fri, 15 May 2020 16:20:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200515142047.GX18353@8bytes.org>
References: <20200515094519.20338-1-joro@8bytes.org>
 <8ce93a10-2ce0-e5a0-88a0-5d21d7003c0f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce93a10-2ce0-e5a0-88a0-5d21d7003c0f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:51:03PM +0800, Lu Baolu wrote:
> On 2020/5/15 17:45, Joerg Roedel wrote:
> >   struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> >   {
> > -	return dev->iommu_group->default_domain;
> > +	struct iommu_domain *domain = dev->iommu_group->default_domain;
> > +
> > +	if (__iommu_is_attach_deferred(domain, dev))
> > +		__iommu_attach_device_no_defer(domain, dev);
> 
> It seems that the return value needs to be checked. The default domain
> is invalid if attach() failed.

True, I looked at that, the callers can't handle returning NULL here, so
I kept it this way for now. The outcome is that DMA will fail, but
otherwise we'd see a NULL-ptr dereference really quickly after returning
from that function.

Bottom line: This needs to be cleaned up separatly.

Regards,

	Joerg
