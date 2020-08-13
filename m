Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00821243702
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMI7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 04:59:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgHMI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597309148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xplidKiAunMjEmfmobXpSZSbiqFpNVbmoHS76yAqyR4=;
        b=NvVLdkish7ChXd6EjG2ia7GZ0fbnpJDDuXLz5rXFv0LBnwQOR8xDwofS3tPhqQ2sjTZgtd
        46Kuf88Ed2uLchJ82DuMCWyK7ZaVdQlOa7jABoLV6Bih4sEVKjPkPE2U6GqXlp0XW/fLyY
        L0DrqpjVflMEVhiVjOCYxmyYAhkc2mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-tnH2_dRBMLeGslfaYettJA-1; Thu, 13 Aug 2020 04:59:04 -0400
X-MC-Unique: tnH2_dRBMLeGslfaYettJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 602011005E5B;
        Thu, 13 Aug 2020 08:59:01 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E7D370106;
        Thu, 13 Aug 2020 08:58:54 +0000 (UTC)
Subject: Re: [PATCH v7 5/7] iommu/uapi: Rename uapi functions
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <310ebf1c-02d6-b31f-e92e-619d46fa94aa@redhat.com>
Date:   Thu, 13 Aug 2020 10:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596068467-49322-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/30/20 2:21 AM, Jacob Pan wrote:
> User APIs such as iommu_sva_unbind_gpasid() may also be used by the
> kernel. Since we introduced user pointer to the UAPI functions,
Practically this is done in the next patch. What about something like:

We plan to have two flavors of the same API functions, one called
through ioctls, carrying a user pointer and one called directly with
valid IOMMU UAPI structs. To differentiate both, let's rename existing
functions with an iommu_uapi_ prefix.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Thanks

Eric
> in-kernel callers cannot share the same APIs. In-kernel callers are also
> trusted, there is no need to validate the data.
> 
> This patch renames all UAPI functions with iommu_uapi_ prefix such that
> is clear to the intended callers.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 18 +++++++++---------
>  include/linux/iommu.h | 31 ++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b6858adc4f17..3a913ce94a3d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1950,35 +1950,35 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>  
> -int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> -			   struct iommu_cache_invalidate_info *inv_info)
> +int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +				struct iommu_cache_invalidate_info *inv_info)
>  {
>  	if (unlikely(!domain->ops->cache_invalidate))
>  		return -ENODEV;
>  
>  	return domain->ops->cache_invalidate(domain, dev, inv_info);
>  }
> -EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> +EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
>  
> -int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -			   struct device *dev, struct iommu_gpasid_bind_data *data)
> +int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> +			       struct device *dev, struct iommu_gpasid_bind_data *data)
>  {
>  	if (unlikely(!domain->ops->sva_bind_gpasid))
>  		return -ENODEV;
>  
>  	return domain->ops->sva_bind_gpasid(domain, dev, data);
>  }
> -EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> +EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
>  
> -int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> -			     ioasid_t pasid)
> +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +				 ioasid_t pasid)
>  {
>  	if (unlikely(!domain->ops->sva_unbind_gpasid))
>  		return -ENODEV;
>  
>  	return domain->ops->sva_unbind_gpasid(dev, pasid);
>  }
> -EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> +EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
>  
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5f0b7859d2eb..2dcc1a33f6dc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -430,13 +430,13 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>  			       struct device *dev);
>  extern void iommu_detach_device(struct iommu_domain *domain,
>  				struct device *dev);
> -extern int iommu_cache_invalidate(struct iommu_domain *domain,
> -				  struct device *dev,
> -				  struct iommu_cache_invalidate_info *inv_info);
> -extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -		struct device *dev, struct iommu_gpasid_bind_data *data);
> -extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, ioasid_t pasid);
> +extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> +				       struct device *dev,
> +				       struct iommu_cache_invalidate_info *inv_info);
> +extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> +				      struct device *dev, struct iommu_gpasid_bind_data *data);
> +extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> +					struct device *dev, ioasid_t pasid);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -1054,21 +1054,22 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
>  	return IOMMU_PASID_INVALID;
>  }
>  
> -static inline int
> -iommu_cache_invalidate(struct iommu_domain *domain,
> -		       struct device *dev,
> -		       struct iommu_cache_invalidate_info *inv_info)
> +static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> +					      struct device *dev,
> +					      struct iommu_cache_invalidate_info *inv_info)
>  {
>  	return -ENODEV;
>  }
> -static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, struct iommu_gpasid_bind_data *data)
> +
> +static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> +					     struct device *dev,
> +					     struct iommu_gpasid_bind_data *data)
>  {
>  	return -ENODEV;
>  }
>  
> -static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -					   struct device *dev, int pasid)
> +static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> +					       struct device *dev, int pasid)
>  {
>  	return -ENODEV;
>  }
> 

