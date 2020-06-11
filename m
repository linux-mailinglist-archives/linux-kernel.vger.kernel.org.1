Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400071F6B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFKPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 11:47:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20166 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591890470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAy7EX/f3nMJPgUfcEXOOrhWk+dzE7IzYVqH/zhVl6M=;
        b=Szh0q3VFZ43JOwBgTviYoHXbYG1oNlKPyc/unW7jwj8C71AECqaHgZvNWeMvRV/Mmp99n9
        /hf3U7Zzna40L+kuTvyB7+bY5WghBfb/YuvJd1rM2P5sr6tkvcITb8FB+S0vCMhXp+oqUc
        LkTUDJ0J2icrT21EjVo2KApB//fapKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-mESMLCO7P0a-03G2a9yMDA-1; Thu, 11 Jun 2020 11:47:48 -0400
X-MC-Unique: mESMLCO7P0a-03G2a9yMDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5117A18FF660;
        Thu, 11 Jun 2020 15:47:46 +0000 (UTC)
Received: from w520.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B7C9100238C;
        Thu, 11 Jun 2020 15:47:42 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:47:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/3] docs: IOMMU user API
Message-ID: <20200611094741.6d118fa8@w520.home>
In-Reply-To: <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 21:12:13 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

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
>  Documentation/userspace-api/iommu.rst | 210 ++++++++++++++++++++++++++++++++++
>  1 file changed, 210 insertions(+)
>  create mode 100644 Documentation/userspace-api/iommu.rst
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

"Build your user application against newer kernels and it may break on
older kernels" is not a great selling point of this UAPI.  Clearly new
features may not be available on older kernels and an application that
depends on a newer feature may be restricted to newer kernels.

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
> +                              sizeof(u32);

In the example structure above:

> +   struct {
> +	__u32 argsz;
> +	__u32 flags;
> +	__u8  data[];
> +  }

This presumes that vfio does not use flags to identify a different
layout, for example a field before data or defining a flag that
provides no data.  IOW, the IOMMU guarantees argsz at the beginning of
all structures, but let's not limit how vfio chooses to bundle that
structure.  minsz should be based on flags, which we'll evaluate to
determine how much more to copy.

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

Note that by including the IOMMU UAPI argsz within minsz, this is
incorrect.

> + 18                if (iommu_argsz > data_size) {
> + 19                        /* User data > current kernel */
> + 20                        return -E2BIG;
> + 21                }

Now I see why you're making the claim that QEMU compiled against an new
kernel may not work on an older kernel.  We can do better.  The current
sizeof the data structure should be the maximum we'll copy from the
user, and we can update the user provided IOMMU UAPI argsz as we pass it
down from the user to avoid exposing ourselves to an arbitrarily large
user buffer.  The IOMMU UAPI interfaces should then also use argsz and
flags to determine whether the data is present for a specified flag.
That should allow a user application compiled against a newer kernel
header, but only using features found on older kernels to continue to
work on older kernels, which seems like a basic requirement to me.

> + 22                copy_from_user(&iommu_bind, (void __user *)
> + 23                               vfio_bind.data, iommu_argsz);
> + 24               /*
> + 25                * Deal with trailing bytes that is bigger than user
> + 26                * provided UAPI size but smaller than the current
> + 27                * kernel data size. Zero fill the trailing bytes.
> + 28                */
> + 29                memset(iommu_bind + iommu_argsz, 0, data_size -
> + 30                       iommu_argsz;

The IOMMU UAPI interface having access to argsz should make this
unnecessary.  Performing this memset() seems like it suggests to the
next layer that it can rely on all fields being present and valid,
which defeats the purpose of argsz.

> + 31
> + 32                iommu_sva_bind_gpasid(domain, dev, iommu_bind_data);
> + 33                break;
> +
> +
> +Case #1 & 2 are supported per backward compatibility rule.
> +
> +Case #3 will fail with -E2BIG at line #20. Case

This is not acceptable IMO.

> +Case #4 may result in other error processed by IOMMU vendor driver. However,
> +the damage shall not exceed the scope of the offending user.

This is a concern in this double wrapped interface, the IOMMU UAPI
layer may expect the vfio layer to validate the data.  Zeroing the
remainder of the data structure is evidence towards that.  The IOMMU
UAPI layer needs to consider all of this untrusted, so why would we not
reflect that by passing a __user pointer through to the IOMMU UAPI such
that it can copy the data from the user itself rather than being
mislead that the contents have been somehow verified?  Thanks,

Alex

