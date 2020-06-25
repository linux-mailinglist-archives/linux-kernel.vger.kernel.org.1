Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A1209F04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404839AbgFYM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 08:59:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:34134 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404650AbgFYM7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:59:20 -0400
IronPort-SDR: AekiDvxjfUtbCvMiFbe4dDr+C0zd6zMCSnJZVCmhCI8t9o/RrNhdKmT++zuMuWrrFMOfIUbgat
 DYD4Av13j/Dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133302075"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="133302075"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 05:59:10 -0700
IronPort-SDR: i6Ys0T4ZOGQuhdpYBW4th9+MHEGWasefrCfEyP583mQ83surcbs8r/lE9QXtG4LHsDnzCDnO2D
 g00PWCTwU2WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="263915035"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.52]) ([10.255.28.52])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 05:59:07 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 5/5] iommu/uapi: Support both kernel and user unbind
 guest PASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8d9d5692-b603-19eb-3f69-c18cfef7b450@linux.intel.com>
Date:   Thu, 25 Jun 2020 20:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2020/6/24 1:03, Jacob Pan wrote:
> +int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +			struct iommu_gpasid_bind_data *data)
>   {
>   	if (unlikely(!domain->ops->sva_unbind_gpasid))
>   		return -ENODEV;
>   
> -	return domain->ops->sva_unbind_gpasid(dev, pasid);
> +	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
> +}
> +EXPORT_SYMBOL_GPL(__iommu_sva_unbind_gpasid);

__iommu_sva_unbind_gpasid() looks more like an internal only helper. How
about something like iommu_sva_kunbind_gpasid()?

Best regards,
baolu
