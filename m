Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0321F61C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 08:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgFKGd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 02:33:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:8441 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgFKGd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:33:28 -0400
IronPort-SDR: ocuRB2P80RjCLdQWJrD5hO0f5u3kXBAH1vYsWD3+shtf8zcMtws5i8VH946q07ZvWw3vXtJ2T0
 M6HSmRtmNCdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 23:33:12 -0700
IronPort-SDR: f9POHyV6nMrJzLkyrojFLS5y+yev3W40P2JigfzgwNTilq1fc/cc1DuAmby6tzGhV7XUP2Wnkn
 AOlDv4Sn1bxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="380300922"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.171.8]) ([10.249.171.8])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2020 23:33:09 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/3] docs: IOMMU user API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e9f468ba-5e25-96ad-cb6d-06addee22a02@linux.intel.com>
Date:   Thu, 11 Jun 2020 14:33:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2020/6/11 12:12, Jacob Pan wrote:
> IOMMU UAPI is newly introduced to support communications between guest
> virtual IOMMU and host IOMMU. There has been lots of discussions on how
> it should work with VFIO UAPI and userspace in general.
> 
> This document is indended to clarify the UAPI design and usage. The
> mechenics of how future extensions should be achieved are also covered
> in this documentation.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   Documentation/userspace-api/iommu.rst | 210 ++++++++++++++++++++++++++++++++++
>   1 file changed, 210 insertions(+)
>   create mode 100644 Documentation/userspace-api/iommu.rst
> 
> diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
> new file mode 100644
> index 000000000000..e95dc5a04a41
> --- /dev/null
> +++ b/Documentation/userspace-api/iommu.rst
> @@ -0,0 +1,210 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. iommu:
> +
> +=====================================
> +IOMMU Userspace API
> +=====================================
> +
> +IOMMU UAPI is used for virtualization cases where communications are
> +needed between physical and virtual IOMMU drivers. For native
> +usage, IOMMU is a system device which does not need to communicate
> +with user space directly.
> +
> +The primary use cases are guest Shared Virtual Address (SVA) and
> +guest IO virtual address (IOVA), wherein virtual IOMMU (vIOMMU) is
> +required to communicate with the physical IOMMU in the host.
> +
> +.. contents:: :local:
> +
> +Functionalities
> +====================================================
> +Communications of user and kernel involve both directions. The
> +supported user-kernel APIs are as follows:
> +
> +1. Alloc/Free PASID
> +2. Bind/unbind guest PASID (e.g. Intel VT-d)
> +3. Bind/unbind guest PASID table (e.g. ARM sMMU)
> +4. Invalidate IOMMU caches
> +5. Service page request
> +
> +Requirements
> +====================================================
> +The IOMMU UAPIs are generic and extensible to meet the following
> +requirements:
> +
> +1. Emulated and para-virtualised vIOMMUs
> +2. Multiple vendors (Intel VT-d, ARM sMMU, etc.)
> +3. Extensions to the UAPI shall not break existing user space
> +
> +Interfaces
> +====================================================
> +Although the data structures defined in IOMMU UAPI are self-contained,
> +there is no user API functions introduced. Instead, IOMMU UAPI is
> +designed to work with existing user driver frameworks such as VFIO.
> +
> +Extension Rules & Precautions
> +-----------------------------
> +When IOMMU UAPI gets extended, the data structures can *only* be
> +modified in two ways:
> +
> +1. Adding new fields by re-purposing the padding[] field. No size change.
> +2. Adding new union members at the end. May increase in size.
> +
> +No new fields can be added *after* the variable size union in that it
> +will break backward compatibility when offset moves. In both cases, a
> +new flag must be accompanied with a new field such that the IOMMU
> +driver can process the data based on the new flag. Version field is
> +only reserved for the unlikely event of UAPI upgrade at its entirety.
> +
> +It's *always* the caller's responsibility to indicate the size of the
> +structure passed by setting argsz appropriately.
> +
> +When IOMMU UAPI extension results in size increase, user such as VFIO
> +has to handle the following scenarios:
> +
> +1. User and kernel has exact size match
> +2. An older user with older kernel header (smaller UAPI size) running on a
> +   newer kernel (larger UAPI size)
> +3. A newer user with newer kernel header (larger UAPI size) running
> +   on a older kernel.
> +4. A malicious/misbehaving user pass illegal/invalid size but within
> +   range. The data may contain garbage.
> +
> +
> +Feature Checking
> +----------------
> +While launching a guest with vIOMMU, it is important to ensure that host
> +can support the UAPI data structures to be used for vIOMMU-pIOMMU
> +communications. Without the upfront compatibility checking, future
> +faults are difficult to report even in normal conditions. For example,
> +TLB invalidations should always succeed from vIOMMU's
> +perspective. There is no architectural way to report back to the vIOMMU
> +if the UAPI data is incompatible. For this reason the following IOMMU
> +UAPIs cannot fail:
> +
> +1. Free PASID
> +2. Unbind guest PASID
> +3. Unbind guest PASID table (SMMU)
> +4. Cache invalidate
> +5. Page response
> +
> +User applications such as QEMU is expected to import kernel UAPI
> +headers. Only backward compatibility is supported. For example, an
> +older QEMU (with older kernel header) can run on newer kernel. Newer
> +QEMU (with new kernel header) may fail on older kernel.
> +
> +IOMMU vendor driver should report the below features to IOMMU UAPI
> +consumers (e.g. via VFIO).
> +
> +1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
> +2. IOMMU_NESTING_FEAT_BIND_PGTBL
> +3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
> +4. IOMMU_NESTING_FEAT_CACHE_INVLD
> +5. IOMMU_NESTING_FEAT_PAGE_REQUEST
> +
> +Take VFIO as example, upon request from VFIO user space (e.g. QEMU),
> +VFIO kernel code shall query IOMMU vendor driver for the support of
> +the above features. Query result can then be reported back to the
> +user-space caller. Details can be found in
> +Documentation/driver-api/vfio.rst.
> +
> +
> +Data Passing Example with VFIO
> +------------------------------
> +As the ubiquitous userspace driver framework, VFIO is already IOMMU
> +aware and share many key concepts such as device model, group, and
> +protection domain. Other user driver frameworks can also be extended
> +to support IOMMU UAPI but it is outside the scope of this document.
> +
> +In this tight-knit VFIO-IOMMU interface, the ultimate consumer of the
> +IOMMU UAPI data is the host IOMMU driver. VFIO facilitates user-kernel
> +transport, capability checking, security, and life cycle management of
> +process address space ID (PASID).
> +
> +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU driver is the
> +ultimate consumer of its UAPI data. At VFIO layer, the IOMMU UAPI data
> +is wrapped in a VFIO UAPI data for sanity checking. It follows the
> +pattern below:
> +
> +::
> +
> +   struct {
> +	__u32 argsz;
> +	__u32 flags;
> +	__u8  data[];
> +  }
> +
> +Here data[] contains the IOMMU UAPI data structures.
> +
> +In order to determine the size and feature set of the user data, argsz
> +and flags are also embedded in the IOMMU UAPI data structures.
> +A "__u32 argsz" field is *always* at the beginning of each structure.
> +
> +For example:
> +::
> +
> +   struct iommu_gpasid_bind_data {
> +	__u32 argsz;
> +	__u32 version;
> +	#define IOMMU_PASID_FORMAT_INTEL_VTD	1
> +	__u32 format;
> +	#define IOMMU_SVA_GPASID_VAL	(1 << 0)
> +	__u64 flags;
> +	__u64 gpgd;
> +	__u64 hpasid;
> +	__u64 gpasid;
> +	__u32 addr_width;
> +	__u8  padding[12];
> +	/* Vendor specific data */
> +	union {
> +		struct iommu_gpasid_bind_data_vtd vtd;
> +	};
> +  };
> +
> +Use bind guest PASID as an example, VFIO code shall process IOMMU UAPI
> +request as follows:
> +
> +::
> +
> + 1        /* Minsz must include IOMMU UAPI "argsz" of __u32 */
> + 2        minsz = offsetofend(struct vfio_iommu_type1_bind, flags) +

Where is the vfio_iommu_type1_bind definition? I haven't found it in
both this series and current code.

> +                              sizeof(u32);
> + 3        copy_from_user(&vfio_bind, (void __user *)arg, minsz);
> + 4
> + 5        /* Check VFIO argsz */
> + 6        if (vfio_bind.argsz < minsz)
> + 7                return -EINVAL;
> + 8
> + 9        /* VFIO flags must be included in minsz */
> + 10        switch (vfio_bind.flags) {
> + 11        case VFIO_IOMMU_BIND_GUEST_PGTBL:
> + 12                /*
> + 13                 * Get the current IOMMU bind GPASID data size,
> + 14                 * which accounted for the largest union member.
> + 15                 */
> + 16                data_size = sizeof(struct iommu_gpasid_bind_data);
> + 17                iommu_argsz = vfio_bind.argsz - minsz;
> + 18                if (iommu_argsz > data_size) {
> + 19                        /* User data > current kernel */
> + 20                        return -E2BIG;
> + 21                }
> + 22                copy_from_user(&iommu_bind, (void __user *)
> + 23                               vfio_bind.data, iommu_argsz);
> + 24               /*
> + 25                * Deal with trailing bytes that is bigger than user
> + 26                * provided UAPI size but smaller than the current
> + 27                * kernel data size. Zero fill the trailing bytes.
> + 28                */
> + 29                memset(iommu_bind + iommu_argsz, 0, data_size -
> + 30                       iommu_argsz;

Where is iommu_bind definition? I am assuming that it's

	struct iommu_gpasid_bind_data iommu_bind;

You need to cast it to (void *) to avoid pointer overflow.

	memset((void *)&iommu_bind + iommu_argsz, 0, ...);

By the way, right parenthesis is missed.

> + 31
> + 32                iommu_sva_bind_gpasid(domain, dev, iommu_bind_data);

Where is the iommu_bind_data definition?

> + 33                break;
> +
> +
> +Case #1 & 2 are supported per backward compatibility rule.
> +
> +Case #3 will fail with -E2BIG at line #20. Case
> +
> +Case #4 may result in other error processed by IOMMU vendor driver. However,
> +the damage shall not exceed the scope of the offending user.
> 

The above description is not clear. People are hard to find the right
description of each case.

Best regards,
baolu
