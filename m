Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EFB274A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:22:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:8645 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVUWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:22:08 -0400
IronPort-SDR: Xj93aYAV3LMQ1eJ8O7eHnc4n3iEMVqN+NrfnivW0ucUtIrS/vZZyn5zZeXH/BpEFssEpx44wxk
 NX5BLjC69P/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="245538604"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="245538604"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:22:07 -0700
IronPort-SDR: 8CxwxhWgoL4Wn/YAMFmwoR54aP+Ht5jSCTlmmo9xGJ9mHUqC7zXk1hIDa44dNUPY85rDkB/xCt
 jmWVuCIQi6Sw==
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="382436019"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:22:07 -0700
Date:   Tue, 22 Sep 2020 13:24:12 -0700
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
Message-ID: <20200922132412.614d4461@jacob-builder>
In-Reply-To: <20200918101108.672c2f5a@jacob-builder>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200918094450.GP31590@8bytes.org>
        <20200918101108.672c2f5a@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

I sent out v10 with Randy's comments addressed but I didn't change this
patch. Does my explanation below make sense? I am hoping to make it in
v5.10 since many other pieces depend on it, your guidance is much
appreciated.

Jacob


On Fri, 18 Sep 2020 10:11:08 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Joerg,
> 
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
> For example, in v5.10, ABI has IOMMU_PASID_FORMAT_LAST = 2, then user data
> with format = 2 will be rejected. So this user app will not work or
> released.
> 
> Now say in v5.11, we add one more format in the middle and set
> IOMMU_PASID_FORMAT_LAST = 3. Then user data with the new format = 2 can
> be supported.
> 
> Without the checking for IOMMU_PASID_FORMAT_LAST, at v5.10 time the user
> binary may succeed and become legacy binary that we cannot break in v5.11.
> This renders format = 2 unusable for v5.11.
> 
> I thought enum makes it less susceptible to programming errors than
> defines by making sure the ascending order. I might have missed your
> point, could you elaborate?
> 
> > Regards,
> > 
> > 	Joerg
> >   
> > > 
> > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  include/uapi/linux/iommu.h | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > > index b42acc8fe007..7cc6ee6c41f7 100644
> > > --- a/include/uapi/linux/iommu.h
> > > +++ b/include/uapi/linux/iommu.h
> > > @@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
> > >  					 IOMMU_SVA_VTD_GPASID_PCD |
> > > \ IOMMU_SVA_VTD_GPASID_PWT)
> > >  
> > > +enum iommu_pasid_data_format {
> > > +	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
> > > +	IOMMU_PASID_FORMAT_LAST,
> > > +};
> > > +
> > >  /**
> > >   * struct iommu_gpasid_bind_data - Information about device and guest
> > > PASID binding
> > >   * @argsz:	User filled size of this data
> > >   * @version:	Version of this data structure
> > > - * @format:	PASID table entry format
> > > + * @format:	PASID table entry format of enum
> > > iommu_pasid_data_format type
> > >   * @flags:	Additional information on guest bind request
> > >   * @gpgd:	Guest page directory base of the guest mm to bind
> > >   * @hpasid:	Process address space ID used for the guest mm in
> > > host IOMMU @@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
> > >  	__u32 argsz;
> > >  #define IOMMU_GPASID_BIND_VERSION_1	1
> > >  	__u32 version;
> > > -#define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > >  	__u32 format;
> > >  	__u32 addr_width;
> > >  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > > -- 
> > > 2.7.4    
> 
> 
> Thanks,
> 
> Jacob


Thanks,

Jacob
