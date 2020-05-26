Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA281D2D59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 12:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgENKua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 06:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgENKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:50:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD27C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 03:50:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so3336257wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=38QmTxTEvJ+S2RAZ0sqfJydd1bsWIjyWyPL61uxbueE=;
        b=dXTFxbV4xPkr5lF2OCPKqUedgY0t6sReFjLznPu8135QK1a7rG1EDc7ReEtI+gsX1h
         9nhI7PGvc/jd2PFL3fifUvYOGN+czY8t1oia8m+HcwcgEH7qC3hmBXDtVGofOoNjEIDF
         +2oqoMus5jTzc2G8j14KYFk4pXUokob/sWThr/k4MNOy9fZLL8bBZoV7IWl7lDWBCDz+
         +9yowUBLrz6Upsqvh+Au4cUJ+7qcROlpazLY8IYe1eYkoFzm08OwcNJYl5sWVDMuaJQX
         H7EKrdPecwNVecOO8hsM00VbT366cc9mPfmKH/CWt25eLTsiZSNQCcuqh1/eL/5kw9NR
         iG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=38QmTxTEvJ+S2RAZ0sqfJydd1bsWIjyWyPL61uxbueE=;
        b=kfuHLrOInWufAbCsHtK6igxpw55IvuZCIooX1WIVJ6o+Y8TceLSBsIUf+31JbY2XoV
         CXTwUoJjDXJiV1UDEgkoZpzacoeHb+Gig6g1k4SX06NbASziJltdWdkEj12Te7ZEeryW
         HpmVEsgnLWns97HhYpD4sRzuXVTMuzee36QnhpmGjtw+1BI7vWwNFZnqVCJOKhbKWmtX
         G+3fSzCn6LRQh/rZLiZbNner4zMG8cocgWbVblgtZjSDddPJfcXTk0hmTl2dKeWU9YA/
         y+jNiI7jdG6T/NBRgKNh0B4Ky9G7qGHE0vGKBbRjWsbZTY3pGDzggC86I6JysGkP7uaa
         6+yw==
X-Gm-Message-State: AOAM5324i9PJXjjSSqCzwlr5tAX9XCepSfcF0YieMrASm67E59xbt4BA
        Mlvzb8hrxLmi1hd3nZkPHAlWcw==
X-Google-Smtp-Source: ABdhPJylSdZ+y+t7WLaiGVL0w8Eft2SxOfv0jQvv/uh4mawVTFMnwcN4CUndqM6JXoUXPa2i1y2wyQ==
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr5069970wrh.175.1589453426540;
        Thu, 14 May 2020 03:50:26 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id g135sm22120343wme.22.2020.05.14.03.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 03:50:26 -0700 (PDT)
Date:   Thu, 14 May 2020 12:50:16 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bharat Bhushan <bbhushan2@marvell.com>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org,
        jasowang@redhat.com, eric.auger.pro@gmail.com,
        eric.auger@redhat.com
Subject: Re: [PATCH v6] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200514105016.GA2252@myrica>
References: <20200514075237.3941-1-bbhushan2@marvell.com>
 <20200514043747-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514043747-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 05:31:00AM -0400, Michael S. Tsirkin wrote:
> On Thu, May 14, 2020 at 01:22:37PM +0530, Bharat Bhushan wrote:
> > Different endpoint can support different page size, probe
> > endpoint if it supports specific page size otherwise use
> > global page sizes.
> > 
> > Device attached to domain should support a minimum of
> > domain supported page sizes. If device supports more
> > than domain supported page sizes then device is limited
> > to use domain supported page sizes only.
> 
> OK so I am just trying to figure it out.
> Before the patch, we always use the domain supported page sizes
> right?
> 
> With the patch, we still do, but we also probe and
> validate that device supports all domain page sizes,
> if it does not then we fail to attach the device.

Generally there is one endpoint per domain. Linux creates the domains and
decides which endpoint goes in which domain. It puts multiple endpoints in
a domain in two cases:

* If endpoints cannot be isolated from each others by the IOMMU, for
  example if ACS isolation isn't enabled in PCIe. In that case endpoints
  are in the same IOMMU group, and therefore contained in the same domain.
  This is more of a quirk for broken hardware, and isn't much of a concern
  for virtualization because it's easy for the hypervisor to present
  endpoints isolated from each others.

* If userspace wants to put endpoints in the same VFIO container, then
  VFIO first attempts to put them in the same IOMMU domain, and falls back
  to multiple domains if that fails. That case is just a luxury and we
  shouldn't over-complicate the driver to cater for this.

So the attach checks don't need to be that complicated. Checking that the
page masks are exactly the same should be enough.

> This seems like a lot of effort for little benefit, can't
> hypervisor simply make sure endpoints support the
> iommu page sizes for us?

I tend to agree, it's not very likely that we'll have a configuration with
different page sizes between physical and virtual endpoints.

If there is a way for QEMU to simply reject VFIO devices that don't use
the same page mask as what's configured globally, let's do that instead of
introducing the page_size_mask property.

> > @@ -615,7 +636,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  	struct viommu_dev *viommu = vdev->viommu;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > -	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> > +	viommu_page_size = 1UL << __ffs(vdev->pgsize_bitmap);
> >  	if (viommu_page_size > PAGE_SIZE) {
> >  		dev_err(vdev->dev,
> >  			"granule 0x%lx larger than system page size 0x%lx\n",
> 
> 
> Looks like this is messed up on 32 bit: e.g. 0x100000000 will try to do
> 1UL << -1, which is undefined behaviour. Which is btw already messed up
> wrt viommu->pgsize_bitmap, but that's not a reason to propagate
> the error.

Realistically we're not going to have a page granule larger than 4G, it's
going to be 4k or 64k. But we can add a check that truncates the
page_size_mask to 32-bit and makes sure that it's non-null.

> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property	head;
> > +	__u8					reserved[4];
> > +	/* Same format as virtio_iommu_config::page_size_mask */
> 
> It's actually slightly different in that
> this must be a superset of domain page size mask, right?

No it overrides the global mask

> > +	__le64					pgsize_bitmap;

Bharat, please rename this to page_size_mask for consistency

Thanks,
Jean

> > +};
> > +
> >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> >  
> > -- 
> > 2.17.1
> 
