Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96E1A2295
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgDHNH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 09:07:26 -0400
Received: from 8bytes.org ([81.169.241.247]:58502 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgDHNH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:07:26 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CE5312CC; Wed,  8 Apr 2020 15:07:24 +0200 (CEST)
Date:   Wed, 8 Apr 2020 15:07:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v11 02/10] iommu/uapi: Define a mask for bind data
Message-ID: <20200408130722.GA27140@8bytes.org>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585939334-21396-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:42:06AM -0700, Jacob Pan wrote:
> Memory type related flags can be grouped together for one simple check.
> 
> ---
> v9 renamed from EMT to MTS since these are memory type support flags.
> ---
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 4ad3496e5c43..d7bcbc5f79b0 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
>  	__u32 pat;
>  	__u32 emt;
>  };
> -
> +#define IOMMU_SVA_VTD_GPASID_MTS_MASK	(IOMMU_SVA_VTD_GPASID_CD | \
> +					 IOMMU_SVA_VTD_GPASID_EMTE | \
> +					 IOMMU_SVA_VTD_GPASID_PCD |  \
> +					 IOMMU_SVA_VTD_GPASID_PWT)

Where and how will this be used? Can you add this in the patch that
actually makes use of it?

Also please add newlines before and after that define.


Regards,

	Joerg
