Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6261E27032F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIRRYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:24:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:20560 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgIRRYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:24:32 -0400
IronPort-SDR: z7VMRBb7oF37TGj2Nmwp2Xvbr6V4gXRqKauMF+hdZyaf0H//HbmJossukABs//6J6hwZ3o+m9C
 ZGx/5f+ZQZUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147671534"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147671534"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 10:24:28 -0700
IronPort-SDR: rr9f3VCLLmOjz9hSvF10aX5G17aKu+w6kiEVPPxj6fmpFYwliE+msfw5gaIXAy7ffw00MoPXAF
 vHMwD0c575Bg==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="347074562"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 10:24:27 -0700
Date:   Fri, 18 Sep 2020 10:26:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v9 0/7] IOMMU user API enhancement
Message-ID: <20200918102630.6d592442@jacob-builder>
In-Reply-To: <20200918100235.GQ31590@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200918100235.GQ31590@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Fri, 18 Sep 2020 12:02:36 +0200, Joerg Roedel <joro@8bytes.org> wrote:

> Hi Jacob,
> 
> On Fri, Sep 11, 2020 at 02:57:49PM -0700, Jacob Pan wrote:
> > IOMMU user API header was introduced to support nested DMA translation
> > and related fault handling. The current UAPI data structures consist of
> > three areas that cover the interactions between host kernel and guest:
> >  - fault handling
> >  - cache invalidation
> >  - bind guest page tables, i.e. guest PASID
> > 
> > Future extensions are likely to support more architectures and vIOMMU
> > features.
> > 
> > In the previous discussion, using user-filled data size and feature
> > flags is made a preferred approach over a unified version number.
> > https://lkml.org/lkml/2020/1/29/45
> > 
> > In addition to introduce argsz field to data structures, this patchset
> > is also trying to document the UAPI design, usage, and extension rules.
> > VT-d driver changes to utilize the new argsz field is included, VFIO
> > usage is to follow.
> > 
> > This set is available at:
> > https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v9  
> 
> This changes user visible structs in incompatible ways, are you sure
> those are not used yet anywhere?
> 
These structs are not used yet in that IOMMU UAPI does not provide
direct user IOCTLs. For guest SVA of assigned devices, VFIO is used. Yi's
companion patches are here.
https://lore.kernel.org/linux-iommu/5dd95fbf-054c-3bbc-e76b-2d5636214ff2@redhat.com/T/#t

These user structs can also be used by other framework in the future, such
as vDPA.

> Please address Randy's comments on patch 1 and my comment about the
> build-time checking and repost with linux-api@vger.kernel.org on Cc.
> 
Will do.

> Regards,
> 
> 	Joerg


Thanks,

Jacob
