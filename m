Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D446E26F9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRKCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:02:39 -0400
Received: from 8bytes.org ([81.169.241.247]:45262 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRKCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:02:38 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 91457293; Fri, 18 Sep 2020 12:02:37 +0200 (CEST)
Date:   Fri, 18 Sep 2020 12:02:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>
Subject: Re: [PATCH v9 0/7] IOMMU user API enhancement
Message-ID: <20200918100235.GQ31590@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On Fri, Sep 11, 2020 at 02:57:49PM -0700, Jacob Pan wrote:
> IOMMU user API header was introduced to support nested DMA translation and
> related fault handling. The current UAPI data structures consist of three
> areas that cover the interactions between host kernel and guest:
>  - fault handling
>  - cache invalidation
>  - bind guest page tables, i.e. guest PASID
> 
> Future extensions are likely to support more architectures and vIOMMU features.
> 
> In the previous discussion, using user-filled data size and feature flags is
> made a preferred approach over a unified version number.
> https://lkml.org/lkml/2020/1/29/45
> 
> In addition to introduce argsz field to data structures, this patchset is also
> trying to document the UAPI design, usage, and extension rules. VT-d driver
> changes to utilize the new argsz field is included, VFIO usage is to follow.
> 
> This set is available at:
> https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v9

This changes user visible structs in incompatible ways, are you sure
those are not used yet anywhere?

Please address Randy's comments on patch 1 and my comment about the
build-time checking and repost with linux-api@vger.kernel.org on Cc.

Regards,

	Joerg
