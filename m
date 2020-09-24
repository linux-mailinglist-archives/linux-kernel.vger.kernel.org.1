Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21A27787F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgIXS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:29:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:48021 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbgIXS3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:29:02 -0400
IronPort-SDR: 3yHXE7IWj/mNP2XtIecF696qX/sC2D8FeHqmLOE4DXhANdI7BE9u3JAhmAR0loOGNXrI5eMDxu
 OXlrALCGD9Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158685276"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="158685276"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 11:29:01 -0700
IronPort-SDR: QXlCgJfZs4NQkVasYkmAuphEPC/dg9mtM1psTJODac5uq50sWC7/wkE/AoLsNbcbtEeyi2hQ5f
 p9K5dySYZ1Ww==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="305931568"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 11:29:01 -0700
Date:   Thu, 24 Sep 2020 11:31:07 -0700
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
Subject: Re: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data
 format
Message-ID: <20200924113107.75379e6e@jacob-builder>
In-Reply-To: <20200924084015.GC27174@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200918094450.GP31590@8bytes.org>
        <20200918101108.672c2f5a@jacob-builder>
        <20200924084015.GC27174@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Thu, 24 Sep 2020 10:40:16 +0200, Joerg Roedel <joro@8bytes.org> wrote:

> > On Fri, 18 Sep 2020 11:44:50 +0200, Joerg Roedel <joro@8bytes.org>
> > wrote: 
> > > On Fri, Sep 11, 2020 at 02:57:52PM -0700, Jacob Pan wrote:  
> > > > There can be multiple vendor-specific PASID data formats used in
> > > > UAPI structures. This patch adds enum type with a last entry which
> > > > makes range checking much easier.    
> > > 
> > > But it also makes it much easier to screw up the numbers (which are
> > > ABI) by inserting a new value into the middle. I prefer defines here,
> > > or alternativly BUILD_BUG_ON() checks for the numbers.
> > >   
> > I am not following, the purpose of IOMMU_PASID_FORMAT_LAST *is* for
> > preparing the future insertion of new value into the middle.
> > The checking against IOMMU_PASID_FORMAT_LAST is to protect ABI
> > compatibility by making sure that out of range format are rejected in
> > all versions of the ABI.  
> 
> But with the enum you could have:
> 
> enum {
> 	VTD_FOO,
> 	SMMU_FOO,
> 	LAST,
> };
> 
> which makes VTD_FOO==0 and SMMU_FOO==1, and when in the next version
> someone adds:
> 
> enum {
> 	VTD_FOO,
> 	VTD_BAR,
> 	SMMU_FOO,
> 	LAST,
> };
> 
> then SMMU_FOO will become 2 and break ABI. So I'd like to have this
> checked somewhere.
Got your point, will change to defines.

Thanks,

Jacob
