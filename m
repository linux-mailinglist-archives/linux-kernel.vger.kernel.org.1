Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6428A20FADB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbgF3Riv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 13:38:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:8504 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbgF3Rin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:43 -0400
IronPort-SDR: KQRPHvU5i7a5Ww7B7T/H1YT/fIWZo4S8puHgmybqNHP+JUaOj7dKMzNPhwj35EuMoJymhdymJN
 NMNtmOYN4dAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126428140"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="126428140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:32:41 -0700
IronPort-SDR: 8ERkfvNsoaa/8gxtVZB2mdZwEOK5hjdH8BE7oVzq/zt4a5FLO1qb8zhtcCF5ag0bt/PEcHTWFY
 IZCJ4nSiKXnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="265174866"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 10:32:40 -0700
Date:   Tue, 30 Jun 2020 10:39:15 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 1/5] docs: IOMMU user API
Message-ID: <20200630103915.42f79a35@jacob-builder>
In-Reply-To: <MWHPR11MB1645D1A989A7D4E22BCB29A38C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1592931837-58223-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200626161923.339e17a6@w520.home>
        <20200629160518.471159cf@jacob-builder>
        <MWHPR11MB1645D1A989A7D4E22BCB29A38C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 02:52:45 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan
> > Sent: Tuesday, June 30, 2020 7:05 AM
> > 
> > On Fri, 26 Jun 2020 16:19:23 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Tue, 23 Jun 2020 10:03:53 -0700
> > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > >  
> > > > IOMMU UAPI is newly introduced to support communications between
> > > > guest virtual IOMMU and host IOMMU. There has been lots of
> > > > discussions on how it should work with VFIO UAPI and userspace
> > > > in general.
> > > >
> > > > This document is indended to clarify the UAPI design and usage.
> > > > The mechenics of how future extensions should be achieved are
> > > > also covered in this documentation.
> > > >
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > >  Documentation/userspace-api/iommu.rst | 244
> > > > ++++++++++++++++++++++++++++++++++ 1 file changed, 244
> > > > insertions(+) create mode 100644
> > > > Documentation/userspace-api/iommu.rst
> > > >
> > > > diff --git a/Documentation/userspace-api/iommu.rst
> > > > b/Documentation/userspace-api/iommu.rst new file mode 100644
> > > > index 000000000000..f9e4ed90a413
> > > > --- /dev/null
> > > > +++ b/Documentation/userspace-api/iommu.rst
> > > > @@ -0,0 +1,244 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +.. iommu:
> > > > +
> > > > +=====================================
> > > > +IOMMU Userspace API
> > > > +=====================================
> > > > +
> > > > +IOMMU UAPI is used for virtualization cases where
> > > > communications are +needed between physical and virtual IOMMU
> > > > drivers. For native +usage, IOMMU is a system device which does
> > > > not need to communicate +with user space directly.
> > > > +
> > > > +The primary use cases are guest Shared Virtual Address (SVA)
> > > > and +guest IO virtual address (IOVA), wherein a virtual IOMMU
> > > > (vIOMMU) is +required to communicate with the physical IOMMU in
> > > > the host. +
> > > > +.. contents:: :local:
> > > > +
> > > > +Functionalities
> > > > +===============
> > > > +Communications of user and kernel involve both directions. The
> > > > +supported user-kernel APIs are as follows:
> > > > +
> > > > +1. Alloc/Free PASID
> > > > +2. Bind/unbind guest PASID (e.g. Intel VT-d)
> > > > +3. Bind/unbind guest PASID table (e.g. ARM sMMU)
> > > > +4. Invalidate IOMMU caches
> > > > +5. Service page requests
> > > > +
> > > > +Requirements
> > > > +============
> > > > +The IOMMU UAPIs are generic and extensible to meet the
> > > > following +requirements:
> > > > +
> > > > +1. Emulated and para-virtualised vIOMMUs
> > > > +2. Multiple vendors (Intel VT-d, ARM sMMU, etc.)
> > > > +3. Extensions to the UAPI shall not break existing user space
> > > > +
> > > > +Interfaces
> > > > +==========
> > > > +Although the data structures defined in IOMMU UAPI are
> > > > self-contained, +there is no user API functions introduced.
> > > > Instead, IOMMU UAPI is +designed to work with existing user
> > > > driver frameworks such as VFIO. +
> > > > +Extension Rules & Precautions
> > > > +-----------------------------
> > > > +When IOMMU UAPI gets extended, the data structures can *only*
> > > > be +modified in two ways:
> > > > +
> > > > +1. Adding new fields by re-purposing the padding[] field. No
> > > > size change. +2. Adding new union members at the end. May
> > > > increase in size. +
> > > > +No new fields can be added *after* the variable sized union in
> > > > that it +will break backward compatibility when offset moves. In
> > > > both cases, a +new flag must be accompanied with a new field
> > > > such that the IOMMU +driver can process the data based on the
> > > > new flag. Version field is +only reserved for the unlikely
> > > > event of UAPI upgrade at its entirety. +
> > > > +It's *always* the caller's responsibility to indicate the size
> > > > of the +structure passed by setting argsz appropriately.
> > > > +Though at the same time, argsz is user provided data which is
> > > > not +trusted. The argsz field allows the user to indicate how
> > > > much data +they're providing, it's still the kernel's
> > > > responsibility to validate +whether it's correct and sufficient
> > > > for the requested operation. +
> > > > +Compatibility Checking
> > > > +----------------------
> > > > +When IOMMU UAPI extension results in size increase, user such
> > > > as VFIO +has to handle the following cases:
> > > > +
> > > > +1. User and kernel has exact size match
> > > > +2. An older user with older kernel header (smaller UAPI size)
> > > > running on a
> > > > +   newer kernel (larger UAPI size)
> > > > +3. A newer user with newer kernel header (larger UAPI size)
> > > > running
> > > > +   on an older kernel.
> > > > +4. A malicious/misbehaving user pass illegal/invalid size but
> > > > within
> > > > +   range. The data may contain garbage.  
> > >
> > > What exactly does vfio need to do to handle these?
> > >  
> > VFIO does nothing other than returning the status from IOMMU driver.
> > Based on the return status, users such as QEMU can cause fault
> > conditions within the vIOMMU.  
> 
> But from above description, "user such as VFIO has to handle the
> following cases"...
> 
I really meant the whole UAPI framework. How about:

"When IOMMU UAPI extension results in size increase, the following
cases must be handled:"

> Thanks
> Kevin
> 
> >   
> > > > +
> > > > +Feature Checking
> > > > +----------------
> > > > +While launching a guest with vIOMMU, it is important to ensure
> > > > that host +can support the UAPI data structures to be used for
> > > > vIOMMU-pIOMMU +communications. Without upfront compatibility
> > > > checking, future faults +are difficult to report even in normal
> > > > conditions. For example, TLB +invalidations should always
> > > > succeed. There is no architectural way to +report back to the
> > > > vIOMMU if the UAPI data is incompatible. If that +happens, in
> > > > order to protect IOMMU iosolation guarantee, we have to +resort
> > > > to not giving completion status in vIOMMU. This may result in
> > > > +VM hang. +
> > > > +For this reason the following IOMMU UAPIs cannot fail:
> > > > +
> > > > +1. Free PASID
> > > > +2. Unbind guest PASID
> > > > +3. Unbind guest PASID table (SMMU)
> > > > +4. Cache invalidate
> > > > +
> > > > +User applications such as QEMU is expected to import kernel
> > > > UAPI +headers. Backward compatibility is supported per feature
> > > > flags. +For example, an older QEMU (with older kernel header)
> > > > can run on newer +kernel. Newer QEMU (with new kernel header)
> > > > may refuse to initialize +on an older kernel if new feature
> > > > flags are not supported by older +kernel. Simply recompile
> > > > existing code with newer kernel header should +not be an issue
> > > > in that only existing flags are used. +
> > > > +IOMMU vendor driver should report the below features to IOMMU
> > > > UAPI +consumers (e.g. via VFIO).
> > > > +
> > > > +1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
> > > > +2. IOMMU_NESTING_FEAT_BIND_PGTBL
> > > > +3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
> > > > +4. IOMMU_NESTING_FEAT_CACHE_INVLD
> > > > +5. IOMMU_NESTING_FEAT_PAGE_REQUEST
> > > > +
> > > > +Take VFIO as example, upon request from VFIO user space (e.g.
> > > > QEMU), +VFIO kernel code shall query IOMMU vendor driver for the
> > > > support of +the above features. Query result can then be
> > > > reported back to the +user-space caller. Details can be found in
> > > > +Documentation/driver-api/vfio.rst.
> > > > +
> > > > +
> > > > +Data Passing Example with VFIO
> > > > +------------------------------
> > > > +As the ubiquitous userspace driver framework, VFIO is already
> > > > IOMMU +aware and share many key concepts such as device model,
> > > > group, and +protection domain. Other user driver frameworks can
> > > > also be extended +to support IOMMU UAPI but it is outside the
> > > > scope of this document. +
> > > > +In this tight-knit VFIO-IOMMU interface, the ultimate consumer
> > > > of the +IOMMU UAPI data is the host IOMMU driver. VFIO
> > > > facilitates user-kernel +transport, capability checking,
> > > > security, and life cycle management of +process address space
> > > > ID (PASID). +
> > > > +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU
> > > > driver is the +ultimate consumer of its UAPI data. At VFIO
> > > > layer, the IOMMU UAPI data +is wrapped in a VFIO UAPI data. It
> > > > follows the +pattern below::
> > > > +
> > > > +   struct {
> > > > +	__u32 argsz;
> > > > +	__u32 flags;
> > > > +	__u8  data[];
> > > > +   };
> > > > +
> > > > +Here data[] contains the IOMMU UAPI data structures. VFIO has
> > > > the +freedom to bundle the data as well as parse data size
> > > > based on its own flags. +
> > > > +In order to determine the size and feature set of the user
> > > > data, argsz +and flags are also embedded in the IOMMU UAPI data
> > > > structures. +A "__u32 argsz" field is *always* at the beginning
> > > > of each structure. +
> > > > +For example:
> > > > +::
> > > > +
> > > > +   struct iommu_cache_invalidate_info {
> > > > +	__u32	argsz;
> > > > +	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> > > > +	__u32	version;
> > > > +	/* IOMMU paging structure cache */
> > > > +	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /*
> > > > IOMMU IOTLB */
> > > > +	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 <<
> > > > 1) /* Device IOTLB */
> > > > +	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /*
> > > > PASID cache */
> > > > +	#define IOMMU_CACHE_INV_TYPE_NR		(3)
> > > > +	__u8	cache;
> > > > +	__u8	granularity;
> > > > +	__u8	padding[2];
> > > > +	union {
> > > > +		struct iommu_inv_pasid_info pasid_info;
> > > > +		struct iommu_inv_addr_info addr_info;
> > > > +	} granu;
> > > > +   };
> > > > +
> > > > +VFIO is responsible for checking its own argsz and flags then
> > > > invokes +appropriate IOMMU UAPI functions. User pointer is
> > > > passed to IOMMU +layer for further processing. The
> > > > responsibilities are divided as +follows:
> > > > +
> > > > +- Generic IOMMU layer checks argsz range and override
> > > > out-of-range
> > > > +  value. If the exact argsz is based on generic flags, they are
> > > > checked
> > > > +  here as well.
> > > > +
> > > > +- Vendor IOMMU driver checks argsz based on vendor flags, UAPI
> > > > data
> > > > +  is consumed based on flags
> > > > +
> > > > +Once again, use guest TLB invalidation as an example, argsz is
> > > > based +on generic flags in the invalidation information. IOMMU
> > > > generic code +shall process the UAPI data as the following:
> > > > +
> > > > +::
> > > > +
> > > > + int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > > > device *dev,
> > > > +			void __user *uinfo)
> > > > + {
> > > > +	/* Current kernel data size is the max to be copied
> > > > from user */
> > > > +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> > > > +	memset((void *)&inv_info, 0, maxsz);
> > > > +
> > > > +	/*
> > > > +	 * No new spaces can be added before the variable sized
> > > > union, the
> > > > +	 * minimum size is the offset to the union.
> > > > +	 */
> > > > +	minsz = offsetof(struct iommu_cache_invalidate_info,
> > > > granu); +
> > > > +	/* Copy minsz from user to get flags and argsz */
> > > > +	if (copy_from_user(&inv_info, uinfo, minsz))
> > > > +		return -EFAULT;
> > > > +
> > > > +	/* Fields before variable size union is mandatory */
> > > > +	if (inv_info.argsz < minsz)
> > > > +		return -EINVAL;
> > > > +	/*
> > > > +	 * User might be using a newer UAPI header which has a
> > > > larger data
> > > > +	 * size, we shall support the existing flags within the
> > > > current
> > > > +	 * size.
> > > > +	 */
> > > > +	if (inv_info.argsz > maxsz)
> > > > +		inv_info.argsz = maxsz;
> > > > +
> > > > +	/* Checking the exact argsz based on generic flags */
> > > > +	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
> > > > +		inv_info.argsz != offsetofend(struct
> > > > iommu_cache_invalidate_info,
> > > > +					granu.addr_info))  
> > >
> > > Is it really reasonable to expect the user to specify argsz to the
> > > exact union element for the callback?  I'd certainly expect users
> > > to simply use sizeof(struct iommu_cache_invalidate_info) and it
> > > should therefore be sufficient to test >= here rather than jump
> > > through hoops with an exact size.  We're already changing
> > > inv_info.argsz above to fit our known structure, it's
> > > inconsistent to then expect it to be some exact value.
> > >  
> > I was thinking argsz doesn't have to be the exact struct size. It
> > should be whatever the sufficient & correct size used by the user
> > for a given call.
> > 
> > For example, current struct iommu_gpasid_bind_data {} only has VT-d
> > data. If it gets extended with SMMU data in the union, VT-d vIOMMU
> > emulation should only fill the union size of vt-d.
> >   
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
> > > > +		inv_info.argsz != offsetofend(struct
> > > > iommu_cache_invalidate_info,
> > > > +					granu.pasid_info))
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* Copy the remaining user data _after_ minsz */
> > > > +	if (copy_from_user((void *)&inv_info + minsz, uinfo +
> > > > minsz,
> > > > +				inv_info.argsz - minsz))
> > > > +		return -EFAULT;
> > > > +
> > > > +	return domain->ops->cache_invalidate(domain, dev,
> > > > &inv_info);
> > > > + }
> > > > + Add a wrapper
> > > > +   __iommu_unbind_( kernel data, same user data, kernel copy)
> > > > +  
> > This should be removed. Sorry about the confusion. The patch does
> > not have two data pointers, just separate APIs for kernel and user.
> >   
> > > > +Notice that in this example, since union size is determined by
> > > > generic +flags, all checking to argsz is validated in the
> > > > generic IOMMU layer, +vendor driver does not need to check
> > > > argsz. However, if union size is +based on vendor data, such as
> > > > iommu_sva_bind_gpasid(), it will be +vendor driver's
> > > > responsibility to validate the exact argsz.  
> > >
> > > struct iommu_cache_invalidate_info is a good example because it
> > > explicitly states a table of type vs granularity validity.  When
> > > the cache_invalidate() callback is used by an internal user we can
> > > consider it a bug in the caller if its usage falls outside of
> > > these prescribed valid combinations, ie. iommu_ops callbacks may
> > > assume a trusted caller that isn't trying to exploit any
> > > loophole.  
> > Separate APIs are proposed in the patchset to address UAPIs
> > with both kernel and user callers. Sorry about the last line in the
> > example above. Currently, only unbind_gpasid() and page_response()
> > have both kernel and userspace callers. e.g.
> > 
> >    /* userspace caller */
> >    int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > 			void __user *udata)
> > 
> >    /* in-kernel caller */
> >    int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> >                                  struct iommu_gpasid_bind_data
> > *data)
> > 
> > We don;t expect in-kernel caller for cache invalidate in that it is
> > implied in unmap, unbind operations.
> >   
> > >  But here
> > > we've done nothing more than validated the supplied size to pass
> > > it through to a non-user hardened callback.  We didn't check the
> > > version,  
> > Yes, I should move up the version check from vendor driver.
> >   
> > > we didn't check that any of the undefined bits in cache or
> > > granularity or padding were set, we don't know what flags might be
> > > set in the union elements.  
> > You are right, we should sanitize reserved bits.
> >   
> > > For example, if a user is able to set a
> > > flag that gets ignored now, that means we can never use that flag
> > > without potentially breaking that user in the future.  
> > Good point, all reserved/unused bits should be tested.
> >   
> > >  If a user can
> > > pass in version 3141592654 now, then we can never use version for
> > > validation.  I see that intel_iommu_sva_invalidate() does test the
> > > version, but has no obvious other hardening.  I'm afraid we're
> > > being far to lax about accepting a data structure provided by a
> > > user, we should not assume good faith. Thanks,
> > >  
> > Agreed. will add checks in the IOMMU generic layer for reserved
> > bits.
> > For VT-d vendor driver, we do check all bits in cache types, i.e. in
> > intel/iommu.c
> > 	for_each_set_bit(cache_type,
> > 			 (unsigned long *)&inv_info->cache,
> > 			 IOMMU_CACHE_INV_TYPE_NR) {
> > 
> > 
> > one other hardening is to check vendor argsz. This is in the
> > bind_gpasid call.
> > 
> > 	if (data->argsz != offsetofend(struct
> > iommu_gpasid_bind_data, vendor.vtd))
> > 		return -EINVAL;
> > 
> > 
> >   
> > > Alex
> > >  
> > 
> > [Jacob Pan]
> > 
> > 
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu  

[Jacob Pan]
