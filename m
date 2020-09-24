Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE6276C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgIXIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgIXIkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:40:20 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB3C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:40:20 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D53C3295; Thu, 24 Sep 2020 10:40:17 +0200 (CEST)
Date:   Thu, 24 Sep 2020 10:40:16 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
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
        Yi Sun <yi.y.sun@intel.com>
Subject: Re: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data
 format
Message-ID: <20200924084015.GC27174@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200918094450.GP31590@8bytes.org>
 <20200918101108.672c2f5a@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918101108.672c2f5a@jacob-builder>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On Fri, Sep 18, 2020 at 10:11:08AM -0700, Jacob Pan wrote:
> On Fri, 18 Sep 2020 11:44:50 +0200, Joerg Roedel <joro@8bytes.org> wrote:
> 
> > On Fri, Sep 11, 2020 at 02:57:52PM -0700, Jacob Pan wrote:
> > > There can be multiple vendor-specific PASID data formats used in UAPI
> > > structures. This patch adds enum type with a last entry which makes
> > > range checking much easier.  
> > 
> > But it also makes it much easier to screw up the numbers (which are ABI)
> > by inserting a new value into the middle. I prefer defines here, or
> > alternativly BUILD_BUG_ON() checks for the numbers.
> > 
> I am not following, the purpose of IOMMU_PASID_FORMAT_LAST *is* for
> preparing the future insertion of new value into the middle.
> The checking against IOMMU_PASID_FORMAT_LAST is to protect ABI
> compatibility by making sure that out of range format are rejected in all
> versions of the ABI.

But with the enum you could have:

enum {
	VTD_FOO,
	SMMU_FOO,
	LAST,
};

which makes VTD_FOO==0 and SMMU_FOO==1, and when in the next version
someone adds:

enum {
	VTD_FOO,
	VTD_BAR,
	SMMU_FOO,
	LAST,
};

then SMMU_FOO will become 2 and break ABI. So I'd like to have this
checked somewhere.

Regards,

	Joerg
