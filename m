Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1326F984
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIRJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:44:56 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 02:44:55 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 00962293; Fri, 18 Sep 2020 11:44:51 +0200 (CEST)
Date:   Fri, 18 Sep 2020 11:44:50 +0200
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
Subject: Re: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data
 format
Message-ID: <20200918094450.GP31590@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 02:57:52PM -0700, Jacob Pan wrote:
> There can be multiple vendor-specific PASID data formats used in UAPI
> structures. This patch adds enum type with a last entry which makes
> range checking much easier.

But it also makes it much easier to screw up the numbers (which are ABI)
by inserting a new value into the middle. I prefer defines here, or
alternativly BUILD_BUG_ON() checks for the numbers.

Regards,

	Joerg

> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index b42acc8fe007..7cc6ee6c41f7 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
>  					 IOMMU_SVA_VTD_GPASID_PCD |  \
>  					 IOMMU_SVA_VTD_GPASID_PWT)
>  
> +enum iommu_pasid_data_format {
> +	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
> +	IOMMU_PASID_FORMAT_LAST,
> +};
> +
>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
>   * @argsz:	User filled size of this data
>   * @version:	Version of this data structure
> - * @format:	PASID table entry format
> + * @format:	PASID table entry format of enum iommu_pasid_data_format type
>   * @flags:	Additional information on guest bind request
>   * @gpgd:	Guest page directory base of the guest mm to bind
>   * @hpasid:	Process address space ID used for the guest mm in host IOMMU
> @@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
>  	__u32 argsz;
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
> -#define IOMMU_PASID_FORMAT_INTEL_VTD	1
>  	__u32 format;
>  	__u32 addr_width;
>  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> -- 
> 2.7.4
